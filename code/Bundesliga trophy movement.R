##############################
## 1. Load Necessary Libraries
##############################
library(ggplot2)
library(sf)
library(dplyr)
library(rnaturalearth)
library(rnaturalearthdata)
library(rnaturalearthhires)
library(ggrepel)

####################################
## 2. Define the Full Winners Dataset (112 rows)
####################################

german_winners <- data.frame(
  season = c(
    # =============== 1903–1914 (excluding 1904) ===============
    1903, 1905, 1906, 1907, 1908, 1909, 1910, 1911, 1912, 1913, 1914,
    
    # =============== Skipping 1915–1919 (WWI) =================
    
    # =============== 1920–1932 (excluding 1922) ===============
    1920, 1921, 1923, 1924, 1925, 1926, 1927, 1928, 1929, 1930, 1931, 1932,
    
    # =============== 1933–1944 ===============
    1933, 1934, 1935, 1936, 1937, 1938, 1939, 1940, 1941, 1942, 1943, 1944,
    
    # =============== Skipping 1945, 1946–1947 ===============
    
    # =============== 1948–1963 ===============
    1948, 1949, 1950, 1951, 1952, 1953, 1954, 1955, 1956, 1957, 1958, 1959,
    1960, 1961, 1962, 1963,
    
    # =============== 1964–2024 (Bundesliga era) ===============
    # 1964 through 2024 = 61 seasons
    1964:2024
  ),
  winner = c(
    # 1903–1914 (11 entries)
    "VfB Leipzig","Union 92 Berlin","VfB Leipzig","Freiburger FC","Viktoria Berlin",
    "Phönix Karlsruhe","Karlsruher FV","Viktoria Berlin","Holstein Kiel","VfB Leipzig","SpVgg Fürth",
    
    # 1920–1932 (12 entries, skipping 1922)
    "1. FC Nürnberg","1. FC Nürnberg","Hamburger SV","1. FC Nürnberg","1. FC Nürnberg","SpVgg Fürth",
    "1. FC Nürnberg","Hamburger SV","SpVgg Fürth","Hertha BSC","Hertha BSC","Bayern Munich",
    
    # 1933–1944 (12 entries)
    "Fortuna Düsseldorf","Schalke 04","Schalke 04","1. FC Nürnberg","Schalke 04","Hannover 96",
    "Schalke 04","Schalke 04","Schalke 04","Schalke 04","Dresdner SC","Dresdner SC",
    
    # 1948–1963 (16 entries)
    "1. FC Nürnberg","VfR Mannheim","VfB Stuttgart","1. FC Kaiserslautern","VfB Stuttgart",
    "1. FC Kaiserslautern","Hannover 96","Rot-Weiss Essen","Borussia Dortmund","Borussia Dortmund",
    "Schalke 04","Eintracht Frankfurt","Hamburger SV","1. FC Nürnberg","1. FC Köln","Borussia Dortmund",
    
    # 1964–2024 (61 entries) => must match year-for-year
    # We'll assign them exactly in the same chronological order you gave
    # 1963–64 actually ended in 1964 (1)
    "1. FC Köln",
    # 1964–65 (2)
    "Werder Bremen",
    # 1965–66 (3)
    "TSV 1860 Munich",
    # 1966–67 (4)
    "Eintracht Braunschweig",
    # 1967–68 (5)
    "1. FC Nürnberg",
    # 1968–69 (6)
    "Bayern Munich",
    # 1969–70 (7)
    "Borussia Mönchengladbach",
    # 1970–71 (8)
    "Borussia Mönchengladbach",
    # 1971–72 (9)
    "Bayern Munich",
    # 1972–73 (10)
    "Bayern Munich",
    # 1973–74 (11)
    "Bayern Munich",
    # 1974–75 (12)
    "Borussia Mönchengladbach",
    # 1975–76 (13)
    "Borussia Mönchengladbach",
    # 1976–77 (14)
    "Borussia Mönchengladbach",
    # 1977–78 (15)
    "1. FC Köln",
    # 1978–79 (16)
    "Hamburger SV",
    # 1979–80 (17)
    "Bayern Munich",
    # 1980–81 (18)
    "Bayern Munich",
    # 1981–82 (19)
    "Hamburger SV",
    # 1982–83 (20)
    "Hamburger SV",
    # 1983–84 (21)
    "VfB Stuttgart",
    # 1984–85 (22)
    "Bayern Munich",
    # 1985–86 (23)
    "Bayern Munich",
    # 1986–87 (24)
    "Bayern Munich",
    # 1987–88 (25)
    "Werder Bremen",
    # 1988–89 (26)
    "Bayern Munich",
    # 1989–90 (27)
    "Bayern Munich",
    # 1990–91 (28)
    "1. FC Kaiserslautern",
    # 1991–92 (29)
    "VfB Stuttgart",
    # 1992–93 (30)
    "Werder Bremen",
    # 1993–94 (31)
    "Bayern Munich",
    # 1994–95 (32)
    "Borussia Dortmund",
    # 1995–96 (33)
    "Borussia Dortmund",
    # 1996–97 (34)
    "Bayern Munich",
    # 1997–98 (35)
    "1. FC Kaiserslautern",
    # 1998–99 (36)
    "Bayern Munich",
    # 1999–2000 (37)
    "Bayern Munich",
    # 2000–01 (38)
    "Bayern Munich",
    # 2001–02 (39)
    "Borussia Dortmund",
    # 2002–03 (40)
    "Bayern Munich",
    # 2003–04 (41)
    "Werder Bremen",
    # 2004–05 (42)
    "Bayern Munich",
    # 2005–06 (43)
    "Bayern Munich",
    # 2006–07 (44)
    "VfB Stuttgart",
    # 2007–08 (45)
    "Bayern Munich",
    # 2008–09 (46)
    "VfL Wolfsburg",
    # 2009–10 (47)
    "Bayern Munich",
    # 2010–11 (48)
    "Borussia Dortmund",
    # 2011–12 (49)
    "Borussia Dortmund",
    # 2012–13 (50)
    "Bayern Munich",
    # 2013–14 (51)
    "Bayern Munich",
    # 2014–15 (52)
    "Bayern Munich",
    # 2015–16 (53)
    "Bayern Munich",
    # 2016–17 (54)
    "Bayern Munich",
    # 2017–18 (55)
    "Bayern Munich",
    # 2018–19 (56)
    "Bayern Munich",
    # 2019–20 (57)
    "Bayern Munich",
    # 2020–21 (58)
    "Bayern Munich",
    # 2021–22 (59)
    "Bayern Munich",
    # 2022–23 (60)
    "Bayern Munich",
    # 2023–24 (61)
    "Bayer Leverkusen"),
  stringsAsFactors = FALSE
)

