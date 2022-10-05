#!/bin/sh
export DATABASE_URL="user=postgres password=postgres host=localhost port=5432 dbname=default sslmode=disable"

echo "\nsanity check"
time go run main.go "select count(*) FROM lineorder;"

echo "\nSSB Q1.1"
time go run main.go "SELECT sum(LO_EXTENDEDPRICE * LO_DISCOUNT) AS revenue FROM lineorder WHERE LO_ORDERDATE >= DATE '1993-01-01' AND LO_ORDERDATE <= DATE '1993-12-31' AND LO_DISCOUNT >= 1 AND LO_DISCOUNT <= 3 AND LO_QUANTITY < 25;"

echo "\nSSB Q1.2"
go run main.go "SELECT sum(LO_EXTENDEDPRICE * LO_DISCOUNT) AS revenue FROM lineorder WHERE LO_ORDERDATE >= DATE '1994-01-01' AND LO_ORDERDATE < DATE '1994-02-01' AND LO_DISCOUNT >= 4 AND LO_DISCOUNT <= 6 AND LO_QUANTITY >= 26 AND LO_QUANTITY <= 35;"

