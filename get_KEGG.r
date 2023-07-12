# Load the required packages
library(rvest)
library(dplyr)
library(stringr)
library(foreach)
library(doParallel)

#######################
#######################
# Get all pathway id from KEGG
#######################
#######################
# Specify the URL
url <- "https://rest.kegg.jp/list/pathway"

# Read the webpage content
webpage_content <- readLines(url)

# Extract the strings with prefix "map"
variables <- str_extract(webpage_content, "(?<=map)\\d+")


#######################
#######################
# Extract all KO orthologs belonging to the same pathway
#######################
# Specify the base URL
base_url <- "https://www.kegg.jp/kegg-bin/view_ortholog_table?map="

# Set the number of parallel workers
num_cores <- detectCores()

# Initialize parallel backend
registerDoParallel(cores = num_cores)

# Initialize an empty list to store the data frames
dfs <- foreach(variable = variables, .combine = bind_rows) %dopar% {
  # Construct the URL for the current variable
  url <- paste0(base_url, variable)
  
  # Initialize a variable to store the scraped data
  df <- NULL
  
  # Try scraping the webpage
  tryCatch({
    # Read the webpage and extract the table
    webpage <- read_html(url)
    table <- html_table(html_nodes(webpage, "table")[[1]])
    
    # Convert the table to a data frame
    df <- as.data.frame(table)
    
    # Modify the first cell in the data frame
    df[1, 1] <- substr(variable, nchar(variable) - 4, nchar(variable))
    df <- df[1, ]
  }, error = function(e) {
    # Print an error message if scraping fails
    cat("Error scraping webpage:", url, "\n")
  })
  
  # Return the data frame
  df
}

# Stop parallel backend
stopImplicitCluster()

# Combine all individual data frames into one
combined_df <- bind_rows(dfs)

# Print the resulting data frame
print(combined_df)
