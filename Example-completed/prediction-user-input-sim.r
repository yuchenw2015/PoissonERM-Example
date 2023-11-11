################################################################################
###########Add simulated exposure to incidence vs exposure###############
################################################################################
library(tidyverse)
#number of bins for grouping exposure values of observations (the data used in modeling)
bin_n_obs <- 7 #Default value is 5

#Provide the new data set for prediction
sim_inc_expo_data <- "simdata.csv"

#Selected Exposure Metric(s) column(s) in Obs Data (not sim data) shown on prediction plot
#If Obs_Expo_list is missing, Obs_Expo_list = names(orig.exposureCov) which was saved in the modeling result
Obs_Expo_list <- c("CAVE1", "CAVE2")

#Metric column(s) in simulation data to be used as Exposure(s) on plot
#the order needs to be consistent with Obs_Expo_list
#If Sim_Expo_list is missing, Sim_Expo_list =  Obs_Expo_list
Sim_Expo_list <- c("CAVE1", "CAVE2")


#Statistic of Exposure used to calculate fitted value.
#"median", "geomean";
Center_Metric <- "geomean" #Default value "geomean"
Center_Metric_name <- "geometric mean"
#Center_Metric <- "median" #Default value "geomean"
#Center_Metric_name <- "Median"

#Group Label column name

grp_colname <- "GROUP" #column name in simdata.csv
grp_colname_tab <- "Treatment" #name to display in tables
#provide levels in Group Label column
#if levels.grp is missing, a vector of the unique values in grp_colname will be levels.grp
levels.grp <- c("10 mg QD",
                "30 mg QD",
                "50 mg QD",
                "100 mg QD")
#provide labels of each level in Group Label column
#if labels.grp is missing, labels.grp = levels.grp
labels.grp <- c("10 mg once daily",
                "30 mg once daily",
                "50 mg once daily",
                "100 mg once daily")

# Only include partial exposure records
filter_condition <- "GROUP != '10 mg QD'" #remove 10 mg QD group

expo_pred_tab_caption <- "Predicted exposure metric values for each dose are derived from 2,500 simulated subjects."

#PredictionPoisson(save.name = "myEnvironment_new.RData")
#ReportPoisson(model.RData = "myEnvironment_new.RData")
