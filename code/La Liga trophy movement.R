##############################
## 1) Libraries
##############################
library(ggplot2)
library(sf)
library(tidyverse)
library(rnaturalearth)
library(rnaturalearthdata)
library(rnaturalearthhires)
library(ggrepel)

##########################################
## Spain Winners (93 rows, enumerated)
##########################################
spain_winners <- data.frame(
  season = c(
    # 1929 (1)
    "1929",
    # 1929–30 (2)
    "1930",
    # 1930–31 (3)
    "1931",
    # 1931–32 (4)
    "1932",
    # 1932–33 (5)
    "1933",
    # 1933–34 (6)
    "1934",
    # 1934–35 (7)
    "1935",
    # 1935–36 (8)
    "1936",
    # Skipping 1936–37, 1937–38, 1938–39
    # 1939–40 (9)
    "1940",
    # 1940–41 (10)
    "1941",
    # 1941–42 (11)
    "1942",
    # 1942–43 (12)
    "1943",
    # 1943–44 (13)
    "1944",
    # 1944–45 (14)
    "1945",
    # 1945–46 (15)
    "1946",
    # 1946–47 (16)
    "1947",
    # 1947–48 (17)
    "1948",
    # 1948–49 (18)
    "1949",
    # 1949–50 (19)
    "1950",
    # 1950–51 (20)
    "1951",
    # 1951–52 (21)
    "1952",
    # 1952–53 (22)
    "1953",
    # 1953–54 (23)
    "1954",
    # 1954–55 (24)
    "1955",
    # 1955–56 (25)
    "1956",
    # 1956–57 (26)
    "1957",
    # 1957–58 (27)
    "1958",
    # 1958–59 (28)
    "1959",
    # 1959–60 (29)
    "1960",
    # 1960–61 (30)
    "1961",
    # 1961–62 (31)
    "1962",
    # 1962–63 (32)
    "1963",
    # 1963–64 (33)
    "1964",
    # 1964–65 (34)
    "1965",
    # 1965–66 (35)
    "1966",
    # 1966–67 (36)
    "1967",
    # 1967–68 (37)
    "1968",
    # 1968–69 (38)
    "1969",
    # 1969–70 (39)
    "1970",
    # 1970–71 (40)
    "1971",
    # 1971–72 (41)
    "1972",
    # 1972–73 (42)
    "1973",
    # 1973–74 (43)
    "1974",
    # 1974–75 (44)
    "1975",
    # 1975–76 (45)
    "1976",
    # 1976–77 (46)
    "1977",
    # 1977–78 (47)
    "1978",
    # 1978–79 (48)
    "1979",
    # 1979–80 (49)
    "1980",
    # 1980–81 (50)
    "1981",
    # 1981–82 (51)
    "1982",
    # 1982–83 (52)
    "1983",
    # 1983–84 (53)
    "1984",
    # 1984–85 (54)
    "1985",
    # 1985–86 (55)
    "1986",
    # 1986–87 (56)
    "1987",
    # 1987–88 (57)
    "1988",
    # 1988–89 (58)
    "1989",
    # 1989–90 (59)
    "1990",
    # 1990–91 (60)
    "1991",
    # 1991–92 (61)
    "1992",
    # 1992–93 (62)
    "1993",
    # 1993–94 (63)
    "1994",
    # 1994–95 (64)
    "1995",
    # 1995–96 (65)
    "1996",
    # 1996–97 (66)
    "1997",
    # 1997–98 (67)
    "1998",
    # 1998–99 (68)
    "1999",
    # 1999–2000 (69)
    "2000",
    # 2000–01 (70)
    "2001",
    # 2001–02 (71)
    "2002",
    # 2002–03 (72)
    "2003",
    # 2003–04 (73)
    "2004",
    # 2004–05 (74)
    "2005",
    # 2005–06 (75)
    "2006",
    # 2006–07 (76)
    "2007",
    # 2007–08 (77)
    "2008",
    # 2008–09 (78)
    "2009",
    # 2009–10 (79)
    "2010",
    # 2010–11 (80)
    "2011",
    # 2011–12 (81)
    "2012",
    # 2012–13 (82)
    "2013",
    # 2013–14 (83)
    "2014",
    # 2014–15 (84)
    "2015",
    # 2015–16 (85)
    "2016",
    # 2016–17 (86)
    "2017",
    # 2017–18 (87)
    "2018",
    # 2018–19 (88)
    "2019",
    # 2019–20 (89)
    "2020",
    # 2020–21 (90)
    "2021",
    # 2021–22 (91)
    "2022",
    # 2022–23 (92)
    "2023",
    # 2023–24 (93)
    "2024"
  ),
  winner = c(
    # 1929 (1)
    "Barcelona",
    # 1929–30 (2)
    "Athletic Bilbao",
    # 1930–31 (3)
    "Athletic Bilbao",
    # 1931–32 (4)
    "Madrid FC",
    # 1932–33 (5)
    "Madrid FC",
    # 1933–34 (6)
    "Athletic Bilbao",
    # 1934–35 (7)
    "Real Betis",
    # 1935–36 (8)
    "Athletic Bilbao",
    
    # Skipping 1936–37, 1937–38, 1938–39
    
    # 1939–40 (9)
    "Atlético Aviación",
    # 1940–41 (10)
    "Atlético Aviación",
    # 1941–42 (11)
    "Valencia",
    # 1942–43 (12)
    "Athletic Bilbao",
    # 1943–44 (13)
    "Valencia",
    # 1944–45 (14)
    "Barcelona",
    # 1945–46 (15)
    "Sevilla",
    # 1946–47 (16)
    "Valencia",
    # 1947–48 (17)
    "Barcelona",
    # 1948–49 (18)
    "Barcelona",
    # 1949–50 (19)
    "Atlético Madrid",
    # 1950–51 (20)
    "Atlético Madrid",
    # 1951–52 (21)
    "Barcelona",
    # 1952–53 (22)
    "Barcelona",
    # 1953–54 (23)
    "Real Madrid",
    # 1954–55 (24)
    "Real Madrid",
    # 1955–56 (25)
    "Athletic Bilbao",
    # 1956–57 (26)
    "Real Madrid",
    # 1957–58 (27)
    "Real Madrid",
    # 1958–59 (28)
    "Barcelona",
    # 1959–60 (29)
    "Barcelona",
    # 1960–61 (30)
    "Real Madrid",
    # 1961–62 (31)
    "Real Madrid",
    # 1962–63 (32)
    "Real Madrid",
    # 1963–64 (33)
    "Real Madrid",
    # 1964–65 (34)
    "Real Madrid",
    # 1965–66 (35)
    "Atlético Madrid",
    # 1966–67 (36)
    "Real Madrid",
    # 1967–68 (37)
    "Real Madrid",
    # 1968–69 (38)
    "Real Madrid",
    # 1969–70 (39)
    "Atlético Madrid",
    # 1970–71 (40)
    "Valencia",
    # 1971–72 (41)
    "Real Madrid",
    # 1972–73 (42)
    "Atlético Madrid",
    # 1973–74 (43)
    "Barcelona",
    # 1974–75 (44)
    "Real Madrid",
    # 1975–76 (45)
    "Real Madrid",
    # 1976–77 (46)
    "Atlético Madrid",
    # 1977–78 (47)
    "Real Madrid",
    # 1978–79 (48)
    "Real Madrid",
    # 1979–80 (49)
    "Real Madrid",
    # 1980–81 (50)
    "Real Sociedad",
    # 1981–82 (51)
    "Real Sociedad",
    # 1982–83 (52)
    "Athletic Bilbao",
    # 1983–84 (53)
    "Athletic Bilbao",
    # 1984–85 (54)
    "Barcelona",
    # 1985–86 (55)
    "Real Madrid",
    # 1986–87 (56)
    "Real Madrid",
    # 1987–88 (57)
    "Real Madrid",
    # 1988–89 (58)
    "Real Madrid",
    # 1989–90 (59)
    "Real Madrid",
    # 1990–91 (60)
    "Barcelona",
    # 1991–92 (61)
    "Barcelona",
    # 1992–93 (62)
    "Barcelona",
    # 1993–94 (63)
    "Barcelona",
    # 1994–95 (64)
    "Real Madrid",
    # 1995–96 (65)
    "Atlético Madrid",
    # 1996–97 (66)
    "Real Madrid",
    # 1997–98 (67)
    "Barcelona",
    # 1998–99 (68)
    "Barcelona",
    # 1999–2000 (69)
    "Deportivo La Coruña",
    # 2000–01 (70)
    "Real Madrid",
    # 2001–02 (71)
    "Valencia",
    # 2002–03 (72)
    "Real Madrid",
    # 2003–04 (73)
    "Valencia",
    # 2004–05 (74)
    "Barcelona",
    # 2005–06 (75)
    "Barcelona",
    # 2006–07 (76)
    "Real Madrid",
    # 2007–08 (77)
    "Real Madrid",
    # 2008–09 (78)
    "Barcelona",
    # 2009–10 (79)
    "Barcelona",
    # 2010–11 (80)
    "Barcelona",
    # 2011–12 (81)
    "Real Madrid",
    # 2012–13 (82)
    "Barcelona",
    # 2013–14 (83)
    "Atlético Madrid",
    # 2014–15 (84)
    "Barcelona",
    # 2015–16 (85)
    "Barcelona",
    # 2016–17 (86)
    "Real Madrid",
    # 2017–18 (87)
    "Barcelona",
    # 2018–19 (88)
    "Barcelona",
    # 2019–20 (89)
    "Real Madrid",
    # 2020–21 (90)
    "Atlético Madrid",
    # 2021–22 (91)
    "Real Madrid",
    # 2022–23 (92)
    "Barcelona",
    # 2023–24 (93)
    "Real Madrid"
  ),
  stringsAsFactors = FALSE
)

