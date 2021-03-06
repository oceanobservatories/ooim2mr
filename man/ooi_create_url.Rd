% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ooi_create_url.R
\name{ooi_create_url}
\alias{ooi_create_url}
\title{Generate an OOI request URL through a curated remote lookup table.}
\usage{
ooi_create_url(
  site = "",
  node = "",
  instrument = "",
  method = "",
  stream = "",
  start_date = "2010-01-01",
  start_time = "00:00:00",
  stop_date = "2040-12-31",
  stop_time = "23:59:59"
)
}
\arguments{
\item{site}{An eight (8) character designator for OOI sites.}

\item{node}{A five (5) character designator for OOI nodes. Alternatively, a simplified string for OOI sites that is greater than 5 characters. grep allows for use of substrings.}

\item{instrument}{A twelve (12) character designator for the OOI instrument on the associated site and node. grep allows for use of substrings.}

\item{method}{An indicator for how the data was delivered. Options are recovered_cspp, recovered_host, recovered_inst, streamed, telemetered.}

\item{stream}{Optional: Default is an empty string. If utilized, it helps narrow URL selection to a single URL. grep allows for use of substrings.}

\item{start_date}{The UTC start date of the data request in the format of YYYY-mm-dd. Default is 2010-01-01.}

\item{start_time}{The UTC start time of the data request in the format of HH:MM:SS. Default is 00:00:00.}

\item{stop_date}{The UTC stop date of the data request in the format of YYYY-mm-dd. Default is 2040-12-31.}

\item{stop_time}{The UTC stop time of the data request in the format of HH:MM:SS. Default is 23:59:59.}
}
\value{
The request URL generated from input parameters. If more than one URL is created from the inputs, a list of URLs is returned, prompting the user to finetune their selection.
}
\description{
Generate an OOI request URL through a curated remote lookup table.
}
\examples{
url = ooi_create_url(site = 'CE02SHSP',node = 'PROFILER',instrument = 'CTD',method = 'recovered_cspp') #Requests CE02SHSP CTD data that was recovered from the profiler for the OOI lifespan (excluded parameters use defaults).
url = ooi_create_url(site = 'CE05MOAS',node = 'GL382',instrument = 'DO',method = 'telemetered',start_date = '2019-01-10',stop_date = '2019-01-31') #Requests EA Glider 382 DO data that was telemetered from the glider for the first month of 2019.
urls = ooi_create_url(site = 'CE') #This would return all assets within the Endurance Array.
}
