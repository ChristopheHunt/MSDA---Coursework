library(pacman)
p_load(plyr, dplyr, tidyr, ggplot2, rgdal, maptools, RColorBrewer, scales, tools, gdata, ggplot2)

url_for_download <- c("https://raw.githubusercontent.com/jlaurito/CUNY_IS608/master/lecture1/data/inc5000_data.csv")

raw_data <- read.csv(url_for_download)

raw_data_complete_cases <- raw_data[(complete.cases(raw_data)),]

raw_data_name <- file_path_sans_ext(gsub(".+/", "", url_for_download))

business_data <- raw_data_complete_cases %>%
                               select(Name, State) %>%
                               group_by(State) %>%
                               summarise(Total = length(Name))

state_shape_files <- "http://www2.census.gov/geo/tiger/GENZ2015/shp/cb_2015_us_state_20m.zip"
download.file(state_shape_files, destfile = "cb_2015_us_state_20m.zip")
unzip("cb_2015_us_state_20m.zip")
states <- readOGR(dsn = ".", layer = "cb_2015_us_state_20m")

#I ran into alot of trouble with Alaska making the graph too wide so I used the below code snippet to move around Hawaii and Alaska which came from this stackoverflow post - http://stackoverflow.com/questions/13757771/relocating-alaska-and-hawaii-on-thematic-map-of-the-usa-with-ggplot2

fixup <- function(usa,alaskaFix,hawaiiFix){

  alaska=usa[usa$NAME=="Alaska",]
  alaska = fix1(alaska,alaskaFix)
  proj4string(alaska) <- proj4string(usa)

  hawaii = usa[usa$NAME=="Hawaii",]
  hawaii = fix1(hawaii,hawaiiFix)
  proj4string(hawaii) <- proj4string(usa)

  usa = usa[! usa$NAME %in% c("Alaska","Hawaii"),]
  usa = rbind(usa,alaska,hawaii)

  return(usa)

}

fix1 <- function(object,params){
  r=params[1];scale=params[2];shift=params[3:4]
  object = elide(object,rotate=r)
  size = max(apply(bbox(object),1,diff))/scale
  object = elide(object,scale=size)
  object = elide(object,shift=shift)
  object
}

states <- spTransform(states,CRS("+init=epsg:2163")) %>%
          fixup(c(-35,1.5,-2800000,-2600000),c(-35,1,6800000,-1600000))

#end of code snippet from stack overflow 

states@data$id <- rownames(states@data)
states.df <- fortify(states, region = "id") %>% 
             join(states@data, by = "id") %>%
             merge(business_data, by.x = c("STUSPS"), by.y = c("State"))
file.remove(dir(getwd(), pattern = "cb_2015_us_state_20m", full.names = TRUE)) #Clean Up 
bcounts_wNames <- fortify(aggregate(cbind(long, lat) ~ Total + NAME, data = states.df, FUN = mean)) 

ggplot(states.df) + 
  geom_polygon(colour="grey40", aes(long, lat, group = group, fill = Total) ) +
  geom_text(data = bcounts_wNames, aes(long, lat, label = Total), size=3, colour = "firebrick1", fontface = "bold") + 
  theme_void() +
  scale_fill_gradientn(colors =  brewer.pal(9,"PuBu"), space = "Lab", guide = "legend") +
  ggtitle(paste0("\n\nCount of Companies in Data Set : ", raw_data_name," by US State (including US Territory of Puerto Rico) \n"))

ggsave("answer_to_question1.jpeg", height = 7, width = 10)

state_most_companies <- 3

third_most_companies <- as.data.frame(raw_data_complete_cases %>%
                                         select(Name, State) %>%
                                         group_by(State) %>%
                                         summarise(Total = length(Name)) %>%
                                         arrange(-Total)
                                        )[state_most_companies,]

business_data <- raw_data_complete_cases[(raw_data_complete_cases$State == third_most_companies$State),] %>%
                 select(Industry, Employees) %>%
                 group_by(Industry) %>%
                 mutate(no_of_companies = length(Industry)) %>%
                 mutate(is_outlier = ifelse(no_of_companies == 1 , 0, 
                                     ifelse(Employees > sd(Employees, na.rm = TRUE) * 3, 1, 0))) %>%
                 filter(is_outlier == 0) %>% 
                 mutate(avg_emp = mean(Employees), 
                        sem = ifelse(no_of_companies == 1 , 0, 
                                     sd(Employees, na.rm = TRUE)/sqrt(length(Employees))))  %>%
                 select(-Employees) %>%
                 distinct(avg_emp, sem) %>% 
                 arrange(-avg_emp)

business_data$Industry <- reorder(business_data$Industry, new.order = as.vector(unique(business_data$Industry)))

title <- paste0("Average Number of Employees by Industry for ", third_most_companies$State)

ggplot(business_data, aes(x = Industry, y = avg_emp)) + 
       geom_bar(stat="identity") + 
       geom_errorbar(aes(ymin= avg_emp - sem, ymax=avg_emp + sem), width = .5) +  
       theme_minimal() + 
       theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
       ylab(label = "Average Number of Employees \n") +
       xlab(label = "\n Industry Type \n") +
       ggtitle(bquote(atop(.(title), atop("Bar Chart with Error Bars using Standard Error of the Mean"),"")))

ggsave("answer_to_question2.jpeg", height = 8, width = 10 )

revenue_data <- raw_data_complete_cases %>%
                              select(Revenue, Employees, Industry) %>%
                              group_by(Industry) %>% 
                              mutate(Revenue_Per_Employee = (Revenue/Employees)) %>%
                              mutate(`Average Revenue Per Employee` = mean(Revenue_Per_Employee),
                                     `Median Revenue Per Employee` = median(Revenue_Per_Employee)) %>%
                              gather(type, value, `Average Revenue Per Employee`:`Median Revenue Per Employee` ) %>%
                              select(Industry, type, value) %>%
                              distinct(type, value) %>%
                              arrange(-value) 

revenue_data$Industry <- reorder(revenue_data$Industry, new.order = as.vector(unique(revenue_data$Industry)))

ggplot(revenue_data, aes(x = Industry, y = value, color = type)) + 
       geom_point(size = 3) + 
       theme_light() + 
       scale_color_discrete(name = "Employee Revenue Statistic") + 
       theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
       ylab(label = "Revenue\n") +
       xlab(label = "\n Industry Type") +
       scale_y_continuous(labels = dollar) + 
       ggtitle(paste0("Revenue Statistics by Employee by Industry Type for ", third_most_companies$State))

ggsave("answer_to_question3.jpeg", height = 8, width = 13 )
