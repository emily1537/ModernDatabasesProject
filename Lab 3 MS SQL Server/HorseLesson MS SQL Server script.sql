/* 
	Emily Carlson
	770022156
	CSCI 245 Modern Datbases  
	Lab 3: HorseLesson Script
	10-10-18
*/


USE HorseLesson; 

CREATE TABLE [Student] (
	[StudentID] int NOT NULL IDENTITY(1,1),
	[FirstName] varchar(60) NOT NULL,
	[LastName] varchar(60) NOT NULL,
	[Birthday] datetime NOT NULL,
	[EmContactPhone] varchar(14) NOT NULL,
	PRIMARY KEY ([StudentID]) 
)

GO

CREATE TABLE [Lesson] (
	[LessonID] int NOT NULL IDENTITY(1,1),
	[Name] varchar(60) NOT NULL,
	[Price] decimal(5,2) NOT NULL,
	[MinAge] int,
	PRIMARY KEY ([LessonID]),
	CONSTRAINT [UniqueLessonName] UNIQUE ([Name])
)

GO

CREATE TABLE [ScheduledLesson] (
	[SchedLessonID] int NOT NULL IDENTITY(1,1),
	[StartTime] datetime NOT NULL,
	[EndTime] datetime NOT NULL,
	[LessonID] int NOT NULL,
	[TeacherID] int NOT NULL,
	PRIMARY KEY ([SchedLessonID])
)

GO

CREATE TABLE [StudentLesson] (
	[StudentLessonID] int NOT NULL IDENTITY(1,1),
	[StudentID] int NOT NULL,
	[Present] bit NOT NULL DEFAULT 0,
	[SchedLessonID] int NOT NULL,
	PRIMARY KEY ([StudentLessonID]) 
)

GO

CREATE TABLE [Horse] (
	[HorseID] int NOT NULL IDENTITY(1,1),
	[Name] varchar(50) NOT NULL,
	[VaccDate] DATETIME NOT NULL,
	PRIMARY KEY ([HorseID])
)

GO


CREATE TABLE [Teacher] (
	[TeacherID] int NOT NULL IDENTITY(1,1),
	[FirstName] varchar(60) NOT NULL,
	[LastName] varchar(60) NOT NULL,
	[Email] varchar(50) NULL,
	[Phone] varchar(14) NULL,
	PRIMARY KEY ([TeacherID]) 
)

GO

CREATE TABLE [LessonHorse] (
	[LessonHorseID] int NOT NULL IDENTITY(1,1),
	[HorseID] int NOT NULL,
	[SchedLessonID] int NOT NULL,
	PRIMARY KEY ([LessonHorseID])
)

GO



ALTER TABLE [ScheduledLesson] ADD CONSTRAINT [fk_SchedLesson_Lesson] FOREIGN KEY ([LessonID]) REFERENCES [Lesson] ([LessonID])

GO

ALTER TABLE [ScheduledLesson] ADD CONSTRAINT [fk_SchedLesson_Teacher] FOREIGN KEY ([TeacherID]) REFERENCES [Teacher] ([TeacherID])

GO

ALTER TABLE [StudentLesson] ADD CONSTRAINT [fk_StuLess_SchedLesson] FOREIGN KEY ([SchedLessonID]) REFERENCES [ScheduledLesson] ([SchedLessonID])

GO

ALTER TABLE [LessonHorse] ADD CONSTRAINT [fk_LessonHorse_Horse] FOREIGN KEY ([HorseID]) REFERENCES [Horse] ([HorseID])

GO

ALTER TABLE [StudentLesson] ADD CONSTRAINT [fk_StuLess_Student] FOREIGN KEY ([StudentID]) REFERENCES [Student] ([StudentID])

GO

ALTER TABLE [LessonHorse] ADD CONSTRAINT [fk_LessonHorse_SchedLesson] FOREIGN KEY ([SchedLessonID]) REFERENCES [ScheduledLesson] ([SchedLessonID])

GO
