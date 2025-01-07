##############################
## 1) Libraries
##############################
library(ggplot2)
library(sf)
library(dplyr)
library(ggrepel)
library(rnaturalearth)
library(rnaturalearthdata)
library(rnaturalearthhires)
library(readr)  # for parse_number(), if needed

##############################################
## 2) Italian Winners (121 Rows, 1898–2024)
##############################################
italy_winners <- data.frame(
  year = c(
    # 1898 (1)
    "1898",
    # 1899 (2)
    "1899",
    # 1900 (3)
    "1900",
    # 1901 (4)
    "1901",
    # 1902 (5)
    "1902",
    # 1903 (6)
    "1903",
    # 1904 (7)
    "1904",
    # 1905 (8)
    "1905",
    # 1906 (9)
    "1906",
    # 1907 (10)
    "1907",
    # 1908 (11)
    "1908",
    # 1909 (12)
    "1909",
    # 1910 (13)
    "1910",
    # 1911 (14)
    "1911",
    # 1912 (15)
    "1912",
    # 1913 (16)
    "1913",
    # 1914 (17)
    "1914",
    # 1915 (18)
    "1915",
    
    # Skipping war 1916–1919
    
    # 1920 (19)
    "1920",
    # 1921 (20)
    "1921",
    # 1922 (21)
    "1922",
    # 1923 (22)
    "1923",
    # 1924 (23)
    "1924",
    # 1925 (24)
    "1925",
    # 1926 (25)
    "1926",
    # 1927 (26)
    "1927",
    # 1928 (27)
    "1928",
    # 1929 (28)
    "1929",
    # 1930 (29)
    "1930",
    # 1931 (30)
    "1931",
    # 1932 (31)
    "1932",
    # 1933 (32)
    "1933",
    # 1934 (33)
    "1934",
    # 1935 (34)
    "1935",
    # 1936 (35)
    "1936",
    # 1937 (36)
    "1937",
    # 1938 (37)
    "1938",
    # 1939 (38)
    "1939",
    # 1940 (39)
    "1940",
    # 1941 (40)
    "1941",
    # 1942 (41)
    "1942",
    # 1943 (42)
    "1943",
    
    # 1944 partial, 1945 canceled
    
    # 1946 (43)
    "1946",
    # 1947 (44)
    "1947",
    # 1948 (45)
    "1948",
    # 1949 (46)
    "1949",
    # 1950 (47)
    "1950",
    # 1951 (48)
    "1951",
    # 1952 (49)
    "1952",
    # 1953 (50)
    "1953",
    # 1954 (51)
    "1954",
    # 1955 (52)
    "1955",
    # 1956 (53)
    "1956",
    # 1957 (54)
    "1957",
    # 1958 (55)
    "1958",
    # 1959 (56)
    "1959",
    # 1960 (57)
    "1960",
    # 1961 (58)
    "1961",
    # 1962 (59)
    "1962",
    # 1963 (60)
    "1963",
    # 1964 (61)
    "1964",
    # 1965 (62)
    "1965",
    # 1966 (63)
    "1966",
    # 1967 (64)
    "1967",
    # 1968 (65)
    "1968",
    # 1969 (66)
    "1969",
    # 1970 (67)
    "1970",
    # 1971 (68)
    "1971",
    # 1972 (69)
    "1972",
    # 1973 (70)
    "1973",
    # 1974 (71)
    "1974",
    # 1975 (72)
    "1975",
    # 1976 (73)
    "1976",
    # 1977 (74)
    "1977",
    # 1978 (75)
    "1978",
    # 1979 (76)
    "1979",
    # 1980 (77)
    "1980",
    # 1981 (78)
    "1981",
    # 1982 (79)
    "1982",
    # 1983 (80)
    "1983",
    # 1984 (81)
    "1984",
    # 1985 (82)
    "1985",
    # 1986 (83)
    "1986",
    # 1987 (84)
    "1987",
    # 1988 (85)
    "1988",
    # 1989 (86)
    "1989",
    # 1990 (87)
    "1990",
    # 1991 (88)
    "1991",
    # 1992 (89)
    "1992",
    # 1993 (90)
    "1993",
    # 1994 (91)
    "1994",
    # 1995 (92)
    "1995",
    # 1996 (93)
    "1996",
    # 1997 (94)
    "1997",
    # 1998 (95)
    "1998",
    # 1999 (96)
    "1999",
    # 2000 (97)
    "2000",
    # 2001 (98)
    "2001",
    # 2002 (99)
    "2002",
    # 2003 (100)
    "2003",
    # 2004 (101)
    "2004",
    # 2005 (102)
    "2005",
    # 2006 (103)
    "2006",
    # 2007 (104)
    "2007",
    # 2008 (105)
    "2008",
    # 2009 (106)
    "2009",
    # 2010 (107)
    "2010",
    # 2011 (108)
    "2011",
    # 2012 (109)
    "2012",
    # 2013 (110)
    "2013",
    # 2014 (111)
    "2014",
    # 2015 (112)
    "2015",
    # 2016 (113)
    "2016",
    # 2017 (114)
    "2017",
    # 2018 (115)
    "2018",
    # 2019 (116)
    "2019",
    # 2020 (117)
    "2020",
    # 2021 (118)
    "2021",
    # 2022 (119)
    "2022",
    # 2023 (120)
    "2023",
    # 2024 (121)
    "2024"
  ),
  winner = c(
    # 1898 (1)
    "Genoa",
    # 1899 (2)
    "Genoa",
    # 1900 (3)
    "Genoa",
    # 1901 (4)
    "Milan",
    # 1902 (5)
    "Genoa",
    # 1903 (6)
    "Genoa",
    # 1904 (7)
    "Genoa",
    # 1905 (8)
    "Juventus",
    # 1906 (9)
    "Milan",
    # 1907 (10)
    "Milan",
    # 1908 (11)
    "Pro Vercelli",
    # 1909 (12)
    "Pro Vercelli",
    # 1910 (13)
    "Internazionale",
    # 1911 (14)
    "Pro Vercelli",
    # 1912 (15)
    "Pro Vercelli",
    # 1913 (16)
    "Pro Vercelli",
    # 1914 (17)
    "Casale",
    # 1915 (18)
    "Genoa",
    
    # skipping war 1916–1919
    
    # 1920 (19)
    "Internazionale",
    # 1921 (20)
    "Pro Vercelli",
    # 1922 (21)
    "Pro Vercelli",
    # 1923 (22)
    "Genoa",
    # 1924 (23)
    "Genoa",
    # 1925 (24)
    "Bologna",
    # 1926 (25)
    "Juventus",
    # 1927 (26)
    "Not awarded",
    # 1928 (27)
    "Torino",
    # 1929 (28)
    "Bologna",
    # 1930 (29)
    "Ambrosiana-Inter",
    # 1931 (30)
    "Juventus",
    # 1932 (31)
    "Juventus",
    # 1933 (32)
    "Juventus",
    # 1934 (33)
    "Juventus",
    # 1935 (34)
    "Juventus",
    # 1936 (35)
    "Bologna",
    # 1937 (36)
    "Bologna",
    # 1938 (37)
    "Ambrosiana-Inter",
    # 1939 (38)
    "Bologna",
    # 1940 (39)
    "Ambrosiana-Inter",
    # 1941 (40)
    "Bologna",
    # 1942 (41)
    "Roma",
    # 1943 (42)
    "Torino",
    
    # 1944 partial, 1945 canceled
    
    # 1946 (43)
    "Torino",
    # 1947 (44)
    "Torino",
    # 1948 (45)
    "Torino",
    # 1949 (46)
    "Torino",
    # 1950 (47)
    "Juventus",
    # 1951 (48)
    "Milan",
    # 1952 (49)
    "Juventus",
    # 1953 (50)
    "Internazionale",
    # 1954 (51)
    "Internazionale",
    # 1955 (52)
    "Milan",
    # 1956 (53)
    "Fiorentina",
    # 1957 (54)
    "Milan",
    # 1958 (55)
    "Juventus",
    # 1959 (56)
    "Milan",
    # 1960 (57)
    "Juventus",
    # 1961 (58)
    "Juventus",
    # 1962 (59)
    "Milan",
    # 1963 (60)
    "Internazionale",
    # 1964 (61)
    "Bologna",
    # 1965 (62)
    "Internazionale",
    # 1966 (63)
    "Internazionale",
    # 1967 (64)
    "Juventus",
    # 1968 (65)
    "Milan",
    # 1969 (66)
    "Fiorentina",
    # 1970 (67)
    "Cagliari",
    # 1971 (68)
    "Internazionale",
    # 1972 (69)
    "Juventus",
    # 1973 (70)
    "Juventus",
    # 1974 (71)
    "Lazio",
    # 1975 (72)
    "Juventus",
    # 1976 (73)
    "Torino",
    # 1977 (74)
    "Juventus",
    # 1978 (75)
    "Juventus",
    # 1979 (76)
    "Milan",
    # 1980 (77)
    "Internazionale",
    # 1981 (78)
    "Juventus",
    # 1982 (79)
    "Juventus",
    # 1983 (80)
    "Roma",
    # 1984 (81)
    "Juventus",
    # 1985 (82)
    "Hellas Verona",
    # 1986 (83)
    "Juventus",
    # 1987 (84)
    "Napoli",
    # 1988 (85)
    "Milan",
    # 1989 (86)
    "Internazionale",
    # 1990 (87)
    "Napoli",
    # 1991 (88)
    "Sampdoria",
    # 1992 (89)
    "Milan",
    # 1993 (90)
    "Milan",
    # 1994 (91)
    "Milan",
    # 1995 (92)
    "Juventus",
    # 1996 (93)
    "Milan",
    # 1997 (94)
    "Juventus",
    # 1998 (95)
    "Juventus",
    # 1999 (96)
    "Milan",
    # 2000 (97)
    "Lazio",
    # 2001 (98)
    "Roma",
    # 2002 (99)
    "Juventus",
    # 2003 (100)
    "Juventus",
    # 2004 (101)
    "Milan",
    # 2005 (102)
    "Not awarded",
    # 2006 (103)
    "Internazionale",
    # 2007 (104)
    "Internazionale",
    # 2008 (105)
    "Internazionale",
    # 2009 (106)
    "Internazionale",
    # 2010 (107)
    "Internazionale",
    # 2011 (108)
    "Milan",
    # 2012 (109)
    "Juventus",
    # 2013 (110)
    "Juventus",
    # 2014 (111)
    "Juventus",
    # 2015 (112)
    "Juventus",
    # 2016 (113)
    "Juventus",
    # 2017 (114)
    "Juventus",
    # 2018 (115)
    "Juventus",
    # 2019 (116)
    "Juventus",
    # 2020 (117)
    "Juventus",
    # 2021 (118)
    "Internazionale",
    # 2022 (119)
    "Milan",
    # 2023 (120)
    "Napoli",
    # 2024 (121)
    "Internazionale"
  ),
  stringsAsFactors = FALSE
)

