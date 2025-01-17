#' Get the N most variable rows from a numeric table
#'
#' Return a subset of an input matrix or data frame, containing only the N most variable rows, sorted. Variability is calculated as the Coefficient of Variation (sd/mean).
#' @param data numeric matrix or data frame
#' @param N integer Number of rows to return (default \code{10}).
#' @return A matrix or data frame (same as input) with the selected rows.
#' @examples
#' data(Hadza)
#' Hadza.carb = subsetFun(Hadza, "Carbohydrate metabolism")
#' # Which are the 20 most variable KEGG functions in the ORFs related to carbohydrate metabolism?
#' topCarb = mostVariable(Hadza.carb$functions$KEGG$tpm, N=20)
#' # Now print them with nice names
#' rownames(topCarb) = paste(rownames(topCarb), Hadza.carb$misc$KEGG_names[rownames(topCarb)], sep="; ")
#' topCarb
#' We can pass this to any R function
#' heatmap(topCarb)
#' But for convenience we provide wrappers for plotting ggplot2 heatmaps and barplots
#' plotHeatmap(topCarb, label_y="TPM")
#' plotBars(topCarb, label_y="TPM")
#' @export
mostVariable = function(data, N = 10)
    {
    if (!is.data.frame(data) & !is.matrix(data)) { stop('The first argument must be a matrix or a data frame') }

    total_items = nrow(data)

    if (N <= total_items) # Do we have at least N items?
        { # Do we have at least N items?
        if (N <= 0)
            {
            stop('N<=0. There is nothing to return')
            }
        } else
            { # User asks for sth impossible
            warning(sprintf('N=%s but only %s items exist. Returning %s items', N, total_items, total_items))
            N = total_items
        }
        items = names(sort(apply(data,1,sd)/apply(data,1,mean), decreasing = T)[1:N])
        

    data = data[items,]

    return(data)
    }