# Check row count => Should be 93
nrow(spain_winners)   # 93
length(spain_winners$winner)  # 93

##############################
## 3) spain_club_coords
##############################
# Minimal example; expand as needed for all champions.

spain_club_coords <- data.frame(
  winner = c(
    "Barcelona","Athletic Bilbao","Madrid FC","Real Betis","Atlético Aviación","Atlético Madrid",
    "Valencia","Sevilla","Real Madrid","Real Sociedad","Deportivo La Coruña"
    # etc. for every champion
  ),
  city = c(
    "Barcelona","Bilbao","Madrid","Seville","Madrid","Madrid",
    "Valencia","Seville","Madrid","San Sebastián","A Coruña"
  ),
  lat = c(
    41.3874, 43.2630, 40.4168, 37.3891, 40.4168, 40.4168,
    39.4699, 37.3891, 40.4168, 43.3214, 43.3709
  ),
  lon = c(
    2.1686, -2.9350, -3.7038, -5.9845, -3.7038, -3.7038,
    -0.3763, -5.9845, -3.7038, -1.9855, -8.3959
  ),
  stringsAsFactors = FALSE
)

##############################
## 4A) Merge spain_winners with spain_club_coords
##############################
winners_coords <- spain_winners %>%
  left_join(spain_club_coords, by="winner")

