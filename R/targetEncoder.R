#' Mean encoding of categorical features
#'
#' @import data.table
#'
#' @param target target variable (default is \code{NULL})
#' @param group group variable
#' @param seed random seed (default is \code{sample(1e6, 1)})
#'
#' @export
targetEncoder <- function(target, group) {

  # aggregate
  counts <- data.table(target=target, g=group)
  counts <- counts[, .(a=sum(target), .N), by=g]

  # lookup tables
  alpha <- mean(target)*length(target)
  train_counts <- counts[, setNames((a + alpha)/(N+alpha), g)]
  test_counts <- counts[, setNames(a/N, g)]

  # map counts to posterior encodings
  function(new_groups, type="train") {
    if (type=="train")
      train_counts[as.character(new_groups)]
    else
      test_counts[as.character(new_groups)]
  }
}
