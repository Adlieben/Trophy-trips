##############################
## 1. Load Necessary Libraries
##############################
library(ggplot2)
library(ggspatial)
library(sf)
library(dplyr)
library(rnaturalearth)
library(rnaturalearthdata)
# devtools::install_github("ropensci/rnaturalearthhires")
library(rnaturalearthhires)
library(ggrepel) # Better text labelling

####################################
## 2. Define the Full Winners Dataset
####################################
# Each entry includes:
# - 'season': the season label (e.g., "1888–89")
# - 'winner': the club that won in that season

winners <- data.frame(
  season = c(
    "1888–89","1889–90","1890–91","1891–92","1892–93","1893–94","1894–95","1895–96","1896–97",
    "1897–98","1898–99","1899–1900","1900–01","1901–02","1902–03","1903–04","1904–05","1905–06",
    "1906–07","1907–08","1908–09","1909–10","1910–11","1911–12","1912–13","1913–14","1914–15",
    # World War I (1915–16 to 1918–19) - no winners, so we skip
    "1919–20","1920–21","1921–22","1922–23","1923–24","1924–25","1925–26","1926–27","1927–28",
    "1928–29","1929–30","1930–31","1931–32","1932–33","1933–34","1934–35","1935–36","1936–37",
    "1937–38","1938–39",
    # World War II (1939–40 to 1945–46) - no winners, so we skip
    "1946–47","1947–48","1948–49","1949–50","1950–51","1951–52","1952–53","1953–54","1954–55",
    "1955–56","1956–57","1957–58","1958–59","1959–60","1960–61","1961–62","1962–63","1963–64",
    "1964–65","1965–66","1966–67","1967–68","1968–69","1969–70","1970–71","1971–72","1972–73",
    "1973–74","1974–75","1975–76","1976–77","1977–78","1978–79","1979–80","1980–81","1981–82",
    "1982–83","1983–84","1984–85","1985–86","1986–87","1987–88","1988–89","1989–90","1990–91",
    "1991–92",  # End of Football League First Division
    "1992–93","1993–94","1994–95","1995–96","1996–97","1997–98","1998–99","1999–00","2000–01",
    "2001–02","2002–03","2003–04","2004–05","2005–06","2006–07","2007–08","2008–09","2009–10",
    "2010–11","2011–12","2012–13","2013–14","2014–15","2015–16","2016–17","2017–18","2018–19",
    "2019–20","2020–21","2021–22","2022–23","2023–24"
  ),
  winner = c(
    # 1888–89 to 1889–90
    "Preston North End","Preston North End",
    # 1890–91 to 1891–92
    "Everton","Sunderland",
    # 1892–93 to 1893–94
    "Sunderland","Aston Villa",
    # 1894–95 to 1895–96
    "Sunderland","Aston Villa",
    # 1896–97 to 1897–98
    "Aston Villa","Sheffield United",
    # 1898–99 to 1899–1900
    "Aston Villa","Aston Villa",
    # 1900–01 to 1901–02
    "Liverpool","Sunderland",
    # 1902–03 to 1903–04
    "The Wednesday","The Wednesday",
    # 1904–05 to 1905–06
    "Newcastle United","Liverpool",
    # 1906–07 to 1907–08
    "Newcastle United","Manchester United",
    # 1908–09 to 1909–10
    "Newcastle United","Aston Villa",
    # 1910–11 to 1911–12
    "Manchester United","Blackburn Rovers",
    # 1912–13 to 1913–14
    "Sunderland","Blackburn Rovers",
    # 1914–15
    "Everton",
    # 1919–20 to 1920–21
    "West Bromwich Albion","Burnley",
    # 1921–22 to 1922–23
    "Liverpool","Liverpool",
    # 1923–24 to 1924–25
    "Huddersfield Town","Huddersfield Town",
    # 1925–26 to 1926–27
    "Huddersfield Town","Newcastle United",
    # 1927–28 to 1928–29
    "Everton","The Wednesday",
    # 1929–30 to 1930–31
    "Sheffield Wednesday","Arsenal",
    # 1931–32 to 1932–33
    "Everton","Arsenal",
    # 1933–34 to 1934–35
    "Arsenal","Arsenal",
    # 1935–36 to 1936–37
    "Sunderland","Manchester City",
    # 1937–38 to 1938–39
    "Arsenal","Everton",
    # 1946–47 to 1947–48
    "Liverpool","Arsenal",
    # 1948–49 to 1949–50
    "Portsmouth","Portsmouth",
    # 1950–51 to 1951–52
    "Tottenham Hotspur","Manchester United",
    # 1952–53 to 1953–54
    "Arsenal","Wolverhampton Wanderers",
    # 1954–55 to 1955–56
    "Chelsea","Manchester United",
    # 1956–57 to 1957–58
    "Manchester United","Wolverhampton Wanderers",
    # 1958–59 to 1959–60
    "Wolverhampton Wanderers","Burnley",
    # 1960–61 to 1961–62
    "Tottenham Hotspur","Ipswich Town",
    # 1962–63 to 1963–64
    "Everton","Liverpool",
    # 1964–65 to 1965–66
    "Manchester United","Liverpool",
    # 1966–67 to 1967–68
    "Manchester United","Manchester City",
    # 1968–69 to 1969–70
    "Leeds United","Everton",
    # 1970–71 to 1971–72
    "Arsenal","Derby County",
    # 1972–73 to 1973–74
    "Liverpool","Leeds United",
    # 1974–75 to 1975–76
    "Derby County","Liverpool",
    # 1976–77 to 1977–78
    "Liverpool","Nottingham Forest",
    # 1978–79 to 1979–80
    "Liverpool","Liverpool",
    # 1980–81 to 1981–82
    "Aston Villa","Liverpool",
    # 1982–83 to 1983–84
    "Liverpool","Liverpool",
    # 1984–85 to 1985–86
    "Everton","Liverpool",
    # 1986–87 to 1987–88
    "Everton","Liverpool",
    # 1988–89 to 1989–90
    "Arsenal","Liverpool",
    # 1990–91 to 1991–92
    "Arsenal","Leeds United",
    # 1992–93 to 1993–94 (Premier League starts)
    "Manchester United","Manchester United",
    # 1994–95 to 1995–96
    "Blackburn Rovers","Manchester United",
    # 1996–97 to 1997–98
    "Manchester United","Arsenal",
    # 1998–99 to 1999–00
    "Manchester United","Manchester United",
    # 2000–01 to 2001–02
    "Manchester United","Arsenal",
    # 2002–03 to 2003–04
    "Manchester United","Arsenal",
    # 2004–05 to 2005–06
    "Chelsea","Chelsea",
    # 2006–07 to 2007–08
    "Manchester United","Manchester United",
    # 2008–09 to 2009–10
    "Manchester United","Chelsea",
    # 2010–11 to 2011–12
    "Manchester United","Manchester City",
    # 2012–13 to 2013–14
    "Manchester United","Manchester City",
    # 2014–15 to 2015–16
    "Chelsea","Leicester City",
    # 2016–17 to 2017–18
    "Chelsea","Manchester City",
    # 2018–19 to 2019–20
    "Manchester City","Liverpool",
    # 2020–21 to 2021–22
    "Manchester City","Manchester City",
    # 2022–23 to 2023–24
    "Manchester City","Manchester City"
  ),
  stringsAsFactors = FALSE
)


