#' Finds the most common value in a vector.
#' 
#' @param x Input vector.
#' 
#' @export
mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}
