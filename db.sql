USE [master]
GO
/****** Object:  Database [TextGit]    Script Date: 01.05.2018 08:15:21 ******/
CREATE DATABASE [TextGit]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TextGit', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\TextGit.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TextGit_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\TextGit_log.ldf' , SIZE = 1280KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TextGit] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TextGit].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TextGit] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TextGit] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TextGit] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TextGit] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TextGit] SET ARITHABORT OFF 
GO
ALTER DATABASE [TextGit] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TextGit] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TextGit] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TextGit] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TextGit] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TextGit] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TextGit] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TextGit] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TextGit] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TextGit] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TextGit] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TextGit] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TextGit] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TextGit] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TextGit] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TextGit] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TextGit] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TextGit] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TextGit] SET  MULTI_USER 
GO
ALTER DATABASE [TextGit] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TextGit] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TextGit] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TextGit] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [TextGit] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'TextGit', N'ON'
GO
ALTER DATABASE [TextGit] SET QUERY_STORE = OFF
GO
USE [TextGit]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [TextGit]
GO
/****** Object:  Table [dbo].[Documents]    Script Date: 01.05.2018 08:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Documents](
	[DocumentID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Documents] PRIMARY KEY CLUSTERED 
(
	[DocumentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Versions]    Script Date: 01.05.2018 08:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Versions](
	[VersionID] [int] IDENTITY(1,1) NOT NULL,
	[ChangeNote] [varchar](50) NULL,
	[DocumentContent] [text] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[fkDocumentID] [int] NOT NULL,
 CONSTRAINT [PK_Versions] PRIMARY KEY CLUSTERED 
(
	[VersionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Documents] ON 

INSERT [dbo].[Documents] ([DocumentID], [Title]) VALUES (1, N'Test 1')
INSERT [dbo].[Documents] ([DocumentID], [Title]) VALUES (4, N'Lorem Ipsum ')
SET IDENTITY_INSERT [dbo].[Documents] OFF
SET IDENTITY_INSERT [dbo].[Versions] ON 

INSERT [dbo].[Versions] ([VersionID], [ChangeNote], [DocumentContent], [CreatedAt], [fkDocumentID]) VALUES (2, N'Initial Commit', N'wow such content', CAST(N'2018-04-26T12:41:02.260' AS DateTime), 1)
INSERT [dbo].[Versions] ([VersionID], [ChangeNote], [DocumentContent], [CreatedAt], [fkDocumentID]) VALUES (3, N'Change Content', N'This is a lot longer', CAST(N'2018-04-26T13:24:29.937' AS DateTime), 1)
INSERT [dbo].[Versions] ([VersionID], [ChangeNote], [DocumentContent], [CreatedAt], [fkDocumentID]) VALUES (4, N'Add exclamation mark', N'This is a lot longer!', CAST(N'2018-04-26T14:06:02.540' AS DateTime), 1)
INSERT [dbo].[Versions] ([VersionID], [ChangeNote], [DocumentContent], [CreatedAt], [fkDocumentID]) VALUES (6, N'Add more lines', N'This is a lot longer!


Wow, multiline!', CAST(N'2018-04-26T14:21:28.940' AS DateTime), 1)
INSERT [dbo].[Versions] ([VersionID], [ChangeNote], [DocumentContent], [CreatedAt], [fkDocumentID]) VALUES (9, N'Create Document', N'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', CAST(N'2018-04-26T14:55:19.927' AS DateTime), 4)
INSERT [dbo].[Versions] ([VersionID], [ChangeNote], [DocumentContent], [CreatedAt], [fkDocumentID]) VALUES (10, N'Add second paragraph', N'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. 

Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. ', CAST(N'2018-04-26T14:55:44.473' AS DateTime), 4)
SET IDENTITY_INSERT [dbo].[Versions] OFF
ALTER TABLE [dbo].[Versions] ADD  CONSTRAINT [DF_Versions_CreatedAt]  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Versions]  WITH CHECK ADD  CONSTRAINT [FK_Versions_Documents] FOREIGN KEY([fkDocumentID])
REFERENCES [dbo].[Documents] ([DocumentID])
GO
ALTER TABLE [dbo].[Versions] CHECK CONSTRAINT [FK_Versions_Documents]
GO
USE [master]
GO
ALTER DATABASE [TextGit] SET  READ_WRITE 
GO
