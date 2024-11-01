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

polls_data_filtered <- read_excel("../data/02-analysis_data/polls_data_filtered.xlsx")
glimpse(polls_data_filtered)

# Calculate the count of polls for each candidate in the subset
poll_counts <- polls_data_filtered %>%
  group_by(candidate_name) %>%
  summarise(n = n())

# Plot with boxplot and sample size labels
for (i in seq_along(candidate_chunks)) {
  candidate_subset <- candidate_chunks[[i]]
  
  # Filter data for the current subset of candidates
  data_subset <- polls_data_filtered %>%
    filter(candidate_name %in% candidate_subset)
  
  # Merge with poll_counts to get sample size labels
  data_subset <- data_subset %>%
    left_join(poll_counts, by = "candidate_name")
  
  # Create boxplot with labels for poll count
  p <- ggplot(data_subset, aes(x = candidate_name, y = pct, fill = candidate_name)) +
    geom_boxplot() +
    labs(title = paste("Distribution of Poll Results for Candidates Set", i),
         x = "Candidate",
         y = "Percentage Support (pct)") +
    geom_text(data = poll_counts %>% filter(candidate_name %in% candidate_subset),
              aes(x = candidate_name, y = max(data_subset$pct) + 1, label = paste0("n=", n)),
              hjust = -0.2, vjust = 0.5, size = 3) +
    theme_minimal() +
    theme(legend.position = "none",
          axis.text.x = element_text(angle = 45, hjust = 1))
  
  # Save the plot
  ggsave(filename = paste0("poll_results_boxplot_with_n_set_", i, ".png"), plot = p, width = 10, height = 8)
}

print("Boxplots with sample sizes saved as separate files in the working directory.")


