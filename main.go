package main

import (
	"context"
	"flag"
	"fmt"
	"os"
	"time"

	"github.com/jackc/pgx/v5"
)

func main() {
	env := flag.String("env", "DATABASE_URL", "env to load database url from")
	flag.Parse()

	// urlExample := "postgres://username:password@localhost:5432/database_name"
	conn, err := pgx.Connect(context.Background(), os.Getenv(*env))
	if err != nil {
		fmt.Fprintf(os.Stderr, "Unable to connect to database: %v\n", err)
		os.Exit(1)
	}
	defer conn.Close(context.Background())

	args := flag.Args()
	if len(args) != 1 {
		fmt.Printf("support running only one query, got: %d\n", len(args))
		os.Exit(1)
	}

	query := args[0]

	ctx, canc := context.WithTimeout(context.Background(), time.Second)
	defer canc()
	t := time.Now()
	rows, err := conn.Query(ctx, query)
	if err != nil {
		fmt.Printf("got err: %s", err)
		os.Exit(1)
	}

	if err := rows.Err(); err != nil {
		fmt.Printf("rows err: %s", err)
		os.Exit(1)
	}

	fmt.Println(rows.CommandTag().String())
	switch t := rows.CommandTag(); {
	case t.Select():
	case t.Insert():
	case t.Delete():
	case t.Update():
	}

	defer rows.Close()
	i := 0
	for rows.Next() {
		vals, err := rows.Values()
		if err != nil {
			fmt.Printf("values err: %s", err)
			os.Exit(1)
		}
		fmt.Println(vals)
		i++
	}
	d := time.Now().Sub(t)
	fmt.Printf("fetch %d rows took: %s\n", i, d)
}
