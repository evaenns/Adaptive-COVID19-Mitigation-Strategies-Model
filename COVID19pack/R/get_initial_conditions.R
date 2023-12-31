#' @title Initial condition generation
#' 
#' 
#' @param parms list of parameters generated by parameters() function
#' @param m_init_cases data.frame of initial cases in MN
#'
#' uses an rda of data from March 22nd to generate the initial conditions of the model 
#'
#' @return
#' vector which has the initial conditions of the simulation
#'
#' @export
get_initial_conditions <- function(parms, m_init_cases){
  init_cases_detected <- parms$init_cases_detected
  N <- parms$N
  age_prop <- parms$age_prop
  comorbidity_prop_by_age <- parms$comorbidity_prop_by_age
  v_exp_str <- parms$epi_groups_ls$v_exp_str
  v_inf_str <- parms$epi_groups_ls$v_inf_str
  v_asym_inf_str <- parms$epi_groups_ls$v_asym_inf_str 
  prop_asym <- parms$prop_asymptomatic
  prop_inf_by_age <- parms$prop_inf_by_age
  nis <- parms$n_infected_states
  nes <- parms$n_exposed_states
  
  m_init_cases <- as.matrix(m_init_cases)
  
  ic <- parms$ls_ix$ic
  ia <- parms$ls_ix$ia
  ie_str <- parms$ls_ix$ie_str
  index <- parms$ls_ix$index
  
  # estimate undetected cases
  total_v_init_NDinf <- sum(colSums(m_init_cases) * (1 - init_cases_detected) / init_cases_detected)
  
  v_init_NDinf <- total_v_init_NDinf * prop_inf_by_age
  v_init_NDinf_asym <- rep(0, 9)
  v_init_NDinf_sym <- rep(0, 9)
  
  # Initial starting vector
  init_vec <- 0 * vector(mode = "numeric", length = length(index))
  #print(length(init_vec))
  # First, distribute people across age and comorbidity compartments
  # indexing will be ia = (i-1) and cg=0 or 1
  # cases (known and unknown by age)
  n_cases_by_age <- apply(m_init_cases, 2, sum) + v_init_NDinf

  ## Susceptible (eg=1) ##
  # Num in age group i with no co-morbidities
  init_vec[index[ie_str == "S" & ic == 0]] <- (N * age_prop - n_cases_by_age) * (1 - comorbidity_prop_by_age)
    
  # Num in age group i with at least one co-morbidity
  init_vec[index[ie_str == "S" & ic == 1]] <- (N * age_prop - n_cases_by_age) * comorbidity_prop_by_age
    
  ## Detected cases ##
  # Infected -> go to last infected state
  init_vec[index[ie_str == v_inf_str[length(v_inf_str)] & ic == 0]] <-
    m_init_cases["I", ] * (1 - comorbidity_prop_by_age)
  
  init_vec[index[ie_str == v_inf_str[length(v_inf_str)] & ic == 1]] <-
    m_init_cases["I", ] * comorbidity_prop_by_age 
    
  # Hospitalized -> go to H (eg=16)
  init_vec[index[ie_str == "H" & ic == 0]] <- m_init_cases["H", ] * (1 - comorbidity_prop_by_age)
  init_vec[index[ie_str == "H" & ic == 1]] <- m_init_cases["H", ] * comorbidity_prop_by_age
    
  # ICU -> go to ICU (eg=17)
  init_vec[index[ie_str == "ICU" & ic == 0]] <- m_init_cases["ICU", ] * (1 - comorbidity_prop_by_age)
  init_vec[index[ie_str == "ICU" & ic == 1]] <- m_init_cases["ICU", ] * comorbidity_prop_by_age
    
  # Recovered -> go to R (eg=18)
  init_vec[index[ie_str == "R" & ic == 0]] <- m_init_cases["R", ] * (1 - comorbidity_prop_by_age)
  init_vec[index[ie_str == "R" & ic == 1]] <- m_init_cases["R", ] * comorbidity_prop_by_age
  
  # Dead --> got to D (eg=19)
  init_vec[index[ie_str == "D" & ic == 0]] <- m_init_cases["D", ] * (1 - comorbidity_prop_by_age)
  init_vec[index[ie_str == "D" & ic == 1]] <- m_init_cases["D", ] * comorbidity_prop_by_age
    
  ## Distribute undetected cases proportionately across exposed, asymptomatic, and infectious compartments
  n_comp_s_e <- length(c(v_exp_str, v_inf_str))
  n_comp_a <- length(v_asym_inf_str)
    
  v_init_NDinf_asym <- v_init_NDinf * prop_asym[1, ] * (nis + nes) / (2 * nes + nis) 
  v_init_NDinf_sym <- v_init_NDinf * (1 - prop_asym[1, ] * (nis + nes) / (2 * nes + nis))
    
  # no comorbidities
  #asymptomatic
  init_vec[index[ie_str %in% c(v_asym_inf_str) & ic == 0]] <-
    init_vec[index[ie_str %in% c(v_asym_inf_str) & ic == 0]] +
    rep((v_init_NDinf_asym / (n_comp_a) * (1 - comorbidity_prop_by_age)), 
        each = length(v_asym_inf_str))
  
  #symptomatic and exposed
  init_vec[index[ie_str %in% c(v_exp_str, v_inf_str) & ic == 0]] <-
    init_vec[index[ie_str %in% c(v_exp_str, v_inf_str) & ic == 0]] +
    rep((v_init_NDinf_sym / (n_comp_s_e) * (1 - comorbidity_prop_by_age)), 
        each = length(c(v_exp_str, v_inf_str)))

  # comorbidities
  #asymptomatic
  init_vec[index[ie_str %in% c(v_asym_inf_str) & ic == 1]] <-
    init_vec[index[ie_str %in% c(v_asym_inf_str) & ic == 1]] +
    rep((v_init_NDinf_asym / (n_comp_a) * (comorbidity_prop_by_age)), 
        each = length(v_asym_inf_str))

  #symptomatic and exposed
  init_vec[index[ie_str %in% c(v_exp_str, v_inf_str) & ic == 0]] <-
    init_vec[index[ie_str %in% c(v_exp_str, v_inf_str) & ic == 0]] +
    rep((v_init_NDinf_sym / (n_comp_s_e) * (comorbidity_prop_by_age)), 
        each = length(c(v_exp_str, v_inf_str)))
  
  return(init_vec)
}

