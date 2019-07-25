/* Pivoting Survey Data*/

--first we only check survey 1
/*COALESCE change the NULL (non answered value) to -1
so we know that -1 means the user didn't answer
NULL means that the question doesn't exist in this survey*/
SELECT u.UserId
	,1 as SurveyID,
	COALESCE((
		SELECT Answer_Value
		FROM Answer as a
		Where u.UserId= a.UserId
		AND a.SurveyId=1
		AND a.QuestionId=1
	),-1)as Q1,
	COALESCE((
		SELECT Answer_Value
		FROM Answer as a
		Where u.UserId= a.UserId
		AND a.SurveyId=1
		AND a.QuestionId=2
	),-1) as Q2,
	NULL as Q3
FROM [User] as u
WHERE EXISTS
(SELECT *
FROM Answer as a
WHERE a.UserId=u.UserId
AND SurveyId=1)
--Afther the first survey, we just have to put all the other survey together
--survey 2
UNION
(
SELECT u.UserId
	,2 as SurveyID,
	NULL as Q1,
	COALESCE((
		SELECT Answer_Value
		FROM Answer as a
		Where u.UserId= a.UserId
		AND a.SurveyId=2
		AND a.QuestionId=2
	),-1) as Q2,
	COALESCE((
		SELECT Answer_Value
		FROM Answer as a
		Where u.UserId= a.UserId
		AND a.SurveyId=2
		AND a.QuestionId=3
	),-1) as Q3
FROM [User] as u
WHERE EXISTS
(SELECT *
FROM Answer as a
WHERE a.UserId=u.UserId
AND SurveyId=2)
)
--Survey 3
UNION
(
SELECT u.UserId
	,3 as SurveyID,
	COALESCE((
		SELECT Answer_Value
		FROM Answer as a
		Where u.UserId= a.UserId
		AND a.SurveyId=3
		AND a.QuestionId=1
	),-1) as Q1,
	NULL as Q2,
	NULL as Q3
FROM [User] as u
WHERE EXISTS
(SELECT *
FROM Answer as a
WHERE a.UserId=u.UserId
AND SurveyId=3)
)

