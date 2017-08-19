#### Libraries ###################
library("sf") # load the SHP file. Could all be done with sp pkg really
library("sp") # the elevatr pkg takes the sp::spatialPointsDataframe class to get elevations
library("elevatr") # Heavy lifter to retrieve elevations from points
library("ggplot2") # Plotting library
library("dplyr")   # data manipulation
# https://github.com/clauswilke/ggjoy
library("ggjoy")   # Heavy lifter of joyplot geom. Props to Claus Wilke
## For additional plot fonts, follow: https://stackoverflow.com/questions/34522732/changing-fonts-in-ggplot2
# library("extrafont")

#### Data ########################
SHP_loc  <- file.path(getwd(),"data", "SHP")
SHP_name <- "perp_line_points_100_1pcnt_GCSWGS84.shp"
transect_pnts <- st_read(file.path(SHP_loc,SHP_name))
# convert to SpatialPointsDataFrame for get_elev_point()
points_sp <- as(transect_pnts, "Spatial")
# projection: "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
prj_dd <- proj4string(points_sp)

#### Get Elevation Data #########
## You can skip this as it takes about an hour
## I included a csv of the results, but if you want to pull new data, go for it...
## Vignette for elevatr pkg: https://cran.r-project.org/web/packages/elevatr/vignettes/introduction_to_elevatr.html
# df_elev_epqs_100_1pcnt <- get_elev_point(points_sp, prj = prj_dd, src = "epqs")
# write.csv(df_elev_epqs_100_1pcnt, "elevation_points_100_1pcnt.csv")
CSV_loc  <- file.path(getwd(),"data")
CSV_name <- "elevation_points_100_1pcnt.csv"
df_elev_epqs_100_1pcnt <- read.csv(file.path(CSV_loc, CSV_name))

#### Data Prep ##################
elev_point_plot <- data.frame(df_elev_epqs_100_1pcnt) %>%
  select(mem_point1, new_tran_5, X, Y, elevation) %>%
  rename(profile_position = mem_point1, transect = new_tran_5) %>%
  arrange(transect, profile_position) %>%
  mutate(elevation = ifelse(transect == 100 & profile_position == 0.35, 0, elevation))

#### Plotting! ##################
# There are two nearly identicle plots (could have wrapped into a function...)
# First plot is at the aspect ratio I like for the image narrow and tall
# Second plot is at a 2:1 aspect ratio so when I tweet it, it doesn't get truncated
PNG_loc  <- file.path(getwd(),"images")
## Preferred aspect ratio
ggplot(elev_point_plot, aes(y = transect, x = profile_position, 
                            height = elevation, group = transect)) +
  geom_joy(stat = "identity", scale = 8.5, size = 0.375,
           color = "white", fill = "black") +
  theme_joy() +
  scale_y_reverse() +
  labs(title = "ECLIPSE 2017",
       caption = "PATH OF TOTALITY ELEVATION PROFILES") +
  theme(
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    panel.spacing = unit(0, "lines"),
    plot.background = element_rect(fill = 'black', colour = 'white'),
    axis.title=element_blank(),
    axis.text=element_blank(),
    axis.ticks=element_blank(),
    plot.title = element_text(size = rel(3.55),  family= "Arial",
                              color = "white",hjust = 0.5),
    plot.caption = element_text(size = rel(1.15), family="Arial",
                                color = "white",hjust = 0.5)
  )
ggsave(file.path(PNG_loc,"eclispe_preferred_aspect.png"), width = 5.5, height = 8)

## 2:1 aspect ratio
ggplot(elev_point_plot, aes(y = transect, x = profile_position, 
                            height = elevation, group = transect)) +
  geom_joy(stat = "identity", scale = 8.5, size = 0.375,
           color = "white", fill = "black") +
  theme_joy() +
  scale_y_reverse() +
  labs(title = "ECLIPSE 2017",
       caption = "PATH OF TOTALITY ELEVATION PROFILES") +
  theme(
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    panel.spacing = unit(0, "lines"),
    plot.background = element_rect(fill = 'black', colour = 'white'),
    axis.title=element_blank(),
    axis.text=element_blank(),
    axis.ticks=element_blank(),
    plot.title = element_text(size = rel(3.15),  family= "Arial", # for 2:1
                              color = "white",hjust = 0.5),
    plot.caption = element_text(size = rel(1.02), family="Arial", # for 2:1
                                color = "white",hjust = 0.5) ,
    plot.margin=unit(c(0.5,9.5,0.5,9.5), "cm") # for 2:1 aspect
  )
ggsave(file.path(PNG_loc,"eclispe_2_1_aspect_ratio.png"), width = 12, height = 6)


