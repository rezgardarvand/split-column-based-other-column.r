#split column based other column.r
library(data.table)
DT <- fread("plot1   data    plot2   data2 plot3 data3
            a       25       c       28     k     6
            b       46       e       18  NA  NA
            c       21       j       66  NA  NA
            d       32  NA  NA  NA  NA
            e       1   NA  NA  NA  NA")
L <- lapply( split.default(DT, f = 2:(ncol(DT)+1) %/% 2 ),
             function(x) setnames(x, old = grep("^plot", names(x), value = TRUE), new = "plot") )
# merge function
mymerge <- function(x, y) merge.data.table(x, y, all = TRUE, by = "plot", allow.cartesian = TRUE)
# full merge all the data.table in the list L using Reduce()
ans <- Reduce(mymerge, L)[!is.na(plot), ]
# replace NA with 0 (zero)
ans[is.na(ans)] <- 0


