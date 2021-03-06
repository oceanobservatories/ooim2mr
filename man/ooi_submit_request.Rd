% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ooi_submit_request.R
\name{ooi_submit_request}
\alias{ooi_submit_request}
\title{Submit data request to OOINet.}
\usage{
ooi_submit_request(url, user, token)
}
\arguments{
\item{url}{The request URL generated through the ooi_create_url() function, or as a  string input by the user.}

\item{user}{The username made available through an OOINet account, entered as a string.}

\item{token}{The token made available through an OOINet account, entered as a string.}
}
\value{
A JSON response object is returned if the request is successful. If it is not successful, nothing is returned and a message with the status code is printed.
}
\description{
Submit data request to OOINet.
}
\examples{
url = "https://ooinet.oceanobservatories.org/api/m2m/12576/sensor/inv/CE05MOAS/GL382/04-DOSTAM000/telemetered/dosta_abcdjm_glider_instrument?beginDT=2019-01-10T00:00:00.000Z&endDT=2019-01-31T23:59:59.999Z"
response = ooi_submit_request(url,user = 'OOI-API-USERNAME-HERE',token = 'OOI-API-TOKEN-HERE')
}