# Confirm row count = 112
nrow(german_winners)

############################################################
## 3. Map Each Club to Approximate Latitude and Longitude
############################################################

# (A) Create a lookup table of German cities
############################################################
## 3A. Create a Master city_coords for German Cities
############################################################
city_coords <- data.frame(
  city = c(
    # Big hubs
    "Berlin","Munich","Hamburg","Cologne","Frankfurt","Leipzig","Dortmund","Bremen",
    "Stuttgart","Nuremberg","Düsseldorf","Hanover","Karlsruhe","Freiburg","Kiel",
    "Essen","Mainz","Aachen","Leverkusen",
    
    # Additional for champions
    "Fürth","Dresden","Mannheim","Kaiserslautern","Braunschweig"
  ),
  lat = c(
    52.5200, 48.1371, 53.5511, 50.9375, 50.1109, 51.3397, 51.5136, 53.0793,
    48.7758, 49.4521, 51.2277, 52.3705, 49.0069, 47.9990, 54.3213,
    51.4556, 49.9929, 50.7753, 51.0323, 
    
    # extra
    49.4774, 51.0504, 49.4875, 49.4433, 52.2647
  ),
  lon = c(
    13.4050, 11.5754, 9.9937, 6.9603, 8.6821, 12.3731, 7.4653, 8.8017,
    9.1829, 11.0767, 6.7735, 9.7332, 8.4037, 7.8494, 10.1349,
    7.0116, 8.2473, 6.0839, 7.0032,
    
    # extra
    10.9887, 13.7373, 8.4660, 7.7689, 10.5267
  ),
  stringsAsFactors = FALSE
)

# Remove duplicates if any
city_coords <- city_coords %>% distinct(city, .keep_all=TRUE)

# (B) Define major cities to label in larger text (adjust as you see fit)
# Major cities to label
major_cities <- c("Berlin","Munich","Hamburg","Cologne","Frankfurt","Leipzig","Dortmund","Bremen")

major_city_coords <- city_coords %>%
  filter(city %in% major_cities)

others_coords <- city_coords %>%
  filter(! city %in% major_cities)

