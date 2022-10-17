## 5. Data transformation

# Tidyverse training
# Following the R for Data Science book to learn the Tidyverse at https://www.tidyverse.org/
# https://r4ds.had.co.nz/

#Libraries
library(tidyverse)
library(nycflights13)

flights

#5.2 Filter ROWS with filter()
#for subsetting

filter(flights, month == 1, day == 1)
jan1 <- filter(flights, month == 1, day == 1)
(dec25 <- filter(flights, month == 12, day == 25))

# R provides the standard suite: >, >=, <, <=, != (not equal), and == (equal).
# Multiple arguments to filter() are combined with "and": every expression must be true in order for a row to be included in the output. 
# For other types of combinations, you'll need to use Boolean operators yourself: & is "and", | is "or", and ! is "not".

#The following code finds all flights that departed in November or December:
filter(flights, month == 11 | month == 12)
(nov_dec <- filter(flights, month %in% c(11, 12)))
# jan_okt <- filter(flights, !(month %in% c(11, 12)))
# unique(jan_okt$month)

#Sometimes you can simplify complicated subsetting by remembering De Morgan's law: !(x & y) is the same as !x | !y, and !(x | y) is the same as !x & !y. 
#For example, if you wanted to find flights that weren't delayed (on arrival or departure) by more than two hours, you could use either of the following two filters:
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)

#filter() only includes rows where the condition is TRUE; it excludes both FALSE and NA values. If you want to preserve missing values, ask for them explicitly:
df <- tibble(x = c(1, NA, 3))
df
(filter(df, x > 1))
(filter(df, is.na(x) | x > 1))

#5.2.4 Exercises
flights
#1.1 Had an arrival delay of two or more hours
(filter(flights, arr_delay >= 120)) #arr_delay in minutes, so >120
#1.2 Flew to Houston (IAH or HOU)
(filter(flights, dest == "IAH" | dest == "HOU" ))
(filter(flights, dest %in% c("IAH", "HOU")))
#1.3 Were operated by United, American, or Delta
airlines #UA, AA, DL
(filter(flights, carrier %in% c("UA", "AA", "DL")))
#1.4 Departed in summer (July, August, and September)
(filter(flights, month %in% c(7, 8, 9)))
(filter(flights, month %in% 7:9))
(filter(flights, month >= 7, month <= 9))
(filter(flights, month == 7 | month == 8 | month == 9))
#1.5 Arrived more than two hours late, but didn't leave late
(filter(flights, arr_delay > 120, dep_delay <= 0)) 
#1.6 Were delayed by at least an hour, but made up over 30 minutes in flight
(filter(flights, dep_delay >= 60, dep_delay - arr_delay > 30)) 
#1.7 Departed between midnight and 6am (inclusive)
(filter(flights, dep_time == 2400 | dep_time <= 600)) 

?between()
(filter(flights, between(month, 7, 9))) #1.4 Departed in summer (July, August, and September)
(filter(flights, is.na(dep_time))) #8255 flights no dep_time
summary(flights) # also dep_delay, arr_time, arr-Delay, air_time, cancelled flights

NA^0
NA|TRUE
NA & FALSE
NA | FALSE

#5.3 Arrange rows with arrange() 
arrange(flights, year, month, day)
arrange(flights, desc(dep_delay))
df <- tibble(x = c(5, 2, NA))
arrange(df, x)
arrange(df, desc(x))
#5.3.1 Exercises
arrange(flights, desc(is.na(dep_time)), dep_time)
arrange(flights, desc(dep_delay))
arrange(flights, dep_delay)
arrange(flights, air_time)
arrange(flights, desc(air_time))
arrange(flights, distance)
arrange(flights, desc(distance))

#5.4 Select COLUMNS with select() for subsetting
select(flights, year, month, day)
select(flights, year:day)
select(flights, -(year:day))
# starts_with("abc"): matches names that begin with "abc".
# ends_with("xyz"): matches names that end with "xyz".
# contains("ijk"): matches names that contain "ijk".
# matches("(.)\\1"): selects variables that match a regular expression. This one matches any variables that contain repeated characters. You'll learn more about regular expressions in strings.
# num_range("x", 1:3): matches x1, x2 and x3

rename(flights, tail_num = tailnum) # changes column name tailnum to tail_num
select(flights, time_hour, air_time, everything()) # moves time_hour and air_time to front of tibble

#5.4.1 Exercises
select(flights, dep_time, dep_delay, arr_time, arr_delay)
select(flights, 4, 6, 7, 9)
select(flights, all_of(c("dep_time", "dep_delay", "arr_time", "arr_delay")))
select(flights, any_of(c("dep_time", "dep_delay", "arr_time", "arr_delay")))
variables <- c("dep_time", "dep_delay", "arr_time", "arr_delay")
select(flights, all_of(variables))
select(flights, starts_with("dep_"), starts_with("arr_"))
select(flights, matches("^(dep|arr)_(time|delay)$"))
select(flights, year, month, day, year, year) #ignores duplicates
vars <- c("year", "month", "day", "dep_delay", "arr_delay")
select(flights, one_of(vars))
select(flights, contains("TIME")) #ignores case for letters
select(flights, contains("TIME", ignore.case = FALSE))

#5.5 Add new variables with mutate()
# Besides selecting sets of existing columns, it's often useful to add new columns that are functions of existing columns. That's the job of mutate().
# mutate() always adds new columns at the end of your dataset