# Check row count => 121
nrow(italy_winners)
length(italy_winners$winner)

##############################
## 3) italy_club_coords
##############################
# This includes ALL clubs that appear in `italy_winners$winner`
# with approximate lat/lon for their home city.
# 'Not awarded' has no lat/lon (or NA).
italy_club_coords <- data.frame(
  winner = c(
    "Genoa","Milan","Juventus","Pro Vercelli","Casale","Internazionale","Torino",
    "Bologna","Roma","Hellas Verona","Napoli","Sampdoria","Lazio","Cagliari",
    "Fiorentina","Ambrosiana-Inter","Not awarded"
  ),
  city = c(
    "Genoa","Milan","Turin","Vercelli","Casale Monferrato","Milan","Turin",
    "Bologna","Rome","Verona","Naples","Genoa","Rome","Cagliari",
    "Florence","Milan", NA # "Not awarded" => no city
  ),
  lat = c(
    44.4071, 45.4642, 45.0703, 45.3200, 45.1333, 45.4642, 45.0703,
    44.4942, 41.9028, 45.4342, 40.8518, 44.4071, 41.9028, 39.2238,
    43.7696, 45.4642, NA  # last is 'Not awarded'
  ),
  lon = c(
    8.9340, 9.19, 7.6869, 8.4200, 8.4500, 9.19, 7.6869,
    11.3495, 12.4964, 10.9978, 14.2681, 8.9340, 12.4964, 9.1217,
    11.2558, 9.19, NA
  ),
  stringsAsFactors = FALSE
)

