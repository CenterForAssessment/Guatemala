######################################################################################
###
### Preparation script for Guatemala LONG data
###
######################################################################################

### Load packages

require(data.table)
require(SGP)


### Load data

Guatemala_Data_LONG <- fread("Data/Base_Files/COHORTE_1_LONG_FORMAT_SGP.csv", colClasses=rep("character", 15))


### Tidy up data

Guatemala_Data_LONG[,LAST_NAME:=as.character(sapply(LAST_NAME, capwords))]
Guatemala_Data_LONG[,FIRST_NAME:=as.character(sapply(FIRST_NAME, capwords))]
Guatemala_Data_LONG[,SCHOOL_NAME:=as.character(sapply(SCHOOL_NAME, capwords))]
Guatemala_Data_LONG[,DISTRICT_NAME:=as.character(sapply(DISTRICT_NAME, capwords))]
Guatemala_Data_LONG[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]


### Invalidate Cases

Guatemala_Data_LONG[GRADE=="", VALID_CASE:="INVALID_CASE"]
Guatemala_Data_LONG[is.na(SCALE_SCORE), VALID_CASE:="INVALID_CASE"]


### Save Data

save(Guatemala_Data_LONG, file="Data/Guatemala_Data_LONG")
