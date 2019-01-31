--Function

USE HorseLesson
GO
-- =============================================
-- Author:		Emily Carlson
-- Create date: 12/03/2018
-- Description:	HorseLesson Function
-- =============================================


--temporal database or time series database, apache druid, do posts on this wierd int thing, on the write up


CREATE FUNCTION NumStudentsLesson 
	(@SchedLessonID INT)
	RETURNS int
AS BEGIN
    DECLARE @NumStudents INT

	SET @NumStudents = 0

    SELECT @NumStudents = COUNT([StudentLesson].StudentID)
	FROM [HorseLesson].[dbo].[StudentLesson] INNER JOIN
		[HorseLesson].[dbo].[ScheduledLesson] ON [HorseLesson].[dbo].[StudentLesson].SchedLessonId =[HorseLesson].[dbo].[ScheduledLesson].SchedLessonId 
	WHERE [StudentLesson].Present = 1 AND [StudentLesson].SchedLessonID = @SchedLessonID

    RETURN @NumStudents
END

GO




--Procedure 

USE [HorseLesson]
GO
/****** Object:  StoredProcedure [dbo].[LessonInfo]    Script Date: 12/04/18 1:52:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Emily Carlson
-- Create date: 12/03/2018
-- Description:	HorseLesson Stored procedure
-- =============================================
CREATE PROCEDURE [dbo].[LessonInfo]  
	@LessonID INT
AS
BEGIN
	SET NOCOUNT ON;

	IF @LessonID is null
		SET @LessonID = 1

	SELECT [Lesson].LessonID, [Lesson].Name, [ScheduledLesson].StartTime, [dbo].[NumStudentsLesson](ScheduledLesson.SchedLessonID) AS "Number of Students"
	FROM [HorseLesson].[dbo].[Lesson] INNER JOIN
		[HorseLesson].[dbo].[ScheduledLesson] ON [HorseLesson].[dbo].[Lesson].LessonID =[HorseLesson].[dbo].[ScheduledLesson].LessonID
	WHERE [Lesson].LessonID = @LessonID
	ORDER By [ScheduledLesson].StartTime
END


execute [HorseLesson].[dbo].LessonInfo
		@LessonID = 1
