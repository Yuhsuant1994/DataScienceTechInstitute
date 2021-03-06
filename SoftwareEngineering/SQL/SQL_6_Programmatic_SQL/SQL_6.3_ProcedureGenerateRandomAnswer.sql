USE [Survey_Sample_A18]
GO
/****** Object:  StoredProcedure [dbo].[GenerateRandomAnswer]    Script Date: 7/25/2019 10:54:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER   PROCEDURE [dbo].[GenerateRandomAnswer] 
	@nbRows int = 10
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @currentSurveyId int;
	DECLARE @currentQuestionId int;
	DECLARE @currentUserId int;
	DECLARE @loop int;
	DECLARE @existanceCount int;

	SET @loop = 0;

	WHILE @loop < @nbRows
	BEGIN
		--Step1: select a random surveyid
		SET @currentSurveyId = (select top(1) SurveyId from Survey order by newid());
		--Step2: select a random question from the selected surveyid
		SET @currentQuestionId = (select top(1) QuestionId 
					from SurveyStructure 
					where SurveyId = @currentSurveyId  order by newid());
		--Step3: select a random user
		SET @currentUserId = (select top(1) UserId from [User] order by newid());

		--Step4: check the existence of this composition
		SET @existanceCount = (SELECT COUNT(UserId) From Answer 
							where UserId = @currentUserId
							and SurveyId = @currentSurveyId
							and QuestionId = @currentQuestionId);
		IF @existanceCount = 0
		BEGIN
			INSERT INTO [dbo].[Answer]
				   ([QuestionId] ,[SurveyId] ,[UserId] ,[Answer_Value])
			VALUES (@currentQuestionId ,@currentSurveyId ,@currentUserId ,
					convert(int, RAND()*10));
			SET @loop = @loop + 1;
		END;
		
		

	END;
END;
