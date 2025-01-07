# Trophy Trips

Here is code for mapping the location of major football trophies in England, Spain, Germany and Italy. Everything was created in R using [R Studio](https://posit.co/download/rstudio-desktop/). If you have any questions or issues related to the code, feel free to reach out to me. The code is very extensively commented, both to make the steps clearer and to avoid an error on my side.

# Notes

All trophy winners were taken from wikipedia. During this process, a few arbitrary decisions were made:

- Years with no winners (due to both world wars, the civil war in Spain and corruption) are omitted from the dataset.
- German winners from 1943 to 1990 were taken for West Germany (Oberligen & Budesliga). For East German champions, please refer to the dedicated [Wikipedia page](https://en.wikipedia.org/wiki/List_of_East_German_football_champions).
- Winners of the Copa del Rey are not considered here, despite it sometimes being considered the predecessor of La Liga.
- For the 1921-22 Italian season, Pro Vercelli was retained as the winner after the creation of the Confederazione Calcistica Italiana (CCI). This decision is based on most major Italian teams deciding to participate in the Prima Divisione that season rather than in the Prima Categoria. The alternative winner that isn't included here is Novese.

For a comprehensive list of the champions retained, you can also run the data in R and look at the 'winners' dataset. Furthermore, to accelerate the coding process, approximate longitudes and latitudes for cities were generated with ChatGPT. These correspond to the coordinates of the city generally associated with the club and not the location of the club or stadium (so both AS Roma and Lazio are listed as Rome, for example). I looked over the generated points and believe them to be approximatively correct for each city; however, if one city is substantially off, let me know.

Lines for Italy and Spain are presented as curves due to the relative scarcity of winners. This is also possible for Germany and England but reduces the space available for labels.

# Can I extend this to other leagues?

I would love to extend this work to other leagues when I have the time but feel free to do it yourself. All I ask is for you to credit me for the methodology. I'm also happy to assist if you're debuting in R.
