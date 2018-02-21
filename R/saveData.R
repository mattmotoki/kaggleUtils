#' Convenience function for saving data.
#'
#' The function saves the desired data in the \code{"./input/*"} directory.
#' The name of data file will adhere the following naming convention:
#' \code{prefix} and a \code{suffix} seperated by an underscore.
#' Use dashes to seperate terms in the \code{prefix} and \code{suffix}.
#' For example, \code{"train-stage1_tfidf-sublinear.csv"}.
#'
#' @import data.table
#' @import jsonlite
#'
#' @param prefix Either the full name of the file to save (e.g.,
#' \code{"train_features.csv"} or the prefix of the file to save.  If the full
#' name is used then the \code{suffix} parameter should be \code{NULL} and the
#' file extension should be included.
#'
#' @param suffix Suffix of the data file to save This parameter could be useful
#' when interating through features; e.g., in a for loop. (default is \code{NULL})
#'
#' @param folder Folder within \code{"./input/"} to save
#' the file in. (default is \code{NULL})
#'
#' @param subfolder Subfolder with in \code{folder} to save the file in.
#' (default is \code{NULL})
#'
#' @param file_ext Determines the file extension of the file to save
#' \code{saveData()} calls the appropriate function to save the data.
#' Accepted values are \code{"csv", "rds", "rda", "xgb"}.  If
#' \code{file_ext = "xgb"} then the file to save is expected to be an
#' xgb model.  (default is \code{"csv"})
#'
#' @param overwrite Whether or not an existing file with the same name should be
#' overwritten. If \code{overwrite=NA} then the user is asked whether the file
#' should be overwritten.  (default is \code{TRUE})
#'
#' @param verbose Whether or not to print details about the file being saved
#' (default is \code{TRUE})
#'
#' @param ... Additional parameters to pass the save function.
#'
#' @seealso \code{\link{loadData}} The complimentary function to \code{saveData}.
#'
#' @examples
#' # save "train_features.csv" in ./Data/clusters/skmeans
#' saveData("train_features", folder="clusters", subfolder="skmeans")
#'
#' # save "train_features.csv"
#' saveData("train", suffix="features")
#'
#' # save "train_features.rds"
#' saveData("train", suffix="features", file_ext="rds")
#'
#' @keywords save
#' @export

saveData <- function(dt, prefix, suffix=NULL, folder=NULL, subfolder=NULL,
                     file_ext="csv", overwrite=TRUE, verbose=TRUE, data_path='./input', ...) {

  getInput <- function() {
    cat("   The file", file_name, "already exists.\n")
    cat("   Do you want to overwrite it? (T/F)")
    as.logical(readline(prompt="   "))
  }

  # create file name
  parseNULL <- function(prefix, x) ifelse(is.null(x), "", paste0(prefix, x))
  file_name <- sprintf("%s%s.%s", prefix, parseNULL("_", suffix), file_ext)

    # add path to the file name
  folder    <- parseNULL("/", folder)
  subfolder <- parseNULL("/", subfolder)
  full_path <- sprintf("%s%s%s/", data_path, folder, subfolder)
  full_name <- paste0(full_path, file_name)

  # try to save the file
  if (file.exists(full_name)) {
    while (!is.logical(overwrite) || is.na(overwrite)) { overwrite <- getInput()}
  } else {overwrite <- TRUE}

  if (overwrite) {
    dir.create(full_path, showWarnings=F, recursive=T)
    if (verbose) cat("Saving", file_name, "\n")
    switch(
      file_ext,
      csv = fwrite,
      rds = saveRDS,
      xgb = xgb.save,
      json = write,
      stop(sprintf("Could not save %s.  Please check file extension.", file_name))
    )(dt, full_name, ...)
  }
}
