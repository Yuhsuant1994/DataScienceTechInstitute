
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER Tre_StudentNumberGeneration 
   ON  dbo.Applicat 
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @currentApplicationStatus int;
	DECLARE @currentStudentNumber int;
	DECLARE @currentCohortYear nvarchar(100);
	DECLARE @lastSequenceNumber int;
	DECLARE @currentEmail nvarchar(100);
    -- Insert statements for trigger here
	IF UPDATE(Status) 
	BEGIN
		
		SET @currentApplicationStatus =(SELECT ApplicationStatus FROM inserted );
		SET @currentStudentNumber=(SELECT StudentNumber FROM inserted );
		
		-- CARRY ON ONLY IF ApplicationStatus == 2: "Accepted"
		IF @currentApplicationStatus = 2 AND @currentStudentNumber IS NULL
		BEGIN
			SET @currentEmail = (select email from inserted);
			
			--Clean Cohort year
			SET @currentCohortYear = (
					SELECT REPLACE( REPLACE(LOWER(CohortName), 'autumn', ''),
									'spring', '') 
					FROM inserted);
			SET @currentCohortYear = LTRIM(RTRIM(@currentCohortYear));

			SET @lastSequenceNumber = ( SELECT COALESCE( MAX( 
				CAST(RIGHT(CAST(StudentNumber as nvarchar), 3) as int) 
				), 0) + 1
			FROM Applicant
			WHERE StudentNumber LIKE CONCAT(@currentCohortYear, '%')
			)
				
			-- OK, we have everything, let's update the table
			UPDATE Applicant
			SET StudentNumber = 
				CAST(@currentCohortYear + FORMAT(@lastSequenceNumber, '00#')
						as int)
			WHERE email = @currentEmail;

		END
	END
END
GO
