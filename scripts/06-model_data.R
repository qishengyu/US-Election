#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
analysis_data <- read_csv("data/analysis_data/weekly_support.csv")


# Fit a GLM to predict weekly aggregated support based on time (week) and candidate
glm_model <- glm(weighted_support ~ candidate_name + week, data = weekly_support, family = gaussian())

# Summary of the GLM
summary(glm_model)

# Set a future date for prediction (e.g., election day)
future_date <- as.Date("2024-11-05")  # Adjust as needed

# Create a new data frame for prediction, keeping 'week' as a Date type
new_data <- data.frame(candidate_name = unique(weekly_support$candidate_name),
                       week = future_date)

# Generate predictions
predictions <- predict(glm_model, newdata = new_data, type = "response")
predicted_support <- data.frame(candidate_name = new_data$candidate_name,
                                predicted_support = predictions)

# Print predictions for each candidate
print(predicted_support)


# Sort predictions in descending order of predicted support
sorted_predictions <- predicted_support %>%
  arrange(desc(predicted_support))

# Print the sorted predictions
print(sorted_predictions)
# Sort predictions in descending order of predicted support
sorted_predictions <- predicted_support %>%
  arrange(desc(predicted_support))

# Print the sorted predictions
print(sorted_predictions)


#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)


