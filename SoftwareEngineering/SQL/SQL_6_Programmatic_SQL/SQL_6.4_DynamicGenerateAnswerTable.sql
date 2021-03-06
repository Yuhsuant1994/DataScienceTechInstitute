USE [Survey_Sample_A18]
GO
/****** Object:  StoredProcedure [dbo].[getAllSurveyAnswerData]    Script Date: 01/06/2019 10:38:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[getAllSurveyAnswerData] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @strTemplateUnionBase nvarchar(max);
	DECLARE @currentSurveyId int;
	DECLARE @strCurrentUnionBloc nvarchar(max);
	DECLARE @strFinalQuery nvarchar(max);

	DECLARE @MaxSurveyId int;
	DECLARE @loop int;

	DECLARE @strQueryCoalesceAnswerColumn nvarchar(max);
	DECLARE @strQueryNullAnswerColumn varchar(max);

	SET @strFinalQuery = '';
	
	SET @MaxSurveyId = (SELECT MAX(SurveyId) FROM Survey);
	SET @loop = 1;

	SET @strQueryCoalesceAnswerColumn = '
	COALESCE(	(
								SELECT	Answer_Value
								FROM	Answer as a
								WHERE	a.UserId = u.UserId
										AND a.SurveyId = <SURVEY_ID>
										AND a.QuestionId = <QUESTION_ID>
							), -1) AS A<QUESTION_ID> ' ;
	SET @strQueryNullAnswerColumn = ' NULL as A<QUESTION_ID> '


	SET @strTemplateUnionBase ='
	(
		SELECT
				UserId,
				<SURVEY_ID> as SurveyId,
				<DYNAMIC_QUESTIONS>
		FROM
				[User] as u
		WHERE EXISTS
		(
			SELECT *
			FROM Answer as a
			WHERE
				u.UserId = a.UserId
				AND a.SurveyId = <SURVEY_ID>
		)
	)';
	DECLARE surveyCursor CURSOR FOR
					SELECT	SurveyId
					FROM	Survey
					ORDER BY SurveyId;
	OPEN surveyCursor;

	FETCH NEXT FROM surveyCursor INTO @currentSurveyId;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- BODY OF OUTER LOOP, OVER ALL THE SURVEYS

		--FOR THE @currentSurveyId, let's extract the relevant questions
 
		DECLARE currentQuestionsCursor CURSOR FOR
				SELECT *
				FROM
				(
					SELECT
						SurveyId,
						QuestionId,
						1 as InSurvey
					FROM
						SurveyStructure
					WHERE
						SurveyId = @currentSurveyId
					UNION
					SELECT 
						@currentSurveyId as SurveyId,
						Q.QuestionId,
						0 as InSurvey
					FROM
						Question as Q
					WHERE NOT EXISTS
					(
						SELECT *
						FROM SurveyStructure as S
						WHERE S.SurveyId = @currentSurveyId AND S.QuestionId = Q.QuestionId
					)
				) as t
				ORDER BY QuestionId;

		DECLARE @currentSurveyIdInQuestion int;
		DECLARE @currentQuestionId int;
		DECLARE @currentInSurvey int;

		OPEN currentQuestionsCursor;
		FETCH NEXT FROM currentQuestionsCursor INTO @currentSurveyIdInQuestion,
												@currentQuestionId,
												@currentInSurvey;
		DECLARE @strColumnsQuery nvarchar(max);
		SET @strColumnsQuery = '';
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- INNER LOOP FOR COLUMN PROCESSING
			

			IF @currentInSurvey = 0 -- QUESTION NOT UN SURVEY
			BEGIN
				SET @strColumnsQuery = @strColumnsQuery + 
				REPLACE(@strQueryNullAnswerColumn,'<QUESTION_ID>', @currentQuestionId); 
			END
			ELSE -- The Question is in the survey
			BEGIN
				SET @strColumnsQuery = @strColumnsQuery + 
				REPLACE(@strQueryCoalesceAnswerColumn,'<QUESTION_ID>', @currentQuestionId);
			END;

			FETCH NEXT FROM currentQuestionsCursor INTO @currentSurveyIdInQuestion,
												@currentQuestionId,
												@currentInSurvey;
			-- IF MORE ROWS ARE TO COME FOR THE CURSOR, PAD a COMMA IN THE STRING
			IF @@FETCH_STATUS = 0
			BEGIN
				SET @strColumnsQuery = @strColumnsQuery + ' , ';
			END;
		END; -- END OF WHILE INNER LOOP
		
		--BACK IN OUTER LOOP ON SURVEYS
		CLOSE currentQuestionsCursor;
		DEALLOCATE currentQuestionsCursor;

		
		SET @strCurrentUnionBloc = REPLACE(@strTemplateUnionBase,
							'<DYNAMIC_QUESTIONS>', @strColumnsQuery);
		
		SET @strCurrentUnionBloc = REPLACE(@strCurrentUnionBloc, 
										'<SURVEY_ID>',
										convert(nvarchar(max), @currentSurveyId)
										);

		SET @strFinalQuery = @strFinalQuery + @strCurrentUnionBloc
		

		FETCH NEXT FROM surveyCursor INTO @currentSurveyId;
		IF @@FETCH_STATUS = 0
		BEGIN
			SET @strFinalQuery = @strFinalQuery + ' UNION '
		END;
	
	END;
	
	close surveyCursor;
	deallocate surveyCursor;

	--SELECT @strFinalQuery;

	EXEC sp_executesql @strFinalQuery;
    
END