##############################
## 4A) Merge: Winners + Coordinates
##############################
italy_merged <- italy_winners %>%
  left_join(italy_club_coords, by="winner")

# Check for missing lat/lon
missing_coords <- italy_merged %>% filter(is.na(lat) & winner != "Not awarded")
if(nrow(missing_coords) > 0) {
  stop(
    "Missing lat/lon for the following clubs:\n",
    paste(unique(missing_coords$winner), collapse=", ")
  )
}

##############################
## 4B) Major vs. Other Winners
##############################
# We'll define major cities in Italy:
# "Milan", "Turin", "Rome", "Naples", "Genoa", "Bologna", "Florence" etc.
major_cities_italy <- c("Milan","Turin","Rome","Naples","Genoa","Bologna","Florence")

# Subset
major_winners <- italy_merged %>%
  filter(city %in% major_cities_italy)

other_winners <- italy_merged %>%
  filter(! city %in% major_cities_italy & !is.na(city))

# Distinct city coords (since multiple clubs share same city)
major_city_labels <- major_winners %>%
  distinct(city, lat, lon)

other_city_labels <- other_winners %>%
  distinct(city, lat, lon) %>% filter(city != 'Casale Monferrato', city != 'Vercelli')

##############################
## 5) Sort + Build Curved Arcs
##############################
# Convert year -> numeric, then sort ascending
italy_sorted <- italy_merged %>%
  mutate(year_num = parse_number(year)) %>%
  arrange(year_num)

