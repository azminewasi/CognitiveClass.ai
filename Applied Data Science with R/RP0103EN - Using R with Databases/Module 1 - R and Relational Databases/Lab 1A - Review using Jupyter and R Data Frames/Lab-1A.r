movie <- list("Toy Story", 1995, c("Animation", "Adventure", "Comedy"))

movie

movie[2]

movie[1:3]

movie <- list(name = "Toy Story",
             year = 1995,
             genre = c("Animation", "Adventure", "Comedy"))

movie

movie$genre

movie["genre"]

movie[2:3]

class(movie$name)
class(movie$foreign)

movie[["age"]] <- 5
movie

movie[["age"]] <- 6
# Now it's 6, not 5
movie

movie[["age"]] <- NULL
movie

# We split our previous list in two sublists
movie_part1 <- list(name = "Toy Story")
movie_part2 <- list(year = 1995, genre = c("Animation", "Adventure", "Comedy"))

# Now we call the function c() to put everything together again
movie_concatenated <- c(movie_part1, movie_part2)

# Check it out
movie_concatenated

movies <- data.frame(name = c("Toy Story", "Akira", "The Breakfast Club", "The Artist",
                              "Modern Times", "Fight Club", "City of God", "The Untouchables"),
                    year = c(1995, 1998, 1985, 2011, 1936, 1999, 2002, 1987),
                    stringsAsFactors=F)

movies

movies$name

# This returns the first (1st) column
movies[1]

str(movies)

class(movies$year)

movies[1,2] #1-Toy Story, 2-1995

head(movies)

tail(movies)

movies['length'] <- c(81, 125, 97, 100, 87, 139, 130, 119)
movies

movies <- rbind(movies, c(name="Dr. Strangelove", year=1964, length=94))
movies

movies <- movies[-12,]
movies

movies[["length"]] <- NULL
movies

ls<-NULL
