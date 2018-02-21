#' Wrapper to convert a data.table to an lgb.Dataset
#'
#' @import data.table
#' @import lightgbm
#'
#' @param DT data.table to convert
#' @param p value to pass to \code{overSample} (default is \code{p=0})
#'
#' @export
dt2lgb <- function(DT, ...) {
  loadNamespace("data.table")
  loadNamespace("lightgbm")

  # set up additional information
  info_list <- list(...)
  info_list[["label"]] <- DT[["target"]]

  # convert data.table
  feat_cols <- setdiff(names(DT), c("id", "target"))
  lgb.Dataset(as.matrix(DT[, ..feat_cols]), info=info_list)
}
