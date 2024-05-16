#Tidying data using Tidyr
library(tidyverse)

#Tidy data

#as_tibble

table1
#> # A tibble: 
#> 6 × 4
#> country year cases population
#> <chr> <int> <int> <int>
#> 1 Afghanistan 1999 745 19987071
#> 2 Afghanistan 2000 2666 20595360
#> 3 Brazil 1999 37737 172006362
#> 4 Brazil 2000 80488 174504898
#> 5 China 1999 212258 1272915272
#> 6 China 2000 213766 1280428583

table2
#> # A tibble: 12 × 4
#> country year type count
#> <chr> <int> <chr> <int>
#> 1 Afghanistan 1999 cases 745
#> 2 Afghanistan 1999 population 19987071
#> 3 Afghanistan 2000 cases 2666
#> 4 Afghanistan 2000 population 20595360
#> 5 Brazil 1999 cases 37737
#> 6 Brazil 1999 population 172006362
#> # ... with 6 more rows

table3
#> # A tibble: 6 × 3
#> country year rate
#> #> * <chr> <int> <chr>
#> 1 Afghanistan 1999 745/19987071
#> 2 Afghanistan 2000 2666/20595360
#> 3 Brazil 1999 37737/172006362
#> 4 Brazil 2000 80488/174504898
#> 5 China 1999 212258/1272915272
#> 6 China 2000 213766/1280428583

#Note %>% is a pipe which we’ll cover later in this workshop. Just briefly though to help you
#before you get to that section at the end of the day

#A pipe is really only designed to help you better understand what the code is doing. It takes
#the data (left of the pipe) and applies the function (right of pipe). In todays workshop we’ll
#use both %>%, and |> which achieve the exact same thing (|> is brand new in base R, %>% only works in tidyr and magrittr packages)

# Compute rate per 10,000
table1 %>%
  mutate(rate = cases / population * 10000)
#> # A tibble: 6 × 5
#> country year cases population rate
#> <chr> <int> <int> <int> <dbl>
#> 1 Afghanistan 1999 745 19987071 0.373
#> 2 Afghanistan 2000 2666 20595360 1.29
#> 3 Brazil 1999 37737 172006362 2.19
#> 4 Brazil 2000 80488 174504898 5.61
#> 5 China 1999 212258 1272915272 1.67
#> 6 China 2000 213766 1280428583 1.67


# Compute cases per year
table1 %>%
  count(year, wt = cases)
#> # A tibble: 2 × 2
#> year n
#> <int> <int>
#> 1 1999 250740
#> 2 2000 296920


# Visualise changes over time
library(ggplot2)
ggplot(table1, aes(year, cases)) +
  geom_line(aes(group = country), colour = "grey50") +
  geom_point(aes(colour = country))


#Pivoting data to make it tidy
#To fix these we will pivot our data (i.e. move it around) into tidy form using two functions in
#tidyr: pivot_longer() to lengthen data and pivot_wider() to widen data. Let’s explore
#these functions a bit further

#Lengthening datasets
#pivot_longer() makes datasets “longer” by
#increasing the number of rows and decreasing the number of columns, solving those
#common problems of data values in the variable name

#The issue here is that we want to group our data by year, or use it as a
#factor, and ggplot2 and most statistical packages cannot do this with data in columns. Only
#variables should be in columns. Therefore, including the variable we want to group by (year
#in the below) we pass the variable name to any grouping function, like facet_wrap().

#Using pivot_longer() splits the dataset by column, and reformats it into the tidy format of
#observations as rows, columns as variables and values as cell entries

billboard
#> # A tibble: 317 × 79
#> artist track date.entered wk1 wk2 wk3 wk4 wk5
#> <chr> <chr> <date> <dbl> <dbl> <dbl> <dbl> <dbl>
#> 1 2 Pac Baby Don't Cry (Ke... 2000-02-26 87 82 72 77 87
#> 2 2Ge+her The Hardest Part O... 2000-09-02 91 87 92 NA NA
#> 3 3 Doors Down Kryptonite 2000-04-08 81 70 68 67 66
#> 4 3 Doors Down Loser 2000-10-21 76 76 72 69 67
#> 5 504 Boyz Wobble Wobble 2000-04-15 57 34 25 17 17
#> 6 98^0 Give Me Just One N... 2000-08-19 51 39 34 26 26
#> # ℹ 311 more rows
#> # ℹ 71 more variables: wk6 <dbl>, wk7 <dbl>, wk8 <dbl>, wk9 <dbl>, ...

