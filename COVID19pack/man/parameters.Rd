% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/parameters_v3.R
\name{parameters}
\alias{parameters}
\title{Model parameter generation

Parameter Generation for MN Covid-19 model

input values of parameters or use defaults to generate list of parameters
that is used by main function.}
\usage{
parameters(
  epi_states_index,
  hash_table,
  beta = 0.019,
  beta_after = 0.019,
  beta_change = FALSE,
  hosp_mul = 1,
  hosp_change = FALSE,
  weight_60p_init = 0.08,
  n_days_incubation = 5.2,
  n_days_infectious = 7.8,
  exposed_transition_rate = NA,
  infected_transition_rate = NA,
  n_days_rec_hosp = c(4.41, 4.41, 4.41, 5.8, 5.8, 6.03, 7.72, 7.6, 6.45),
  n_days_rec_ICU = c(17.5, 17.5, 17.5, 17.5, 17.5, 19.65, 21.51, 15.38, 15.38),
  init_cases_detected = 0.019,
  n_icu_beds = 2200,
  relative_risk_mort_co = 1,
  str_peak_type = c("hospitalizations"),
  v_strat_status = c(sd = 1, sip = 1, sc = 1, sd60p = 1, bec = 1),
  prop_asymptomatic = NULL,
  prop_asymp_19 = 0.408,
  p_h_50_59 = c(0.062, 0.062),
  p_h_60p = c(0.245, 0.245),
  p_dying_home_70 = 0.088,
  p_dying_home_80 = 0.088,
  start_time_social_distancing = Inf,
  start_time_sip = Inf,
  start_time_behavior_change = Inf,
  start_time_60plus_distancing = Inf,
  start_time_school_closure = Inf,
  end_time_social_distancing = -Inf,
  end_time_sip = -Inf,
  end_time_behavior_change = -Inf,
  end_time_60plus_distancing = -Inf,
  end_time_school_closure = -Inf,
  social_distancing_contact_reduction = 0.246,
  sip_cr_mat = matrix(c(0.65, 0.65, 0.65, 0.148, 0.65, 0.65, 0.65, 0.148, 0.65, 0.65,
    0.65, 0.148, 0.148, 0.148, 0.148, 0.062), nrow = 4, byrow = T),
  beh_cr_mat = matrix(c(0.454, 0.931, 0.454, 0.735, 0.931, 0.291, 0.931, 0.931, 0.454,
    0.931, 0.454, 0.735, 0.735, 0.931, 0.735, 0.062), nrow = 4, byrow = T),
  school_closure_contact_reduction = 0.4,
  sip_days_past_peak = -Inf,
  social_distancing_days_past_peak = -Inf,
  sixty_plus_days_past_peak = -Inf,
  school_closure_days_past_peak = -Inf,
  behavior_change_days_past_peak = -Inf,
  p_sens_test = 0.8,
  p_spec_test = 0.99,
  n_tests_per_day = 0,
  quarantine_contact_reduction = 0.8,
  n_days_quarantine = 14,
  p_I_seek_test = 0.05,
  p_nonI_seek_test = 0.0025,
  n_tests_per_day_hosp = 2/11,
  n_tests_per_day_icu = 2/8,
  start_time_testing = 56,
  trigger_strategy = NULL,
  p_decrease_hosp_mort = 0,
  p_decrease_icu_mort = 0,
  n_days_rec_hosp_ma = c(3.85, 3.85, 3.85, 5.02, 5.02, 6.45, 7.96, 6.64, 6.55),
  n_days_rec_ICU_ma = c(15.33, 15.33, 15.33, 15.33, 15.33, 16.86, 19.1, 15.47, 15.47),
  start_time_ma_mort = Inf,
  start_time_ma_dur = as.numeric(as.Date("2020-05-15") - set_start_date()),
  mask_cr_mat = NULL,
  start_time_mask_policy = Inf,
  timestep = 0.05
)
}
\arguments{
\item{epi_states_index}{a list with sub-epi states and indices. This list is generated from `gen_states_index()`.}

\item{hash_table}{a hash table for indexing different epistates, age group and comorbidity group throught a simulation.}

\item{beta}{probability that contact with an infectious person will cause an infection.}

\item{n_days_incubation}{average number of days spent in the exposed states.}

\item{n_days_infectious}{average number of days spent in the infectious states.}

\item{exposed_transition_rate}{rate at which population moves through the exposed tunnel states. This value is NA by default,
and if it is not supplied directly, the value is calculated internally in accordance with timestep, n_exposed_states, and n_days_incubation.}

\item{infected_transition_rate}{rate at which population moves through the exposed tunnel states. This value is NA by default,
and if it is not supplied directly, the value is calculated internally in accordance with timestep, n_infected_states, and n_days_infectious.}

\item{n_days_rec_hosp}{average number of days it takes to recover prior to 5/15 if in the hospital.}

\item{n_days_rec_ICU}{average number of days it takes to recover if in the ICU (w/ bed) prior to 5/15.}

\item{init_cases_detected}{percentage of cases that are assumed to have been detected, as of day 0 in the model. 
Used in inital condition calculation.}

\item{n_icu_beds}{number of ICU beds available in Minnesota.}

\item{relative_risk_mort_co}{relative risk of mortality if a person has 1 or more comorbidities.}

\item{str_peak_type}{string indicating which peak type will be used in calculations. The string could be "deaths", "hospitalizations", "infections", "new_cases", or "new_sym_cases".}

\item{v_strat_status}{a vector that will be used in the solve_model() function which indicates which social distancing strategies are being used}

\item{prop_asymptomatic}{vector that contains the proportion of each age groups which is asymptomatic}

\item{p_h_50_59}{a vector of two elements, representing the probability of hospitalization among age 50-59. The first element is the probability in April/May and the second element is the probability in June-present.}

\item{p_h_60p}{a vector of two elements, representing the probability of hospitalization among age 60+. The first element is the probability in April/May and the second element is the probability in June-present.}

\item{p_dying_home_70}{probability of dying at home for 70-79 year old people who have a symptomatic infection}

\item{p_dying_home_80}{probability of dying at home for 80+ year old people who have a symptomatic infection}

\item{start_time_social_distancing}{day of simulation at which social distancing measures start.}

\item{start_time_sip}{day of simulation at which shelter in place starts.}

\item{start_time_behavior_change}{day of simulation at which population changes behavior independent of enacted policies to start socially distancing.}

\item{start_time_60plus_distancing}{day of simulation at which targeted social distancing measures start for individuals age 60+.}

\item{start_time_school_closure}{day of simulation at which school closures start.}

\item{end_time_social_distancing}{day of simulation at which social distancing measures end.}

\item{end_time_sip}{day of simulation at which shelter in place ends.}

\item{end_time_behavior_change}{day of simulation at which population ceases policy-independent social distancing.}

\item{end_time_60plus_distancing}{day of simulation at which targeted social distancing measures end for individuals age 60+.}

\item{end_time_school_closure}{day of simulation at which school closures end.}

\item{social_distancing_contact_reduction}{as a decimal, the percentage reduction in contact rates when social distancing is in effect}

\item{sip_cr_mat}{as a 4x4 matrix with 4 age groups: 0-19, 20-39, 40-59, 60+. This matrix represents the contact reduction parameter between two age groups or within an age group in SAH.}

\item{beh_cr_mat}{as a 4x4 matrix with 4 age groups: 0-19, 20-39, 40-59, 60+. This matrix represents the contact reduction parameter between two age groups or within an age group post SAH.}

\item{school_closure_contact_reduction}{as a decimal, the percentage reduction in contact rates when school closures are in effect. 
This reduction only applies to relevant entries of the mixing matrix.}

\item{sip_days_past_peak}{number of days shelter in place will be in effect past the chosen peak (infections, hospitalizations, deaths)}

\item{social_distancing_days_past_peak}{number of days social distancing will be in effect past the chosen peak (infections, hospitalizations, deaths)}

\item{sixty_plus_days_past_peak}{number of days 60+ social distancing will be in effect past the chosen peak (infections, hospitalizations, deaths)}

\item{school_closure_days_past_peak}{number of days schools remain closed past the chosen peak (infections, hospitalizations, deaths)}

\item{behavior_change_days_past_peak}{number of days a long-lasting behavior change will be in effect past the chosen peak (infections, hospitalizations, deaths)}

\item{p_sens_test}{sensitivity for test-probability of people who test positive among people infected.}

\item{p_spec_test}{specificity for test-probability of people who test negative among people not infected.}

\item{n_tests_per_day}{number of tests per day.}

\item{quarantine_contact_reduction}{the percentage reduction in contact rates when quarantine in effect.}

\item{n_days_quarantine}{number of days that quarantine in effect.}

\item{p_I_seek_test}{probability of infected individuals seeking test.}

\item{p_nonI_seek_test}{probability of non-infected individuals seeking test.}

\item{n_tests_per_day_hosp}{the number of hospitalized individuals being tested per day.}

\item{n_tests_per_day_icu}{the number of individuals in ICU being tested per day.}

\item{start_time_testing}{day of covid-19 testing start.}

\item{trigger_strategy}{specify the trigger_strategy. The default is `NULL`}

\item{p_decrease_hosp_mort}{percentage of decrease in probability of dying at hospital.}

\item{p_decrease_icu_mort}{percentage of decrease in probability of dying at ICU.}

\item{n_days_rec_hosp_ma}{average number of days it takes to recover post 5/15 if in the hospital.}

\item{n_days_rec_ICU_ma}{average number of days it takes to recover if in the ICU (w/ bed) post 5/15 if in the ICU.}

\item{start_time_ma_mort}{day of medical advances start to reduce mortality.}

\item{start_time_ma_dur}{day of medical advances start to reduce duration in hospital and ICU bed.}

\item{mask_cr_mat}{a matrix of contact reduction considering/including masking effect. The default is `NULL`.}

\item{start_time_mask_policy}{The start time of masking policy. The default is `Inf`.}

\item{timestep}{length of timesteps in days used by the solver function, should be 1 or less}

\item{p_decrease_hosp_dur}{duration of decrease in probability of dying at hospital.}

\item{p_decrease_icu_dur}{duration of decrease in probability of dying at ICU.}

\item{age_groups}{vector which lists the starting age of each age group.}
}
\value{
list of parameters
}
\description{
Model parameter generation

Parameter Generation for MN Covid-19 model

input values of parameters or use defaults to generate list of parameters
that is used by main function.
}
