#' Convenience function for loading data.
#'
#' The function recusively looks for the desired file in \code{"./input"}.
#' The name of data file should follow the following naming convention:
#' \code{prefix} and a \code{suffix} seperated by an underscore.
#' Use dashes to seperate terms in the \code{prefix} and \code{suffix}.
#' For example, \code{"train-stage1_tfidf-sublinear.csv"}.
#'
#' @import data.table
#' @importFrom xgboost xgb.load
#' @importFrom jsonlite fromJSON
#'
#' @param prefix Either the full name of the file to load (e.g.,
#' \code{"train_features.csv"} or the prefix of the file to load.  If the full
#' name is used then the \code{suffix} parameter should be \code{NULL} and the
#' file extension should be included.
#'
#' @param suffix Suffix of the data file to load. This parameter could be useful
#' when interating through features; e.g., in a for loop. (default is \code{NULL})
#'
#' @param file_ext Determines the file extension of the file to load.
#' \code{loadData()} calls the appropriate function to load the data.
#' Accepted values are \code{"csv", "rds", "rda", "xgb"}.  If
#' \code{file_ext = "xgb"} then the file to load is expected to be an
#' xgb model.  (default is \code{"csv"})
#'
#' @param verbose Whether or not to print details about the file being loaded.
#' (default is \code{TRUE})
#'
#' @param ... Additional parameters to pass the load function.
#'
#' @seealso \code{\link{saveData}} The complimentary function to \code{loadData}.  Data
#' is saved with a naming convention compatible with \code{loadData}.
#'
#' @return The desired data to be loaded.
#'
#' @examples
#' # load "./input/**/train_features.csv"
#' loadData("train_features")
#'
#' # loads "./input/**/train_features.csv"
#' loadData("train", suffix="features")
#'
#' # loads "./input/**/train_features.rds"
#' loadData("train", suffix="features", file_ext="rds")
#'
#' @keywords load
#'
#' @export

loadData <- function(prefix, suffix=NULL, file_ext="csv", verbose=TRUE, data_path='./input',...) {


  # parse NULL inputs
  parseNULL <- function(prefix, x) ifelse(is.null(x), "", paste0(prefix, x))
  file_name <- sprintf("%s%s.%s", prefix, parseNULL("_", suffix), file_ext)

  # lookup file
  all_files <- dir(data_path, recursive=T, full.names=T)
  full_name <- all_files[grepl(paste0("/", file_name), all_files)]

  # check if file can be loaded
  if (length(full_name)>=2L)
    stop(sprintf("Multiple files found for %s:\n%s",
                 file_name, paste(full_name, collapse="\n")))

  if (length(full_name)==0L)
    stop(sprintf("%s not found", file_name))

  # load file
  if (verbose) cat("Loading", file_name, "\n")
  switch(
    file_ext,
    csv = fread,
    tsv = fread,
    rds = readRDS,
    rda = load,
    xgb = xgb.load,
    json = fromJSON,
    stop(sprintf("Could not load %s", file_name))
  )(full_name, ...)
}