billboard |>
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    values_to = "rank"
  )

#we reduced the columns by reordering the columns weeks and doing it as rows

#As you can see in the above code snippet, there are three key arguments to the
#pivot_longer() function:


#Note that in the code "week" and "rank" are quoted because they are new variables that we are creating, they don’t exist yet in the data when we run the pivot_longer() call.


#values_drop_na = TRUE FOR QUITTING ALL THE EXCESS OF ROWS WITHOUT INFO

#Such as converting some of our values from strings to numbersusing mutate() and parse_number(). IMPORTANT THINGS TO CHANGE VALUES UNITS

#Pivoting longer

df <- tribble(
  ~id, ~bp1, ~bp2,
  "A", 100, 120,
  "B", 140, 115,
  "C", 120, 125
)


df |>
  pivot_longer(
    cols = bp1:bp2,
    names_to = "measurement",
    values_to = "value"
  )
#> # A tibble: 6 × 3
#> id measurement value
#> <chr> <chr> <dbl>
#> 1 A bp1 100
#> 2 A bp2 120
#> 3 B bp1 140
#> 4 B bp2 115
#> 5 C bp1 120
#> 6 C bp2 125

#Widening datasets
#Widening is essentially the opposite of lengthening and we do so by using the function pivot_wider().
#pivot_wider() allows us to handle an observation if it is scattered across multiple rows

cms_patient_experience
#> # A tibble: 500 × 5
#> org_pac_id org_nm measure_cd measure_title
prf_rate
#> <chr> <chr> <chr> <chr>
<dbl>
  #> 1 0446157747 USC CARE MEDICAL GROUP INC CAHPS_GRP_1 CAHPS for
  MIPS... 63
#> 2 0446157747 USC CARE MEDICAL GROUP INC CAHPS_GRP_2 CAHPS for
MIPS... 87
#> 3 0446157747 USC CARE MEDICAL GROUP INC CAHPS_GRP_3 CAHPS for
MIPS... 86
#> 4 0446157747 USC CARE MEDICAL GROUP INC CAHPS_GRP_5 CAHPS for
MIPS... 57
#> 5 0446157747 USC CARE MEDICAL GROUP INC CAHPS_GRP_8 CAHPS for
MIPS... 85
#> 6 0446157747 USC CARE MEDICAL GROUP INC CAHPS_GRP_12 CAHPS for
MIPS... 24
#> # ℹ 494 more rows



cms_patient_experience |>
  distinct(measure_cd, measure_title)
#> # A tibble: 6 × 2
#> measure_cd measure_title
#> <chr> <chr>
#> 1 CAHPS_GRP_1 CAHPS for MIPS SSM: Getting Timely Care, Appointments,
and In...
#> 2 CAHPS_GRP_2 CAHPS for MIPS SSM: How Well Providers Communicate
#> 3 CAHPS_GRP_3 CAHPS for MIPS SSM: Patient's Rating of Provider
#> 4 CAHPS_GRP_5 CAHPS for MIPS SSM: Health Promotion and Education
#> 5 CAHPS_GRP_8 CAHPS for MIPS SSM: Courteous and Helpful Office Staff
#> 6 CAHPS_GRP_12 CAHPS for MIPS SSM: Stewardship of Patient Resources


##############################pivot_wider() has the opposite interface to pivot_longer(): instead of choosing
#new column names, we need to provide the existing columns that define the values
#(values_from) and the column name (names_from):####################################################

cms_patient_experience |>
  pivot_wider(
  names_from = measure_cd,
  values_from = prf_rate
  )
#> # A tibble: 500 × 9
#> org_pac_id org_nm measure_title CAHPS_GRP_1
CAHPS_GRP_2
#> <chr> <chr> <chr> <dbl>
<dbl>
  #> 1 0446157747 USC CARE MEDICAL GROUP ... CAHPS for MIPS... 63
  NA
