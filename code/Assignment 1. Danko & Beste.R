#Assignment: Plot Deconstruction (Assignment. Graphical Storytelling in R)

#Part 1. First, choose your data
# Read the CSV file and assign it to a variable named dataset
# Specify the file path of the CSV file
file_path <- "C:/Users/Danko Castaño Duro/Desktop/Australia 3 semestre/Modulos 1/INTRODUCTION TO R 4/MB5370_Mod04_Danko/MB5370_Mod04_Danko/Australian Shark-Incident Database Public Version (2).csv"

# Read the CSV file with specified parameters
data <- read.csv(file_path, header = TRUE, sep = ",", quote = "\"")

# Display the structure of the data
summary(data)

