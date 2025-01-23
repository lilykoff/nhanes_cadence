library(tidyverse)
library(slider)
rm(list = ls())


inten = readRDS(here::here("data", "accelerometry", "minute_level_old", "nhanes_1440_D_PAXINTEN.rds"))
inten_c = readRDS(here::here("data", "accelerometry", "minute_level_old", "nhanes_1440_C_PAXINTEN.rds"))
nonwear_bouts =
  inten %>%
  pivot_longer(cols = starts_with("min")) %>%
  group_by(SEQN, PAXDAY) %>%
  mutate(
    zero_vals = slide_dbl(value, .f = function(x){sum(x == 0, na.rm = TRUE) >= 58 && sum(x > 0 & x < 100, na.rm = TRUE) <= 2}, .before = 59, .complete = TRUE),
  ) %>%
  summarize(across(zero_vals, ~sum(.x, na.rm = TRUE))) %>%
  ungroup()

wear =
  nonwear_bouts %>%
  mutate(include_day = (24*60) - zero_vals > 10 * 60)

nonwear_bouts_c =
  inten_c %>%
  pivot_longer(cols = starts_with("min")) %>%
  group_by(SEQN, PAXDAY) %>%
  mutate(
    zero_vals = slide_dbl(value, .f = function(x){sum(x == 0, na.rm = TRUE) >= 58 && sum(x > 0 & x < 100, na.rm = TRUE) <= 2}, .before = 59, .complete = TRUE),
  ) %>%
  summarize(across(zero_vals, ~sum(.x, na.rm = TRUE))) %>%
  ungroup()

wear_c =
  nonwear_bouts %>%
  mutate(include_day = (24*60) - zero_vals > 10 * 60)


wear_all =
  wear %>%
  bind_rows(wear_c)

saveRDS(wear_all, here::here("accelerometry", "processed", "old", "inclusion_c_d.rds"))
# For the analyses presented here, a valid day was defined as having 10 or more hours of monitor wear.
# Wear time was determined by subtracting nonwear time from 24 h.
# Nonwear was defined by an interval of at least 60 consecutive minutes of zero activity intensity counts,
# with allowance for 1-2 min of counts between 0 and 100

inten_small =
 inten %>%
   filter(SEQN == SEQN[1])
x = inten_small %>%
  pivot_longer(cols = starts_with("min")) %>%
  group_by(SEQN, PAXDAY) %>%
  mutate(
    zero_vals = slide_dbl(value, .f = function(x){sum(x == 0, na.rm = TRUE) >= 58 && sum(x > 0 & x < 100, na.rm = TRUE) <= 2}, .before = 59, .complete = TRUE),
  ) %>%
  summarize(across(zero_vals, ~sum(.x, na.rm = TRUE))) %>%
  ungroup()