#> 2 0446157747 USC CARE MEDICAL GROUP ... CAHPS for MIPS... NA
87
#> 3 0446157747 USC CARE MEDICAL GROUP ... CAHPS for MIPS... NA
NA
#> 4 0446157747 USC CARE MEDICAL GROUP ... CAHPS for MIPS... NA
NA
#> 5 0446157747 USC CARE MEDICAL GROUP ... CAHPS for MIPS... NA
NA
#> 6 0446157747 USC CARE MEDICAL GROUP ... CAHPS for MIPS... NA
NA
#> # ℹ 494 more rows
#> # ℹ 4 more variables: CAHPS_GRP_3 <dbl>, CAHPS_GRP_5 <dbl>, ...


cms_patient_experience |>
  pivot_wider(
    id_cols = starts_with("org"),
    names_from = measure_cd,
    values_from = prf_rate
  )
#> # A tibble: 95 × 8
#> org_pac_id org_nm CAHPS_GRP_1 CAHPS_GRP_2 CAHPS_GRP_3
CAHPS_GRP_5
#> <chr> <chr> <dbl> <dbl> <dbl>
  #> 1 0446157747 USC CARE MEDICA... 63 87 86
  57
#> 2 0446162697 ASSOCIATION OF ... 59 85 83
63
#> 3 0547164295 BEAVER MEDICAL ... 49 NA 75 44
#> #> 4 0749333730 CAPE PHYSICIANS... 67 84 85
65
#> 5 0840104360 ALLIANCE PHYSIC... 66 87 87
64
#> 6 0840109864 REX HOSPITAL INC 73 87 84
67
#> # ℹ 89 more rows
#> # ℹ 2 more variables: CAHPS_GRP_8 <dbl>, CAHPS_GRP_12 <dbl>


#Pivoting wider

df <- tribble(
  ~id, ~measurement, ~value,
  "A", "bp1", 100,
  "B", "bp1", 140,
  "B", "bp2", 115,
  "A", "bp2", 120,
  "A", "bp3", 105
)


df |>
  pivot_wider(
    names_from = measurement,
    values_from = value
  )
#> # A tibble: 2 × 4
#> id bp1 bp2 bp3
#> <chr> <dbl> <dbl> <dbl>
#> 1 A 100 120 105
#> 2 B 140 115 NA

df |>
  distinct(measurement) |>
  pull()
#> [1] "bp1" "bp2" "bp3"

df |>
  select(-measurement, -value) |>
  distinct()
#> # A tibble: 2 × 1
#> id
#> <chr>
#> 1 A
#> 2 B


df |>
  select(-measurement, -value) |>
  distinct() |>
  mutate(x = NA, y = NA, z = NA)
#> # A tibble: 2 × 4
#> id x y z
#> <chr> <lgl> <lgl> <lgl>
#> 1 A NA NA NA
#> 2 B NA NA NA



#Separating and uniting data tables

#In table3, we see one
#column (rate) that contains two variables (cases and population). To address this, we
#can use the separate() function which separates one column into multiple columns
#wherever you designate.

table3 %>%
  separate(rate, into = c("cases", "population"))
#> # A tibble: 6 × 4
#> country year cases population
#> <chr> <int> <chr> <chr>
#> 1 Afghanistan 1999 745 19987071
#> 2 Afghanistan 2000 2666 20595360
#> 3 Brazil 1999 37737 172006362
#> 4 Brazil 2000 80488 174504898
#> 5 China 1999 212258 1272915272
#> 6 China 2000 213766 1280428583


#ANOHER WAY
table3 %>%
  separate(rate, into = c("cases", "population"), sep = "/")


#To perform the inverse of separate() we will use unite() to combine multiple columns
#into a single column. In the example below for table5, we use unite() to rejoin century
#and year columns. unite() takes a data frame, the name of the new variable and a set of
#columns to combine using dplyr::select().

table5 %>%
  unite(new, century, year, sep = "")
#> # A tibble: 6 × 3
#> country new rate
#> <chr> <chr> <chr>
#> 1 Afghanistan 1999 745/19987071
#> 2 Afghanistan 2000 2666/20595360
#> 3 Brazil 1999 37737/172006362
#> 4 Brazil 2000 80488/174504898
#> 5 China 1999 212258/1272915272
#> 6 China 2000 213766/128042858


# Handling missing values

#Explicit missing values

treatment <- tribble(
  ~person, ~treatment, ~response,
  "Derrick Whitmore", 1, 7,
  NA, 2, 10,
  NA, 3, NA,
  "Katherine Burke", 1, 4
)


treatment |>
  fill(everything())

