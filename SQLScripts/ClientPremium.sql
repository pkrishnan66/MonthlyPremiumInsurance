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


