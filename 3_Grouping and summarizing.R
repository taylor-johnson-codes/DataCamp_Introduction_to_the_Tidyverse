# Install and load packages
install.packages("gapminder")
library(gapminder)
library(dplyr)
library(ggplot2)

# SUMMARIZE 
# Summarize many observations into one data point

# Summarize to find the median life expectancy
gapminder %>% summarize(medianLifeExp = median(lifeExp))
# prints:
# A tibble: 1 x 1
# medianLifeExp
# <dbl>
# 60.7

# Filter for 1957 then summarize the median life expectancy
gapminder %>% 
  filter(year == 1957) %>%
  summarize(medianLifeExp = median(lifeExp))

# Filter for 1957 then summarize the median life expectancy and the maximum GDP per capita
gapminder %>% 
  filter(year == 1957) %>%
  summarize(medianLifeExp = median(lifeExp), maxGdpPercap = max(gdpPercap))


# GROUP BY

# Find median life expectancy and maximum GDP per capita in each year
gapminder %>% 
  group_by(year) %>% 
  summarize(medianLifeExp = median(lifeExp), maxGdpPercap = max(gdpPercap))
# says to perform summarize() within each year

# Find median life expectancy and maximum GDP per capita in each continent in 1957
gapminder %>% 
  filter(year == 1957) %>%
  group_by(continent) %>% 
  summarize(medianLifeExp = median(lifeExp), maxGdpPercap = max(gdpPercap))
# prints:
# A tibble: 5 x 3
# continent medianLifeExp maxGdpPercap
# <fct>             <dbl>        <dbl>
# 1 Africa             40.6        5487.
# 2 Americas           56.1       14847.
# 3 Asia               48.3      113523.
# 4 Europe             67.6       17909.
# 5 Oceania            70.3       12247.

# Find median life expectancy and maximum GDP per capita in each continent/year combination
gapminder %>% 
  group_by(continent, year) %>% 
  summarize(medianLifeExp = median(lifeExp), maxGdpPercap = max(gdpPercap))
# prints one row for each year/continent combination

by_year <- gapminder %>%
  group_by(year) %>%
  summarize(medianLifeExp = median(lifeExp),
            maxGdpPercap = max(gdpPercap))
by_year

# Create a scatter plot showing the change in medianLifeExp over time
ggplot(by_year, aes(x = year, y = medianLifeExp)) +
  geom_point() +
  expand_limits(y = 0)  # to make sure the plot's y-axis includes zero

# Summarize medianGdpPercap within each continent within each year: by_year_continent
by_year_continent <- gapminder %>%
  group_by(continent, year) %>%
  summarize(medianGdpPercap = median(gdpPercap))
by_year_continent

# Plot the change in medianGdpPercap in each continent over time
ggplot(by_year_continent, aes(x = year, y = medianGdpPercap, color = continent)) +
  geom_point() +
  expand_limits(y = 0)

# Summarize the median GDP and median life expectancy per continent in 2007
by_continent_2007 <- gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarize(medianGdpPercap = median(gdpPercap),
            medianLifeExp = median(lifeExp))

# Use a scatter plot to compare the median GDP and median life expectancy
ggplot(by_continent_2007, aes(x = medianGdpPercap, y = medianLifeExp, color = continent)) +
  geom_point()