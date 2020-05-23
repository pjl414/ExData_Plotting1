#########################
### GetAndCleanData.R ###
#########################

# Download data from homework URL
url1<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url1,
              destfile = "householdpower.zip",
              method = "curl")

# Unzip the file just downloaded
unzip("householdpower.zip")
# We get a text file called "household_power_consumption.txt"

# The file size is quite large, with about 2 million lines.
# So to avoid pulling the whole data set into R when we only
# plan on using a small amount, I wrote a small function below
# called `processText()` that will read the text file
# line-by-line until, extra the data from the dates we want,
# and write this data to a new text file.  To save on the 
# computing time, the function keeps track of when the we are 
# beyond the dates we care about and stops reading the data.

processText<-function(filepath, output_name){
  con = file(filepath, "r")
  cat(readLines(con, n = 1),
      file = output_name,
      sep="\n")
  i_n<-0 ;i_o<-0
  found<-FALSE; keep_searching<-TRUE; diff_o<-0
  while (keep_searching) {
    diff_n<-i_o-i_n 
    line = readLines(con, n = 1)
    if ( grepl("[12]+/2/2007",line) ) { 
      cat(line,file=output_name,sep="\n",
          append=TRUE)
      found<-TRUE
      i_o<-i_o+1 
      diff_o<-i_o - i_n 
    }
    if (diff_o - diff_n ==0 & found ==TRUE){ 
      keep_searching<-FALSE
    }
  }
  close(con)
  print(paste(output_name,"is ready!"))
}

# Now we can use our function to process the data.
processText("household_power_consumption.txt",
            "plot_data.txt")

# You should now have the plot data as a
# text file in your working directory.