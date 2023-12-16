--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      Final_Project_Dimensional_Model.DM1
--
-- Date Created : Thursday, November 30, 2023 17:06:41
-- Target DBMS : MySQL 8.x
--

use final_project;

-- 
-- TABLE: Bridge_MovieGenre 
--

CREATE TABLE Bridge_MovieGenre(
    MovieGenreSK      INT            AUTO_INCREMENT,
    MovieSK           INT            NOT NULL,
    GenreSK           INT            NOT NULL,
    DI_CreatedDate    DATE           NOT NULL,
    DI_ProcessID      VARCHAR(10)    NOT NULL,
    PRIMARY KEY (MovieGenreSK)
)ENGINE=MYISAM
;



-- 
-- TABLE: Bridge_MovieRegion 
--

CREATE TABLE Bridge_MovieRegion(
    MovieRegionSK     INT            AUTO_INCREMENT,
    RegionSK          INT            NOT NULL,
    MovieSK           INT            NOT NULL,
    DI_CreatedDate    DATE           NOT NULL,
    DI_ProcessID      VARCHAR(10)    NOT NULL,
    PRIMARY KEY (MovieRegionSK)
)ENGINE=MYISAM
;



-- 
-- TABLE: Bridge_PersonProfession 
--

CREATE TABLE Bridge_PersonProfession(
    PersonProfessionSK    INT            AUTO_INCREMENT,
    ProfessionSK          INT            NOT NULL,
    PersonSK              INT            NOT NULL,
    DI_CreatedDate        DATE           NOT NULL,
    DI_ProcessID          VARCHAR(10)    NOT NULL,
    PRIMARY KEY (PersonProfessionSK)
)ENGINE=MYISAM
;



-- 
-- TABLE: Bridge_TitlePrincipal 
--

