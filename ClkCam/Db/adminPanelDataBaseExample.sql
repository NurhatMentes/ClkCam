USE [master]
GO
/****** Object:  Database [ClkCamDB]    Script Date: 05.05.2022 19:25:39 ******/
CREATE DATABASE [ClkCamDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'StarWork', FILENAME = N'C:\Users\yunus\StarWork.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'StarWork_log', FILENAME = N'C:\Users\yunus\StarWork_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ClkCamDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ClkCamDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ClkCamDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ClkCamDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ClkCamDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ClkCamDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ClkCamDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ClkCamDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ClkCamDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ClkCamDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ClkCamDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ClkCamDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ClkCamDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ClkCamDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ClkCamDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ClkCamDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ClkCamDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ClkCamDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ClkCamDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ClkCamDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ClkCamDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ClkCamDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ClkCamDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ClkCamDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ClkCamDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ClkCamDB] SET  MULTI_USER 
GO
ALTER DATABASE [ClkCamDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ClkCamDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ClkCamDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ClkCamDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ClkCamDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ClkCamDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ClkCamDB] SET QUERY_STORE = OFF
GO
USE [ClkCamDB]
GO
/****** Object:  Table [dbo].[AboutUs]    Script Date: 05.05.2022 19:25:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AboutUs](
	[AboutUsId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_AboutUs] PRIMARY KEY CLUSTERED 
(
	[AboutUsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 05.05.2022 19:25:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[AdminId] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](50) NOT NULL,
	[Job] [nvarchar](50) NULL,
	[Phone] [nvarchar](10) NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[RePassword] [nvarchar](50) NOT NULL,
	[Auth] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[AdminId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdminLog]    Script Date: 05.05.2022 19:25:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminLog](
	[AdminLogId] [int] IDENTITY(1,1) NOT NULL,
	[AdminId] [int] NOT NULL,
	[State] [nvarchar](20) NULL,
	[LogDate] [datetime] NULL,
 CONSTRAINT [PK_AdminLog] PRIMARY KEY CLUSTERED 
(
	[AdminLogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Blog]    Script Date: 05.05.2022 19:25:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blog](
	[BlogId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[ImgUrl] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Blog] PRIMARY KEY CLUSTERED 
(
	[BlogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 05.05.2022 19:25:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NULL,
	[Description] [nvarchar](50) NULL,
	[ImgUrl] [ntext] NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 05.05.2022 19:25:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[CommentId] [int] IDENTITY(1,1) NOT NULL,
	[BlogId] [int] NOT NULL,
	[FirstLastName] [nvarchar](max) NOT NULL,
	[Email] [nvarchar](max) NOT NULL,
	[CommentContent] [nvarchar](max) NOT NULL,
	[Confirmation] [bit] NOT NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[CommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 05.05.2022 19:25:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](
	[ContactId] [int] IDENTITY(1,1) NOT NULL,
	[Adress] [nvarchar](max) NOT NULL,
	[Tel] [nvarchar](10) NULL,
	[Email] [nvarchar](max) NOT NULL,
	[EmailPassword] [nvarchar](50) NOT NULL,
	[Whatsapp] [nvarchar](max) NULL,
	[Facebook] [nvarchar](max) NULL,
	[Twitter] [nvarchar](max) NULL,
	[Instagram] [nvarchar](max) NULL,
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[ContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HomeVideo]    Script Date: 05.05.2022 19:25:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HomeVideo](
	[HomeVideoId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](70) NULL,
	[Description] [nvarchar](100) NOT NULL,
	[VideoUrl] [nvarchar](max) NULL,
 CONSTRAINT [PK_HomeVideo] PRIMARY KEY CLUSTERED 
(
	[HomeVideoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Service]    Script Date: 05.05.2022 19:25:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Service](
	[ServiceId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](150) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Tag] [nvarchar](max) NULL,
	[ImgUrl] [nvarchar](max) NULL,
 CONSTRAINT [PK_Service] PRIMARY KEY CLUSTERED 
(
	[ServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SiteIdentity]    Script Date: 05.05.2022 19:25:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SiteIdentity](
	[IdentityId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NULL,
	[Keywords] [nvarchar](200) NULL,
	[Description] [nvarchar](max) NULL,
	[LogoUrl] [nvarchar](max) NULL,
 CONSTRAINT [PK_SiteIdentity] PRIMARY KEY CLUSTERED 
(
	[IdentityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Slider]    Script Date: 05.05.2022 19:25:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Slider](
	[SliderId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](30) NULL,
	[Description] [nvarchar](max) NULL,
	[ImgUrl] [nvarchar](max) NULL,
 CONSTRAINT [PK_Slider] PRIMARY KEY CLUSTERED 
(
	[SliderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubCategory]    Script Date: 05.05.2022 19:25:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubCategory](
	[SubCategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NULL,
	[SubCategoryName] [nvarchar](50) NOT NULL,
	[ImgUrl] [ntext] NULL,
 CONSTRAINT [PK_SubCategory] PRIMARY KEY CLUSTERED 
(
	[SubCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SystemAdmin]    Script Date: 05.05.2022 19:25:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemAdmin](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SystemAdmin] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Admin] ON 

INSERT [dbo].[Admin] ([AdminId], [FullName], [Job], [Phone], [Email], [Password], [RePassword], [Auth]) VALUES (1, N'StarWork - Admin', N'Yönetici', N'0555555551', N'starwork-it@outlook.com', N'6C246C2D1EC0997E5E8D3F2689E0A901', N'6C246C2D1EC0997E5E8D3F2689E0A901', N'Admin')
SET IDENTITY_INSERT [dbo].[Admin] OFF
GO
SET IDENTITY_INSERT [dbo].[AdminLog] ON 

INSERT [dbo].[AdminLog] ([AdminLogId], [AdminId], [State], [LogDate]) VALUES (5, 1, N'Giriş Yapıldı', CAST(N'2022-05-05T19:17:44.603' AS DateTime))
INSERT [dbo].[AdminLog] ([AdminLogId], [AdminId], [State], [LogDate]) VALUES (6, 1, N'Çıkış Yapıldı', CAST(N'2022-05-05T19:17:51.973' AS DateTime))
INSERT [dbo].[AdminLog] ([AdminLogId], [AdminId], [State], [LogDate]) VALUES (7, 1, N'Giriş Yapıldı', CAST(N'2022-05-05T19:17:54.027' AS DateTime))
SET IDENTITY_INSERT [dbo].[AdminLog] OFF
GO
SET IDENTITY_INSERT [dbo].[Blog] ON 

INSERT [dbo].[Blog] ([BlogId], [CategoryId], [Title], [Content], [ImgUrl]) VALUES (2, 1, N'Test', N'Test', N'test')
SET IDENTITY_INSERT [dbo].[Blog] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryId], [CategoryName], [Description], [ImgUrl]) VALUES (1, N'Kulaklık', N'Kulak üstü kulaklık', N'/Uploads/Category/67cf44ea-24c1-4b54-9f5f-f85e9032220d.jpg')
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [Description], [ImgUrl]) VALUES (2, N'Saat', N'Akıllı saat', N'/Uploads/Category/0a65dcc9-798b-4baa-aa23-377a84a6203b.jpg')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([CommentId], [BlogId], [FirstLastName], [Email], [CommentContent], [Confirmation]) VALUES (3, 2, N'etst', N'REWTR', N'erwr', 0)
SET IDENTITY_INSERT [dbo].[Comment] OFF
GO
SET IDENTITY_INSERT [dbo].[Service] ON 

INSERT [dbo].[Service] ([ServiceId], [Title], [Description], [Tag], [ImgUrl]) VALUES (1, N'Cam değişimi', N'<p>ititna ile cam değdjashdjkashkdkjhasjkdajsdhajs dhasjdhasjkhdkjashdjkhaskdjhakshdjshfkdja shfjkdsahfgafhjgafhgdfghsdgf hgsdafgdshgfhjgdsfhjgds fhjgdsfhjgdshfgdshfgdshgfhdsgfhsdgfhjgsdfhgsdfkgjsdafgdsahfgd shfhdsfaggfdaskgfghkahadskhgdsahadskhdaskadsdgsah gdskgdskghdsakh fakhgfahgfjfahgakdsaghkadskghfkghsdfhkdsaghjfashfgsadhg fhFGHajfghjgsfdsugfhdsGFHAJFHSFHGHAHJGDSFHJFHJGFDHJAGFHJ GFHJAGFHGFSDAFGSDAFGGFASGFASDHFDHSFGFDSHFGSFHJGDSFHJ GDFHJDSGFHJGSDFHJGDSAFHJAFHJF HJFHJFHJFGHJGFHJGDFHJGDSFHAGFHAJGFGDFHJişim<strong>i yapılır</strong></p>
', N'cam,ekran,telefon', N'/Uploads/Service/1e364a01-8c8f-4c53-adb4-8e58b20a0385.jpg')
SET IDENTITY_INSERT [dbo].[Service] OFF
GO
SET IDENTITY_INSERT [dbo].[SubCategory] ON 

INSERT [dbo].[SubCategory] ([SubCategoryId], [CategoryId], [SubCategoryName], [ImgUrl]) VALUES (2, 2, N'Akıllı Saatt', N'/Uploads/SubCategory/b7d9c7aa-16e1-4146-be9e-b746484e78bf.jpg')
INSERT [dbo].[SubCategory] ([SubCategoryId], [CategoryId], [SubCategoryName], [ImgUrl]) VALUES (3, 1, N'Kulak üstü', N'/Uploads/SubCategory/d6c55ec0-a265-4810-8cb0-2516d5dc0746.jpg')
SET IDENTITY_INSERT [dbo].[SubCategory] OFF
GO
ALTER TABLE [dbo].[Comment] ADD  CONSTRAINT [DF_Comment_Confirmation]  DEFAULT ((0)) FOR [Confirmation]
GO
ALTER TABLE [dbo].[AdminLog]  WITH CHECK ADD  CONSTRAINT [FK_AdminLog_Admin] FOREIGN KEY([AdminId])
REFERENCES [dbo].[Admin] ([AdminId])
GO
ALTER TABLE [dbo].[AdminLog] CHECK CONSTRAINT [FK_AdminLog_Admin]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Blog] FOREIGN KEY([BlogId])
REFERENCES [dbo].[Blog] ([BlogId])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Blog]
GO
ALTER TABLE [dbo].[SubCategory]  WITH CHECK ADD  CONSTRAINT [FK_SubCategory_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[SubCategory] CHECK CONSTRAINT [FK_SubCategory_Category]
GO
USE [master]
GO
ALTER DATABASE [ClkCamDB] SET  READ_WRITE 
GO
