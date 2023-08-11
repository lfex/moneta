# Getting Started

## Download Moneta

> Download the project source code:

```bash
$ git clone https://github.com/lfex/moneta
$ cd moneta
```

> Next, get all the dependencies downloaded and built:

```bash
$ rebar3 compile
```

The moneta project offers some convenience wrappers for the Erlang/OTP ``mnesia`` and ``qlc`` modules. To walk through the tutorial, you'll need to download the project source code.

Once you have the code built, you're ready to go :-) Now you can start the LFE REPL, letting it know where to save your data.

> Start LFE and let it know where you data will be saved:

```bash
$ rebar3 lfe repl
```

> Once in the REPL, you're ready to start dataing:

```
Erlang/OTP 26 [erts-14.0.2] [source] [64-bit] [smp:10:10] ...

   ..-~.~_~---..
  (      \\     )    |   A Lisp-2+ on the Erlang VM
  |`-.._/_\\_.-':    |   Type (help) for usage info.
  |         g |_ \   |
  |        n    | |  |   Docs: http://docs.lfe.io/
  |       a    / /   |   Source: http://github.com/lfe/lfe
   \     l    |_/    |
    \   r     /      |   LFE v2.1.2 (abort with ^G)
     `-E___.-'

lfe>
```

## First Run

> We're going to be using macros in the REPL, so let's include them:

``` cl
lfe> (include-lib "moneta/include/macros.lfe")
--loaded-moneta-macros--
```

> Create a schema, asking Moneta to start the Mnesia database for you automatically:

```cl
lfe> (mnta:create-schema #(start true))
ok
```

> Define a record for storing data:

``` cl
lfe> (defrecord funky a b c)
```

> Now create a defaul table (with no provided table definition):

```cl
lfe> (mnta:create-table 'funky $ENV)
#(atomic ok)
```

From the LFE REPL you can create a new database on disk, start Mnesia
up, and then create a table. After creating the table, you can examine the table's metadata.

> We can take a look at our creation with this command:

```cl
> (mnta:info)
```

> Which should give you something like this:

```
---> Processes holding locks <---
---> Processes waiting for locks <---
---> Participant transactions <---
---> Coordinator transactions <---
---> Uncertain transactions <---
---> Active tables <---
in-project     : with 11       records occupying 399      words of mem
project        : with 7        records occupying 367      words of mem
manager        : with 3        records occupying 335      words of mem
employee       : with 7        records occupying 601      words of mem
in-department  : with 7        records occupying 367      words of mem
department     : with 3        records occupying 481      words of mem
schema         : with 7        records occupying 1138     words of mem
===> System info in version "4.22", debug level = none <===
opt_disc. Directory "/Users/oubiwann/lab/lfe/moneta/Mnesia.nonode@nohost" is used.
use fallback at restart = false
running db nodes   = [nonode@nohost]
stopped db nodes   = []
master node tables = []
remote             = []
ram_copies         = []
disc_copies        = [department,employee,'in-department','in-project',
                      manager,project,schema]
disc_only_copies   = []
[{nonode@nohost,disc_copies}] = [schema,department,'in-department',employee,
                                 manager,project,'in-project']
2 transactions committed, 0 aborted, 0 restarted, 0 logged to disc
0 held locks, 0 in queue; 0 local transactions, 0 remote
0 transactions waits for other nodes: []
ok
```

You can quit the REPL now, as we'll restart it in the next section.
