############--------------------------------------------------------------
##  DATA FRAME REFERENCE AND SUBSETTING
##  By Sarit Pery
##  
##  Please feel free to suggest corrections and additions to the file.
##  You may contact me at sarit@peryjoy.com
############--------------------------------------------------------------
  

# A "data frame" is a table that usually holds your data. 
# This is why we sometimes refer the columns as the variable names,
#   and to the rows as observations. 


# ----------Prepare the environment
    rm(list = ls())
    cat ("\014")
    if(is.null(dev.list()) == FALSE) dev.off()
    
    # listen_df is a data frame for the purpose of exercizing.
    listen_df <- read.csv(
        "https://www.dropbox.com/s/modnpbbqjrmuodr/listenSurvey.csv?dl=1",
        stringsAsFactors = FALSE)


    
# -------- Saving the subset - General note

    # When we want to use only a part of our data frame, it's called subset.
    #   we can save this subset as:
    #   
    #   1. save the subset in a new data frame
    #   2. save the subset back into the original data frame, so we overwrite it
    #   3. just use the subset, without saving it separately.
    #   
    # All three options will be demonstrated along the coming examples.
    
    
    
# ---------- Refer to a single column - Use of the $-sign

    # Just show me the specific column 
    listen_df$years_together_1        
    
    # Just show me the specific column multiplied by 2
    listen_df$years_together_1 * 2    
    
    # Create a new column called "AnewName", and put in it half the ages.
    # If I refer to a non-existing name, it creates it.
    listen_df$A.new.Name <- listen_df$age_1 / 2
    
    # Refer to a column and overwrite it with new values.
    # First, the right-hand-side is calculated: multiply years-together by 2, 
    # Second, it assigns the result to years-together (it overwrites it)
    listen_df$years_together_1 <- listen_df$years_together_1 * 2
 

# ---------- Refer to several columns/rows - Use of the []-sign
    
    # The brackets enable to constrain the rows and columns :
    
    # No constraints on rows nor on columns = show me all the data
    listen_df[ , ]  
    listen_df
    
    # ------- refer to data by rows/columns number (index)

        # show me the first row (with all the variables)
        listen_df[ 1, ]
        
        # show me rows 1, 3, 5
        listen_df[c(1, 3, 5), ]
        
        # show me a calculation with the second and third columns: 
        listen_df[ , c(2,3)] ^ 2
        
        # create a new data frame, holding the last calculation
        Sqr.23.colns <- listen_df[ , c(2,3)] ^ 2

        # show me the square-root of columns 2-3, in rows 10-20:
        sqrt( listen_df[ c(10:20), c(2,3)]  )

    # ------- refer to data by column names:
        
        # show me a single column by name:
        # Very important: the name of the column should be in quotes.
        listen_df[ , "age_1" ]
        
        # show me: Three columns by name, multiplied by 3
        listen_df[ , c("age_1", "trust_1", "years_together_1") ] * 3
        
        # show me the last calculation, for rows 23-45 only: 
        listen_df[ c(23:45), c("age_1", "trust_1", "years_together_1")] *3
        
        # create a new data frame, holding the last calculation
        Age.Trust.Together.Times.3 <- 
            listen_df[ c(23:45), c("age_1", "trust_1", "years_together_1")] *3
        
    # ------- refer to data by variable:
        
        # We can use variables to hold the names of the column names we wish 
        # to refer to. 
        # Now the reference to the columns is without the "".
        
        # Create a list of the columns we want to subset:
        the.Variables.I.Want <- c("age_1", "trust_1", "years_together_1")
        
        # show me the columns I want with the variable - use the variable name
        # without the ""
        listen_df[ , the.Variables.I.Want]
        
        # Create a variable by calculation (just an example)
        # I know that there are Humility column names, so I can prepare a 
        # calculated list of the variables names:
        Humility.Items <- paste0("Humility_", 1:9)
        
        # show me just the Humility columns:
        listen_df[ , Humility.Items]
        
        # add 1 to all the humility items:
        listen_df[ , Humility.Items] <- listen_df[ , Humility.Items] + 1
  
    # ------- refer to data by A Question - Logical:
        
        # We can refer to columns or rows by a logical (TRUE/FALSE) Question:
        # For example, show me the rows for Age > 30. 
        # Every row is either TRUE or FALSE for that question.
        
        # take the rows where Age > 30, 
        # and save it into a new data frame:
        Age.Over.30 <- listen_df[ listen_df$age_1 > 30, ]
        
        # bonus line... 
        # Show the age distribution in the original data frame, and in the 
        #   Age.Over.30 data frame:
        table(listen_df$age_1)
        table(Age.Over.30$age_1)
        
        
    # ------- Remove rows from a data frame:
        
        # Remove rows by a Question (Logical)  
            # remove the rows where there is NA in a specific column:
            # save it as a new data frame:
            listen.No.NA.In.Gender <- listen_df[ !is.na(listen_df$gender) , ]
            
            # remove the rows where Age > 30, 
            # and save it into a new data frame:
            Age.Under.30 <- listen_df[ listen_df$age_1 <= 30, ]
            
    
        # Remove rows by row-number:
        listen.No.NA.In.Gender <- listen_df[-c(1, 3, 5), ]
        listen.No.NA.In.Gender <- listen_df[-c(1:16), ]
            
    # ------- Remove columns from a data frame:
        
        # remove columns by column-number:
        listen.Wo.123 <- listen_df[ , -c(1:3)]
    
        # remove columns by name: 
        # ----------------------
        # You have to work in two steps: 
        # 1. Find the columns numbers or a TRUE/FALSE for all the column-names
        # 2. Remove the columns by the column numbers / logical
 
        the.Variables.I.Dont.Want <- c("age_1", "trust_1", "years_together_1")
        
        #option 1 : logical
    
        # Return a TRUE/FALSE for each name
        #  %in% is just a funny-looking function that returns TRUE/FALSE 
        #       for each element in the first vector (the.Variables.I.Dont.Want), 
        #       if it's in the second vector (names(listen_df)).
        the.Vars.I.Dont.Want.Index <- names(listen_df) %in% the.Variables.I.Dont.Want
        listenOnlyWanted <- listen_df[ , !the.Vars.I.Dont.Want.Index]
        
        #option 2 : locate columns position in order to remove it
        #  %in% is just a funny-looking function that returns TRUE/FALSE 
        #       for each element in the first vector (the.Variables.I.Dont.Want), 
        #       if it's in the second vector (names(listen_df)).
        the.Vars.I.Dont.Want.Index <- 
            which(the.Variables.I.Dont.Want %in% names(listen_df))
            listenOnlyWanted <- listen_df[ , !the.Vars.I.Dont.Want.Index]
        