% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/loadData.R
\name{loadData}
\alias{loadData}
\title{Convenience function for loading data.}
\usage{
loadData(prefix, suffix = NULL, file_ext = "csv", verbose = TRUE,
  data_path = "./input", reader = NULL, ...)
}
\arguments{
\item{prefix}{Either the full name of the file to load (e.g.,
\code{"train_features.csv"} or the prefix of the file to load.  If the full
name is used then the \code{suffix} parameter should be \code{NULL} and the
file extension should be included.}

\item{suffix}{Suffix of the data file to load. This parameter could be useful
when interating through features; e.g., in a for loop. (default is \code{NULL})}

\item{file_ext}{Determines the file extension of the file to load.
\code{loadData()} calls the appropriate function to load the data.
Accepted values are \code{"csv", "rds", "rda", "xgb"}.  If
\code{file_ext = "xgb"} then the file to load is expected to be an
xgb model.  (default is \code{"csv"})}

\item{verbose}{Whether or not to print details about the file being loaded.
(default is \code{TRUE})}

\item{reader}{Function to read the data from disk.
(default is \code{NULL}, the reader function is inferred from \code{file_ext})}

\item{...}{Additional parameters to pass the load function.}
}
\value{
The desired data to be loaded.
}
\description{
The function recusively looks for the desired file in \code{"./input"}.
The name of data file should follow the following naming convention:
\code{prefix} and a \code{suffix} seperated by an underscore.
Use dashes to seperate terms in the \code{prefix} and \code{suffix}.
For example, \code{"train-stage1_tfidf-sublinear.csv"}.
}
\examples{
# load "./input/**/train_features.csv"
loadData("train_features")

# loads "./input/**/train_features.csv"
loadData("train", suffix="features")

# loads "./input/**/train_features.rds"
loadData("train", suffix="features", file_ext="rds")

}
\seealso{
\code{\link{saveData}} The complimentary function to \code{loadData}.
Data is saved with a naming convention compatible with \code{loadData}.
}
\keyword{load}
