# Install and load packages
install.packages("gapminder")
library(gapminder)
library(dplyr)
library(ggplot2)

# Create gapminder_1952
gapminder_1952 <- gapminder %>% filter(year == 1952)
gapminder_1952

# Change to put pop on the x-axis and gdpPercap on the y-axis
ggplot(gapminder_1952, aes(x = pop, y = gdpPercap)) +
  geom_point()  # _point for scatter plot visual
# scatter plots are good for comparing two variables; one point/plot equals one observation from the data set

# Create a scatter plot with pop on the x-axis and lifeExp on the y-axis
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) + 
  geom_point()

# LOG SCALES
# Logarithmic scale: each fixed distance represents a multiplication of the value
# Useful when lots of points are grouped together in one area of a scatter plot

# Change this plot to put the x-axis on a log scale
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) +
  geom_point() +
  scale_x_log10()  
  # log10 scale: 1  10  100  1,000  10,000  etc.
  # 1e+05 = start with 1 and go 5 places to right = 100,000
  # 1e+05 = (1 * 10^5) = 100,000

# Scatter plot comparing pop and gdpPercap, with both axes on a log scale
ggplot(gapminder_1952, aes(x = pop, y = gdpPercap)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10()


# ADD COLOR

# Scatter plot comparing pop and lifeExp, with color representing continent
ggplot(gapminder_1952, aes(x = pop, y = lifeExp, color = continent)) +
  geom_point() +
  scale_x_log10()
# now dots of the same continent are all the same color and a legend for what each color represents is automatically there


# ADD SIZE TO EACH PLOT

# Add the size aesthetic to represent a country's gdpPercap
ggplot(gapminder_1952, aes(x = pop, y = lifeExp, color = continent, size = gdpPercap)) +
  geom_point() +
  scale_x_log10()
# now each dot is bigger or smaller based on a scale that's automatically there


# FACETING
# To divide a graph into subplots based on one of its variables

# Scatter plot comparing pop and lifeExp, faceted by continent

ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) + 
  geom_point() +
  scale_x_log10() +
  facet_wrap(~continent)
# now there are five different scatter plots, one for each continent in the data set
# ~ means "by"; we're splitting the plot BY continent

# Scatter plot comparing gdpPercap and lifeExp, with color representing continent
# and size representing population, faceted by year
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point() +
  scale_x_log10() +
  facet_wrap(~year)