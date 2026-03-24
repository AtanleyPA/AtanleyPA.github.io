USE [SQL Tasks]
GO

SELECT [Year]
      ,[Team]
      ,[NAME ]
      ,[No#]
      ,[Pos]
      ,[Ht]
      ,[Wt]
      ,[Age]
      ,[Exp]
      ,[College]
      ,[FirstName]
      ,[LastName]
      ,[Ft]
      ,[In]
      ,[Inches]
      ,[NumGrp]
  FROM [dbo].['Football Players Data$']

GO


USE [SQL Tasks]
GO

SELECT [Year]
      ,[Team]
      ,[NAME ]
      ,[No#]
      ,[Pos]
      ,[Ht]
      ,[Wt]
      ,[Age]
      ,[Exp]
      ,[College]
      ,[FirstName]
      ,[LastName]
      ,[Ft]
      ,[In]
      ,[Inches]
      ,[NumGrp]
  FROM [dbo].['Football Players Data$']

GO

--1	Write a query to find all the players in the "Arizona" team.

SELECT*
FROM[dbo].['Football Players Data$']
WHERE [Team] = 'Arizona'
       
--2	Write a query to find all the players who play as a "WR" (Wide Receiver).

SELECT*
FROM[dbo].['Football Players Data$']
WHERE[Pos] ='WR'

--3	Write a query to list all players taller than 6 feet 2 inches.

SELECT*
FROM[dbo].['Football Players Data$']
WHERE[Ht] >'6-2'

--4	Write a query to find all players who attended the "Washington" college.

SELECT*
FROM[dbo].['Football Players Data$']
WHERE [College] ='Washington'

--5	Write a query to list players who are 25 years old or younger.

SELECT*
FROM[dbo].['Football Players Data$']
WHERE [Age] <= '25'

--6	Write a query to find all players with missing Age data.

SELECT*
FROM[dbo].['Football Players Data$']
WHERE [Age] = 'N/A'

--7	Write a query to find players who are rookies (Exp = 'R').

SELECT*
FROM[dbo].['Football Players Data$']
WHERE [Exp] = 'R'

--8	Write a query to find the tallest player on the "New Orleans" team.

SELECT [Team]
       ,MAX([Ht]) As [Tallest Player] 
FROM[dbo].['Football Players Data$']
WHERE [Team] = 'New Orleans'
group by [Team]

--9	Write a query to find players weighing more than 250 pounds.

SELECT*
FROM[dbo].['Football Players Data$']
WHERE [Wt] > '250'

--10 Write a query to calculate the average height of players at each position.

SELECT*
        ,AVG([Inches]) Over (Partition by [Pos] )as [Average Height]
FROM[dbo].['Football Players Data$']


--11 Write a query to find the heaviest player for each position.

SELECT *
        ,MAX([Wt]) OVER (PARTITION BY[Pos]) AS [Heaviest Player]
FROM [dbo].['Football Players Data$']


--12 Write a query to rank players by age within their team. If two players have the same age, rank them by their weight.
  
 SELECT*
        ,RANK() OVER (PARTITION BY[Team] ORDER BY AGE, Wt) As Rank
FROM[dbo].['Football Players Data$']

--13 Write a query to calculate the average height (in inches) for all players older than 25 years.
With Dummy as
(
SELECT *
        ,Case
        When [Age] = 'N/A' then '0'
        Else [Age]
        End as Age2 
From [dbo].['Football Players Data$']
)

Select *
        ,AVG([Inches]) Over (Partition by age) As [Average Height]
From Dummy
Where [Age2] > 25

--14 Write a query to find all players whose height is greater than the average height of their respective team.

With Dummy As
(
Select *
        ,avg([Inches]) Over (Partition by[Team]) As [Team Avg Height]
From[dbo].['Football Players Data$']

)

Select *
From Dummy
Where [Inches] > [Team Avg Height]
           
    
--15 Write a query to find all players who share the same last name.

With Dummy As
(
Select* 
       ,count(*) Over (Partition by [LastName]) As [Duplicate]
From [dbo].['Football Players Data$']
)
Select *
From Dummy
Where [Duplicate] >1


--16 Write a query to find the players with the minimum height for each position.

With Dummy As
(
Select *
        ,Min([Inches]) Over (Partition by[Pos] ) As [Min Height]
From[dbo].['Football Players Data$']
)
Select *
From Dummy
where [Inches] = [Min Height]

--17 Write a query to get the number of players for each team grouped by their experience level.

Select*
      ,Count(*) Over (Partition By [Team] order by [Exp] asc) As [Experience Level]
From [dbo].['Football Players Data$']


--18 Write a query to find the tallest and shortest players from each college.



Select*
       ,Max([Inches]) Over (Partition by [College]) as [Tallest Player]
       ,Min ([Inches]) Over (Partition by [College]) As [Shortest Player]
From [dbo].['Football Players Data$']



--19 Write a query to find all players whose weight is above the average weight for their respective position.

With Dummy As
(
SELECT*
        ,AVG([Wt]) OVER (Partition by[Pos] ) As [Average Weight]
From [dbo].['Football Players Data$']
)
Select * 
From Dummy
Where [Wt] >  [Average Weight]

--20 Write a query to calculate the percentage of players in each position for every team.

With Dummy As

(

Select *
        ,Count(*) Over (Partition by [Team]) as [Total Number]
       ,Count(*) Over (Partition by [Team] order by [Pos]) as [Number per Position]
From [dbo].['Football Players Data$']

)

select *
        ,(([Number per Position]*100.0)/[Total Number]) As [% Player per Position]
From Dummy