CREATE TABLE Bridge_TitlePrincipal(
    TitlePrincipalSK    INT            AUTO_INCREMENT,
    MovieSK             INT            NOT NULL,
    PersonSK            INT            NOT NULL,
    DI_CreatedDate      DATE           NOT NULL,
    DI_ProcessID        VARCHAR(10)    NOT NULL,
    PRIMARY KEY (TitlePrincipalSK)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Date 
--

CREATE TABLE Dim_Date(
    DateSK            INT            NOT NULL,
    Date              DATE           NOT NULL,
    Month             VARCHAR(20),
    Quarter           INT,
    Year              INT,
    Season            VARCHAR(20),
    DI_CreatedDate    DATE           NOT NULL,
    DI_ProcessID      VARCHAR(10)    NOT NULL,
    PRIMARY KEY (DateSK)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Genre 
--

CREATE TABLE Dim_Genre(
    GenreSK           INT            AUTO_INCREMENT,
    Genre             VARCHAR(25)    NOT NULL,
    DI_CreatedDate    DATE           NOT NULL,
    DI_ProcessID      VARCHAR(10)    NOT NULL,
    PRIMARY KEY (GenreSK)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Movies 
--

CREATE TABLE Dim_Movies(
    MovieSK           INT             AUTO_INCREMENT,
    tconst            VARCHAR(20)     NOT NULL,
    PrimaryTitle      VARCHAR(500),
    OriginalTitle     VARCHAR(500),
    startYear         VARCHAR(18),
    endYear           VARCHAR(18),
    runtimeMinutes    VARCHAR(18),
    DI_CreatedDate    DATE            NOT NULL,
    DI_ProcessID      VARCHAR(10)     NOT NULL,
    PRIMARY KEY (MovieSK)
)ENGINE=MYISAM
;

ALTER TABLE dim_movies
ADD COLUMN scd_start DATE NOT NULL,
ADD COLUMN scd_end DATE NOT NULL,
ADD COLUMN scd_version INT NOT NULL,
ADD COLUMN scd_active INT NOT NULL;

drop table dim_movies;


-- 
-- TABLE: Dim_Person 
--

CREATE TABLE Dim_Person(
    PersonSK          INT            AUTO_INCREMENT,
    nconst            VARCHAR(10)    NOT NULL,
    PrimaryName       VARCHAR(255),
    BirthYear         VARCHAR(18),
    DeathYear         VARCHAR(18),
    DI_CreatedDate    DATE           NOT NULL,
    DI_ProcessID      VARCHAR(10)    NOT NULL,
    PRIMARY KEY (PersonSK)
)ENGINE=MYISAM
;

ALTER TABLE dim_person 
ADD COLUMN scd_start DATE NOT NULL,
ADD COLUMN scd_end DATE NOT NULL,
ADD COLUMN scd_version INT NOT NULL,
ADD COLUMN scd_active INT NOT NULL;

drop table dim_person;


-- 
-- TABLE: Dim_Profession 
--

CREATE TABLE Dim_Profession(
    ProfessionSK      INT            AUTO_INCREMENT,
    Profession        VARCHAR(50)    NOT NULL,
    DI_CreatedDate    DATE           NOT NULL,
    DI_ProcessID      VARCHAR(10)    NOT NULL,
    PRIMARY KEY (ProfessionSK)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Region 
--

CREATE TABLE Dim_Region(
    RegionSK          INT             AUTO_INCREMENT,
    Region            VARCHAR(100),
    DI_CreatedDate    DATE            NOT NULL,
    DI_ProcessID      VARCHAR(10)     NOT NULL,
    PRIMARY KEY (RegionSK)
)ENGINE=MYISAM
;



-- 
-- TABLE: Fct_MovieRevenue 
--

CREATE TABLE Fct_MovieRevenue(
    MovieRevenueSK    INT             AUTO_INCREMENT,
    MovieSK           INT             NOT NULL,
    DateSK            INT             NOT NULL,
    Title             VARCHAR(100),
    Gross             VARCHAR(50),
    Theatres          INT,
    PerTheatre        VARCHAR(50),
    TotalGross        VARCHAR(50),
    DI_CreatedDate    DATE            NOT NULL,
    DI_ProcessID      VARCHAR(10)     NOT NULL,
    PRIMARY KEY (MovieRevenueSK)
)ENGINE=MYISAM
;

ALTER TABLE Fct_MovieRevenue 
MODIFY Theatres VARCHAR(10);


-- 
-- TABLE: Fct_Ratings 
--

CREATE TABLE Fct_Ratings(
    RatingsSK         INT            AUTO_INCREMENT,
    MovieSK           INT,
    runtimeMinutes    INT,
    releaseYear       INT,
    Avg_Rating        FLOAT,
    NumVotes          INT,
    DI_CreatedDate    DATE           NOT NULL,
    DI_ProcessID      VARCHAR(10)    NOT NULL,
    PRIMARY KEY (RatingsSK)
)ENGINE=MYISAM
;


-- 
-- TABLE: Bridge_MovieGenre 
--

ALTER TABLE Bridge_MovieGenre ADD CONSTRAINT RefDim_Genre12 
    FOREIGN KEY (GenreSK)
    REFERENCES Dim_Genre(GenreSK)
;

ALTER TABLE Bridge_MovieGenre ADD CONSTRAINT RefDim_Movies22 
    FOREIGN KEY (MovieSK)
    REFERENCES Dim_Movies(MovieSK)
;


-- 
-- TABLE: Bridge_MovieRegion 
--

ALTER TABLE Bridge_MovieRegion ADD CONSTRAINT RefDim_Movies41 
    FOREIGN KEY (MovieSK)
    REFERENCES Dim_Movies(MovieSK)
;

ALTER TABLE Bridge_MovieRegion ADD CONSTRAINT RefDim_Region161 
    FOREIGN KEY (RegionSK)
    REFERENCES Dim_Region(RegionSK)
;


-- 
-- TABLE: Bridge_PersonProfession 
--

ALTER TABLE Bridge_PersonProfession ADD CONSTRAINT RefDim_Profession201 
    FOREIGN KEY (ProfessionSK)
    REFERENCES Dim_Profession(ProfessionSK)
;

ALTER TABLE Bridge_PersonProfession ADD CONSTRAINT RefDim_Person211 
    FOREIGN KEY (PersonSK)
    REFERENCES Dim_Person(PersonSK)
;


-- 
-- TABLE: Bridge_TitlePrincipal 
--

ALTER TABLE Bridge_TitlePrincipal ADD CONSTRAINT RefDim_Movies31 
    FOREIGN KEY (MovieSK)
    REFERENCES Dim_Movies(MovieSK)
;

ALTER TABLE Bridge_TitlePrincipal ADD CONSTRAINT RefDim_Person71 
    FOREIGN KEY (PersonSK)
    REFERENCES Dim_Person(PersonSK)
;


-- 
-- TABLE: Fct_MovieRevenue 
--

ALTER TABLE Fct_MovieRevenue ADD CONSTRAINT RefDim_Movies51 
    FOREIGN KEY (MovieSK)
    REFERENCES Dim_Movies(MovieSK)
;

ALTER TABLE Fct_MovieRevenue ADD CONSTRAINT RefDim_Date61 
    FOREIGN KEY (DateSK)
    REFERENCES Dim_Date(DateSK)
;


-- 
-- TABLE: Fct_Ratings 
--

ALTER TABLE Fct_Ratings ADD CONSTRAINT RefDim_Movies191 
    FOREIGN KEY (MovieSK)
    REFERENCES Dim_Movies(MovieSK)
;


