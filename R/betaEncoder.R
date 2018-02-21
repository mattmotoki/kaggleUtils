#' Likelihood encoding of categorical feautres and binary target variable.
#' 
#' This function uses likelihood encoding to map categorical variables in to 
#' a numeric value such.  The beta distrubution is used as a prior (the 
#' conjugate prior of the bernoulli distribution).  The parameters of the 
#' prior are taken to be \eqn{alpha = n*p} and \eqn{beta = n*(1-p)} where
#' \eqn{n} is the population size and \eqn{p} is the population mean.  New
#' values are mapped to a random value from the \eqn{Beta(alpha+a, beta+b)} 
#' with \eqn{a} being number of successes in the group and \eqn{b} being number
#' failures.
#' 
#' @import data.table
#'
#' @param target target variable (default is \code{NULL})
#' @param group group variable 
#' @param seed random seed (default is \code{sample(1e6, 1)})
#' 
#' @export
betaEncoder <- function(target, train_group, test_group, prior_strength=1) {
  
  # calculate prior
  p <- mean(target)
  n <- prior_strength*sqrt(table(c(train_group, test_group)))
  
  alpha <- n*p
  beta <- n*(1-p)
  
  # calculate counts
  counts <- data.table(target=target, group=train_group)
  counts <- counts[, .(
    a = sum(target),
    b = .N-sum(target)
  ), by=group]

  # map counts to posterior encodings
  function(new_groups) {
    x <- rbeta(length(new_groups), alpha, beta) 
    for (g in counts[, group]) {
      inds <- which(new_groups==g)
      x[inds] <- rbeta(
        length(inds),
        alpha[as.character(g)] + counts[group==g, a], 
        beta[as.character(g)] + counts[group==g, b]
      ) 
    }
    return(x)
  }
}