# (D) Approximate mapping of clubs to lat/lon of their home city
# Each champion club => city + approximate lat/lon
club_coords <- data.frame(
  winner = c(
    # Each champion club
    "VfB Leipzig","Union 92 Berlin","Freiburger FC","Viktoria Berlin",
    "Phönix Karlsruhe","Karlsruher FV","Holstein Kiel","SpVgg Fürth",
    "1. FC Nürnberg","Hamburger SV","Hertha BSC","Bayern Munich","Fortuna Düsseldorf",
    "Schalke 04","Hannover 96","Dresdner SC","VfR Mannheim","VfB Stuttgart",
    "1. FC Kaiserslautern","Rot-Weiss Essen","Borussia Dortmund",
    "Eintracht Frankfurt","TSV 1860 Munich","Werder Bremen","Borussia Mönchengladbach",
    "VfL Wolfsburg","1. FC Köln","Eintracht Braunschweig","Mannheim", 
    "Bayer Leverkusen"
  ),
  city = c(
    # The city each club calls home
    "Leipzig","Berlin","Freiburg","Berlin","Karlsruhe","Karlsruhe","Kiel","Fürth",
    "Nuremberg","Hamburg","Berlin","Munich","Düsseldorf","Gelsenkirchen","Hanover",
    "Dresden","Mannheim","Stuttgart","Kaiserslautern","Essen","Dortmund","Frankfurt",
    "Munich","Bremen","Mönchengladbach","Wolfsburg","Cologne","Braunschweig","Mannheim",
    "Leverkusen"
  ),
  lat = c(
    51.3397, 52.5200, 47.9990, 52.5200, 49.0069, 49.0069, 54.3213, 49.4774,
    49.4521, 53.5511, 52.5200, 48.1371, 51.2277, 51.5177, 52.3705,
    51.0504, 49.4875, 48.7758, 49.4447, 51.4556, 51.5136, 50.1109,
    48.1371, 53.0793, 51.1800, 52.4227, 50.9375, 52.2647, 49.4875,
    51.0323
  ),
  lon = c(
    12.3731, 13.4050, 7.8494, 13.4050, 8.4037, 8.4037, 10.1349, 10.9887,
    11.0767, 9.9937, 13.4050, 11.5754, 6.7735, 7.1007, 9.7332,
    13.7373, 8.4660, 9.1829, 7.7689, 7.0116, 7.4653, 8.6821,
    11.5754, 8.8017, 6.4333, 10.7925, 6.9603, 10.5267, 8.4660,
    7.0032
  ),
  stringsAsFactors = FALSE
)

# Merge into german_winners
winner_coords <- german_winners %>%
  left_join(club_coords, by = "winner")

# Check if any lat/lon are missing
missing_coords <- winner_coords %>% filter(is.na(lat))
if(nrow(missing_coords) > 0) {
  cat("Missing lat/lon for these clubs:\n")
  print(unique(missing_coords$winner))
  stop("Add them to club_coords!")
}

# We'll define major_cities explicitly:
major_cities <- c("Berlin","Munich","Hamburg","Cologne","Frankfurt","Leipzig","Dortmund","Bremen")

# major_winners => clubs whose 'city' is in major_cities
major_winners <- winner_coords %>% 
  filter(city %in% major_cities)

# other_winners => champions in other cities
other_winners <- winner_coords %>%
  filter(!city %in% major_cities)

major_city_labels <- major_winners %>%
  distinct(city, lat, lon)  # keep one row per city

freiburg_label <- other_winners %>%
  filter(city == 'Freiburg')

##############################
## 4. Load Germany Map
##############################
germany_map <- rnaturalearth::ne_countries(
  scale       = "medium",
  country     = "Germany",
  returnclass = "sf"
)

##############################
## 5) Final Plot
##############################
ggplot() +
  # 1) Germany polygon
  geom_sf(data=germany_map, fill="lightgrey", color="black", size=0.4) +
  
  # 2) Trophy path
  geom_path(
    data=winner_coords,
    aes(x=lon, y=lat, group=1, color=as.numeric(season)),
    size=1, alpha=0.4
  ) +
  
  # 3) Small points for "other" winners
  geom_point(
    data=other_winners,
    aes(x=lon, y=lat),
    size=1.5,
    color="gray40"
  ) +
  
  # 4) Big points for major city winners
  geom_point(
    data=major_winners,
    aes(x=lon, y=lat),
    size=3.0,
    color="black"
  ) +
  
  # 5) Label each major city only once
  geom_text_repel(
    data = major_city_labels,        # distinct cities only
    aes(x=lon, y=lat, label=city),
    size=3.5,
    color="black",
    box.padding=0.5,
    point.padding=0.5,
    segment.color="black",
    max.overlaps=Inf,
    nudge_x = c(2, 0.5, -0.4, 0.5, -0.5, -2.5, -1, -0.5),
    nudge_y = c(0, 1, 1, -1, 1, -0.5, -0.8, 1)
  ) +
  
  # Freiburg (because it's an outlier)
  geom_text_repel(
    data = freiburg_label,
    aes(x=lon, y=lat, label=city),
    size=2.5,
    color="black",
    box.padding=0.5,
    point.padding=0.5,
    segment.color="black",
    max.overlaps=Inf,
    nudge_x = -1,
    nudge_y = -0.5
  ) +
  
  # 6) Color scale for season
  scale_color_viridis_c(
    name="Year",
    option="A",
    guide=guide_colorbar(barwidth=20, barheight=0.5)
  ) +
  
  theme_minimal() +
  labs(title="First Division Trophies Since 1903") +
  theme(
    legend.position="bottom",
    axis.title=element_blank(),
    axis.text=element_blank(),
    axis.ticks=element_blank(),
    panel.grid=element_blank(),
    plot.title=element_text(color="black", size=16, face="bold", hjust=0.5)
  ) +
  
  coord_sf(xlim=c(5,15.5), ylim=c(47,55.5))
