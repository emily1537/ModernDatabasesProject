--Emily Carlson
--770022156
--CSCI 245 Modern Datbases  
--Lab 5: HorseLesson Script
--10-22-18



CREATE TABLE Student (
	StudentID serial4 NOT NULL,
	FirstName varchar(60) NOT NULL,
	LastName varchar(60) NOT NULL,
	Birthday timestamp(0) NOT NULL,
	EmContactPhone varchar(14) NOT NULL,
	PRIMARY KEY (StudentID) 
)

WITHOUT OIDS;

CREATE TABLE Lesson (
	LessonID serial4 NOT NULL,
	Name varchar(60) NOT NULL,
	Price decimal(5,2) NOT NULL,
	MinAge int,
	PRIMARY KEY (LessonID),
	CONSTRAINT UniqueLessonName UNIQUE (Name)
)

WITHOUT OIDS;

CREATE TABLE ScheduledLesson (
	SchedLessonID serial4 NOT NULL,
	StartTime timestamp(0) NOT NULL,
	EndTime timestamp(0) NOT NULL,
	LessonID int NOT NULL,
	TeacherID int NOT NULL,
	PRIMARY KEY (SchedLessonID)
)

WITHOUT OIDS;

CREATE TABLE StudentLesson (
	StudentLessonID serial4 NOT NULL,
	StudentID int NOT NULL,
	Present bool NOT NULL DEFAULT '0',
	SchedLessonID int NOT NULL,
	PRIMARY KEY (StudentLessonID) 
)

WITHOUT OIDS;

CREATE TABLE Horse (
	HorseID serial4 NOT NULL,
	Name varchar(50) NOT NULL,
	VaccDate timestamp(0) NOT NULL,
	PRIMARY KEY (HorseID)
)

WITHOUT OIDS;


CREATE TABLE Teacher (
	TeacherID serial4 NOT NULL,
	FirstName varchar(60) NOT NULL,
	LastName varchar(60) NOT NULL,
	Email varchar(50) NULL,
	Phone varchar(14) NULL,
	PRIMARY KEY (TeacherID) 
)

WITHOUT OIDS;

CREATE TABLE LessonHorse (
	LessonHorseID serial4 NOT NULL,
	HorseID int NOT NULL,
	SchedLessonID int NOT NULL,
	PRIMARY KEY (LessonHorseID)
)

WITHOUT OIDS;



ALTER TABLE ScheduledLesson ADD CONSTRAINT fk_SchedLesson_Lesson FOREIGN KEY (LessonID) REFERENCES Lesson (LessonID);

ALTER TABLE ScheduledLesson ADD CONSTRAINT fk_SchedLesson_Teacher FOREIGN KEY (TeacherID) REFERENCES Teacher (TeacherID);

ALTER TABLE StudentLesson ADD CONSTRAINT fk_StuLess_SchedLesson FOREIGN KEY (SchedLessonID) REFERENCES ScheduledLesson (SchedLessonID);

ALTER TABLE LessonHorse ADD CONSTRAINT fk_LessonHorse_Horse FOREIGN KEY (HorseID) REFERENCES Horse (HorseID);

ALTER TABLE StudentLesson ADD CONSTRAINT fk_StuLess_Student FOREIGN KEY (StudentID) REFERENCES Student (StudentID);

ALTER TABLE LessonHorse ADD CONSTRAINT fk_LessonHorse_SchedLesson FOREIGN KEY (SchedLessonID) REFERENCES ScheduledLesson (SchedLessonID);

--Import Data 
COPY Horse FROM 'C:\HorseLessonCSV\Horse.csv' DELIMITER ',' CSV HEADER;
COPY Lesson FROM 'C:\HorseLessonCSV\Lesson.csv' DELIMITER ',' CSV HEADER;
COPY Student FROM 'C:\HorseLessonCSV\Student.csv' DELIMITER ',' CSV HEADER;
COPY Teacher FROM 'C:\HorseLessonCSV\Teacher.csv' DELIMITER ',' CSV HEADER;
COPY ScheduledLesson FROM 'C:\HorseLessonCSV\ScheduledLesson.csv' DELIMITER ',' CSV HEADER;
COPY StudentLesson FROM 'C:\HorseLessonCSV\StudentLesson.csv' DELIMITER ',' CSV HEADER;
COPY LessonHorse FROM 'C:\HorseLessonCSV\LessonHorse.csv' DELIMITER ',' CSV HEADER;