######################################################################################
###
### Preparation script for Guatemala LONG data
###
######################################################################################

### Load packages

require(data.table)
require(SGP)


### variables

tmp.achievement_levels <- c("Insatisfactorio", "Necesita mejorar", "Satisfactorio", "Excelente")

### Load data

Guatemala_Data_LONG <- fread("Data/Base_Files/ALLCOHORTS_LONG.csv", colClasses=rep("character", 7))


### Tidy up data

setnames(Guatemala_Data_LONG, c("COD_ESTUDIANTE"), c("ID"))
Guatemala_Data_LONG[,VALID_CASE:="VALID_CASE"]
Guatemala_Data_LONG[,CONTENT_AREA:="READING"]
Guatemala_Data_LONG[GRADE=="", GRADE:=NA]
Guatemala_Data_LONG[ACHIEVEMENT_LEVEL=="", ACHIEVEMENT_LEVEL:=NA]
Guatemala_Data_LONG[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]

Guatemala_Data_LONG[nchar(ID)==18, ID:=paste0("0", ID)]

Guatemala_Data_LONG[,ACHIEVEMENT_LEVEL_ORIGINAL:=ACHIEVEMENT_LEVEL]
Guatemala_Data_LONG[,ACHIEVEMENT_LEVEL:=NULL]
Guatemala_Data_LONG <- SGP:::getAchievementLevel(Guatemala_Data_LONG, state="GUA")
Guatemala_Data_LONG[GRADE=="4", ACHIEVEMENT_LEVEL:=ACHIEVEMENT_LEVEL_ORIGINAL]
Guatemala_Data_LONG[GRADE=="4" & ACHIEVEMENT_LEVEL=="1", ACHIEVEMENT_LEVEL:=tmp.achievement_levels[1]]
Guatemala_Data_LONG[GRADE=="4" & ACHIEVEMENT_LEVEL=="2", ACHIEVEMENT_LEVEL:=tmp.achievement_levels[2]]
Guatemala_Data_LONG[GRADE=="4" & ACHIEVEMENT_LEVEL=="3", ACHIEVEMENT_LEVEL:=tmp.achievement_levels[3]]
Guatemala_Data_LONG[GRADE=="4" & ACHIEVEMENT_LEVEL=="4", ACHIEVEMENT_LEVEL:=tmp.achievement_levels[4]]
Guatemala_Data_LONG[,ACHIEVEMENT_LEVEL_ORIGINAL:=NULL]

### Invalidate Cases

Guatemala_Data_LONG[is.na(SCALE_SCORE), VALID_CASE:="INVALID_CASE"]
setkey(Guatemala_Data_LONG, VALID_CASE, CONTENT_AREA, YEAR, ID, GRADE, SCALE_SCORE)
setkey(Guatemala_Data_LONG, VALID_CASE, CONTENT_AREA, YEAR, ID)
Guatemala_Data_LONG[which(duplicated(Guatemala_Data_LONG, by=key(Guatemala_Data_LONG)))-1, VALID_CASE:="INVALID_CASE"]


### Save Data

save(Guatemala_Data_LONG, file="Data/Guatemala_Data_LONG.Rdata")
