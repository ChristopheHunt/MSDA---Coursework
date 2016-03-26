library(RColorBrewer)
library(ggplot2)
library(RMySQL)

proj_user <- "project3"
proj_pwd  <- "CUNYRBridge4"
proj_db   <- "skill"
proj_host <- "db4free.net"

skilldb = dbConnect(MySQL(), user=proj_user, password=proj_pwd, dbname=proj_db, host=proj_host)
data <- dbGetQuery(skilldb, "select * from tbl_data")

ggplot(data[(data$source_id != 2),], aes(source_name, skill_name, label = skill_name, 
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

