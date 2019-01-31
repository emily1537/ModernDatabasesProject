#--Emily Carlson
#--770022156
#--CSCI 245 Modern Datbases  
#--Lab 4: HorseLesson Script
#--10-22-18



USE HorseLesson; 

CREATE TABLE `Student` (
	`StudentID` int NOT NULL AUTO_INCREMENT,
	`FirstName` varchar(60) NOT NULL,
	`LastName` varchar(60) NOT NULL,
	`Birthday` datetime NOT NULL,
	`EmContactPhone` varchar(14) NOT NULL,
	PRIMARY KEY (`StudentID`) 
)

ENGINE =InnoDB;

CREATE TABLE `Lesson` (
	`LessonID` int NOT NULL AUTO_INCREMENT,
	`Name` varchar(60) NOT NULL,
	`Price` decimal(5,2) NOT NULL,
	`MinAge` int,
	PRIMARY KEY (`LessonID`),
	CONSTRAINT `UniqueLessonName` UNIQUE (`Name`)
)

ENGINE =InnoDB;

CREATE TABLE `ScheduledLesson` (
	`SchedLessonID` int NOT NULL AUTO_INCREMENT,
	`StartTime` datetime NOT NULL,
	`EndTime` datetime NOT NULL,
	`LessonID` int NOT NULL,
	`TeacherID` int NOT NULL,
	PRIMARY KEY (`SchedLessonID`)
)

ENGINE =InnoDB;

CREATE TABLE `StudentLesson` (
	`StudentLessonID` int NOT NULL AUTO_INCREMENT,
	`StudentID` int NOT NULL,
	`Present` bit NOT NULL DEFAULT 0,
	`SchedLessonID` int NOT NULL,
	PRIMARY KEY (`StudentLessonID`) 
)

ENGINE =InnoDB;

CREATE TABLE `Horse` (
	`HorseID` int NOT NULL AUTO_INCREMENT,
	`Name` varchar(50) NOT NULL,
	`VaccDate` DATETIME NOT NULL,
	PRIMARY KEY (`HorseID`)
)

ENGINE =InnoDB;


CREATE TABLE `Teacher` (
	`TeacherID` int NOT NULL AUTO_INCREMENT,
	`FirstName` varchar(60) NOT NULL,
	`LastName` varchar(60) NOT NULL,
	`Email` varchar(50) NULL,
	`Phone` varchar(14) NULL,
	PRIMARY KEY (`TeacherID`) 
)

ENGINE =InnoDB;

CREATE TABLE `LessonHorse` (
	`LessonHorseID` int NOT NULL AUTO_INCREMENT,
	`HorseID` int NOT NULL,
	`SchedLessonID` int NOT NULL,
	PRIMARY KEY (`LessonHorseID`)
)

ENGINE =InnoDB;



ALTER TABLE `ScheduledLesson` ADD CONSTRAINT `fk_SchedLesson_Lesson` FOREIGN KEY (`LessonID`) REFERENCES `Lesson` (`LessonID`);

ALTER TABLE `ScheduledLesson` ADD CONSTRAINT `fk_SchedLesson_Teacher` FOREIGN KEY (`TeacherID`) REFERENCES `Teacher` (`TeacherID`);

ALTER TABLE `StudentLesson` ADD CONSTRAINT `fk_StuLess_SchedLesson` FOREIGN KEY (`SchedLessonID`) REFERENCES `ScheduledLesson` (`SchedLessonID`);

ALTER TABLE `LessonHorse` ADD CONSTRAINT `fk_LessonHorse_Horse` FOREIGN KEY (`HorseID`) REFERENCES `Horse` (`HorseID`);

ALTER TABLE `StudentLesson` ADD CONSTRAINT `fk_StuLess_Student` FOREIGN KEY (`StudentID`) REFERENCES `Student` (`StudentID`);

ALTER TABLE `LessonHorse` ADD CONSTRAINT `fk_LessonHorse_SchedLesson` FOREIGN KEY (`SchedLessonID`) REFERENCES `ScheduledLesson` (`SchedLessonID`);
