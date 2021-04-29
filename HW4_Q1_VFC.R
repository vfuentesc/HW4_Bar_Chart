rm(list = ls())

wd <- "C:/Users/fuent/OneDrive - The University of Chicago/Spring 2021/Data Visualization/Week 4/HW/bar_chart"
setwd(wd)

library(tidyverse)
library(stringr)

data <- read_csv("India-NCT-Delhi-daily.csv")

cutoffs <- c(-Inf, 12, 35.5, 55.5, 150.5, 250.5, 500, +Inf)
labels_cuts <- c("good", "moderate", "unhealthy_sensitive", "unhealthy", "unhealthy_very", "hazardous", "extreme")

data_modified <-
  data %>%
  mutate(level = cut(avg,
                     breaks = cutoffs,
                     labels = labels_cuts)) %>%
  pivot_wider(id_cols = date, names_from = level, values_from = avg, values_fill = 0) %>%
  left_join(data %>% select(date, max), by = "date") %>%
  mutate(max_add = max - (good + moderate + unhealthy_sensitive + unhealthy + unhealthy_very + hazardous + extreme)) %>%
  select(date, all_of(labels_cuts), max_add, max)

write_csv(data_modified, "HW4_Q1_VFC.csv")
