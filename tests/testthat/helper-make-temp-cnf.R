# a function to make a temporary .cnf file for testing

make_temp_cnf <- function(){
  temp.cnf <- tempfile()

  contents <- "[client]
    port = 1234
    host = somehost

    [test_connection_1]
    user = testuser1
    password = testpass1
    database = testdb1

    [test_connection_2]
    user = testuser2
    password = testpass2
    database = testdb2
    \n"

  cat(contents, file = temp.cnf)

  return(temp.cnf)
}
