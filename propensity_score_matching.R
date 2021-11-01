install.packages("dplyr")
install.packages("MatchIt")

library(MatchIt)
library(dplyr)
library(ggplot2)

fat <- read.csv("bmi_over_24_new2.csv")
head(fat)

fat_nomiss <- fat %>%  # MatchIt does not allow missing values
  select(is_fat, age, gender) %>%
  na.omit()

fat_match <- matchit(is_fat ~ age + gender,
                     method = "nearest", data = fat_nomiss)
fat_match_data <- match.data(fat_match)
dim(fat_match_data)

write.csv(fat_match_data, file="fat_match_data.csv", row.names = FALSE)
