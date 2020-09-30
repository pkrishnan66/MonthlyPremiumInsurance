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


