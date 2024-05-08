library(tidyverse)

input.data.name <- "obsdata.csv"
pat.num <- "ID" #ID is the column name in data set

#Column for time in days
EVDUR <- "TIME"
EVDUR.unit <- "days"

dv <- "DV" #DV is the outcome column name in data set
# Levels as they appear in the dataset
dv.levels <- c(0, 1)
# Labels you'd like to see in the report
dv.labels <- c("No", "Yes")

# Column describing endpoints
endpcolName <- "FLAG" #FLAG is the flag column name in data set
# Subset of endpoints in analysis dataset to be analyzed
# Can be numbers or character strings, howevever they show up in the dataset
endpoints <- c(1,2,3) #the actual values in FLAG to be used in this analysis
#endpoints <- c(1,3) #FLAG=2 will be ignored in this analysis

# ENDPOINTS names.
# Names for endpoints as they should appear in tables and figures.
# Should be the same length as the "endpoints" vector above.
# Any endpoint name cannot be a sub-string of the other one
# Bad example
#endpName <- c("Adverse",
#              "Adverse Event",
#              "Adverse Event Type")

# EXAMPLE:
endpName <- c("Adverse Event Type 1",
              "Adverse Event Type 2",
              "Adverse Event Type 3")

endpName <- sapply(X = endpName, simplify = F, USE.NAMES = T, FUN = function(n){
  if(n == "Adverse Event Type 1"){
    numb <- endpoints[1] #FLAG = 1 (endpoints[1]) is "Adverse Event Type 1"
    label <- n
  }else if(n == "Adverse Event Type 2"){
    numb <- endpoints[2] #FLAG = 2 (endpoints[2]) is "Adverse Event Type 2"
    label <- n
  }else if(n == "Adverse Event Type 3"){
    numb <- endpoints[3] #FLAG = 3 (endpoints[3]) is "Adverse Event Type 3"
    label <- n
  }else{
    numb <- 0
    label <- 0
  }
  endp.list <- c(numb, label)
  return(endp.list)
} # function(n)
) # sapply

sub.endpcolName <- "SUB" #SUB is the column name in the data set
sub.endpName <- list(`Adverse Event Type 1` = c(`Severe` = 1,
                                                `Mild` = 2,
                                                `None` = 3),
                     #Endpoint name = c(Actual sub-category name = Value in the column)
                     `Adverse Event Type 2` = c(`SubType 1` = 1,
                                                `SubType 2` = 2,
                                                `SubType 3` = 3,
                                                `SubType 4` = 4,
                                                `SubType 5` = 5,
                                                `SubType 6` = 6),
                     `Adverse Event Type 3` = c(`Severe` = 1,
                                                `Moderate` = 2,
                                                `Mild` = 3,
                                                `None` = 4))


#The same column cannot be set as dvg and sub.endpcolName at the same time
#dvg <- "SUB" #SUB is the column name in the data set

# EXPOSURE covariates - list
# Names should correspond to names in analysis dataset.
# EXAMPLE:
orig.exposureCov <- c("CAVE1","CAVE2") #exposure metric column names in data

desc.exposureCov.1 <- sapply(X = orig.exposureCov, simplify = F, USE.NAMES = T, FUN = function(f){
  if(f == "CAVE1"){
    #name to show in tables or figures
    title = "C[ave1]~(ng/mL)" #use ~ for white space; use [x] for subscript text
    label = "Time-weighted average concentration A" #Name to show in report context
    #end.p = c(endpoints[1]) #will be used in the first endpoint
    end.p = c(endpoints[1:3]) #will be used in all 3 endpoints
  }else if(f == "CAVE2"){
    title = "C[ave2]~(ng/mL)"
    label = "Time-weighted average concentration B"
    end.p = c(endpoints[1:3])
  }else{

  }
  list(title = title, label = label, end.p = end.p)
} # function(f)
) # sapply


# CATEGORICAL covariates - list
# Names should correspond to names in analysis dataset.
# EXAMPLE:
full.cat <- c("RACE","SEX", "LOCATION")

