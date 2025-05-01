library(ggplot2) # data visualization
library(patchwork) # combining different plots
library(dplyr)  # data wrangling
library(lubridate)  # working with dates
library(sf)   # extracting spacial coordinates 

load("whale_project_backup.RData")   # load saved workspace 

coords <- st_coordinates(whale_sst_combined)  # extract lat and lon 
whale_sst_combined$lon <- coords[, 1]  # Add lat and lon columns to sf object
whale_sst_combined$lat <- coords[, 2]

plot1 <- ggplot(whale_sst_combined, aes(x = lon, y = lat)) +
  geom_point(color = "steelblue", alpha = 0.6, size = 2) +
  labs(title = "Whale Sightings", x = "Longitude", y = "Latitude") +
  theme_minimal()       # Map View of Whale sightings 


plot2 <- ggplot(whale_sst_combined, aes(x = eventDate, y = sst_at_sighting)) +
  geom_point(color = "firebrick", alpha = 0.6) +
  geom_smooth(method = "loess", se = FALSE, color = "black") +
  labs(title = "SST at Whale Sightings Over Time", x = "Date", y = "SST (°C)") +
  theme_minimal()       # SST over time 



plot3 <- ggplot(whale_sst_combined, aes(x = sst_at_sighting)) +
  geom_histogram(fill = "darkorange", color = "white", bins = 30) +
  labs(title = "Histogram of SST at Sightings", x = "SST (°C)", y = "Count") +
  theme_minimal()     # Plot Histogram of SST and Sightings



plot4 <- ggplot(whale_sst_combined, aes(x = lat, y = sst_at_sighting)) +
  geom_point(color = "darkgreen", alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  labs(title = "SST vs Latitude", x = "Latitude", y = "SST (°C)") +
  theme_minimal()      # Plot of SST vs. Latitude



plot5 <- ggplot(whale_sst_combined, aes(x = lon, y = sst_at_sighting)) +
  geom_point(color = "purple", alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  labs(title = "SST vs Longitude", x = "Longitude", y = "SST (°C)") +
  theme_minimal()       # Plot of SST vs. Longitude 

combined_plot <- (plot1 | plot2) / (plot3 | plot4 | plot5)   # Combine plots into singular layout 

print(combined_plot)
ggsave("combined_plot.png", combined_plot, width = 12, height = 8, dpi = 300) 

whale_sst_combined$month <- month(whale_sst_combined$eventDate, label = TRUE)
ggplot(whale_sst_combined, aes(x = month, y = sst_at_sighting)) +
       geom_boxplot(fill = "skyblue") +
       labs(title = "SST at Sightings by Month", x = "Month", y = "SST (°C)") +
       theme_minimal()

lm_mod <- lm(sst_at_sighting ~ lon + lat, data = whale_sst_combined) #Predict SST using lat and long

lm_mod2 <- lm(sst_at_sighting ~ lon + lat + I(lon^2) + I(lat^2), data = whale_sst_combined)  #Predict SSt using lat and long with quadratic terms


anova(lm_mod, lm_mod2)  #compare two models 

summary(lm_mod2)  #summary of more useful model

cor.test(whale_sst_combined$sst_at_sighting, whale_sst_combined$lat) #Pearson correlation test between SST and lat
           
cor.test(whale_sst_combined$sst_at_sighting, whale_sst_combined$lon) #Pearson correlation test between SSta nd long