missing_coords <- winners_coords %>% filter(is.na(lat))
if(nrow(missing_coords) > 0) {
  stop("Missing lat/lon for: ", paste(unique(missing_coords$winner), collapse=", "))
}

##############################
## 4B) Major vs. Other
##############################
major_cities <- c("Madrid","Barcelona","Valencia","Seville","Bilbao") 
# add more if you'd like: "San Sebastián" for Real Sociedad, etc.

major_winners <- winners_coords %>%
  filter(city %in% major_cities)

other_winners <- winners_coords %>%
  filter(! city %in% major_cities)

# We'll label each major city only once:
major_city_labels <- major_winners %>%
  distinct(city, lat, lon)

other_labels <- other_winners %>%
  distinct(city, lat, lon)

##############################
## 4c) Sort + Create Curves
##############################
# Sort by season numeric
winners_coords_sorted <- winners_coords %>%
  mutate(season_num = parse_number(season)) %>%
  arrange(season_num)

# Add next champion coords
winners_curves <- winners_coords_sorted %>%
  mutate(
    lon_next = lead(lon),
    lat_next = lead(lat),
    season_next = lead(season_num)
  ) %>%
  filter(
    !is.na(lon_next), 
    !is.na(lat_next),
    !(lon == lon_next & lat == lat_next)  # exclude identical coords
  )

