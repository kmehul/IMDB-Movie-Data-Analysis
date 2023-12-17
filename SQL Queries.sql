use final_project;

##Trend Analysis

#Average Movie Runtime change over the years
SELECT 
    startYear, 
    AVG(CAST(runtimeMinutes AS DECIMAL(10, 3))) AS AvgRuntimeMinutes
FROM 
    Dim_Movies
WHERE 
    startYear IS NOT NULL 
    AND runtimeMinutes !="\\N" 
    AND startYear > 0
GROUP BY 
    startYear
ORDER BY 
    startYear;

#Average Movie Rating over the Years
SELECT 
    m.startYear, 
   AVG(CAST(r.Avg_Rating AS DECIMAL(6, 3))) AS AverageRating
FROM 
    Dim_Movies m
JOIN 
    Fct_Ratings r ON m.MovieSK = r.MovieSK
WHERE 
    m.startYear !="\\N" 
    AND r.Avg_Rating IS NOT NULL
GROUP BY 
    m.startYear
ORDER BY 
    m.startYear;

#Number of movies over the years
SELECT 
    m.startYear AS ReleaseYear, 
    COUNT(*) AS NumberOfMoviesReleased
FROM 
    Dim_Movies m
WHERE 
    m.startYear IS NOT NULL AND m.startYear != '\\N'  
GROUP BY 
    m.startYear
ORDER BY 
    m.startYear;

##Genre Analysis

#Genre Popularity over past decade
SELECT 
    g.Genre, 
    AVG(CAST(r.Avg_Rating AS DECIMAL(6, 1))) AS AverageRating
FROM 
    Dim_Genre g
JOIN 
    Bridge_MovieGenre bg ON g.GenreSK = bg.GenreSK
JOIN 
    Dim_Movies m ON bg.MovieSK = m.MovieSK
JOIN 
    Fct_Ratings r ON m.MovieSK = r.MovieSK
WHERE 
    m.startYear BETWEEN YEAR(CURDATE()) - 10 AND YEAR(CURDATE())
GROUP BY 
    g.Genre
ORDER BY 
    AverageRating DESC;

#Top 5 genres by gross earnings
SELECT 
    g.Genre,
    SUM(CAST(REPLACE(REPLACE(r.Gross, '$', ''), ',', '') AS DECIMAL(18,0))) AS TotalGross
FROM 
    Dim_Genre g
JOIN 
    Bridge_MovieGenre bg ON g.GenreSK = bg.GenreSK
JOIN 
    Dim_Movies m ON bg.MovieSK = m.MovieSK
JOIN 
    Fct_MovieRevenue r ON m.MovieSK = r.MovieSK
GROUP BY 
    g.Genre
ORDER BY 
    TotalGross DESC
LIMIT 5;

##Performance Metrics

#Runtime vs Rating
SELECT 
    m.runtimeMinutes, 
    AVG(r.Avg_Rating) AS AverageRating
FROM 
    Dim_Movies m
JOIN 
    Fct_Ratings r ON m.MovieSK = r.MovieSK
WHERE
	m.runtimeMinutes != "\\N"
GROUP BY 
    m.runtimeMinutes
ORDER BY 
    m.runtimeMinutes;

#Movie Runtime vs Average Gross
SELECT 
    m.runtimeMinutes, 
    CEILING(AVG(NULLIF(CAST(REPLACE(REPLACE(r.Gross, '$', ''), ',', '') AS DECIMAL(18,2)), 0))) AS AverageGross
FROM 
    Dim_Movies m
JOIN 
    Fct_MovieRevenue r ON m.MovieSK = r.MovieSK
WHERE
    r.Gross IS NOT NULL AND r.Gross != ''
GROUP BY 
    m.runtimeMinutes
HAVING 
    AverageGross IS NOT NULL
ORDER BY 
    m.runtimeMinutes;

#Number of Votes vs Average Rating
select Avg_Rating, sum(NumVotes) from fct_ratings
group by Avg_Rating
order by Avg_Rating;

##Director Success Metrics

#Directors with most films rated over 7
SELECT 
    p.PrimaryName AS DirectorName,
    COUNT(DISTINCT m.MovieSK) AS HighRatedMoviesCount
FROM 
    Dim_Person p
JOIN 
    Bridge_PersonProfession bpp ON p.PersonSK = bpp.PersonSK
JOIN 
    Dim_Profession dp ON bpp.ProfessionSK = dp.ProfessionSK
JOIN 
    Bridge_TitlePrincipal btp ON p.PersonSK = btp.PersonSK
JOIN 
    Dim_Movies m ON btp.MovieSK = m.MovieSK
JOIN 
    Fct_Ratings r ON m.MovieSK = r.MovieSK
WHERE 
    dp.Profession = 'Director' AND
    r.Avg_Rating > 7
GROUP BY 
    p.PrimaryName
ORDER BY 
    HighRatedMoviesCount DESC;

#Directors with consistent grossing movies
SELECT 
    p.PrimaryName AS DirectorName,
    COUNT(DISTINCT m.MovieSK) AS TotalFilmsDirected,
    SUM(CAST(REPLACE(REPLACE(mr.Gross, '$', ''), ',', '') AS DECIMAL(10))) AS TotalGrossEarnings
