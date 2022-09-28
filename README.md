# Exploratory-data-analysis-week-4
## Data
 
The data for this assignment are available from the course web site as a single zip file:

Data for Peer Assessment [29Mb]

The zip file contains two files:

PM2.5 Emissions Data (\color{red}{\verb|summarySCC_PM25.rds|}summarySCC_PM25.rds): This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year. Here are the first few rows.

fips: A five-digit number (represented as a string) indicating the U.S. county

SCC: The name of the source as indicated by a digit string (see source code classification table)

Pollutant: A string indicating the pollutant

Emissions: Amount of PM2.5 emitted, in tons

 The type of source (point, non-point, on-road, or non-road)

 The year of emissions recorded

Source Classification Code Table (\color{red}{\verb|Source_Classification_Code.rds|}Source_Classification_Code.rds): This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever categories you think are most useful. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”

## Assignment
 
The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008. You may use any R package you want to support your analysis.
