#!/bin/sh
export DATABASE_URL="user=postgres password=postgres host=localhost port=5432 dbname=default sslmode=disable"
go run main.go "CREATE TABLE lineorder ( \
                    LO_ORDERKEY             INTEGER NOT NULL, \
                    LO_LINENUMBER           INTEGER NOT NULL, \
                    LO_CUSTKEY              INTEGER NOT NULL, \
                    LO_PARTKEY              INTEGER NOT NULL, \
                    LO_SUPPKEY              INTEGER NOT NULL, \
                    LO_ORDERDATE            DATE NOT NULL, \
                    LO_ORDERPRIORITY        STRING NOT NULL, \
                    LO_SHIPPRIORITY         INTEGER NOT NULL, \
                    LO_QUANTITY             INTEGER NOT NULL, \
                    LO_EXTENDEDPRICE        INTEGER NOT NULL, \
                    LO_ORDTOTALPRICE        INTEGER NOT NULL, \
                    LO_DISCOUNT             INTEGER NOT NULL, \
                    LO_REVENUE              INTEGER NOT NULL, \
                    LO_SUPPLYCOST           INTEGER NOT NULL, \
                    LO_TAX                  INTEGER NOT NULL, \
                    LO_COMMITDATE           DATE NOT NULL, \
                    LO_SHIPMODE             STRING NOT NULL \
                )"
go run main.go "create index lineorder_idx on lineorder(LO_ORDERDATE,LO_ORDERKEY)"