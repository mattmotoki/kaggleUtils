#' Wrapper to convert a data.table to an xgb.DMatrix.
#'
#' @import data.table
#' @importFrom xgboost xgb.DMatrix
#'
#' @param DT data.table to convert
#' @param p value to pass to \code{overSample} (default is \code{p=0})
#'
#' @export
dt2xgb <- function(DT, ...) {

  # set up additional information
  info_list <- list(...)
  info_list[["label"]] <- DT[["target"]]

  # convert data.table
  feat_cols <- setdiff(names(DT), c("id", "target"))
  xgb.DMatrix(as.matrix(DT[, ..feat_cols]), info=info_list)
}

