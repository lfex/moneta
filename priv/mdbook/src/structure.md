# DBs and Tables

## Starting Again

> Restart the LFE REPL using a new data directory:

```bash
$ rebar3 lfe repl
```

> Create a default database schema:

```lisp
lfe> (mnta:create-schema #(start true))
ok
```

We've had a quick taste of Mnesia, and what some of the calls look like in LFE.
Next we're going to tackle a bit more heady stuff: tables and relationships.

After you have quit from your previous LFE REPL, restart using the ``Company.DB`` database name and then create a default schema, passing the auto-start option to Mnesia.


## Records as Tables

> The following records are defined in ``examples/tables.lfe``:

```cl
(defrecord employee
  id
  name
  salary
  gender
  phone
  room-number)

(defrecord department
  id
  name)

(defrecord project
  name
  number)

(defrecord manager
  employee-id
  department-id)

(defrecord in-department
  employee-id
  department-id)

(defrecord in-project
  employee-id
  project-name)
```

> Pull in these table definitions:

```cl
lfe> (include-file "examples/tables.lfe")
loaded-example-tables
```

> Define your tables:

```cl
lfe> (set set-tables '(employee department project in-department))
(employee department project in-department)
lfe> (set bag-tables '(manager in-project))
(manager in-project)
```

The ``tables.lfe`` example include defines LFE records that act as our table definitions (and thus all the convenient record macros that come with those). These are only definitions, though -- representing a table schema -- not the actual tables themselves. We need to create those.
as well as a macro that lets us create Mnesia tables with almost no boilerplate.

These records (tables) are taken from the example given in the
[Erlang Mnesia tutorial](http://www.erlang.org/doc/apps/mnesia/Mnesia_chap2.html#id63101) which also gives this entity diagram for their proposed
 "Company" database:

<img src="http://www.erlang.org/doc/apps/mnesia/company.gif" />


## Creating Our Tables

> Create the tables with the appropriate table specs:

```cl
lfe> (mnta:create-tables set-tables '(#(type set)) $ENV)
(#(atomic ok) #(atomic ok) #(atomic ok) #(atomic ok))
lfe> (mnta:create-tables bag-tables '(#(type bag)) $ENV)
(#(atomic ok) #(atomic ok))
```

> This just created all our Mnesia tables for us. If we run it again, we'll see
errors indicating that the tables have already been created:

```cl
lfe> (mnta:create-tables set-tables '(#(type set)))
(#(aborted #(already_exists employee))
 #(aborted #(already_exists department))
 #(aborted #(already_exists project))
 #(aborted #(already_exists in-department)))
lfe> (mnta:create-tables bag-tables '(#(type bag)))
(#(aborted #(already_exists manager))
 #(aborted #(already_exists in-project)))
```

When using Mnesia directly, there is a great deal of boilerplate code that developers need to write in order to create tables. Fortunately, Moneta provides several macros and functions that does this for you, making table-creation as intuitive as possible:  all you need to do is provide table names and table specs.


## Table Metadata

> Next, let's re-run the ``info`` function we saw in the previous section:

```cl
lfe> (mnta:info)
```
```
...
---> Active tables <---
in-project     : with 0        records occupying 305      words of mem
in-department  : with 0        records occupying 305      words of mem
manager        : with 0        records occupying 305      words of mem
project        : with 0        records occupying 305      words of mem
department     : with 0        records occupying 305      words of mem
employee       : with 0        records occupying 305      words of mem
...
```

> Here's how you find what backend type is being used for any given table:

```cl
lfe> (mnta:table-info 'employee 'type)
set
lfe> (mnta:table-info 'in-project 'type)
bag
```

> You can also get table metadata for several tables at once:

```cl
lfe> (mnta:tables-info (++ set-tables bag-tables) 'type)
(set set set set bag bag)
```

> If you're interested in seeing *all* the details of any given table, you can
do so with the ``'all`` parameter:

```cl
lfe> (mnta:table-info 'employee 'all)
(#(access_mode read_write)
#(active_replicas (nonode@nohost))
#(all_nodes (nonode@nohost))
#(arity 7)
#(attributes (id name salary gender phone room-number))
#(checkpoints ())
#(commit_work ())
#(cookie #(#(1396 680215 616649) nonode@nohost))
#(cstruct
 #(cstruct
   employee
   set
   (nonode@nohost)
   ()
   ()
   0
   read_write
   false
   ()
   ()
   false
   employee
   (id name salary gender ...)
   ()
   ()
   ()
   #(...)...))
#(disc_copies ())
#(disc_only_copies ())
#(frag_properties ())
#(index ())
#(load_by_force false)
#(load_node nonode@nohost)
#(load_order 0)
#(load_reason #(dumper create_table))
#(local_content false)
#(majority false)
#(master_nodes ())
#(memory 317)
#(ram_copies (nonode@nohost))
#(record_name employee)
#(record_validation #(employee 7 set))
#(type set)
#(size 0)
#(snmp ())
#(storage_properties ...)
#(...)...)
>
```

The output of the ``info`` function will be very similar to what we saw in the
previous section. However, do note that our new tables are reported in the
"Active tables" section:

If you would like to check up on the tables created above, you can use the
``table-info`` function to pull out certain data.

Next up, we'll start inserting some data.
