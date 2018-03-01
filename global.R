# Global script for birdForestry project

library(SpaDES)

# set the directories
workDirectory <- getwd()

paths <- list(
  cachePath = file.path(workDirectory, "cache"),
  modulePath = file.path(workDirectory, "modules"),
  inputPath = file.path(workDirectory, "inputs"),
  outputPath = file.path(workDirectory, "outputs")
)

setPaths(modulePath = paths$modulePath, inputPath = paths$inputPath, outputPath = paths$outputPath, cachePath = paths$cachePath)

## list the modules to use
modules <- list("glmerBirdModels") # timeseriesHRFCC, birdPrediction

## Set simulation and module parameters

times <- list(start = 1985, end = 2000, timeunit = "year")
parameters <- list(
  .globals = list(.plotInitialTime = 1),
  glmerBirdModels = list(cropping = TRUE, cropForModel = FALSE, start = 1985, end = 1985)
)
objects = list(studyArea = "testArea.shp",
#               species = c("PISI","UEFL","YRWA","DEJU"), #Once this works without species, turn on species selection
               typeDisturbance = c("Transitional", "Permanent", "Both", "Undisturbed"),
               disturbanceDimension = c("local", "neighborhood"))

dev.useRSGD(TRUE) # do not use Rstudio graphics device
dev() # opens external (non-RStudio) device, which is faster
clearPlot()

## Simulation setup
mySim <- simInit(times = times, params = parameters, modules = modules, paths =  paths, objects = objects)
mySimOut <- spades(mySim, debug = TRUE) #c("warblersPointCountBC","init")

moduleDiagram(mySim)
objectDiagram(mySim)
