#---------------------------#
#     ___ README.md ___     #     |\____/\
# Sarah Michel              #     / ,o  o ;
# Coursera                  #   ==:. / Y\ :=
# Getting & Cleaning Data   #     \ `\ w/'/
# 2015-08-22                #     /       \
#---------------------------#

run_analysis.R reads data from the UCI HAR dataset, stitches it together,
does some aggregation, and saves the result as run_analysis_output.txt in the
working directory. The script's functions should be self-explaining by its comments.

One thing to note is, run_analysis.R expects the working directory to contain folder
"UCI HAR Dataset," which contains the contents of the zip file we downloaded.
The script comments also include instructions for how to change the directory to point
at whatever directory you have saved this folder.

run_analysis.R will write a file run_analysis_output.txt to your working directory.
This file can be read back into R with read.table("run_analysis_output.txt",header=TRUE)

codebook.txt describes the output of run_analysis_output.txt.