#Fixed values

#Sometimes missing values represent some fixed and known value, most commonly
#0. You can use dplyr::coalesce() to replace them:

x <- c(1, 4, 5, 7, NA)
coalesce(x, 0)
#> [1] 1 4 5 7 0

#OR

x <- c(1, 4, 5, 7, -99)
na_if(x, -99)
#> [1] 1 4 5 7 NA
#> 


#NaN

#One special type of missing value worth mentioning is NaN or Not a Number. It typically
#behaves the same as NA but in some rare cases you may need to distinguish it using
#is.nan(x):

x <- c(NA, NaN)
x * 10
#> [1] NA NaN
x == 1
#> [1] NA NA
is.na(x)
#> [1] TRUE TRUE


# Implicit missing values

stocks <- tibble(
  year = c(2020, 2020, 2020, 2020, 2021, 2021, 2021),
  qtr = c( 1, 2, 3, 4, 2, 3, 4),
  price = c(1.88, 0.59, 0.35, NA, 0.92, 0.17, 2.66)
)


stocks |>
  pivot_wider(
    names_from = qtr,
    values_from = price
  )
#> # A tibble: 2 × 5
#> year `1` `2` `3` `4`
#> <dbl> <dbl> <dbl> <dbl> <dbl>
#> 1 2020 1.88 0.59 0.35 NA
#> 2 2021 NA 0.92 0.17 2.66









#Exercises
#1. For each of the sample tables, describe what each observation and each column
#represents.
#Table1
#Country: 
#Cases
#Population
#Rate
  

#2. Sketch out the processes you would use to calculate the rate for table2 and
#table3. You will need to perform four operations:

#a. Extract the number of TB cases per country per year

table2
#> # A tibble: 12 × 4
#> country year type count
#> <chr> <int> <chr> <int>
#> 1 Afghanistan 1999 cases 745
#> 2 Afghanistan 1999 population 19987071
#> 3 Afghanistan 2000 cases 2666
#> 4 Afghanistan 2000 population 20595360
#> 5 Brazil 1999 cases 37737
#> 6 Brazil 1999 population 172006362
#> # ... with 6 more rows

table2.1 <- table2|>
pivot_wider(
  names_from = type,
  values_from = count
)

print(table2.1)

table3
#> # A tibble: 6 × 3
#> country year rate
#> #> * <chr> <int> <chr>
#> 1 Afghanistan 1999 745/19987071
#> 2 Afghanistan 2000 2666/20595360
#> 3 Brazil 1999 37737/172006362
#> 4 Brazil 2000 80488/174504898
#> 5 China 1999 212258/1272915272
#> 6 China 2000 213766/1280428583

table3.1 <- table3 %>%
  separate(rate, into = c("cases", "population"), sep = "/")



#b. Extract the matching population per country per year

table2.1



table3.1


#c. Divide cases by population, and multiply by 10,000


#d. Store back in the appropriate place


#Hint: you haven’t yet learned the functions you need to actually perform these, but you can
#still think through the transformations!





#Exercises

#1. Why are pivot_longer() and pivot_wider() not perfectly symmetrical?
#Carefully consider the following example.

stocks <- tibble(
  year = c(2015, 2015, 2016, 2016),
  half = c( 1, 2, 1, 2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>%
  pivot_wider(names_from = year, values_from = return) %>%
  pivot_longer(`2015`:`2016`, names_to = "year", values_to =
                 "return")

#2. Why does this code fail?

table4a %>%
  pivot_longer(c(1999, 2000), names_to = "year", values_to =
                 "cases")
#> Error in `pivot_longer()`:
#> ! Can't subset columns past the end.
#> ℹ Locations 1999 and 2000 don't exist.
#> ℹ There are only 3 columns.

#3. Consider the sample tibble below. Do you need to make it wider or longer?
# What are the variables?
  preg <- tribble(
    ~pregnant, ~male, ~female,
    "yes", NA, 10,
    "no", 20, 12
  )


#Exercises

#Identify what is wrong with each of the following inline CSV files. What happens
#when you run the code?
  read_csv("a,b\n1,2,3\n4,5,6")
  read_csv("a,b,c\n1,2\n1,2,3,4")
  read_csv("a,b\n\"1")
  read_csv("a,b\n1,2\na,b")
  read_csv("a;b\n1;3")
  

