library(dplyr)
library(randomNames)

# Define job titles and departments for random selection

job_titles <- c('Laborer', 'Engineer', 'Foreman', 'Electrician', 'Plumber', 'Carpenter')
departments <- c('Construction', 'Electrical', 'Plumbing', 'Carpentry', 'Management')
genders <- c('Male', 'Female')


# Define custom error class
SalaryOutOfRangeError <- function(message) {
  structure(list(message = message), class = c("SalaryOutOfRangeError", "error", "condition"))
}


# Error handling function
handleError <- function(e) {
  if (inherits(e, "SalaryOutOfRangeError")) {
    cat("<SalaryOutOfRangeError: ", e$message, ">\n", sep = "")
  } else {
    cat("<", class(e), ": ", conditionMessage(e), ">\n", sep = "")
  }
}


generate_workers <- function(num_workers = 400) {
  workers <- data.frame(
    `Employee Name` = replicate(num_workers, randomNames::randomNames()),
    Gender = sample(genders, num_workers, replace = TRUE),
    `Job Title` = sample(job_titles, num_workers, replace = TRUE),
    Department = sample(departments, num_workers, replace = TRUE),
    Salary = sample(5000:35000, num_workers, replace = TRUE),
    stringsAsFactors = FALSE
  )
  return(workers)
}

generate_payment_slips <- function(workers) {
  payment_slips <- list()
  
  for (i in 1:nrow(workers)) {
    worker <- workers[i, ]
    slip <- list(
      `Employee Name` = worker$`Employee Name`,
      Salary = worker$Salary,
      Employee_level = NULL
    )
    
    tryCatch({
      # Raise SalaryOutOfRangeError if salary is out of range
      if (worker$Salary > 35000 || worker$Salary < 5000) {
        stop(SalaryOutOfRangeError(paste("Salary", worker$Salary, "out of range for", worker$`Employee Name`)))
      }
      
      # Conditional statements to assign employee level
      if (10000 < worker$Salary & worker$Salary < 20000) {
        slip$Employee_level <- "A1"
      }
      
      if (7500 < worker$Salary & worker$Salary < 30000 & worker$Gender == "Female") {
        slip$Employee_level <- "A5-F"
      }
      
      payment_slips[[i]] <- slip
      
    }, SalaryOutOfRangeError = function(e) {
      handleError(e)
      slip$Employee_level <- "Unknown"
      payment_slips[[i]] <- slip
      
    }, error = function(e) {
      handleError(e)
      next
    })
  }
  
  payment_slips_df <- do.call(rbind, lapply(payment_slips, function(x) as.data.frame(x, stringsAsFactors = FALSE)))
  return(payment_slips_df)
}

# Example usage
workers <- generate_workers(400)
payment_slips <- generate_payment_slips(workers)
print(payment_slips)
View(payment_slips)

# Optional 

# Save the payment slips to a CSV file
write.csv(payment_slips, "payment_slips.csv", row.names = FALSE)

# Read and view the saved payment slips
saved_payment_slips <- read.csv("payment_slips.csv")
print(saved_payment_slips)