# Assign more elaborate names and factor levels to categorical covs
# NOTE: Assign the desired reference value as the first element of "levels"
# EXAMPLE:
full.cat.1 <- sapply(X = full.cat, simplify = F, USE.NAMES = T, FUN = function(j){
  if(j == "RACE"){
    #categorical values are coded as numbers 1,2,3,4 in data set
    #the levels vector is corresponding to the order of numerical levels in the data set
    levels = c("White", "Black", "Asian", "Other") #1="White", 2="Black", ...
    label = "Race" #Name of the variable to show in report
    #end.p = c(endpoints[1]) #use for the first endpoint
    #end.p = "summary only" #use for demographic summary only, won't be included in modeling
    end.p = c(endpoints[1:3]) #use for all endpoints
  }else if(j == "SEX"){
    levels = c("Male", "Female")
    label = "Sex"
    #end.p = "summary only"
    end.p = c(endpoints[1:3])
  }else if(j == "LOCATION"){
    levels = c("US", "Non-US")
    label = "Geographical~Location" #use ~ for white space
    #end.p = "summary only"
    end.p = c(endpoints[1:3])
  }
  list(levels = levels, label = label, end.p = end.p)
} # function(j)
) # sapply


# CONTINUOUS covariates - list
# Names should correspond to names in analysis dataset.
# EXAMPLE:
orig.con <- c("AGE","BWT")
# Assign more elaborate names to continuous covs
# Write what you want to end up in the plot(s)
# EXAMPLE:
orig.con.1 <- sapply(X = orig.con, simplify = F, USE.NAMES = T, FUN = function(k){
  if(k == "AGE"){
    title = "age" #Name of the variable to show in report
    #end.p = c(endpoints[1]) #use for first endpoint
    #end.p = "summary only" #use for demographic summary only, won't be included in modeling
    end.p = c(endpoints[1:3])
  }else if(k == "BWT"){
    title = "Baseline~Bodyweight~(kg)" #use ~ for white space
    #end.p = "summary only"
    end.p = c(endpoints[1:3])
  }else{
    
  }
  list(title = title, end.p = end.p)
} # function(k)
) # sapply

#Use (continuous variable - reference) in model
#con.model.ref <- "Yes" #Default value "No"
#Not use (continuous variable - reference) in model
con.model.ref <- "No"  #Default value "No"

#The reference number of each continuous variable
#If not provided, will use median by default
#con.ref<- list(ref = c(AGE = 35, #variable name = reference value
#                       BWT = 70),
#               #already.adjusted.in.data is always F, unless the values are already centered in the data set
#               already.adjusted.in.data = F)

###########################################
#######        Other Options      #########
###########################################

# Grouping variable for demographic summaries
demog_grp_var <- "PROT" #Default is "PROT"
#demog_grp_var <- "SEX"

###Additional columns to carry with
###Could be missing
add_col <- c("C")

# threshold percentage for considering endpoints
p.yes.low <- 10 #Defult value 10, must be between 0 and 100
#p.yes.low <- 5 #Defult value 10, must be between 0 and 100

# use Delta D instead of p-value
useDeltaD <- FALSE #Default value FALSE
#significant level to an exposure metric to stay in base model
p_val <- 0.01 #Default significant level 0.01

#useDeltaD <- TRUE #Default value FALSE

# Looking for covariates in modeling
analyze_covs <- "Yes" #Default value "Yes" unless no covariates provided for modeling
# threshold(%) for missing value proportion in continuous covariates
# the variable will be ignored if the missing value is higher than the threshold
p.icon <- 10 #Default value 10, must be between 0 and 100

# threshold(%) for missing value proportion in categorical covariates
# the variable will be ignored if the missing value is higher than the threshold
p.icat <- 10 #Default value 10, must be between 0 and 100

#Significant level for a variable to stay in the final model
p_val_b <- 0.01 #Default significant level 0.01
#p_val_b <- 0.1 #Default significant level 0.01
#Exposure Metric will be in the final model regardless of the significant level.
exclude.exp.met.bd <- "Yes" #Default value "Yes"
#exclude.exp.met.bd <- "No" #Default value "Yes"

# Taking log of exposure metrics
log_exp <- "Yes" #Default value "Yes"
# Taking sqrt of exposure metrics
sqrt_exp <- "Yes" #Default value "Yes"
# Taking log of continuous covariates
log_covs <- "Yes" #Default value "Yes"

#Odds Ratios plot for Continuous Variable
#Compare from low-th percentile to up-th percentile
#If any of them not specified, continuous variable will be removed from OR plots
OR_con_perc <- c(0.25,0.75) #values must be between 0 and 1

#Include Tables in the report
OR_tab <- "Yes" #Default value "Yes"

#Include Figures in the report
OR_fig <- "Yes" #Default value "Yes"

LaTex.table <- TRUE #Default value FALSE

#ERModPoisson()
