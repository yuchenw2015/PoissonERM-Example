library(PoissonERM)
# always clean the environment before using any functions from PoissonERM
rm(list = ls(all = TRUE))
# set folder.dir1 as the path to folder "Example1"
# folder.dir1 is better to be an absolute path
folder.dir1 <- "PoissonERM-Example/Example1/"
ModelPoisson(pathRunType = folder.dir1,
             user.input = "user-input.r")

PredictionPoisson(pathRunType = getwd(),
                  prediction.input = "prediction-user-input-sim.R",
                  model.RData = "myEnvironment.RData")

ReportPoisson(pathRunType = getwd(),
              model.RData = "myEnvironment.RData",
              file.name = "Report_with_pred.Rmd")


# always clean the environment before using any functions from PoissonERM
rm(list = ls(all = TRUE))
# set folder.dir2 as the path to folder "Example2"
# folder.dir2 is better to be an absolute path
folder.dir2 <- "PoissonERM-Example/Example2/"
ModelPoisson(pathRunType = folder.dir2,
             user.input = "user-input.r")
ReportPoisson(pathRunType = getwd(),
              model.RData = "myEnvironment.RData",
              file.name = "Report_no_pred.Rmd")

rm(list = ls(all = TRUE))
