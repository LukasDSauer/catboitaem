# Libraries necessary for this plot
library(emmeans)
library(ggplot2)
library(lme4) # Only needed for the data set

# Data and regression model
data(sleepstudy)
mod <- lm(Reaction ~ Days, data=sleepstudy)
gr <- ref_grid(mod, cov.keep= c("Days"))
emm <- emmeans(gr, spec= c('Days'), level= 0.95)

# Plot
ggplot(data = sleepstudy, mapping = aes(x = Days, y = Reaction, col = Subject)) +
  geom_line() +
  geom_line(data = data.frame(emm), mapping = aes(y = emmean, col = NULL)) +
  geom_ribbon(data = data.frame(emm), mapping = aes(ymin= lower.CL, ymax= upper.CL, y= NULL, col = NULL), fill= 'grey80', alpha = .5) +
  labs(x = "Sleep deprivation [days]",
       y = "Reaction time [ms]",
       title = "Effect of sleep deprivation on reaction time") +
  theme_bw() +
  scale_x_continuous(breaks = (0:20)) +
  theme(legend.position="none")