FROM 
    Dim_Person p
INNER JOIN 
    Bridge_PersonProfession bpp ON p.PersonSK = bpp.PersonSK
INNER JOIN 
    Dim_Profession dp ON bpp.ProfessionSK = dp.ProfessionSK
INNER JOIN 
    Bridge_TitlePrincipal btp ON p.PersonSK = btp.PersonSK
INNER JOIN 
    Dim_Movies m ON btp.MovieSK = m.MovieSK
INNER JOIN 
    Fct_MovieRevenue mr ON m.MovieSK = mr.MovieSK
WHERE 
    dp.Profession = 'Director' AND
    m.startYear IS NOT NULL AND m.startYear != '\\N' AND
    mr.Gross IS NOT NULL AND mr.Gross != '\\N'
GROUP BY 
    p.PrimaryName
ORDER BY 
    TotalFilmsDirected DESC, TotalGrossEarnings DESC;
    
##Actor and Actress Film Records
    
# Top 10 Actors and Actresses based on Movie ratings between 4 & 7
SELECT 
    p.PrimaryName AS ActorActressName,
    COUNT(DISTINCT m.MovieSK) AS NumberOfFilms
FROM 
    Dim_Person p
JOIN 
    Bridge_PersonProfession bpp ON p.PersonSK = bpp.PersonSK
JOIN 
    Dim_Profession dp ON bpp.ProfessionSK = dp.ProfessionSK
JOIN 
    Bridge_TitlePrincipal btp ON p.PersonSK = btp.PersonSK
JOIN 
    Dim_Movies m ON btp.MovieSK = m.MovieSK
JOIN 
    Fct_Ratings r ON m.MovieSK = r.MovieSK
WHERE 
    r.Avg_Rating BETWEEN 4 AND 7
    AND dp.Profession IN ('Actor', 'Actress') 
GROUP BY 
    p.PrimaryName
ORDER BY 
    NumberOfFilms DESC
LIMIT 10;

# Top 5 Actors and Actresses on Ratings
SELECT 
    p.PrimaryName,
    prof.Profession,
    AVG(r.Avg_Rating) AS AvgRating,
    COUNT(DISTINCT m.MovieSK) AS NumberOfMovies
FROM 
    Dim_Person p
JOIN 
    Bridge_PersonProfession bpp ON p.PersonSK = bpp.PersonSK
JOIN 
    Dim_Profession prof ON bpp.ProfessionSK = prof.ProfessionSK
JOIN 
    Bridge_TitlePrincipal btp ON p.PersonSK = btp.PersonSK
JOIN 
    Dim_Movies m ON btp.MovieSK = m.MovieSK
JOIN 
    Fct_Ratings r ON m.MovieSK = r.MovieSK
WHERE 
    prof.Profession IN ('Actor', 'Actress')
GROUP BY 
    p.PrimaryName, prof.Profession
ORDER BY 
    AVG(r.Avg_Rating) DESC
LIMIT 5;

##Seasonal Analysis

#Movie Performance with Seasons
SELECT 
    d.Season,
    SUM(CAST(REPLACE(REPLACE(mr.Gross, '$', ''), ',', '') AS DECIMAL(10))) AS TotalGrossEarnings
FROM 
    Fct_MovieRevenue mr
JOIN 
    Dim_Date d ON mr.DateSK = d.DateSK
GROUP BY 
    d.Season
ORDER BY 
    TotalGrossEarnings DESC;
   
# Top 3 Movies based on Seasons
SELECT
    Season,
    MovieTitle,
    TotalGross
FROM (
    SELECT
        dd.Season AS Season,
        dm.PrimaryTitle AS MovieTitle,
        SUM(CAST(REPLACE(REPLACE(fmr.Gross, '$', ''), ',', '') AS DECIMAL(18, 2))) AS TotalGross,
        ROW_NUMBER() OVER(PARTITION BY dd.Season ORDER BY SUM(CAST(REPLACE(REPLACE(fmr.Gross, '$', ''), ',', '') AS DECIMAL(18, 2))) DESC) AS RowNum
    FROM
        Dim_Date dd
    JOIN
        Fct_MovieRevenue fmr ON dd.DateSK = fmr.DateSK
    JOIN
        Dim_Movies dm ON fmr.MovieSK = dm.MovieSK
    WHERE
        dd.Season IN ('Spring', 'Summer', 'Fall')
        AND dm.PrimaryTitle IS NOT NULL
        AND fmr.Gross IS NOT NULL
    GROUP BY
        dd.Season,
        dm.PrimaryTitle
) AS RankedMovies
WHERE
    RowNum <= 3
ORDER BY
    Season,
    TotalGross DESC;
    
##Release Regions

#Movies with widest release across regions
SELECT
    dm.primaryTitle,
    COUNT(DISTINCT dr.Region) AS NumRegions
FROM
    dim_movies dm join bridge_movieregion mr
    on dm.MovieSK = mr.MovieSK
    join
    dim_region dr on mr.RegionSK = dr.RegionSK
    
GROUP BY
    primaryTitle
ORDER BY
    NumRegions DESC
LIMIT 5;