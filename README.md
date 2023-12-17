# IMDB Data Analysis

This Project focuses on the data analysis of the imdb dataset, which contains the records of movies, crew, and the release details of the movies.

The Aim of this project is to get the data from the source database, transform and map the data using talend studio, and create pipelines so that the data populates successfully in the target tables of the destination database.

The end goal of this project is to create visualizations in Tableau and PowerBI for analysis and interpretation of the trends in accordance with the BI requirements of the Project.

## Source

The Source of this project is a database which contains the initial staging tables with the different movie and crew details.

Following is a list of the sources:-

1. **imdb_title_basics** : This table stores the details about the movie.
2. **imdb_title_akas** : This table tracks the release of the movies across different regions.
3. **imdb_title_principals** : This is the first table that has the person to movie connections.
4. **imdb_title_crew** : This table tracks the connections of movies to writers and directors.
5. **imdb_name basics** : This table has all the details of the person/people who are connected to the movies in some way.
6. **imdb_title_ratings** : This table ocntains the records of the ratings the movies received.
7. **json files** : There are 2 json files, the first one tracks the person name changes and the second one keeps the track of the movie name changes.
8. **tsv Files** : There are tsv files for 9 movies, which track the box office performance of these movies.

All of these files are loaded as the staging tables in the destination database using pipelines created in talend.

## Target

The target database has 12 tables, which are a result of mapping and split from the stage tables to get the appropriate tables in the context of the BI requirements.

Following is a list of the final target tables:

1. **dim_date** : This table contains a specified number of date records from a specified particular date.
2. **dim_person** : This table contains the details of every person related to the movies.
3. **dim_movies** : This table contains the details of all the movies.
4. **dim_profession** : This table has the record of every profession.
5. **bridge_personprofession** : This table is the bridge table that connects the person to the profession.
6. **dim_genre** : This table contains all the genres.
7. **bridge_moviegenre** : This table is the bridge table that connects the movies to its genres.
8. **dim_region** : This table has the record of all the regions.
9. **bridge_movieregion** : This table is the bridge table that connects the movies to the regions that they were released in.
10. **bridge_titleprincipal** : This is the bridge table that connects people to the movies that they were a part of.
11. **fct_ratings** : This table keeps track of the ratings for the movies.
12. **fct_movierevenue** : This table contains the box office records of the 9 movies and hence tracking their performance.

## Data Model

<img src="ER Studio/Screenshots/Physical Model.png" alt="Data Model">

## Source and Final Database Files

Click [here](https://drive.google.com/drive/folders/1JCeybAu02B9q3PD-X4igESFPpuXtabbg?usp=sharing) to access the source files for this project, and [here](https://drive.google.com/file/d/1vt3Qqg_Y-5381TznE5FhzroFW4U9R6bx/view?usp=sharing) to access the complete final database file.