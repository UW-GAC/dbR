
[![Travis-CI Build Status](https://travis-ci.org/UW-GAC/dbR.svg?branch=develop)](https://travis-ci.org/UW-GAC/dbR)[![Coverage Status](https://coveralls.io/repos/github/UW-GAC/wgsadbworkr/badge.svg?branch=master)](https://coveralls.io/github/UW-GAC/wgsadbworkr?branch=master)

### dbR

**Disclaimer:** This code is very much under *development*. If you use it, it may leave your computer a smoking crater on your desk.

dbR contains some utility functions for working with the in-house databases at the University of Washington Genetic Analysis Center (UW GAC).

### Installation

``` {.r}
devtools::install_github("UW-GAC/dbR")
```

### Quick demo

Get list of mySQL databases described in a \~/.mysql.cnf file via `list_from_cnf()`:

``` {.r}
library(dbR)
databases <- list_from_cnf('~/.mysql.cnf')
```

Get a mysql database connection to a database, `testdb`, which is listed in your .mysql.cnf file:

``` {.r}
con <- get_db_mysql("testdb")
```

or in a different .cnf file:

``` {.r}
con <- get_db_mysql("testdb", config = "~/.custom.cnf")
```

Get a dplyr sql src object connection to `testdb`:

``` {.r}
con <- dplyr_connect("testdb")
```

or to a different .cnf file:

``` {.r}
con <- dplyr_connect("testdb", config = "~/.custom.cnf")
```
