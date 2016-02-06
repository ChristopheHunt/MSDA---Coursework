library(babynames)
x <- data.frame(babynames)
x.sub1 <- subset(x, year > 2010 & prop > 2.366e-05)
x.sub1

hist(x.sub1$prop)
boxplot(x.sub1$n)
plot(x = x.sub1$n, y = x.sub1$prop)

str(x.sub1)
summary(x)

head(x)

hist(x$prop)
histogram
boxplot
scatterplot

table(x.sub1$name)

summary(x.sub1$)

