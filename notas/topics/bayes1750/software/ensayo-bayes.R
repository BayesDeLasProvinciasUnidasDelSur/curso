# install.packages("manipulate")
library(manipulate)

x <- runif(1, 0, 1)
y <- runif(1, 0, 1)

table <- function(reset, addBall, add10Balls) {
  if (reset) {
    x <<- runif(1, 0, 1)
    y <<- runif(1, 0, 1)
  }
  if (addBall) {
    x <<- append(x, runif(1, 0, 1))
    y <<- append(y, runif(1, 0, 1))
  }
  if (add10Balls) {
    x <<- append(x, runif(10, 0, 1))
    y <<- append(y, runif(10, 0, 1))
  }
  cols <- ifelse(x < x[1],'red','green')
  cols[1] <- 'black'
  exitos <- sum(cols == 'green')
  total <- length(x)-1
  prop <- ifelse(total == 0, 'indefinido', exitos / total)
  plot(x, y,
       asp=1,
       xlim=c(0,1), ylim=c(0,1),
       col= cols,
       main=paste("P =", 1-x[1], "\n",
                  "Total =", total, "\n",
                  "Éxitos/Total =", prop))
  abline(v=0)
  abline(v=1)
  abline(h=0)
  abline(h=1)
}
manipulate(
  table(reset, addBall, add10Balls),
  reset=button("Reset"),
  addBall=button("Agregar bolita"),
  add10Balls=button("Agregar 10 bolitas"))



# install.packages("shiny")
# install.packages("ggplot2")
# install.packages("png")
# install.packages("markdown")
# install.packages("knitr")
#· library('shiny')
# shiny::runGitHub('IS606', 'jbryer', subdir='inst/shiny/BayesBilliards')
