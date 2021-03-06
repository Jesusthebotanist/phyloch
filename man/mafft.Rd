\name{mafft}
\alias{mafft}

\title{DNA Sequence Alignment with MAFFT}

\description{
The function is a wrapper to MAFFT an can be used for sequence and profile aligning.}

\usage{
mafft(x, y, add, method = "localpair", maxiterate = 1000, op = 1.53, 
    ep = 0.0, path, quiet)
}

\arguments{
	
  \item{x}{an object of class \code{DNAbin}.}
  
  \item{y}{an object of class \code{DNAbin}, if given both \code{x} and \code{y} are preserved and aligned to each other ("profile alignment").}
  
  \item{add}{a character string giving the method used for adding \code{y} to \code{x}: \code{"add"}, \code{"addprofile"} (default), or any unambiguous abbreviatin of these.}
  
  \item{method}{a character string giving the alignment method. Available accuracy-oriented methods for less than 200 sequences are \code{"localpair"}, \code{"globalpair"}, and \code{"genafpair"} as well as \code{"retree 1"} and  \code{"retree 2"}for speed-oriented alignment.}
  
  \item{maxiterate}{an integer giving the number of cycles of iterative refinement to perform; default 1000}
  
  \item{op}{a numeric giving the \code{gap opening penalty} at group-to-group alignment; default 1.53}
  
  \item{ep}{a numeric giving the offset value, which works like \code{gap extension penalty}, for group-to-group alignment; default 0.0}
  
  \item{path}{a character string indicating the path to the MAFFT executable.}
  
  \item{quiet}{logical: if set to \code{TRUE}, mafft progress is printed out on the screen}
  
}

\details{
\code{"localpair"} selects the \bold{L-INS-i} algorithm, probably most accurate; recommended for <200 sequences; iterative refinement method incorporating local pairwise alignment information.

\code{"globalpair"} selects the \bold{G-INS-i} algorithm suitable for sequences of similar lengths; recommended for <200 sequences; iterative refinement method incorporating global pairwise alignment information.

\code{"genafpair"} selects the \bold{E-INS-i} algorithm suitable for sequences containing large unalignable regions; recommended for <200 sequences.

\code{"retree 1"} selects the \bold{FFT-NS-1} algorithm, the simplest
progressive option in MAFFT; recommended for >200 sequences.

\code{"retree 2"} selects the \bold{FFT-NS-2} algorithm that use an second iteration of alignment based on a guide tree computed from an FFT-NS-1 aligment; recommended for >200 sequences.
}

\value{
  A \code{matrix} of class \code{"DNAbin"}.
}

\references{
	
	Katoh, K. and H. Toh. 2008. Recent developments in the MAFFT 
	multiple sequence alignment program. 
	\emph{Briefings in Bioinformatics} \bold{9}: 286-298.
	
	Katoh, K., K.-i. Kuma, H. Toh, and T. Miyata. 2005. Mafft 
	version 5: improvement in accuracy of multiple sequence 
	alignment. \emph{Nucleic Acids Research} \bold{33}: 511--518. 
	
	Katoh, K., K. Misawa, K.-i. Kuma, and T. Miyata. 2002. 
	Mafft: a novel method for rapid multiple sequence alignment 
	based on fast Fourier transform. \emph{Nucleid Acids Research} 
	\bold{30}: 3059--3066.
	
	\url{http://align.bmr.kyushu-u.ac.jp/mafft/software/}
	
}

\note{\code{mafft} was last updated and tested to work with MAFFT 7.032. If you have problems getting the function to work with a newer version of MAFFT, please contact the package maintainer.}

\author{Christoph Heibl}

\seealso{
\code{\link{read.fas}} to import DNA sequences;
  \code{\link{prank}} for another alignment algorithm;
	\code{\link{gblocks}} and \code{\link{aliscore}} for alignment cleaning.
}
