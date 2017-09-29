Data Science Skills
========================================================
author: Group 1
date: 

What is Data Science
========================================================



We set out to answer "Which skills are the most valued data science skills?". 

Let's begin by looking at what *Data Science* is: 


```r
library(xml2)
library(XML)
library(stringr)
data.science <- read_html("https://en.wikipedia.org/wiki/Data_science")
data.science.html <- htmlTreeParse(data.science, useInternal = TRUE) 
data.science.text <- unlist(xpathApply(data.science.html, '//body', xmlValue))
gsub("\\[[0-9].+\\]", "", str_trim(str_extract(data.science.text, "Data Science is.+")))
```

[1] "Data Science is an interdisciplinary field about processes and systems to extract knowledge or insights from data in various forms, either structured or unstructured, which is a continuation of some of the data analysis fields such as statistics, data mining, and predictive analytics, similar to Knowledge Discovery in Databases (KDD)."


What is Data Science 
======================================================== 

Essentially, Data Science is a mix of many fields and diverse skills. It lies at the intersection of math, computer science, and domain expertise. 

<center><img src="https://raw.githubusercontent.com/ChristopheHunt/MSDA---Coursework/master/Data%20607/Homework/Group%20Project/Data_Science_VD.png" height="370px" /></center>

<div class="footer" style="margin-top;font-size:80%;"> The Data Science Venn Diagram is Creative Commons licensed as [Attribution-NonCommercial](http://creativecommons.org/licenses/by-nc/3.0/legalcode).
Slide With Plot
========================================================

![plot of chunk unnamed-chunk-3](R Presentation-figure/unnamed-chunk-3-1.png)
