# IMDB Movie Data Analysis

## Overview
This project focuses on the data analysis of the IMDB dataset, which contains records of movies, crew, and release details. The aim is to extract data from the source database, transform and map it using Talend Studio, and create pipelines to populate the target tables in the destination database. The end goal is to create visualizations in Tableau and PowerBI for analysis and interpretation of trends based on the BI requirements.

## Table of Contents
- [Source](#source)
- [Target](#target)
- [Data Model](#data-model)
- [Visualization](#visualization)
- [Key Findings](#key-findings)
- [Technologies Used](#technologies-used)
- [Source and Final Database Files](#source-and-final-database-files)
- [Contributors](#contributors)
- [License](#license)

## Source
The source of this project is a database containing initial staging tables with various movie and crew details. The following is a list of the sources:

- **imdb_title_basics**: Stores details about movies.
- **imdb_title_akas**: Tracks the release of movies across different regions.
- **imdb_title_principals**: First table with person-to-movie connections.
- **imdb_title_crew**: Tracks connections of movies to writers and directors.
- **imdb_name_basics**: Details of persons connected to movies.
- **imdb_title_ratings**: Records of movie ratings.
- **json files**: Two files, one tracking person name changes and the other tracking movie name changes.
- **tsv Files**: Nine files tracking the box office performance of specific movies.

All these files are loaded as staging tables in the destination database using pipelines created in Talend.

## Target
The target database has 12 tables, resulting from mapping and splitting the stage tables to meet BI requirements. The final target tables are:

- **dim_date**: Contains a specified number of date records from a particular start date.
- **dim_person**: Details of every person related to movies.
- **dim_movies**: Details of all movies.
- **dim_profession**: Records of every profession.
- **bridge_personprofession**: Connects persons to professions.
- **dim_genre**: Contains all genres.
- **bridge_moviegenre**: Connects movies to their genres.
- **dim_region**: Records of all regions.
- **bridge_movieregion**: Connects movies to their release regions.
- **bridge_titleprincipal**: Connects people to movies they were part of.
- **fct_ratings**: Tracks movie ratings.
- **fct_movierevenue**: Box office records of nine movies, tracking their performance.

## Data Model
The data model for this project includes various dimension and fact tables, structured to support BI analysis. It includes the following key tables:
- **Dimension Tables**: dim_date, dim_person, dim_movies, dim_profession, dim_genre, dim_region.
- **Fact Tables**: fct_ratings, fct_movierevenue.
- **Bridge Tables**: bridge_personprofession, bridge_moviegenre, bridge_movieregion, bridge_titleprincipal.
  <img src="ER Studio/Screenshots/Physical Model.png" alt="Data Model">

## Visualization
The project includes visualizations created in Tableau and PowerBI to analyze and interpret trends in the data according to BI requirements. These visualizations help in understanding various metrics such as movie ratings distribution, revenue trends, genre popularity, etc.

## Key Findings
- **Top Rated Movies**: Identified the top-rated movies based on user ratings, providing insights into user preferences.
- **Revenue Trends**: Analyzed revenue trends over the years, revealing patterns in movie box office performance.
- **Genre Popularity**: Determined the most popular genres, helping understand trends in movie production and consumption.
- **Seasonal Trends**: Analysis of seasonal trends in movie releases and revenues.

## Technologies Used
- **Talend Studio**: For ETL processes.
- **Tableau**: For data visualization.
- **PowerBI**: For data visualization.
- **MySQL**: For database management.
- **JSON**: For handling name changes.
- **TSV**: For tracking box office performance.

## Source and Final Database Files

Click [here](https://1drv.ms/u/s!AvT3QVDElVmegUmSm12iOM20Qv_k?e=dgmBhb) to access the source files for this project, and [here](https://1drv.ms/u/s!AvT3QVDElVmegUooqSmDO9feP7sp?e=jytSjN) to access the complete final database file.

## Contributors
- **Kumar Mehul**: [GitHub](https://github.com/kmehul) | [LinkedIn](https://www.linkedin.com/in/kmehul992/) | kumar-mehul@outlook.com

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
