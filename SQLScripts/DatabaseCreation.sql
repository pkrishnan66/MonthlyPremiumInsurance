USE [master]
GO

/****** Object:  Database [TALPremiumInsurance]    Script Date: 01-10-2020 00:11:00 ******/
CREATE DATABASE [TALPremiumInsurance]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TALPremiumInsurance', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\TALPremiumInsurance.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TALPremiumInsurance_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\TALPremiumInsurance_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [TALPremiumInsurance] SET COMPATIBILITY_LEVEL = 110
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TALPremiumInsurance].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [TALPremiumInsurance] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [TALPremiumInsurance] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [TALPremiumInsurance] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [TALPremiumInsurance] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [TALPremiumInsurance] SET ARITHABORT OFF 
GO

ALTER DATABASE [TALPremiumInsurance] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [TALPremiumInsurance] SET AUTO_CREATE_STATISTICS ON 
GO

ALTER DATABASE [TALPremiumInsurance] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [TALPremiumInsurance] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [TALPremiumInsurance] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [TALPremiumInsurance] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [TALPremiumInsurance] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [TALPremiumInsurance] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [TALPremiumInsurance] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [TALPremiumInsurance] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [TALPremiumInsurance] SET  DISABLE_BROKER 
GO

ALTER DATABASE [TALPremiumInsurance] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [TALPremiumInsurance] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [TALPremiumInsurance] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [TALPremiumInsurance] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [TALPremiumInsurance] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [TALPremiumInsurance] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [TALPremiumInsurance] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [TALPremiumInsurance] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [TALPremiumInsurance] SET  MULTI_USER 
GO

ALTER DATABASE [TALPremiumInsurance] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [TALPremiumInsurance] SET DB_CHAINING OFF 
GO

ALTER DATABASE [TALPremiumInsurance] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [TALPremiumInsurance] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO

ALTER DATABASE [TALPremiumInsurance] SET  READ_WRITE 
GO


USE [TALPremiumInsurance]
GO

/****** Object:  Table [dbo].[OccupationRating]    Script Date: 01-10-2020 00:06:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[OccupationRating](
	[OccupationRatingId] [int] IDENTITY(1,1) NOT NULL,
	[Rating] [varchar](20) NOT NULL,
	[Factor] [decimal](4, 2) NOT NULL,
 CONSTRAINT [PK_OccupationRating] PRIMARY KEY CLUSTERED 
(
	[OccupationRatingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO
USE [TALPremiumInsurance]
GO

/****** Object:  Table [dbo].[Occupation]    Script Date: 01-10-2020 00:06:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Occupation](
	[OccupationId] [int] IDENTITY(1,1) NOT NULL,
	[Occupation] [varchar](10) NOT NULL,
	[OccupationRatingId] [int] NOT NULL,
 CONSTRAINT [PK_Occupation] PRIMARY KEY CLUSTERED 
(
	[OccupationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Occupation]  WITH CHECK ADD  CONSTRAINT [FK_Occupation_OccupationRating] FOREIGN KEY([OccupationRatingId])
REFERENCES [dbo].[OccupationRating] ([OccupationRatingId])
GO

ALTER TABLE [dbo].[Occupation] CHECK CONSTRAINT [FK_Occupation_OccupationRating]
GO


USE [TALPremiumInsurance]
GO

/****** Object:  Table [dbo].[ClientPremium]    Script Date: 01-10-2020 00:06:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[ClientPremium](
	[ClientPremiumId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Age] [int] NOT NULL,
	[DateOfBirth] [datetime] NOT NULL,
	[OccupationId] [int] NOT NULL,
	[DeathSumInsured] [decimal](10, 2) NOT NULL,
	[MonthlyPremium] [decimal](10, 2) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[ClientPremiumId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[ClientPremium]  WITH CHECK ADD  CONSTRAINT [FK_Client_Occupation] FOREIGN KEY([OccupationId])
REFERENCES [dbo].[Occupation] ([OccupationId])
GO

ALTER TABLE [dbo].[ClientPremium] CHECK CONSTRAINT [FK_Client_Occupation]
GO


INSERT INTO [dbo].OccupationRating values (
'Professional', 1.0)
INSERT INTO [dbo].OccupationRating values (
'White Collar', 1.25)
INSERT INTO [dbo].OccupationRating values (
'Light Manual', 1.50)
INSERT INTO [dbo].OccupationRating values (
'Heavy Manual', 1.75)

Select * from OccupationRating

INSERT INTO [dbo].Occupation values ('Cleaner',3)
INSERT INTO [dbo].Occupation values ('Doctor',1)
INSERT INTO [dbo].Occupation values ('Author',2)
INSERT INTO [dbo].Occupation values ('Farmer',4)
INSERT INTO [dbo].Occupation values ('Mechanic',4)
INSERT INTO [dbo].Occupation values ('Florist',3)

INSERT INTO [dbo].ClientPremium values ('Prashanth','37','12/09/1983',4,10000.00 ,210.00,1)
INSERT INTO [dbo].ClientPremium values ('Nishanth','36','12/09/1984',4,10000.00 ,210.00,1)
INSERT INTO [dbo].ClientPremium values ('Prashanth','37','12/09/1983',4,10000.00 ,210.00,1)
INSERT INTO [dbo].ClientPremium values ('Virender','41','11/11/1978',1,134560.00 ,99305.28,1)
INSERT INTO [dbo].ClientPremium values ('Prasad','41','01/11/1978',2,14560.00 ,7163.52,1)


