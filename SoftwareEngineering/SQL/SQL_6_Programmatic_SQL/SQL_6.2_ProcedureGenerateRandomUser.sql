SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE CreateRandomUser
	@nbofUserToCreate int=50
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	DECLARE @i int;
	SET @i=0;

	While @i<@nbofUserToCreate
	BEGIN
		INSERT INTO [User](User_Name,User_Email)
		Values(NEWID(),NEWID())
		SET @i =@i+1
	END
END
GO
