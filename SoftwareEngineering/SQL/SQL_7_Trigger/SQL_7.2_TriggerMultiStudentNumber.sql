
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER Tre_StudentNumberGeneration 
   ON  dbo.Applicant 
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

	-- We can immediatly prevent a nested call (UPDATE Applicant below)
	-- By checking the system variable @@NESTLEVEL, here should = 1
	IF @@NESTLEVEL < 2
	BEGIN

		DECLARE @nRowCount int;
		SET @nRowCount = (SELECT COUNT(*) FROM inserted);

		IF UPDATE(ApplicationStatus) AND @nRowCount > 0
		BEGIN

			-- CURSORS ARE THE ONLY VAR TYPE WITHOUT @ IN FRONT OF THEIR NAMES
			-- PREPARING THE CURSOR SCHEMA AND UNDERLYING RESULTSET
			DECLARE updatedCursor CURSOR FOR
					SELECT email, ApplicationStatus, StudentNumber, CohortName
					 FROM inserted;

			OPEN updatedCursor;
			FETCH NEXT FROM updatedCursor INTO @currentEmail,
												@currentApplicationStatus,
												@currentStudentNumber,
												@currentCohortName;
			-- @@FETCH_STATUS VALUE IS LOCALISED TO YOUR CURRENT CURSOR
			-- IS = 0WHEN THE LAST FETCH WAS SUCCESFUL IN RETRIEVING A ROW
			-- <> 0 MEANS NOTHING LEFT IN THE RESULTSET  
			WHILE @@FETCH_STATUS = 0
			BEGIN		

				IF @currentApplicationStatus = 2 AND @currentStudentNumber IS NULL
				BEGIN
						SET @currentCohortYear = 
							REPLACE( REPLACE(LOWER(@currentCohortName), 'autumn', ''),
												'spring', '') 
								
						SET @currentCohortYear = LTRIM(RTRIM(@currentCohortYear));
						SET @lastSequenceNumber = ( SELECT COALESCE( MAX( 
							CAST(RIGHT(CAST(StudentNumber as nvarchar), 3) as int) 
							), 0) + 1
						FROM Applicant
						WHERE StudentNumber LIKE CONCAT(@currentCohortYear, '%')
						)
						
						-- OK, we have everything, let's update the table
						BEGIN TRANSACTION;
						BEGIN TRY
							UPDATE Applicant
							SET StudentNumber = 
								CAST(@currentCohortYear + FORMAT(@lastSequenceNumber, '00#')
										as int)
							WHERE email = @currentEmail;
							COMMIT;
						END TRY
						
						BEGIN CATCH
							-- Look at this pasge for the meaning of all the error description
							-- https://docs.microsoft.com/en-us/sql/t-sql/language-elements/try-catch-transact-sql
							SELECT  ERROR_NUMBER() AS ErrorNumber  
									,ERROR_SEVERITY() AS ErrorSeverity  
									,ERROR_STATE() AS ErrorState  
									,ERROR_PROCEDURE() AS ErrorProcedure  
									,ERROR_LINE() AS ErrorLine  
									,ERROR_MESSAGE() AS ErrorMessage;
							ROLLBACK;
						END CATCH;

				END; 
				FETCH NEXT FROM updatedCursor INTO @currentEmail,
												@currentApplicationStatus,
												@currentStudentNumber,
												@currentCohortName;
			
			END; --WHILE @@FETCH_STATUS =0

			CLOSE updatedCursor;
			DEALLOCATE updatedCursor;

		END; --IF UPDATE(ApplicationStatus)
	END; -- IF @@NESTLEVEL > 2
END
GO
