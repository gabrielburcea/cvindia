#' firstup
#'
#' @param x 
#'
#' @return
#' @export
#'
#' @examples
firstup <- function(x) {
  substr(x, 1, 1) <- toupper(substr(x, 1, 1))
  x
}



#' simpleCap 
#'
#' @param x 
#'
#' @return first letter of a string into upper case 
#' @export
#'
#' @examples
simpleCap <- function(x) {
  s <- strsplit(x, " ")[[1]]
  paste(toupper(substring(s, 1,1)), substring(s, 2),
        sep="", collapse=" ")
}
