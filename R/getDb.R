#' Obtain a database connection
#' 
#' @param test Logical indicator of whether to connect to the test database instead of the production database
#' @param devel Logical indicator of whether to connect to the devel database instead of the production database
#' @param write Logical indicator of whether to connect with write permission instead of read-only permission
#' @param verbose Logical indicator of whether to print information about the connection
#' @param strict Logical indicator of whether to connect using strict mode in MySQL instead of the default mode
#' @param utc Logical indicator of whether to set the timezone to UTC instead of the server time zone
#' @param autocommit Logical indicator of whether to use mysql's autocommit instead of running everything in an implicit transaction
#' @param cnf_file Path to the mysql configuration file on disk
#' 
#' @return
#' A connection to the TOPMed phentoype database
#' 
#' @details
#' Both \code{test} and \code{devel} cannot both be true.
#' 
#' In general none of these parameters should be changed when calling \code{getDb}
#' interactively. Connections to the production database from workstations with write
#' privileges are not allowed.
#' 
#' @examples
#' db <- getDb(test=TRUE)
#' dbDisconnect(db)
#' 
#' @seealso \code{\link[DBI]{dbGetQuery}}, \code{\link[DBI]{dbDisconnect}}
#' 
#' @export
## this will all change once the new database is set up
getDb <- function(test = FALSE, devel = FALSE, write = FALSE, verbose = TRUE, strict = TRUE, utc = TRUE, autocommit = FALSE, cnf_file = "~/.mysql-topmed.cnf"){

  if (devel & test) {
    msg <- "set either devel or test, but not both"
    stop(msg)
  }

  production_flag <- !test & !devel
  
  suffix <- NA
  if (test) {
    suffix <- "_test"
  } else if (devel) {
    suffix <- "_devel"
  } else {
    suffix <- "_production"
  }

  write_string <- ifelse(write, "_full", "_readonly")
  cnf_group <- paste0("mysql_topmed_pheno", write_string, suffix)

  host <- Sys.info()[["nodename"]]
  
  if (write & production_flag & !.hostHasWritePrivileges(host)){
    msg <- "host not in allowed hosts for production database!"
    stop(msg)
  }
  
  db <- dbConnect(MySQL(), default.file = cnf_file, group = cnf_group)

  if (strict){
    # set sql strict mode
    dbGetQuery(db, "SET @@SQL_MODE  =  'TRADITIONAL'")
  }
  
  if (utc) {
    # set timezone to utc
    dbGetQuery(db, "SET time_zone  =  '+00:00'")
  }
  
  if (!autocommit) {
    dbGetQuery(db, "SET autocommit  =  0")
  }
  
  # possibly could do some checks
  #info <- dbGetInfo(db)
  if (verbose){
    summary(db)
  }

  if (write & production_flag) {
    message(sprintf("You are connecting to the production database '%s' with write privileges!", dbGetInfo(db)$dbname))
  }
  
  db
}

#' Check if a hostname can write to the production database
#' 
#' @param hostname The hostname to check, e.g. \code{"neyman"}
#' 
#' @details
#' The hostname should be returned from \code{Sys.info()[["nodename"]]}
#' 
#' @return 
#' \code{TRUE} if the host has write privileges for the production database, otherwise \code{FALSE}
#' 
#' @rdname hostHasWritePrivileges
.hostHasWritePrivileges <- function(hostname){
  grepl(paste(HOSTS_ALLOWED_TO_WRITE_TO_PRODUCTION, collapse="|"), hostname)
}