winners_curves2 <- winners_curves %>%
  group_by(lon, lat, lon_next, lat_next) %>%
  mutate(dupe_index = row_number()) %>%
  ungroup()

##############################
## 5) Spain Map
##############################
spain_map <- ne_countries(
  scale = "medium",
  country = "Spain",
  returnclass = "sf"
)

##############################
## 6) Final Plot
##############################
# 1) Start the ggplot
p <- ggplot() +
  # (A) Spain polygon
  geom_sf(
    data  = spain_map,
    fill  = "lightgrey",
    color = "black",
    size  = 0.4
  )

# 2) Add multiple 'geom_curve()' layers in a loop
max_dupe <- max(winners_curves2$dupe_index)

for (k in seq_len(max_dupe)) {
  # Subset to dupe_index == k
  subset_k <- winners_curves2 %>% filter(dupe_index == k)
  
  p <- p + geom_curve(
    data = subset_k,
    aes(
      x    = lon,
      y    = lat,
      xend = lon_next,
      yend = lat_next,
      color = season_num  # or as.numeric(season)
    ),
    curvature = 0.1 + 0.01*(k-1),  # e.g. 0.2 for k=1, 0.3 for k=2, etc.
    angle = 90,
    size  = 1.0,
    alpha = 0.4
  )
}

# 3) Add your champion points
p <- p + 
  geom_point(
    data = other_winners,
    aes(x=lon, y=lat),
    size=1.5,
    color="gray40"
  ) +
  geom_point(
    data = major_winners,
    aes(x=lon, y=lat),
    size=3.0,
    color="black"
  )

# 4) Label major cities once, with your existing repel & nudge
p <- p +
  geom_text_repel(
    data = major_city_labels,
    aes(x=lon, y=lat, label=city),
    size=3.5,
    box.padding=0.5,
    point.padding=0.5,
    segment.color="black",
    max.overlaps=Inf,
    color="black",
    nudge_x = c(1.5,-0.5,0,0.5,0.5),
    nudge_y = c(0,1,-1,-0.5,-1)
  ) +
  geom_text_repel(
    data = other_labels,
    aes(x=lon, y=lat, label=city),
    size=2.5,
    box.padding=0.5,
    point.padding=0.5,
    segment.color="black",
    max.overlaps=Inf,
    color="black",
    nudge_x = c(0.5,-0.5),
    nudge_y = c(0.5,0.5)
  )

# 5) Color scale, theme, bounding box
p <- p +
  scale_color_viridis_c(
    name="Year",
    option="A",
    guide=guide_colorbar(barwidth=20, barheight=0.5)
  ) +
  theme_minimal() +
  labs(title="First Division Trophies Since 1929") +
  theme(
    legend.position="bottom",
    axis.title=element_blank(),
    axis.text=element_blank(),
    axis.ticks=element_blank(),
    panel.grid=element_blank(),
    plot.title=element_text(color="black", size=16, face="bold", hjust=0.5)
  ) +
  coord_sf(xlim=c(-10,4), ylim=c(35.5,44))

# 6) Print
print(p)