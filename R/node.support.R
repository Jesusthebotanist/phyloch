# TO DO
# clear up code (if else statements)
# adapt documentation
# produce fig3


node.support <-
function(x, transfer, cutoff = 0, digits, mode = "numbers", font = 2, pos = "pretty", cex = 0.8, col, legend = FALSE, node, ...){
	
	if (missing(col)) col <- "black"
	
	# reorder node numbers for node labels transferred from
	# source to target tree
	# ---------------------
	if (!missing(transfer)){
	    id <- match.nodelabels(transfer[[1]], transfer[[2]])
	    x <- x[id]	
	}
	
	## convert to numeric
  if ( is.vector(x) ) x <- as.numeric(x)
  else x <- sapply(x, as.numeric)
	supported <- which(x >= cutoff)
  if ( !missing(digits) ) x <- round(x, digits)
	
	mode <- match.arg(mode, c("numbers", "dots", "edges"))
	
	# create vector of node colors
	twocolor <- x
	twocolor[supported] <- col[1]
	twocolor[-supported] <- col[2]
	
	
	lastPP <- get("last_plot.phylo", envir = .PlotPhyloEnv)
	if ( missing(node) ) 
	  node <- (lastPP$Ntip + 1):length(lastPP$xx)
	XX <- lastPP$xx[node]
	YY <- lastPP$yy[node]
	
	# plot support values as NUMBERS:
	# -------------------------------
	if ( mode == "numbers" ){		
		if ( pos == "pretty" ) {
			
			# internal nodes without root node
			intN <- lastPP$Ntip + (2:lastPP$Nnode)
			# subtending nodes
			intNN <- lastPP$edge[lastPP$edge[, 2] %in% intN, 1]
			labelW <- strwidth(x[-1], cex = cex) * 1.1
			edgeW <- lastPP$xx[intN] - lastPP$xx[intNN]
			
			clue1 <- edgeW < labelW 
			SN <- function(e, n){
				x <- e[, 1][e[, 2] == n]
        	    x <- e[, 2][e[, 1] == x]
        	    x[x != n]
			}
			sN <- sapply(intN, SN, e = lastPP$edge)
			clue2 <- intN < sN | sN <= lastPP$Ntip
			print(clue2)
			clue <- clue1 & clue2
			clue <- c(FALSE, clue) # add root
			for ( i in supported ){
			
			    if ( clue[i] )
			       nodelabels(text = x[i], node = i + lastPP$Ntip, 
			           adj = c(1.1, 1.3), font = font, frame = "n", 
			           cex = cex, col = col, ...) 
			    else 
			        nodelabels(text = x[i], node = i + lastPP$Ntip, 
			            adj = c(1.1, -.3), font = font, frame = "n", 
			            cex = cex, col = col, ...)	
		    }		
		} # end of pos == "pretty"
		else {
			if ( pos == "above" ) thisadj <- c(1.1, -.3)    
		    if ( pos == "below" ) thisadj <- c(1.1, 1.3)
		    if ( pos == "right" ) thisadj <- c(-.2, .5)
        x[-supported] <- NA
		    nodelabels(x, adj = thisadj, font = font, 
		        frame = "n", cex = cex, col = col, ...)
		}
	} # end of mode == "numbers"
	
	# plot support values as DOTS:
	# -------------------------------
	if (mode == "dots"){
		points(XX, YY, pch = 19, col = twocolor, 
		    bg = twocolor, cex = cex, ...)
			if (legend){
				xy = locator(2)
				x.points <- rep(xy$x[1], 2)
				y.range <- xy$y[1] - xy$y[2]
				step <- y.range/(2-1)
				y.points <- xy$y[1]
				y.points <- c(y.points, y.points - step)
				x.text <- x.points + xy$x[2] - xy$x[1]
				info <- c(paste(">=",  cutoff), 					paste("<",  cutoff))
				points(x.points, y.points, pch = 21, cex = cex * 6, bg = col)
				text(x.text, y.points, adj=c(0, .55), labels = info)
			}	
	}
	
	# plot support values as thickened EDGES:
	# ---------------------------------------
	if (mode == "edges"){
		
		sn <- supported + lastPP$Ntip
		
		edges <- lastPP$edge
		edges <- edges[edges[, 2] %in% sn,]
		
		ls <- max(lastPP$xx) * 0.000

		for (i in 1:dim(edges)[1]){
			node1 <- edges[i, 1]
			node2 <- edges[i, 2]
			lines(c(lastPP$xx[node1] - ls, lastPP$xx[node2]), 
				rep(lastPP$yy[node2], 2), col = col, lwd = cex, lend = 1)
		}
	}
	invisible(x)
}
