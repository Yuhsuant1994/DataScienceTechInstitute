/*programmatic SQL*/

--generate random User: GUID (converte into varchar)
--select Newid()
DECLARE @nbofUserToCreate int;
DECLARE @i int;

SET @nbofUserToCreate=50;
SET @i=0;

While @i<@nbofUserToCreate
BEGIN
	INSERT INTO [User](User_Name,User_Email)
	Values(NEWID(),NEWID())
	SET @i =@i+1
END