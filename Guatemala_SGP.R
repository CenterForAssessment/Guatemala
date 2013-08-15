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

Guatemala_SGP <- prepareSGP(Guatemala_Data_LONG)


### analyzeSGP

Guatemala_Config <- Grade_12.config <- list(
			MATHEMATICS.2012 = list(
				sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS'),
				sgp.panel.years=c('2009', '2012'),
				sgp.grade.sequences=list(c(9, 12))),
			READING.2012 = list(
				sgp.content.areas=c('READING', 'READING'),
				sgp.panel.years=c('2009', '2012'),
				sgp.grade.sequences=list(c(9, 12))))
						
Guatemala_SGP <- analyzeSGP(Guatemala_SGP,
			sgp.percentiles=TRUE,
			sgp.projections=FALSE,
			sgp.projections.lagged=FALSE,
			sgp.percentiles.baseline=FALSE,
			sgp.projections.baseline=FALSE,
			sgp.projections.lagged.baseline=FALSE,
			sgp.config.drop.nonsequential.grade.progression.variables=FALSE,
			sgp.config=Guatemala_Config)


### combineSGP

Guatemala_SGP<-combineSGP(Guatemala_SGP, state="GUA")			


### summarizeSGP

Guatemala_SGP <- summarizeSGP(Guatemala_SGP)


### visualizeSGP

visualizeSGP(Guatemala_SGP, state="GUA", plot.types=c("bubblePlot", "studentGrowthPlot", bPlot.prior.achievement=FALSE, sgPlot.demo.report=TRUE))


### outputSGP

outputSGP(Guatemala_SGP)


### save results

save(Guatemala_SGP, file="Data/Guatemala_SGP.Rdata")
