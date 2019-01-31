/* 
	Emily Carlson
	770022156
	CSCI 245 Modern Datbases  
	Lab 3: Queries
	10-10-18
*/

-- LakeShore is my teacher's database that we made queries for
-- LakeShore Queries
	-- Query 1
	SELECT ROUND((AVG(CAST(pt.rating AS FLOAT))), 2) "avgRating", pt.SchTourId
		FROM PatronOnTour pt 
		WHERE pt.SchTourId IN 
			(SELECT DISTINCT(st.schTourId )
				FROM ScheduledTour st
				WHERE status = 'Complete'
				GROUP BY st.SchTourId)
		GROUP BY pt.SchTourId
		ORDER BY avgRating DESC;

	-- Query 2
	SELECT ROUND((AVG(CAST(pt.rating AS FLOAT))), 2) "Rating", pt.SchTourId
		FROM PatronOnTour pt 
		WHERE pt.SchTourId IN 
			(SELECT DISTINCT(st.schTourId )
				FROM ScheduledTour st
				WHERE status = 'Complete'
				GROUP BY st.SchTourId)
		GROUP BY pt.SchTourId
		ORDER BY 1 DESC;
	

-- My Database HorseLesson Queries	
	-- Query 1
	SELECT DISTINCT(s.StudentID), (s.LastName + ', ' + s.FirstName) AS "Student Name", l.name, schl.StartTime
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
	SELECT DISTINCT(t.TeacherID), (t.LastName + ', ' + t.FirstName) AS "Teacher Name", l.name As "Lesson Name"
		FROM Teacher t
			JOIN ScheduledLesson schl
				ON t.TeacherID = schl.TeacherID
			JOIN Lesson l
				ON schl.LessonID = l.LessonID
		WHERE l.LessonID = 5
		GROUP BY t.TeacherID, t.LastName, t.FirstName, l.name;
		
	-- Query 3
	SELECT s.StudentID, (s.LastName + ', ' + s.FirstName) AS "Student in Beginning Jumping"
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
	
	
	 