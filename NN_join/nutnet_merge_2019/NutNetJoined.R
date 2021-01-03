
# README ------------------------------------------------------------------


# libraries ---------------------------------------------------------------

library(readxl)
library(tidyverse)


# import raw data ---------------------------------------------------------

nnCombined <- read_csv('comb-by-plot-clim-soil-diversity-04-Dec-2017.csv')
nnRoots <- read_csv('rootsSept2017.csv')
nnDensity <- read_excel('Nutnet_soil bulk density.xlsx',
                        sheet = 'AA_final_soil bulk density')

nnCombined
[1] "site_code"                "block"                    "plot"                     "year"                     "site_name"                "continent"               
[7] "country"                  "region"                   "managed"                  "burned"                   "grazed"                   "anthropogenic"           
[13] "habitat"                  "elevation"                "latitude"                 "longitude"                "RAIN_PET"                 "MAT_v2"                  
[19] "MAT_RANGE_v2"             "ISO_v2"                   "TEMP_VAR_v2"              "MAX_TEMP_v2"              "MIN_TEMP_v2"              "ANN_TEMP_RANGE_v2"       
[25] "TEMP_WET_Q_v2"            "TEMP_DRY_Q_v2"            "TEMP_WARM_Q_v2"           "TEMP_COLD_Q_v2"           "MAP_v2"                   "MAP_WET_M_v2"            
[31] "MAP_DRY_M_v2"             "MAP_VAR_v2"               "MAP_WET_Q_v2"             "MAP_DRY_Q_v2"             "MAP_WARM_Q_v2"            "MAP_COLD_Q_v2"           
[37] "AI"                       "PET"                      "N_Dep"                    "experiment_type"          "N"                        "P"                       
[43] "K"                        "Exclose"                  "trt"                      "first_nutrient_year"      "first_fenced_year"        "year_trt"                
[49] "sum_INT_cover"            "sum_NAT_cover"            "sum_UNK_cover"            "total_cover"              "INT_rich"                 "NAT_rich"                
[55] "UNK_rich"                 "rich"                     "site_year_rich"           "site_richness"            "site_native_richness"     "site_introduced_richness"
[61] "plot_beta"                "dead_mass"                "live_mass"                "total_mass"               "unsorted_mass"            "proportion_par"          
[67] "Ambient_PAR"              "Ground_PAR"               "pct_C"                    "pct_N"                    "ppm_P"                    "ppm_K"                   
[73] "ppm_Ca"                   "ppm_Mg"                   "ppm_S"                    "ppm_Na"                   "ppm_Zn"                   "ppm_Mn"                  
[79] "ppm_Fe"                   "ppm_Cu"                   "ppm_B"                    "pH"                       "PercentSand"              "PercentSilt"             
[85] "PercentClay"              "Classification"           "rich.vegan"               "shan"                     "simpson"                  "even"                   

nnDensity
[1] "site_code"            "block"                "plot"                 "Treatment"            "cover_year"           "Sample_ID"            "totalcorearea"       
[8] "Totalsoilsample"      "Weightofrootsample"   "soilmoisture"         "totalsoil_minusbag_g" "drysoil_g_calc"       "corevol_cm3_calc"     "bulk_density"        

nnRoots 
[1] "site_code"     "trt"           "plot"          "block"         "cover_year"    "Sample_ID"     "N"             "P"             "K"             "Exclose"       "Rootsgperm2" [12] "pH_rootsample"

nnDensity %>% distinct(site_code) # 29 sites
nnCombined %>% distinct(site_code) # 97 sites
nnRoots %>% distinct(site_code) # 29 sites

nnDensity %>% distinct(site_code, cover_year) # 29 sites
nnRoots %>% distinct(site_code, cover_year) # 29 sites
nnCombined %>%
  distinct(site_code, year) %>%
  filter(site_code %in% c(nnDensity %>% distinct(site_code) %>% pull(site_code)))

# join 2011-2012 density and roots to combined data across all years for which
# sites, blocks, and plots match; remove redundant columns across frames
nnCombinedDensityRoots <- nnCombined %>% 
  left_join(nnDensity %>% select(-Treatment, -cover_year, -Sample_ID), by = c("site_code", "block", "plot")) %>% 
  left_join(nnRoots %>% select(-trt, -Exclose, -N, -P, -K), by = c("site_code", "block", "plot"))

write_csv(nnCombinedDensityRoots, "~/Desktop/lter_homogenized/nutnet_merge_2019/nnCombinedDensityRoots.csv")

# upload to Google Drive manually

# QC script executes but fails to generate plots