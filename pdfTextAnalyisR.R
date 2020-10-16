
library(pdftools)
library(tidyverse)
library(dplyr)


#create variable to hold the text from the pdf file 
#input your pdf file name - it should be in the same directory/folder that this script is kept in
text_block <- pdf_text("yourPdfFileNameHere.pdf") %>%
  readr::read_lines()

#split each string (which is each line of the pdf text) by white spaces
#EX: "The cat ran down the street" becomes "The", "cat", "ran", "dowm".... including white spaces
text_block <- str_split(text_block, " ")

#function to split vectors of strings up
stringsplitter <- function(str) {
  str_split(str, " ")
}
#apply the function to each vector (line of the pdf)
split_text <- sapply(text_block, stringsplitter)
#unlist by a level
split_text <- unlist(split_text)

#remove all of the instances of empty strings 
remove <- c("")
split_text <- split_text[!split_text %in% remove]
#now we have a vector simply of all of the words in the pdf 

#count up the frequency of each word
freq <- table(split_text)
#convert the frequency table to a data frame
freq <- as.data.frame(freq)
#rename the data frame columns to 'Word' and 'Frequency'
freq <- freq %>%
  rename(
    Word = split_text,
    Frequency = Freq
  )

#sort the frequency data from largest (most common word to least)
freq <- freq[order(-freq$Freq),]
#select only the top 20 results (feel free to change this number)
head(freq, 100)






