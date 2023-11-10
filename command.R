library(PoissonERM)
rm(list = ls(all = TRUE))
folder.dir1 <- "PoissonERM-Example/Example1/"
ModelPoisson(pathRunType = folder.dir1,
             user.input = "user-input.r")

PredictionPoisson(pathRunType = getwd(),
                  prediction.input = "prediction-user-input-sim.R",
                  model.RData = "myEnvironment.RData")

ReportPoisson(pathRunType = getwd(),
              model.RData = "myEnvironment.RData",
              file.name = "Report_with_pred.Rmd")


rm(list = ls(all = TRUE))
folder.dir2 <- "PoissonERM-Example/Example2/"
ModelPoisson(pathRunType = folder.dir2,
             user.input = "user-input.r")
ReportPoisson(pathRunType = getwd(),
              model.RData = "myEnvironment.RData",
              file.name = "Report_no_pred.Rmd")
