#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)

#### Clean data ####
# Filter essential columns for analysis
polls_data_filtered <- polls_data %>%
  select(poll_id, pollster, start_date, end_date, sample_size, population, 
         methodology, candidate_name, pct, party, state)

# View a summary of missing values
summary(polls_data_filtered)

# Remove columns that are entirely NA
polls_data_filtered <- polls_data_filtered %>%
  select_if(~ !all(is.na(.)))

# Remove rows with any remaining NA values in essential columns
polls_data_filtered <- polls_data_filtered %>%
  drop_na()

# Check the data structure again to confirm changes
glimpse(polls_data_filtered)

library("writexl")

write_xlsx(polls_data_filtered, "polls_data_filtered.xlsx")