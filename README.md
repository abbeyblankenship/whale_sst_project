- Objective of project 
  - To analyze spatial and temporal trends of Humpback whales (Megaptera novaeanglia)
    along the east coast of the US with focus on climate change, which was 
    measured by sea surface temperate (SST). Historical whale sighting data was used 
    and then matched to satelellite based SST rasters. 
- Structure of Code-base 
  - libraries used include : tidyverse (general data plotting), sf(spatial data),
  raster (SST raster stacks), fuzzyjoin (matching whale sighting dates to nearest 
  SST raster month), lubridate (dates and timestamps), ggplot2 (plotting). 
  Whale_project_backup.RData.R is the project workspace. Maxent was attempted,
  but not successful due to memory issues. 
- Structure of Data 
  - Whale_data (raw whale sightings including 894 obs. with 50 variables), 
  sst_stack (raster stack of monthly SST's), whale_sst_combined (merged dataset), 
  sst_means (cell means across SST rasters), occ_clean (not used in plots). Each
  sighting contains the date, geometry (lat and lon), and SST value from closest 
  monthly raster. 
- Recreating Results 
  -Generate figures: Run the entire master_script.R file. All plots were generated using the 
  merged dataset. 
  - To process the data, run Data_cleaning.R
- Acknowledgements 
  - Whale sighting data - OBIS-SEAMAP 
  - Sea Surface Data - NOAA OISST datasets 