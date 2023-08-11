# moneta

[![Build Status][gh-actions-badge]][gh-actions]
[![LFE Versions][lfe badge]][lfe]
[![Erlang Versions][erlang badge]][versions]
[![Tags][github tags badge]][github tags]

*A Lispy wrapper for Erlang Mnesia and QLC*

[![][logo]][logo-large]

##### Table of Contents

* [Introduction](#introduction-)
* [Documentation](#documentation-)
* [Modules](#modules-)
* [Resources](#resources-)
* [License](#license-)


## Introduction [&#x219F;](#contents)

This project is mostly a wrapper around the Erlang/OTP ``mnesia`` and ``qlc`` modules. That being said, it does provide the additional following benefits:

* functions and macros for easily creating tables
* additional convenience functions
* Lisp-friendly wrapper functions for Mnesia functions (i.e., hyphens!)


## Documentation [&#x219F;](#contents)

Documentation for Moneta is available in the following forms:

* [Moneta Tutorial](http://lfex.github.io/moneta/)

## Modules [&#x219F;](#contents)

The Erlang namespaces for the modules (ab)used by this project are the following:

* ``mnesia``
* ``qlc``

These are accessible via those same module names in LFE, or using this library, from the following:

* ``mnta`` - holds alll the ``mnesia`` functions besides the dirty ones
* ``mnta-drty`` - split dirty functions into their own module ("dirty" operations are short-cuts that bypass much of the processing and increase the speed of the transaction)
* ``mnta-qry`` - ``qlc`` alias; longer to type than ``qlc``, but provides some nice visual context when scanning code

Function names in the ``mnta*`` modules have the Erlang underscores replaced with LFE hyphens. This work is done via the LFE [kla](https://github.com/lfex/kla) library.


## Resources [&#x219F;](#contents)

* [Mnesia in LYSE](http://learnyousomeerlang.com/mnesia) - One of the best learning-Mnesia resources on the web. Or in print -- buy the book!
* The official [Mnesia docs](http://erlang.org/doc/apps/mnesia/Mnesia_chap1.html)
  * [mnesia module](http://erlang.org/doc/man/mnesia.html)
  * [qlc module](http://erlang.org/doc/man/qlc.html)


## License [&#x219F;](#contents)

```
Copyright © 2016-2023 Duncan McGreggor

Distributed under the Apache License, Version 2.0.
```

Original Mnesia documentation upon which the Moneta tutorial is based:

```
Copyright © 1997-2016 Ericsson AB. All Rights Reserved.
```

[//]: ---Named-Links---

[gh-actions-badge]: https://github.com/lfex/moneta/workflows/ci%2Fcd/badge.svg
[gh-actions]: https://github.com/lfex/moneta/actions
[logo]: priv/images/mnemosyne-y500.png
[logo-large]: priv/images/mnemosyne-y2000.png
[lfe]: https://github.com/lfe/lfe
[lfe badge]: https://img.shields.io/badge/lfe-2.1-blue.svg
[erlang badge]: https://img.shields.io/badge/erlang-20%20to%2026-blue.svg
[versions]: https://github.com/lfex/moneta/blob/master/.github/workflows/cicd.yml
[github tags]: https://github.com/lfex/moneta/tags
[github tags badge]: https://img.shields.io/github/tag/lfex/moneta.svg
