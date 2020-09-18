library(readr)
Spotify <- read_csv("Desktop/radar_viz_8/SpotifyAudioFeaturesApril2019.csv")
library(stringr)
library(tidyverse)
library(splitstackshape)
library(dplyr)
temp <- str_replace_all(Spotify$track_name, "[^[:alnum:]]", " ")
temp2 <- unlist(strsplit(temp, " "))
temp2 <- temp2[temp2 != ""]
word_count <- as.data.frame(table(temp2))
word_count1 <- word_count[order(word_count$Freq, decreasing = TRUE), ]
useless_words <- c('feat','The','No', 'in','Remix','the','BWV','A','Live','of','Tu','Out',
                   '2', 'Op', 's', 'ASOT','1','t','for','Of','In','K','a','II','Be','On',
                   'and','to','Pt','Mix','Allegro','3','Version','From','D','Is','O',
                   'III','C','El','La','E','For','on','de','4','G','B','En','Vivo',
                   '5','with','Down','Up','With','F','at','Edit','L','De','m','Fugue',
                   'Part','Te','Arr','6','IV','Mi','Suite','U','So','Are','0','10','To',
                   'At','12','la','7','And','St','8','der','by','T','Yo','Le','S','re',
                   '9','V','di','RV','Gott','Ain','M','con','Los','Ya','en','Studios','988',
                   'und','第','y','Se','mix','Var','Am','Da','J','Lo','el','Das','Adagio',
                   'Allegretto','P','molto','Y','By','non','900','d','II','e','Un','11','VI',
                   '244','du','15','248','da','24','Es')
word_count1$temp2 <- as.character(word_count1$temp2)
word_count1$temp2[word_count1$temp2 == "Don"] <- "Don't"
word_count1 <- word_count1[!is.na(word_count1$temp2),]
word_count1 <- word_count1[!word_count1$temp2 %in% useless_words,]
names(word_count1) <- c('text', 'size')
write.csv(word_count1, "Desktop/word_count1.csv")

library(rjson)
word_count_json <- toJSON(unname(split(word_count1, 1:nrow(word_count1))))

jsonlite::write_json(word_count1, "Desktop/word_count1.json")
