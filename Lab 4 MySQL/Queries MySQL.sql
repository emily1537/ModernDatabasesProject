/* 
	Emily Carlson
	770022156
	CSCI 245 Modern Datbases  
	Lab 4: Queries
	10-22-18
*/

-- LakeShore is my teacher's database that we made queries for
-- LakeShore Queries
	-- Query 1
	SELECT DISTINCT(c.CrewId), CONCAT(c.LastName, ', ', c.FirstName) AS "Crew Name", b.Name As "Boat Name"
		FROM Crew c
			JOIN ScheduledCrew schlcr
				ON c.CrewId = schlcr.CrewId
			JOIN ScheduledTour schltr
				ON schlcr.SchTourId = schltr.SchTourId
			JOIN Boat b 
				ON schltr.BoatId = b.BoatId
		WHERE b.boatId = 8
		GROUP BY c.CrewId, c.LastName, c.FirstName, b.Name;

	-- Query 2
	SELECT DISTINCT(b.Name) "Boat", t.Name "Tour"
		FROM Boat b
			JOIN ScheduledTour schltr
				ON b.BoatId = schltr.BoatId
			JOIN Tour t
				ON schltr.TourId = t.TourId
		WHERE t.TourId = 3;
	

-- My Database HorseLesson Queries	
	-- Query 1
	SELECT DISTINCT(s.StudentID), CONCAT(s.FirstName, ' ', s.LastName) AS "Student Name", l.name
		FROM Student s
			JOIN StudentLesson sl
				ON s.StudentID = sl.StudentID
			JOIN ScheduledLesson schl
				ON sl.SchedLessonID = schl.SchedLessonID
			JOIN Lesson l
				ON schl.LessonID = l.LessonID
		WHERE schl.LessonID = 1
		GROUP BY l.name, schl.StartTime, s.LastName, s.FirstName, s.StudentID;
	
	-- Query 2
	SELECT DISTINCT(t.TeacherID), CONCAT(t.LastName, ', ', t.FirstName) AS "Teacher Name", l.name As "Lesson Name"
		FROM Teacher t
			JOIN ScheduledLesson schl
				ON t.TeacherID = schl.TeacherID
			JOIN Lesson l
				ON schl.LessonID = l.LessonID
		WHERE l.LessonID = 5
		GROUP BY t.TeacherID, t.LastName, t.FirstName, l.name;
		
	-- Query 3
	SELECT s.StudentID, CONCAT(s.LastName, ', ', s.FirstName) AS "Student in Beginning Jumping"
		FROM Student s
			JOIN StudentLesson sl
				ON s.StudentID = sl.StudentID
		WHERE sl.SchedLessonID IN
			(SELECT schl.SchedLessonID
				FROM ScheduledLesson schl
				WHERE schl.LessonID = 4)
			AND sl.Present = 1
		ORDER BY s.LastName, s.FirstName;
	
	-- Query 4
	SELECT COUNT(DISTINCT(lh.HorseID)) "Number of Lessons", h.name "Horse Name"
		FROM Horse h
			JOIN LessonHorse lh
				ON h.HorseId = lh.HorseID
		GROUP BY h.name
		HAVING COUNT(DISTINCT(lh.HorseID)) > 1;
		
	-- Query 5
	SELECT h.name "Horse", l.name "Lesson"
		FROM Horse h
			JOIN LessonHorse lh
				ON h.HorseId = lh.HorseID
			JOIN ScheduledLesson schl
				ON lh.SchedLessonID = schl.SchedLessonID
			JOIN Lesson l
				ON schl.LessonID = l.LessonID
		WHERE schl.LessonID = 1;
	
	
	 