# Create arcs from row i -> row i+1
italy_curves <- italy_sorted %>%
  mutate(
    lon_next  = lead(lon),
    lat_next  = lead(lat),
    year_next = lead(year_num)
  ) %>%
  filter(
    !is.na(lon_next),
    !is.na(lat_next),
    # exclude identical coords to avoid "end points must not be identical" error
    !(lon == lon_next & lat == lat_next)
  )

# For repeated start->end pairs in consecutive years, create dupe_index
italy_curves2 <- italy_curves %>%
  group_by(lon, lat, lon_next, lat_next) %>%
  mutate(dupe_index = row_number()) %>%
  ungroup()

##############################
## 6) Italy Map + Plot
##############################
# Load or build an Italy map using rnaturalearth
italy_map <- ne_countries(
  scale       = "medium",
  country     = "Italy",
  returnclass = "sf"
)

# Start ggplot
p <- ggplot() +
  # A) Italy polygon
  geom_sf(
    data  = italy_map,
    fill  = "lightgrey",
    color = "black",
    size  = 0.4
  )

# Determine maximum dupe_index
max_dupe <- max(italy_curves2$dupe_index, na.rm=TRUE)

# B) Draw arcs in a loop
for (k in seq_len(max_dupe)) {
  # Subset this dupe_index
  subset_k <- italy_curves2 %>% filter(dupe_index == k)
  
  # Each iteration => different curvature offset
  p <- p + geom_curve(
    data = subset_k,
    aes(
      x = lon, y = lat,
      xend = lon_next, yend = lat_next,
      color = year_num
    ),
    curvature = 0.15 + 0.05*(k-1), # e.g. 0.15, 0.20, 0.25, ...
    angle     = 90,
    size      = 1.0,
    alpha     = 0.4
  )
}

# C) Plot points
p <- p +
  # Smaller gray points for other clubs
  geom_point(
    data = other_winners,
    aes(x=lon, y=lat),
    size=1.5,
    color="gray40"
  ) +
  # Larger black points for major city clubs
  geom_point(
    data = major_winners,
    aes(x=lon, y=lat),
    size=3.0,
    color="black"
  )

# D) Label major vs. other cities
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
    nudge_x = c(-1,0,-0.5,1.3,-0.5,2,0),
    nudge_y = c(-1,0.5,0.5,0.5,-0.8,0,-0.5)
  ) +
  geom_text_repel(
    data = other_city_labels,
    aes(x=lon, y=lat, label=city),
    size=2.5,
    box.padding=0.5,
    point.padding=0.5,
    segment.color="black",
    max.overlaps=Inf,
    color="black",
    nudge_x = c(0,0.5),
    nudge_y = c(-0.5,0.5)
  )

# E) Color scale & theme
p <- p +
  scale_color_viridis_c(
    name="Year",
    option="A",
    guide=guide_colorbar(barwidth=20, barheight=0.5)
  ) +
  theme_minimal() +
  labs(title="First Division Trophies Since 1898") +
  theme(
    legend.position="bottom",
    axis.title       = element_blank(),
    axis.text        = element_blank(),
    axis.ticks       = element_blank(),
    panel.grid       = element_blank(),
    plot.title       = element_text(color="black", size=16, face="bold", hjust=0.5)
  ) +
  # Basic bounding box for Italy
  coord_sf(xlim = c(7, 18), ylim = c(36, 47))

# Print final plot
print(p)