############################################################
## 3. Map Each Club to Approximate Latitude and Longitude
############################################################
# Create a lookup table of major winners' home cities
city_coords <- data.frame(
  city = c(
    "Preston","Liverpool","Sunderland","Birmingham","Sheffield","Liverpool", 
    "Blackburn","Sheffield","Newcastle","Manchester","Manchester","London",
    "Huddersfield","London","London","Wolverhampton","Derby","Nottingham",
    "Burnley","West Bromwich","Portsmouth","Leeds","Ipswich","Leicester"
  ),
  lat = c(
    53.7632,  53.4108, 54.9142, 52.5090, 53.3946, 53.4108,
    53.7286, 53.38297, 54.9783, 53.4830, 53.4631, 51.5095,
    53.6543, 51.5080, 51.4816, 52.5848, 52.9219, 52.9500,
    53.7892, 52.5090, 50.7960, 53.8013, 52.0592, 52.6369
  ),
  lon = c(
    -2.7087, -2.9778, -1.3859, -1.8842, -1.4650, -2.9778,
    -2.4899, -1.4701, -1.6178, -2.2426, -2.2913, -0.1180,
    -1.7870, -0.1280, -0.1910, -2.1220, -1.4756, -1.1500,
    -2.2302, -1.8842, -1.0870, -1.5480, 1.1550, -1.1398
  ),
  stringsAsFactors = FALSE
)

# Remove duplicates so each city is labeled only once
city_coords <- city_coords %>%
  distinct(city, .keep_all = TRUE)

# Major cities (besides Manchester)
major_cities <- c("London", "Liverpool", "Leeds", "Birmingham", "Newcastle")

major_city_coords <- city_coords %>% 
  filter(city %in% major_cities)

# Manchester alone
manchester_coords <- city_coords %>%
  filter(city == "Manchester")

# Portsmouth & Ipswich in smaller font
small_label_coords <- city_coords %>%
  filter(city %in% c("Portsmouth", "Ipswich"))

# All other cities (points only, no labels)
others_coords <- city_coords %>%
  filter(
    !city %in% major_cities,
    city != "Manchester",
    !city %in% c("Portsmouth", "Ipswich")
  )