flights_sml <- select(flights,  year:day, dep_time, arr_time, ends_with("delay"), distance, air_time)
mutate(flights_sml,
       gain = dep_delay - arr_delay,
       speed = distance / air_time * 60
)
mutate(flights_sml,
       gain = dep_delay - arr_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours
)
transmute(flights,   # to only keep newly created variables
          gain = dep_delay - arr_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
)
# Modular arithmetic: %/% (integer division) and %% (remainder), where x == y * (x %/% y) + (x %% y). 
# Modular arithmetic is a handy tool because it allows you to break integers up into pieces. 
# For example, in the flights dataset, you can compute hour and minute from dep_time with:
transmute(flights,
            dep_time,
            hour = dep_time %/% 100,
            minute = dep_time %% 100
  )

#5.5.2
1504 %/% 100 #gives hours
1504 %% 100 # gives remainder = minutes
1504 %/% 100 * 60 + 1504 %% 100
flights_times <- mutate(flights,
                        dep_time_mins = (dep_time %/% 100 * 60 + dep_time %% 100) %% 1440,
                        sched_dep_time_mins = (sched_dep_time %/% 100 * 60 + sched_dep_time %% 100) %% 1440
                        )
select(flights_times, dep_time, dep_time_mins, sched_dep_time, sched_dep_time_mins)

flights
mutate(flights_sml, 
       duration = arr_time - dep_time)

#5.6 Grouped summaries with summarise()
# The last key verb is summarise(). It collapses a data frame to a single row
# summarise() is not terribly useful unless we pair it with group_by(). This changes the unit of analysis from the complete dataset 
# to individual groups. Then, when you use the dplyr verbs on a grouped data frame they'll be automatically applied "by group". 

summarise(flights, delay = mean(dep_delay, na.rm = TRUE))
by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

# %>% is the pipe, it is used in a series of transformations where you focus on the end result, not the intermediate steps
delays <- flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE), #remove NA in this function
    delay = mean(arr_delay, na.rm = TRUE) #remove NA in this function
  ) %>% 
  filter(count > 20, dest != "HNL")

not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))

#Whenever you do any aggregation, it's always a good idea to include either a count (n()), or a count of non-missing values (sum(!is.na(x))). 
# That way you can check that you're not drawing conclusions based on very small amounts of data.
delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay)
  )
ggplot(data = delays, mapping = aes(x = delay)) + 
  geom_freqpoly(binwidth = 10)

delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )
ggplot(data = delays, mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10)
delays %>% #small numbers of observations are filtered out
  filter(n > 25) %>% 
  ggplot(mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10)

# Convert to a tibble so it prints nicely
batting <- as_tibble(Lahman::Batting)

batters <- batting %>% 
  group_by(playerID) %>% 
  summarise(
    ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    ab = sum(AB, na.rm = TRUE)
  )

batters %>% 
  filter(ab > 100) %>% 
  ggplot(mapping = aes(x = ab, y = ba)) +
  geom_point() + 
  geom_smooth(se = FALSE)
batters %>% 
  arrange(desc(ba))

# Useful summary functions: mean(x), median(x), sd(x), IQR(x), mad(x) (= median absolute deviation), min(x), quantile(x, 0.25), max(x), 
# first(x), nth(x, 2), last(x), n(), sum(!is.na()) (to count number of NA), n_distinct(x) (to count number of unique values), count()
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    avg_delay1 = mean(arr_delay),
    avg_delay2 = mean(arr_delay[arr_delay > 0]) # the average positive delay
  )
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(distance_sd = sd(distance)) %>% 
  arrange(desc(distance_sd))
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first = min(dep_time),
    last = max(dep_time)
  )
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first_dep = first(dep_time), 
    last_dep = last(dep_time)
  )
not_cancelled %>% ###snap deze niet
  group_by(year, month, day) %>% 
  mutate(r = min_rank(desc(dep_time))) %>% 
  filter(r %in% range(r))
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(carriers = n_distinct(carrier)) %>% 
  arrange(desc(carriers))
not_cancelled %>% 
  count(dest)
not_cancelled %>% 
  count(tailnum, wt = distance)
# How many flights left before 5am? (these usually indicate delayed flights from the previous day)
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(n_early = sum(dep_time < 500))
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(hour_prop = mean(arr_delay > 60))

daily <- group_by(flights, year, month, day)
(per_day   <- summarise(daily, flights = n()))
(per_month <- summarise(per_day, flights = sum(flights)))
(per_year  <- summarise(per_month, flights = sum(flights)))
daily %>% 
  ungroup() %>%             # no longer grouped by date
  summarise(flights = n()) 

#5.6.7. Exercises
not_cancelled %>% 
  count(dest) 
not_cancelled%>%
  group_by(dest) %>%
  summarise(n = length (dest))
not_cancelled %>% 
  count(tailnum, wt = distance)
not_cancelled %>%
  group_by(tailnum) %>%
  summarise(sum(distance))

#5.7 Grouped mutates (and filters)

flights_sml %>% #find the worst delays on each day
  group_by(year, month, day) %>%
  filter(rank(desc(arr_delay)) < 10)
popular_dests <- flights %>% # find dest that occur > 365
  group_by(dest) %>% 
  filter(n() > 365)
# A grouped filter is a grouped mutate followed by an ungrouped filter. These are hard to check
popular_dests %>% 
  filter(arr_delay > 0) %>% 
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>% 
  select(year:day, dest, arr_delay, prop_delay)
