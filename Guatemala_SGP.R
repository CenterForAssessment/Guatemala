#####################################################
###
### SCRIPT FOR CREATING SGPs FOR GUATEMALA
###
#####################################################

### LOAD SGP PACKAGE

require(SGP)


### Load LONG Data

load("Data/Guatemala_Data_LONG.Rdata")


### prepareSGP

Guatemala_SGP <- prepareSGP(Guatemala_Data_LONG, create.additional.variables=FALSE)


### analyzeSGP

Guatemala_SGP <- analyzeSGP(Guatemala_SGP,
			sgp.percentiles=TRUE,
			sgp.projections=FALSE,
			sgp.projections.lagged=FALSE,
			sgp.percentiles.baseline=FALSE,
			sgp.projections.baseline=FALSE,
			sgp.projections.lagged.baseline=FALSE)


### combineSGP

Guatemala_SGP<-combineSGP(Guatemala_SGP)


### summarizeSGP

#Guatemala_SGP <- summarizeSGP(Guatemala_SGP)


### visualizeSGP

#visualizeSGP(Guatemala_SGP, state="GUA", plot.types=c("bubblePlot", "studentGrowthPlot", bPlot.prior.achievement=FALSE, sgPlot.demo.report=TRUE))


### outputSGP

outputSGP(Guatemala_SGP)


### save results

#save(Guatemala_SGP, file="Data/Guatemala_SGP.Rdata")
