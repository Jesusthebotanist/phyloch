\name{HPDbars}
\Rdversion{1.1}
\alias{HPDbars}

\title{Plot HPD Intervals on Time-calibrated Phylogenies}

\description{
This function plots highest posterior density (HPD) intervals of node ages derived from BEAST (or other molecular dating) analyses. The default of the \code{label} argument works with objects generated by \code{\link{read.beast}} and \code{\link{read.beast.table}}.
}

\usage{
HPDbars(phy, label = "height_95\%_HPD", tab = NULL, nodes, 
	col, lwd, broken = FALSE, ...)
}

\arguments{
  \item{phy}{An object of class \code{phylo}.}
  
  \item{label}{A character string used to identify the columns or list elements for plotting (see details).}
  
  \item{tab}{A matrix, containg at least three columns.}
  
  \item{nodes}{A vector of mode \code{numeric}, giving the number of nodes for which HPD intervals will be plotted; if omitted, HPD intervals will be plotted for all nodes.}
  
  \item{col}{A character string, the color for the HPD bars}
  
  \item{lwd}{An integer, the thickness (\bold{l}ine \bold{w}i\bold{d}th) for the HPD bars}
  
  \item{broken}{Logical, if \code{broken == TRUE}, those HPDbars that project beyond the age of the root are depicted as 'broken' bars.}
  
  \item{...}{Further graphical parameters may also be supplied as arguments.}
}

\details{
The \code{label} argument identifies those two elements of a \code{phylo} object (if \code{tab = NULL}) or columns names of matrix (specified by the \code{tab} argument) that give upper and lowers bounds for ranges or HPDs. The upper and the lower bound have to be characterized by the additon of \code{_MAX} and\code{_MIN} to the label string. Hence, in a typical BEAST analysis, you can choose between \code{"rate_range"}, \code{"rate_95\%_HPD"}, \code{"height_range"}, and \code{"height_95\%_HPD"} (the default) for \code{label}.
}

\author{Christoph Heibl}

\note{Currently, \code{HPDbars} works only with \code{plot.phylo(type = "phylogram")}.
}

\seealso{
\code{\link{read.beast}} and \code{\link{read.beast.table}} to read BEAST/TreeAnnotaor output; \code{\link{plot.phylo.upon}} plots a phylogeny with 'transparent' background; \code{\link{node.support}} can be used to show posterior probablities, rates, etc.; \code{\link{axisChrono}} to add a time-scale.
}

\examples{
# a BEAST analysis of wild barley
# -------------------------------
data(hordeum)

# plot tree invisibly to define the plotting region
# -------------------------------------------------
plot(hordeum, edge.color = 0, tip.color = 0)

# plot highest posterior density bars
# note the warning message!
# -------------------------
HPDbars(hordeum, col = "skyblue", lwd = 5)

# plot tree again with transparent background
# -------------------------------------------
plot.phylo.upon(hordeum)


# the same plot but with x.lim set to the values
# issued by the HPDbars warning message
# -------------------------------------
plot(hordeum, edge.color = 0, tip.color = 0, 
    x.lim = c(-5.24603, 23.26244))
HPDbars(hordeum, col = "skyblue", lwd = 5)
plot.phylo.upon(hordeum)
}