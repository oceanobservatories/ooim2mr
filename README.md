
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ooim2mr <img src="man/figures/ooi-logo.jpg" align = "right" height = "50" /> <img src="man/figures/nsf-logo.png" align = "right" height = "50" />

<!-- badges: start -->

[![License:
CC0-1.0](https://img.shields.io/badge/License-CC0%201.0-lightgrey.svg)](http://creativecommons.org/publicdomain/zero/1.0/)
<!-- badges: end -->

The goal of ooim2mr is to provide users a programmatic method for
accessing [Ocean Observatories Initiative
(OOI)](https://oceanobservatories.org/) scientific data via R. Please
review the [OOI Data Usage
Policy](https://oceanobservatories.org/usage-policy/) if you plan to
cite OOI data.

## Installation

Install the development version of ooim2mr from this GitHub repository
with:

``` r
#install.packages("devtools")
devtools::install_github("oceanobservatories/ooim2mr")
```

This package was built and tested in RStudio. It is recommended that you
utilize this package through the [RStudio integrated development
environment](https://rstudio.com/products/rstudio/download/).

## Bugs, Issues, and Functionality Requests

### General

For general bugs and issues, please use GitHub’s issue tracker. This
package reads from a lookup table in the package data subfolder and has
been curated to only give users science streams with variables that are
L1 or greater data products. If you are unable to find the data that you
want, the request stream and variables may have been inadvertently
removed. If you believe this to the case, please submit this as an
issue.

### Issue: ncdf4 (Windows only)

There is a bug in the ncdf4 package (Version 1.17) that does not allow
the reading of OpenDAP datasets. The work around to this is to first
download the NetCDF file and open it locally. If you are running R on a
MacOS or Linux machine, the ooi\_download\_data() function can generally
be bypassed and the remote locations of the data can be input into the
ooi\_get\_data() funciton. This brings data into the R environment
without downloading any files.

### Functionality Requests

For functionality requests, please submit those directly to the OOI
Helpdesk with “ooim2mr” in the subject line:
<help@oceanobservatories.org>

## Examples

Example R scripts can be found on the [OOI Data Explorations GitHub
Repository](https://github.com/oceanobservatories/ooi-data-explorations/tree/master/R).

## Usage

Most functions in this package require an internet connection to submit
requests or download data through the OOI API. The following native and
CRAN packages are also needed when utilizing this
package.

| Required Package | Install Command           | Use                                     |
| ---------------- | ------------------------- | --------------------------------------- |
| httr             | install.packages(“httr”)  | For submitting requests to OOINet.      |
| ncdf4            | install.packages(“ncdf4”) | For opening NetCDFs.                    |
| stringr          | require(stringr)          | For parsing the lookup table.           |
| jsonlite         | require(jsonlite)         | For interpreting responses from OOINet. |

### ooi\_site\_info

``` r
# Example: Requests site information for the Oregon Inshore Surface Piercing Profiler (CE01ISSP).

user = "OOI-API-USERNAME"
token = "OOI-API-TOKEN"
info = ooi_site_info(site = 'CE01ISSP',user = user, token = token)
```

This function takes a supplied OOI site and submits a request using the
provided credentials to obtain site metadata. The site must be supplied
as an OOI eight (8) character site designator.

A list of OOI sites can be found here:
<https://oceanobservatories.org/site-list/>

The return is a cascading list of lists that contains site metadata with
respect to nodes, instruments, streams, etc.

You can create or find your OOINet credentials through the Log In tab
here:
<https://ooinet.oceanobservatories.org/>

### ooi\_check\_availability

``` r
# Example: Requests deployment and annotation information for the Oregon Inshore Surface Piercing Profiler (CE01ISSP) CTD.

user = "OOI-API-USERNAME"
token = "OOI-API-TOKEN"
check = ooi_check_availability(site = 'CE01ISSP' ,node = 'PROFILER' ,instrument = 'CTD' ,user = user,token = token)
```

The supplied site, node, and instrument are used to submit a request for
deployment and annotation information using the additionally given user
credentials. For this function, a substring of the site, node, and
instrument can be used.

You can create or find your OOINet credentials through the Log In tab
here:
<https://ooinet.oceanobservatories.org/>

### ooi\_create\_url

``` r
# Example: Creates a request URL for the Oregon Inshore Surface Piercing Profiler (CE01ISSP) CTD for July 2019.

site = 'CE01ISSP'
node = 'PROFILER'
instrument = 'CTD'
method = 'recovered'
stream = ''
start_date = '2019-07-01'
start_time = '00:00:00'
stop_date = '2019-07-31'
stop_time = '23:59:59'
url = ooi_create_url(site = site ,
                     node = node ,
                     instrument = instrument, 
                     method = method,
                     stream = stream,
                     start_date = start_date,
                     start_time = start_time,
                     stop_date = stop_date,
                     stop_time = stop_time)
```

The supplied site, node, instrument, and method will be used to parse
the lookup table for a request URL. If for some reason there exist
multiple returned URLs, you can add a stream designator using the stream
parameter.

By default, the site, node, instrument, method, and stream parameters
are set to be empty strings. The function utilizes grep to parse the
lookup table, so it could be used as a search function. For example, if
you wanted to know what OOI Coastal Endurance Array assets telemeter
dissolved oxygen data, the following would return a list of URLs which
you could compare to the [OOI site
list](https://oceanobservatories.org/site-list/).

``` r
site = 'CE'
instrument = 'DO'
method = 'telemetered'

url = ooi_create_url(site = site, instrument = instrument, method = method)
```

#### site

The site is generally an eight (8) character designator.

#### node

The node is generally a five (5) character designator. If inputting a
node that is five (5) characters or less, the function assumes you are
using the actual OOI node designator. If you use an input that is six
(6) characters or more, the function assumes you are using a
simplification of the
node.

| Simplified Node Name | OOI Node Designator                                                                                                                                                                              |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Surface              | Surface Buoys (SBC11, SBD11, SBD12, SBD17, SBS01)                                                                                                                                                |
| Midwater             | Near Surface Instrument Frames (7m, 12m), Mooring Risers (RI000,RII01,RII11,RIM01, RIS01, RID16, RID27, RID26, RIC21, PC03A, PC01A, PC01B)                                                       |
| Seafloor             | Multi-function Nodes, Benthic Packages (MFD35, MFC31, MFD37, LJ01D, MJ01C, LJ01C, LV01C, PN01C, PN01D, LV01A, PN01B, LJ01A, PN01B, MJ01A,PN01A, LJ01B, PN03B, MJ03E, MJ03F, MJ03C, MJ03D, MJ03A) |
| Profiler             | Moorings With One Profiler (SP001, SP002, WFP01, SF03A, SF01A, DP01A, DP03A, DP01B, SF01B)                                                                                                       |
| Upper\_Profiler      | Moorings With Two Profilers (WFP02)                                                                                                                                                              |
| Lower\_Profiler      | Moorings With Two Profilers (WFP03)                                                                                                                                                              |

Glider nodes are the glider’s unique serial number. If you are looking
for glider data, it is recommended that you use the Glider DAC to access
OOI glider data.

Example: Using SEAFLOOR as the node is the same thing as MFD35.

#### instrument

The instrument is generally a twelve (12) character designator, with the
third character being a dash (-). Substring replacement can be used when
parsing the lookup table.

Example: Using 051 as the instrument is the same thing as 02-CTDMOH051.

#### method

The method is how you want to get the data. It can also be simplified
using a substring when also considering the site, node, and instrument.

Example: Using host as the method is the same thing as
recovered\_host.

| Method          | Description                                                                                       |
| --------------- | ------------------------------------------------------------------------------------------------- |
| recovered\_host | Data that the mooring controller collects from the instrument (think datalogger).                 |
| recovered\_inst | Data that the instrument records internally.                                                      |
| recovered\_wfp  | Data that the McLane Moored Profiler controller collects from the instruments (think datalogger). |
| recovered\_cspp | Data that the CSPP controller collects from the instruments (think datalogger).                   |
| streamed        | Data streamed over the Cabled Array.                                                              |
| telemetered     | Data telemetered over cell or iridium. Often decimated in size.                                   |

#### stream

Some instruments are split into multiple data streams. Most of the time,
just supplying the site, node, instrument, and method is enough to get a
single request URL. If multiple URLs are returned, you can specify the
stream to reduce the list to one.

#### start\_date

This is the start date of your data request window in UTC. By default,
it is set to ‘2010-01-01’, so if you do not specify a start date, the
request will get all OOI data since the start of the project.
start\_date must follow the format of ‘YYYY-mm-dd’.

#### start\_time

This is the start time of your data request window in UTC. By default,
it is set to ‘00:00:00’. start\_time must follow the format of
‘HH:MM:SS’.

#### stop\_date

This is the stop date of your data request window in UTC. By default, it
is set to ‘2040-12-31’, so if you do not specify a stop date, the
request will get all OOI data up until the second that you submit the
request. stop\_date must follow the format of ‘YYYY-mm-dd’.

#### stop\_time

This is the stop time of your data request window in UTC. By default, it
is set to ‘23:59:59’. stop\_time must follow the format of
‘HH:MM:SS’.

### ooi\_submit\_request

``` r
#Generic Example: url is the url obtained via ooi_create_url, or as a string url built by hand.

user = "OOI-API-USERNAME"
token = "OOI-API-TOKEN"
url = 'https://ooinet.oceanobservatories.org.....'
response = ooi_submit_request(url = url,user = user, token = token)
```

This function takes the URL generated by ooi\_create\_url() and issues a
request to OOINet for that data. The return is a response object that is
used in a following ooi\_get\_location() function. If the request fails,
a message with the failure reason is printed.

You can create or find your OOINet credentials through the Log In tab
here:
<https://ooinet.oceanobservatories.org/>

### ooi\_get\_location

``` r
#Generic Example: response is the response object created via ooi_submit_request.

remote = ooi_get_location(resposne = response, drop_paired = TRUE)
```

This function queries the JSON response created by the
ooi\_submit\_request() function until the data request is complete. Once
the data request is complete, the OpenDAP urls (dodsC) of where the data
is remotely located is returned. By default, the drop\_paired flag is
set to TRUE. This removes paired datasets from the return output, making
it easier to concatenate multiple files or deployments. If the
drop\_paired flag is set to FALSE, the return includes all paired
dataset
locations.

### ooi\_download\_data

``` r
#Generic Example: remote is the list of OpenDAP urls returned from the ooi_get_location function or as a hand-compiled list.

directory = 'C:\Users\Ian\Desktop\test'
local = ooi_download_data(remote, directory)
```

This function converts the dodsC OpenDAP URLs to fileServer URLs so that
the data can be downloaded to the local machine. Specifying the
directory will download the data to that directory. If left empty, the
default action is to download data to the current R session working
directory.

Files are renamed as site\_node\_instrument\_method\_deployment\_time.nc

This function can be used if you want to look at data later while
offline, but it was initially included to allow Windows users to access
the data via local files through ncdf4. Version 1.17 of ncdf4 struggles
with opening some OpenDAP urls on Windows machines. If you are a MacOS
or Linux R user, you can likely bypass this function if you do not want
to download
data.

### ooi\_get\_data

``` r
# Generic Example: local is the list of filepaths gained through ooi_download_data or a list of hand-crafted filepaths.
# Alternatively, you can use a list of OpenDAP URLs, like the ones you get from ooi_get_location, to bring data directly into the workspace.

data_variables = ooi_get_data(local, simplify_data = TRUE)
data = data.frame(data_variables[['data]])
variables = data.frame(data_variables[['variables_units]])
```

This function will bring data into the work space and attempt to merge
it as a dataframe if the data is 1D. If the data is 2D, it remains a
list of lists. The return for this function is a list of lists. List one
contains the data. List two contains a dataframe of variables that were
brought and the units associated with those variables.

By default, the simplify\_data flag is set to TRUE. This removes
confusing variables and leaves mostly first order or greater data
products. Setting this flag to FALSE will bring in all variables
available in the NetCDF.
