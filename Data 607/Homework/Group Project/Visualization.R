library(RColorBrewer)

data<- read.csv("https://raw.githubusercontent.com/ChristopheHunt/MSDA---Coursework/master/Data%20607/Homework/Group%20Project/tbl_data_version1%20.csv")

ggplot(data, aes(source_name, skill_name, label = skill_name, 
                    size = weighted_rating_overall, fill = skill_type_name)) + 
        geom_point(pch = 21) + 
        scale_fill_manual(values =  brewer.pal(9, "Set1")) + 
        scale_size_continuous(range =c(1,20)) + 
        facet_grid(~skill_type_name) + 
        theme_light() +
        xlab("Source") + 
        ylab("Skill") + 
        theme(legend.position = "none" , axis.text.y = element_text(size=7)) +
        ggtitle("Weighted Rank of Skill by Skill Type and Source")

