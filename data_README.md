## Overview

`data/covariates_accel_mortality_df`: main dataset with all information needed for analysis
One row per participant with following variables (and more) 

**NHANES info** 

- `SEQN`: NHANES id 

- `data_release_cycle`: 7 for 2011-12, 8 for 2013-14

- `masked_variance_pseudo_psu`, `masked_variance_pseudo_stratum`, `full_sample_2_year_interview_weight`, `full_sample_2_year_mec_exam_weight`: used for survey structure and weighting 

**Demographics and health info**

- `age_in_years_at_screening`, `gender`, `bin_diabetes`, `chf`, `arthritis`, `chd`, `heartattack`, `stroke`, `cancer`, `cat_smoke`, `cat_bmi`, `bin_mobilityproblem`, `general_health_condition`, `cat_alcohol`, `cat_education`

**Mortality** 

- `cat_eligstat`: eligibility status for mortality analysis 

- `mortstat`: 1 if died, 0 if alive, `NA` if not eligible 

**Accelerometry info** 

- `has_accel`: logical, did participant receive accelerometer

- `valid_accel`: logical, does participant have valid acceleromtery (`NA` if did not receive)

- `num_valid_day`: number of valid days of accelerometry

**PA variables** 

- `total_<var>`: mean total step or PA variable across valid days 

- `peak1_<var>`: highest value across any minute of the day of PA variable for valid days

- `peak30_<var>`: mean value across any 30 highest value minutes of the day of PA variable for valid days

- `mean_bout_cadence_<var>`: mean value across 2+ minute bouts with >= 60 steps across valid days 

Vars are: `actisteps` = Actilife steps, `adeptsteps` = ADEPT steps, `oaksteps` = Oak steps, `scrfsteps` = stepcount RF steps, `scsslsteps` = stepcount SSL steps, `vssteps` = Verisense steps, `vsrevsteps` = Verisense revised steps 
