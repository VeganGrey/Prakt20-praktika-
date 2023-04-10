USE [master]
GO
/****** Object:  Database [Zakaz]    Script Date: 10.04.2023 23:07:17 ******/
CREATE DATABASE [Zakaz]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Zakaz', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Zakaz.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Zakaz_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Zakaz_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Zakaz] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Zakaz].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Zakaz] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Zakaz] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Zakaz] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Zakaz] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Zakaz] SET ARITHABORT OFF 
GO
ALTER DATABASE [Zakaz] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Zakaz] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Zakaz] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Zakaz] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Zakaz] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Zakaz] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Zakaz] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Zakaz] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Zakaz] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Zakaz] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Zakaz] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Zakaz] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Zakaz] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Zakaz] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Zakaz] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Zakaz] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Zakaz] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Zakaz] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Zakaz] SET  MULTI_USER 
GO
ALTER DATABASE [Zakaz] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Zakaz] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Zakaz] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Zakaz] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Zakaz] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Zakaz] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Zakaz] SET QUERY_STORE = OFF
GO
USE [Zakaz]
GO
/****** Object:  Table [dbo].[Tovars]    Script Date: 10.04.2023 23:07:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tovars](
	[IdTovar] [int] IDENTITY(1,1) NOT NULL,
	[TovarName] [nvarchar](50) NOT NULL,
	[PriceTovar] [int] NOT NULL,
 CONSTRAINT [PK_Tovars] PRIMARY KEY CLUSTERED 
(
	[IdTovar] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Zakazs]    Script Date: 10.04.2023 23:07:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zakazs](
	[IdZakaz] [int] IDENTITY(1,1) NOT NULL,
	[DateZakaz] [datetime] NOT NULL,
	[IdClient] [int] NOT NULL,
	[IdTovar] [int] NOT NULL,
	[Kol] [int] NULL,
 CONSTRAINT [PK_Zakazs] PRIMARY KEY CLUSTERED 
(
	[IdZakaz] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 10.04.2023 23:07:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[IdClient] [int] IDENTITY(1,1) NOT NULL,
	[ClientName] [nvarchar](50) NOT NULL,
	[City] [nvarchar](50) NULL,
	[Adress] [nvarchar](50) NULL,
	[PhoneNumber] [nchar](11) NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[IdClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Zakaziki]    Script Date: 10.04.2023 23:07:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Zakaziki]
AS
SELECT        dbo.Zakazs.IdZakaz, dbo.Zakazs.Kol * dbo.Tovars.PriceTovar AS AllPrice
FROM            dbo.Client INNER JOIN
                         dbo.Zakazs ON dbo.Client.IdClient = dbo.Zakazs.IdClient INNER JOIN
                         dbo.Tovars ON dbo.Zakazs.IdTovar = dbo.Tovars.IdTovar
GO
/****** Object:  View [dbo].[Zadanie2]    Script Date: 10.04.2023 23:07:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Zadanie2]
AS
SELECT        dbo.Client.ClientName, AVG(dbo.Tovars.PriceTovar) AS AvgSumm
FROM            dbo.Zakazs INNER JOIN
                         dbo.Tovars ON dbo.Zakazs.IdTovar = dbo.Tovars.IdTovar INNER JOIN
                         dbo.Client ON dbo.Zakazs.IdClient = dbo.Client.IdClient
GROUP BY dbo.Client.ClientName
GO
/****** Object:  View [dbo].[Zadanie3]    Script Date: 10.04.2023 23:07:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Zadanie3]
AS
SELECT        IdClient, ClientName, City, Adress, PhoneNumber
FROM            dbo.Client
WHERE        (City = 'Москва') OR
                         (City = 'Санкт-Петербург')
GO
/****** Object:  View [dbo].[Zadanie4]    Script Date: 10.04.2023 23:07:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Zadanie4]
AS
SELECT        IdTovar, TovarName, PriceTovar, PriceTovar + PriceTovar * 0.2 AS SummNDS
FROM            dbo.Tovars
GO
/****** Object:  View [dbo].[Zadanie5]    Script Date: 10.04.2023 23:07:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Zadanie5]
AS
SELECT        dbo.Client.ClientName, dbo.Zakazs.Kol * dbo.Tovars.PriceTovar AS AllSumm
FROM            dbo.Client INNER JOIN
                         dbo.Zakazs ON dbo.Client.IdClient = dbo.Zakazs.IdClient INNER JOIN
                         dbo.Tovars ON dbo.Zakazs.IdTovar = dbo.Tovars.IdTovar
WHERE        (dbo.Zakazs.Kol * dbo.Tovars.PriceTovar >
                             (SELECT        AVG(Zakazs_1.Kol * Tovars_1.PriceTovar) AS AvgSumm
                               FROM            dbo.Client AS Client_1 INNER JOIN
                                                         dbo.Zakazs AS Zakazs_1 ON Client_1.IdClient = Zakazs_1.IdClient INNER JOIN
                                                         dbo.Tovars AS Tovars_1 ON Zakazs_1.IdTovar = Tovars_1.IdTovar))
GROUP BY dbo.Client.ClientName, dbo.Zakazs.Kol * dbo.Tovars.PriceTovar
GO
/****** Object:  View [dbo].[View_1]    Script Date: 10.04.2023 23:07:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_1]
AS
SELECT        dbo.Client.ClientName, dbo.Zakazs.Kol * dbo.Tovars.PriceTovar AS AllSumm
FROM            dbo.Client INNER JOIN
                         dbo.Zakazs ON dbo.Client.IdClient = dbo.Zakazs.IdClient INNER JOIN
                         dbo.Tovars ON dbo.Zakazs.IdTovar = dbo.Tovars.IdTovar
WHERE        (dbo.Zakazs.Kol * dbo.Tovars.PriceTovar >
                             (SELECT        AVG(Zakazs_1.Kol * Tovars_1.PriceTovar) AS AvgSumm
                               FROM            dbo.Client AS Client_1 INNER JOIN
                                                         dbo.Zakazs AS Zakazs_1 ON Client_1.IdClient = Zakazs_1.IdClient INNER JOIN
                                                         dbo.Tovars AS Tovars_1 ON Zakazs_1.IdTovar = Tovars_1.IdTovar))
GROUP BY dbo.Client.ClientName, dbo.Zakazs.Kol * dbo.Tovars.PriceTovar
GO
SET IDENTITY_INSERT [dbo].[Client] ON 

INSERT [dbo].[Client] ([IdClient], [ClientName], [City], [Adress], [PhoneNumber]) VALUES (1, N'Васисилий', N'Тюмень', N'ул.Петухова,д.24', N'79207642201')
INSERT [dbo].[Client] ([IdClient], [ClientName], [City], [Adress], [PhoneNumber]) VALUES (2, N'Петр', N'Москва', N'ул.Пушкина,д2,к1', N'79006000102')
INSERT [dbo].[Client] ([IdClient], [ClientName], [City], [Adress], [PhoneNumber]) VALUES (3, N'Генадий', N'Ставрополь', N'ул.Прибоя,д.34', N'79063648712')
INSERT [dbo].[Client] ([IdClient], [ClientName], [City], [Adress], [PhoneNumber]) VALUES (4, N'Игнат', N'Казань', N'ул.Новая,д.3', N'79204127739')
INSERT [dbo].[Client] ([IdClient], [ClientName], [City], [Adress], [PhoneNumber]) VALUES (5, N'Эдуард', N'Санкт-Петербург', N'ул.Чистая,д.14,к3', N'79004520990')
INSERT [dbo].[Client] ([IdClient], [ClientName], [City], [Adress], [PhoneNumber]) VALUES (7, N'Гриша', N'Москва', N'ул.Прибоая,д2', N'79042432209')
INSERT [dbo].[Client] ([IdClient], [ClientName], [City], [Adress], [PhoneNumber]) VALUES (10, N'Матвей', N'Рязань', N'д.32', N'79065435566')
INSERT [dbo].[Client] ([IdClient], [ClientName], [City], [Adress], [PhoneNumber]) VALUES (11, N'Митя', N'Вологда', N'д3', N'79008001234')
INSERT [dbo].[Client] ([IdClient], [ClientName], [City], [Adress], [PhoneNumber]) VALUES (12, N'Петя', N'Ставрополь', N'ул.Башенная', N'79006007351')
SET IDENTITY_INSERT [dbo].[Client] OFF
GO
SET IDENTITY_INSERT [dbo].[Tovars] ON 

INSERT [dbo].[Tovars] ([IdTovar], [TovarName], [PriceTovar]) VALUES (2, N'Подушка Синтетическая', 490)
INSERT [dbo].[Tovars] ([IdTovar], [TovarName], [PriceTovar]) VALUES (3, N'Ножницы по металу', 900)
INSERT [dbo].[Tovars] ([IdTovar], [TovarName], [PriceTovar]) VALUES (4, N'Термос-кружка', 379)
INSERT [dbo].[Tovars] ([IdTovar], [TovarName], [PriceTovar]) VALUES (5, N'Чай GreenField ', 149)
SET IDENTITY_INSERT [dbo].[Tovars] OFF
GO
SET IDENTITY_INSERT [dbo].[Zakazs] ON 

INSERT [dbo].[Zakazs] ([IdZakaz], [DateZakaz], [IdClient], [IdTovar], [Kol]) VALUES (1, CAST(N'2022-02-12T00:00:00.000' AS DateTime), 1, 3, 1)
INSERT [dbo].[Zakazs] ([IdZakaz], [DateZakaz], [IdClient], [IdTovar], [Kol]) VALUES (3, CAST(N'2022-04-19T00:00:00.000' AS DateTime), 5, 5, 3)
INSERT [dbo].[Zakazs] ([IdZakaz], [DateZakaz], [IdClient], [IdTovar], [Kol]) VALUES (4, CAST(N'2022-08-04T00:00:00.000' AS DateTime), 5, 2, 3)
INSERT [dbo].[Zakazs] ([IdZakaz], [DateZakaz], [IdClient], [IdTovar], [Kol]) VALUES (5, CAST(N'2022-12-14T00:00:00.000' AS DateTime), 2, 2, 2)
INSERT [dbo].[Zakazs] ([IdZakaz], [DateZakaz], [IdClient], [IdTovar], [Kol]) VALUES (7, CAST(N'2023-01-17T13:28:58.303' AS DateTime), 2, 3, NULL)
INSERT [dbo].[Zakazs] ([IdZakaz], [DateZakaz], [IdClient], [IdTovar], [Kol]) VALUES (8, CAST(N'2023-01-17T13:36:06.940' AS DateTime), 1, 5, NULL)
INSERT [dbo].[Zakazs] ([IdZakaz], [DateZakaz], [IdClient], [IdTovar], [Kol]) VALUES (9, CAST(N'2023-01-17T13:38:48.137' AS DateTime), 1, 4, NULL)
SET IDENTITY_INSERT [dbo].[Zakazs] OFF
GO
ALTER TABLE [dbo].[Zakazs]  WITH CHECK ADD  CONSTRAINT [FK_Zakazs_Client] FOREIGN KEY([IdClient])
REFERENCES [dbo].[Client] ([IdClient])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Zakazs] CHECK CONSTRAINT [FK_Zakazs_Client]
GO
ALTER TABLE [dbo].[Zakazs]  WITH CHECK ADD  CONSTRAINT [FK_Zakazs_Tovars] FOREIGN KEY([IdTovar])
REFERENCES [dbo].[Tovars] ([IdTovar])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Zakazs] CHECK CONSTRAINT [FK_Zakazs_Tovars]
GO
/****** Object:  StoredProcedure [dbo].[AddClient]    Script Date: 10.04.2023 23:07:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddClient]
@Name nvarchar(50), @City nvarchar(50), @adress nvarchar(50), @phone nvarchar(11), @text nvarchar(max) OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	IF LEN(@Name) = 0
	SET @text= 'Введите имя!'
	ELSE BEGIN
	INSERT INTO Client (ClientName,City,Adress,PhoneNumber)
	VALUES(@Name,@City,@adress,@phone)
	END
	END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[7] 2[34] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Client"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 174
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tovars"
            Begin Extent = 
               Top = 19
               Left = 482
               Bottom = 173
               Right = 656
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Zakazs"
            Begin Extent = 
               Top = 19
               Left = 266
               Bottom = 191
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 2610
         Alias = 1680
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Zakazs"
            Begin Extent = 
               Top = 50
               Left = 372
               Bottom = 179
               Right = 546
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Tovars"
            Begin Extent = 
               Top = 98
               Left = 118
               Bottom = 211
               Right = 292
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Client"
            Begin Extent = 
               Top = 41
               Left = 634
               Bottom = 171
               Right = 808
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 2415
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Zadanie2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Zadanie2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Client"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3015
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Zadanie3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Zadanie3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tovars"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Zadanie4'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Zadanie4'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[7] 2[34] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Client"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 174
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tovars"
            Begin Extent = 
               Top = 19
               Left = 482
               Bottom = 173
               Right = 656
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Zakazs"
            Begin Extent = 
               Top = 19
               Left = 266
               Bottom = 191
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 2610
         Alias = 1680
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Zadanie5'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Zadanie5'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Client"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Zakazs"
            Begin Extent = 
               Top = 6
               Left = 462
               Bottom = 136
               Right = 636
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Tovars"
            Begin Extent = 
               Top = 1
               Left = 261
               Bottom = 114
               Right = 435
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3030
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Zakaziki'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Zakaziki'
GO
USE [master]
GO
ALTER DATABASE [Zakaz] SET  READ_WRITE 
GO
