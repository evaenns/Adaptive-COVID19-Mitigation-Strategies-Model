% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gen_states_index.R
\name{get_ind}
\alias{get_ind}
\title{Generate Indices}
\usage{
get_ind(ncg = 2, neg = 61, nag = 9, epi_groups)
}
\arguments{
\item{ncg}{total number of comorbidity groups}

\item{neg}{total number of epigroups}

\item{nag}{total number of age groups}

\item{epi_groups}{a vector of epi states}
}
\value{
a list of vectors of integers which reference the matching state in the vector of model states
}
\description{
takes vector of epigroups, comorbidity groups, and age groups and generates the indices that will reference the matching state in the
vector of model states. Note that the number of exposed and infectious compartments used in the model is a variable that is specified in
the file 'parameters_v3.R'. The get_ind function is called in the parameters() function to create a data.frame for indexing that is used throughout
the rest of the model.
}
