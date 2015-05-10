#' Weighted Deciles
#'
#' Weighted Cumulative Cumulative Sum of
#'
weighted.deciles <- function(Qv,
                             Wv,
                             decile.title = "",
                             decile.xlab = "",
                             decile.ylab = "",
                             scale.name = "") {

  # clear the plot window

  require(ggplot2)
  require(Hmisc)


  Qsv <- cut(Qv, breaks = wtd.quantile(Qv, weights = Wv, probs = 0:10/10), include.lowest=TRUE, labels=FALSE)



  # calculate max() and min() values for  quartiles. These will be labels on chart

  one.label = paste(round(min(Qv[Qsv == 1]), digit = 2),
                    "-",
                    round(max(Qv[Qsv == 1]), digit =2),
                    " (",round(sum(Wv[Qsv <= 1])),")")

  two.label = paste(round(min(Qv[Qsv == 2]), digit = 2),
                    "-",
                    round(max(Qv[Qsv == 2]), digit =2),
                    " (",round(sum(Wv[Qsv <= 2])),")")

  three.label = paste(round(min(Qv[Qsv == 3]), digit = 2),
                      "-",
                      round(max(Qv[Qsv == 3]), digit =2),
                      " (",round(sum(Wv[Qsv <= 3])),")")

  four.label = paste(round(min(Qv[Qsv == 4]), digit = 2),
                     "-",
                     round(max(Qv[Qsv == 4]), digit =2),
                     " (",round(sum(Wv[Qsv <= 4])),")")

  five.label = paste(round(min(Qv[Qsv == 5]), digit = 2),
                     "-",
                     round(max(Qv[Qsv == 5]), digit =2),
                     " (",round(sum(Wv[Qsv <= 5])),")")

  six.label = paste(round(min(Qv[Qsv == 6]), digit = 2),
                    "-",
                    round(max(Qv[Qsv == 6]), digit =2),
                    " (",round(sum(Wv[Qsv <= 6])),")")

  seven.label = paste(round(min(Qv[Qsv == 7]), digit = 2),
                      "-",
                      round(max(Qv[Qsv == 7]), digit =2),
                      " (",round(sum(Wv[Qsv <= 7])),")")

  eight.label = paste(round(min(Qv[Qsv == 8]), digit = 2),
                      "-",
                      round(max(Qv[Qsv == 8]), digit =2),
                      " (",round(sum(Wv[Qsv <= 8])),")")

  nine.label = paste(round(min(Qv[Qsv == 9]), digit = 2),
                     "-",
                     round(max(Qv[Qsv == 9]), digit =2),
                     " (",round(sum(Wv[Qsv <= 9])),")")

  ten.label = paste(round(min(Qv[Qsv == 10]), digit = 2),
                    "-",
                    round(max(Qv[Qsv == 10]), digit =2),
                    " (",round(sum(Wv[Qsv <= 10])),")")

  data <- data.frame(Qv,Wv,Qsv)

  # title <- ""
  # subtitle <- ""


  # adjust geom_jitter position and alpha to make points easier to see.

  ggplot(data,
         aes(x = factor(Qsv),
             y = Wv, color = Qv)) +
    geom_jitter(
      position = position_jitter(width = .15),
      size = 4,
      alpha = .6) +
    # geom_text(label = ifelse(ramphs$capacity >= 30000, as.character(ramphs$label),""), hjust = .4, vjust = -1, color = "black") +
    theme(legend.text=element_text(size=15),
          axis.text=element_text(size=9, colour = "black")) +
    xlab(decile.xlab) +
    ylab(decile.ylab) +
    scale_colour_gradientn(name = scale.name,colours=rev(rainbow(4))) +
    scale_x_discrete(labels = c(one.label,two.label,three.label, four.label,five.label,six.label,seven.label, eight.label, nine.label, ten.label)) +
    ggtitle(decile.title) +
    theme(plot.title = element_text(lineheight=2, face="bold")) +
    coord_flip()
}
