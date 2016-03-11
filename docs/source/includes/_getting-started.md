# Getting Started

## Download Moneta

> Download the project source code:

```bash
$ git clone https://github.com/lfex/moneta
$ cd moneta
```

> Next, get all the dependencies downloaded and built:

```bash
$ make
```

The moneta project offers some convenience wrappers for the Erlang/OTP ``mnesia`` and ``qlc`` modules. To walk through the tutorial, you'll need to download the project source code.

Once you have the code built, you're ready to go :-) Now you can start the LFE REPL, letting it know where to save your data.

> Start LFE and let it know where you data will be saved:

```bash
$ lfe -mnesia dir '"/tmp/funky"'
```

> Once in the REPL, you're ready to start dataing:

```
Erlang/OTP 17 [erts-6.2] [source] [64-bit] [smp:4:4] ...

   ..-~.~_~--..
  (      \\    )     |   A Lisp-2+ on the Erlang VM
  |`-.._/_\\_.-';    |   Type (help) for usage info.
  |         g (_ \   |
  |        n    | |  |   Docs: http://docs.lfe.io/
  (       a    / /   |   Source: http://github.com/rvirding/lfe
   \     l    (_/    |
    \   r     /      |   LFE v0.11.0-dev (abort with G^)
     `-E___.-'

>
```


## First Run

> Create a schema, asking Moneta to start the Mnesia database for you automatically:

```cl
> (mnt:create-schema #(start true))
ok
```

> Now create a defaul table (with no provided table definition):

```cl
> (mnt:create-table 'funky)
#(atomic ok)
>
```

From the LFE REPL you can create a new database on disk, start Mnesia
up, and then create a table. After creating the table, you can examine the table's metadata.

> We can take a look at our creation with this command:

```cl
> (mnt:info)
```

> Which should give you something like this:

```
---> Processes holding locks <---
---> Processes waiting for locks <---
---> Participant transactions <---
---> Coordinator transactions <---
---> Uncertain transactions <---
---> Active tables <---
funky          : with 0        records occupying 317      words of mem
schema         : with 2        records occupying 541      words of mem
===> System info in version "4.8", debug level = none <===
opt_disc. Directory "/tmp/funky" is used.
use fallback at restart = false
running db nodes   = [nonode@nohost]
stopped db nodes   = []
master node tables = []
remote             = []
ram_copies         = [funky]
disc_copies        = [schema]
disc_only_copies   = []
[{nonode@nohost,disc_copies}] = [schema]
[{nonode@nohost,ram_copies}] = [funky]
3 transactions committed, 0 aborted, 0 restarted, 2 logged to disc
0 held locks, 0 in queue; 0 local transactions, 0 remote
0 transactions waits for other nodes: []
ok
```

You can quit the REPL now, as we'll restart it in the next section.
