# Introduction

*A Lispy wrapper for Erlang Mnesia and QLC*

[![][mnemosyne-logo]][mnemosyne-logo-large]

[mnemosyne-logo]: images/mnemosyne-y500.png
[mnemosyne-logo-large]: images/mnemosyne-y2000.png


## 1.1 Credit

This tutorial is adapted (massively copied) from the [LFE Mnesia Tutorial](http://docs.lfe.io/tutorials/mnesia/1.html), which in turn was borrowed from the Erlang/OTP [Mnesia Book](http://www.erlang.org/doc/apps/mnesia/Mnesia_chap1.html) on the Erlang docs site.


## 1.2 About Mnesia

Mnesia is a distributed Database Management System, appropriate for
telecommunications applications and other Erlang applications which require
continuous operation and soft real-time properties.

Mnesia is designed with requirements like the following in mind:

* Fast real-time key/value lookup
* Complicated non real-time queries mainly for operation and maintenance
* Distributed data due to distributed applications
* High fault tolerance
* Dynamic re-configuration
* Complex objects

Due to its focus on telecommunications applications, Mnesia combines many
concepts found in traditional databases, such as transactions and queries with
concepts such as very fast real-time operations, configurable degree of fault
tolerance (by means of replication) and the ability to reconfigure the system
without stopping or suspending it.

Mnesia is also interesting due to its tight coupling to the programming
language Erlang/LFE, thus almost turning Erlang/LFE into a database programming
language.


## 1.3 Add-on Applications

The following add-ons can be used in conjunction with Mnesia to produce
specialized functions which enhance the operational ability of Mnesia:

* QLC has the ability to optimize the query compiler for the Mnesia Database
  Management System, essentially making the DBMS more efficient.
* QLC, can be used as a database programming language for Mnesia. It includes a
  notation called "list comprehensions" and can be used to make complex
  database queries over a set of tables.
* Mnesia Session is an interface for the Mnesia Database Management System
* Mnesia Session enables access to the Mnesia DBMS from foreign programming
  languages (i.e. other languages than Erlang/LFE).


## 1.4 When to Use Mnesia

Use Mnesia with the following types of applications:

* Applications that need to replicate data.
* Applications that perform complicated searches on data.
* Applications that need to use atomic transactions to update several records
  simultaneously.
* Applications that use soft real-time characteristics.

On the other hand, Mnesia may not be appropriate with the following types of
applications:

* Programs that process plain text or binary data files
* Applications that merely need a look-up dictionary which can be stored to
  disc can utilize the standard library module dets, which is a disc based
  version of the module ets.
* Applications which need disc logging facilities can utilize the module
  disc_log by preference.
* Not suitable for hard real time systems.


## 1.5 Prerequisites

In order to work through this tutorial, you will need the following:

* ``git``
* ``make``
* ``rebar3``
* Erlang installed on your system


## 1.6 Using Mnemosyne

The real differences are the modules and the additional utility functions. Module changes from the ``mnesia`` and ``qlc`` Erlang modules are as follows:

* ``mns`` - holds alll the ``mnesia`` functions besides the dirty ones
* ``mns-drty`` - split dirty functions into their own module ("dirty" operations are short-cuts that bypass much of the processing and increase the speed of the transaction)
* ``mns-qry`` - ``qlc`` alias; longer to type than ``qlc``, but provides some nice visual context when scanning code

The utility functions that have been added are as follows:

TBD


## 1.7 Conventions

We use styled call-outs to provide immediate visual cues about the nature of
the information being shared.

These are as follows:

<aside class="info">
This style indicates useful information, background, or other insights.
</aside>

<aside class="success">
This style indicates a best practice, good usage, and other tips for success.
</aside>

<aside class="caution">
This style indicates one should use caution or that behaviour may not be as
expected
</aside>

<aside class="danger">
This style indicates information that could cause errors if ignored.
</aside>
