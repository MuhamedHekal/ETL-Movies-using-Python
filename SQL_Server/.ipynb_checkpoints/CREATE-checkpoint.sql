create DataBase MoviesDWH;
go 
use MoviesDWH

CREATE TABLE Dim_Cast(
    DummyCol bigint NOT NULL,
	CastID bigint NOT NULL,
    Actor varchar(100) NOT NULL,
    M_Character varchar(max) NOT NULL,
    A_Order bigint NOT NULL,
    CONSTRAINT PK_Cast PRIMARY KEY (DummyCol,CastID) 
);

CREATE TABLE Dim_Crew (
    DummyCol bigint NOT NULL,
	CrewID bigint NOT NULL,
    P_Name varchar(100) NOT NULL,
    Departement varchar(100) NOT NULL,
    Job varchar(100) NOT NULL,
    CONSTRAINT PK_Crew PRIMARY KEY (DummyCol,CrewID)
);

CREATE TABLE Dim_Production_Company (
    DummyCol bigint NOT NULL,
	CompanyID bigint NOT NULL,
    C_Name varchar(max) NOT NULL,
    CONSTRAINT PK_PC PRIMARY KEY (DummyCol,CompanyID)
);

CREATE TABLE Dim_Keywords (
    DummyCol bigint NOT NULL,
	KeywordsID bigint NOT NULL,
    K_Name varchar(100) NOT NULL,
    CONSTRAINT PK_Keywords PRIMARY KEY (DummyCol,KeywordsID)
);

CREATE TABLE Dim_Genres (
    DummyCol bigint NOT NULL,
	GenreID bigint NOT NULL,
    G_Name varchar(100) NOT NULL,
    CONSTRAINT PK_Genres PRIMARY KEY (DummyCol,GenreID)
);

CREATE TABLE Dim_Date (
    DimDateID bigint NOT NULL,
    Release_Date date NOT NULL,
	Year bigint NOT NULL,
	Quarter varchar(100) NOT NULL,
	Month varchar(100) NOT NULL,
	Day varchar(100) NOT NULL,

    CONSTRAINT PK_Date PRIMARY KEY (DimDateID)
);

CREATE TABLE Movies_Fact (
	DimFactID bigint NOT NULL ,
    DimDateID bigint NOT NULL , 
	CastID bigint NOT NULL , 
	DummyCol bigint NOT NULL , 
	CrewID bigint NOT NULL , 
	CompanyID bigint NOT NULL ,  
	KeywordsID bigint NOT NULL , 
	GenreID bigint NOT NULL , 
	Original_Title varchar(200) NOT NULL , 
	Runtime float NOT NULL , 
	Release_Date date NOT NULL ,
	Popularity float NOT NULL ,
	IMDb_Vote_Avg float NOT NULL ,
	Users_Rating_Avg float NOT NULL ,
	Revenue money Not Null,
	Revenue_Normalized_Jan_1999 money Not Null,

	PRIMARY KEY (DimFactID),
	CONSTRAINT FK_Cast FOREIGN KEY (DummyCol,CastID) REFERENCES Dim_Cast(DummyCol,CastID),
	CONSTRAINT FK_Date FOREIGN KEY (DimDateID) REFERENCES Dim_Date(DimDateID),
	CONSTRAINT FK_Crew FOREIGN KEY (DummyCol,CrewID) REFERENCES Dim_Crew(DummyCol,CrewID),
	CONSTRAINT FK_Comp FOREIGN KEY (DummyCol,CompanyID) REFERENCES Dim_Production_Company(DummyCol,CompanyID),
	CONSTRAINT FK_Keys FOREIGN KEY (DummyCol,KeywordsID) REFERENCES Dim_Keywords(DummyCol,KeywordsID),
	CONSTRAINT FK_Genr FOREIGN KEY (DummyCol,GenreID) REFERENCES Dim_Genres(DummyCol,GenreID)

);

ALTER TABLE Movies_Fact
NOCHECK CONSTRAINT FK_Cast ,FK_Date,FK_Crew,FK_Comp,FK_Keys,FK_Genr ;
