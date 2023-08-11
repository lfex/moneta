# Querying

We've already used some of the querying techniques for inserting and selecting all records. Here we'll explore some specifics of other types of queries we can make against the database.

## Select and Match Specs

Mnesia supports a form of querying data using a "match specification" with various level of detail provided at the following:
* [#'mnesia:select/2](https://www.erlang.org/doc/man/mnesia#select-2)
* [#'ets:select/2](https://www.erlang.org/doc/man/ets#select-2)
* [Match Specifications in Erlang](https://www.erlang.org/doc/apps/erts/match_spec)

On the LFE side, a brief description of using match specifications is provided here:
* [ETS and Mnesia](https://github.com/lfe/lfe/blob/develop/doc/src/lfe_guide.7.md#ets-and-mnesia)

Selects in mnesia have to be wrapped in a transaction, so moneta provides a convenience function for this. We can use it and the LFE `ets-ms` macro to query our employee table, finding all who belong to the `B/SFR` department:

```cl
lfe> (set `#(atomic ,results)
       (mnta-qry:select 'employee 
         (ets-ms
          (((match-employee department-id 'B/SFR name '$1)) '() '($1)))))
```

Which gives us the following:

```cl
lfe> results
(("Dacker Bjarne")
 ("Fedoriw Anna")
 ("Nilsson Hans")
 ("Tornkvist Torbjorn")
 ("Mattsson Hakan"))
```

We can also use guards in the match specs, providing a similar capability as the SQL `WHERE` clause. Here we get the three lowest-numbered employee IDs:

```cl
lfe> (set `#(atomic ,results)
       (mnta-qry:select 'employee 
         (ets-ms
          (((match-employee id id name '$2)) (when (=< id 3)) '($2)))))
```

giving us the following:

``` cl
lfe> results
(("Dacker Bjarne")
 ("Carlsson Tuula")
 ("Johnson Torbjorn"))
```

## QLC

The other way to query Mnesia is to use "query list comprehensions" which you can read about in detail at the following:\
* [The "Using QLC" section](https://www.erlang.org/doc/apps/mnesia/mnesia_chap2#example)
* [The Erlang qlc module](https://www.erlang.org/doc/man/qlc)
* [The LFE qlc macro](https://github.com/lfe/lfe/blob/develop/doc/src/lfe_guide.7.md#query-list-comprehensions)

Let's rewrite our queries above using QLCs:

``` cl

```
