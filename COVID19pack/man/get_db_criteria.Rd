% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cycling_trigger.R
\name{get_db_criteria}
\alias{get_db_criteria}
\title{Whether a dial back measure is greater than the threshold}
\usage{
get_db_criteria(icu_demand, avg_case2x, avg_hosp_7days, prevI, strategy)
}
\arguments{
\item{icu_demand}{ICU beds at step t}

\item{avg_case2x}{Average case doubling time at step t}

\item{avg_hosp_7days}{Average new hospitalization in the past 7 days}

\item{prevI}{Prevalence at a time step}

\item{strategy}{A list contains the parameters for the cycling or dialback strategy}
}
\description{
Whether a dial back measure is greater than the threshold
}