# This is the existing club -> lat/lon lookup
winner_coords <- data.frame(
  winner = c(
    "Preston North End","Everton","Sunderland","Aston Villa",
    "Sheffield United","Liverpool","Blackburn Rovers","The Wednesday","Newcastle United",
    "Manchester United","Manchester City","Tottenham Hotspur","Huddersfield Town","Arsenal",
    "Chelsea","Wolverhampton Wanderers","Derby County","Nottingham Forest","Burnley",
    "West Bromwich Albion","Portsmouth","Leeds United","Ipswich Town","Leicester City"
  ),
  lat = c(
    53.7632,  53.4308,  54.9142,  52.5090,
    53.3946,  53.4108,  53.7286,  53.38297, 54.9783,
    53.4631,  53.4830,  51.6043,  53.6543,  51.5549,
    51.4816,  52.5848,  52.9219,  52.9500,  53.7892,
    52.5090,  50.7960,  53.8013,  52.0592,  52.6369
  ),
  lon = c(
    -2.7087, -2.9608, -1.3859, -1.8842,
    -1.4650, -2.9778, -2.4899, -1.4701, -1.6178,
    -2.2913, -2.2426, -0.0657, -1.7870, -0.1080,
    -0.1910, -2.1220, -1.4756, -1.1500, -2.2302,
    -1.8842, -1.0870, -1.5480, 1.1550, -1.1398
  ),
  stringsAsFactors = FALSE
)

# Merge to get lat/lon per winner for each season
winners_coords <- left_join(winners, winner_coords, by = "winner")


##############################
## 4. Load the UK Map
##############################
uk_map <- ne_countries(
  scale       = "medium",
  country     = "United Kingdom",
  returnclass = "sf"
)

##############################
## 5. Final Plot
##############################
ggplot() +
  # (A) Fill entire UK
  geom_sf(
    data  = uk_map,
    fill  = "lightgrey",
    color = "black",
    size  = 0.3
  ) +
  
  # (B) Trophy path (slightly transparent)
  geom_path(
    data = winners_coords,
    aes(x = lon, y = lat, group = 1, color = as.numeric(sub("–.*","",season))),
    size  = 1.0,
    alpha = 0.4
  ) +
  
  # (C) All other cities (points only, no labels)
  geom_point(
    data = others_coords,
    aes(x = lon, y = lat),
    size  = 1.5,
    color = "gray30"
  ) +
  
  # (D) Major city points
  geom_point(
    data  = major_city_coords,
    aes(x = lon, y = lat),
    size  = 3.0,
    color = "black"
  ) +
  
  # (E) Major city labels
  geom_text_repel(
    data = major_city_coords,
    aes(x = lon, y = lat, label = city),
    size            = 3.5,
    color           = "black",
    box.padding     = 0.5,
    point.padding   = 0.5,
    segment.color   = "black",
    force           = 5,     # stronger repel
    max.overlaps    = Inf,
    # Example manual nudges (optional, adjust as needed)
    nudge_x         = c(-0.5,-0.5,-1,0.2,1.2),  
    nudge_y         = c(0.5,-0.5,0.5,-0.5,0.2)
  ) +
  
  # (F) Manchester alone with bigger repel or manual nudge
  geom_point(
    data  = manchester_coords,
    aes(x = lon, y = lat),
    size  = 3.0,
    color = "black"
  ) +
  geom_text_repel(
    data = manchester_coords,
    aes(x = lon, y = lat, label = city),
    size            = 3.5,
    color           = "black",
    box.padding     = 0.8,
    point.padding   = 0.8,
    segment.color   = "black",
    force           = 8,     # extra repel for Manchester
    max.overlaps    = Inf,
    # Example nudge
    nudge_x         = -1.5,
    nudge_y         = -1
  ) +
  
  # (G) Portsmouth & Ipswich points (smaller than major, bigger than others if you want)
  geom_point(
    data  = small_label_coords,
    aes(x = lon, y = lat),
    size  = 1.5,
    color = "black"
  ) +
  
  # (H) Portsmouth & Ipswich labels (smaller font, manual nudges)
  geom_text_repel(
    data = small_label_coords,
    aes(x = lon, y = lat, label = city),
    size            = 2.5,
    color           = "black",
    segment.color   = "black",
    max.overlaps    = Inf,
    # Example manual nudges: [Portsmouth, Ipswich]
    nudge_x = c(-0.3, 0.2),
    nudge_y = c(-0.2, 0.2)
  ) +
  
  # (I) Trophy path color scale
  scale_color_viridis_c(
    name = "Year",
    option = "A",
    guide  = guide_colorbar(barwidth = 20, barheight = 0.5)
  ) +
  
  # (J) Minimal theme
  theme_minimal() +
  labs(title = "First Division Trophies Since 1889") +
  theme(
    legend.position  = "bottom",
    axis.title       = element_blank(),
    axis.text        = element_blank(),
    axis.ticks       = element_blank(),
    panel.grid       = element_blank(),
    plot.title       = element_text(color = "black", size = 16, face = "bold", hjust = 0.5)
  ) +
  
  # (K) Zoom to ~England
  coord_sf(xlim = c(-5, 1.5), ylim = c(50, 55))
