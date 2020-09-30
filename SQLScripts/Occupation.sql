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


