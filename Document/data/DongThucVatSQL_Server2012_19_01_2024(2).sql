USE [master]
GO
/****** Object:  Database [DongThucVat]    Script Date: 19/01/2024 8:26:12 CH ******/
CREATE DATABASE [DongThucVat]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DongThucVat', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.HAUTLYM\MSSQL\DATA\DongThucVat.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DongThucVat_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.HAUTLYM\MSSQL\DATA\DongThucVat_log.ldf' , SIZE = 139264KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DongThucVat].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DongThucVat] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DongThucVat] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DongThucVat] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DongThucVat] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DongThucVat] SET ARITHABORT OFF 
GO
ALTER DATABASE [DongThucVat] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DongThucVat] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DongThucVat] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DongThucVat] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DongThucVat] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DongThucVat] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DongThucVat] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DongThucVat] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DongThucVat] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DongThucVat] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DongThucVat] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DongThucVat] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DongThucVat] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DongThucVat] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DongThucVat] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DongThucVat] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DongThucVat] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DongThucVat] SET RECOVERY FULL 
GO
ALTER DATABASE [DongThucVat] SET  MULTI_USER 
GO
ALTER DATABASE [DongThucVat] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DongThucVat] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DongThucVat] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DongThucVat] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DongThucVat', N'ON'
GO
USE [DongThucVat]
GO
/****** Object:  Schema [dongthucvat]    Script Date: 19/01/2024 8:26:12 CH ******/
CREATE SCHEMA [dongthucvat]
GO
/****** Object:  UserDefinedFunction [dongthucvat].[enum2str$user$gender]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dongthucvat].[enum2str$user$gender] 
( 
   @setval tinyint
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 1 THEN 'MALE'
            WHEN 2 THEN 'FEMALE'
            WHEN 3 THEN 'OTHER'
            ELSE ''
         END
   END
GO
/****** Object:  UserDefinedFunction [dongthucvat].[norm_enum$user$gender]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dongthucvat].[norm_enum$user$gender] 
( 
   @setval nvarchar(max)
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN dongthucvat.[enum2str$user$gender](dongthucvat.[str2enum$user$gender](@setval))
   END
GO
/****** Object:  UserDefinedFunction [dongthucvat].[str2enum$user$gender]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dongthucvat].[str2enum$user$gender] 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 'MALE' THEN 1
            WHEN 'FEMALE' THEN 2
            WHEN 'OTHER' THEN 3
            ELSE 0
         END
   END
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppRoleClaims]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AppRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppRoles]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppRoles](
	[Id] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[NormalizedName] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AppRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppUser]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppUser](
	[Id] [uniqueidentifier] NOT NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NULL,
	[CitiesId] [bigint] NULL,
	[CitiesDistrictId] [bigint] NULL,
	[Avatar] [nvarchar](max) NULL,
	[Gender] [nvarchar](max) NOT NULL,
	[Dob] [datetime2](7) NULL,
	[Address] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
	[LastSigninedTime] [datetime2](7) NULL,
	[IsAdmin] [smallint] NOT NULL,
	[Status] [smallint] NOT NULL,
	[Roles] [nvarchar](max) NOT NULL,
	[UserName] [nvarchar](max) NULL,
	[NormalizedUserName] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[NormalizedEmail] [nvarchar](max) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AppUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppUserClaims]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AppUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppUserLogins]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppUserLogins](
	[UserId] [uniqueidentifier] NOT NULL,
	[LoginProvider] [nvarchar](max) NULL,
	[ProviderKey] [nvarchar](max) NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
 CONSTRAINT [PK_AppUserLogins] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppUserRoles]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppUserRoles](
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_AppUserRoles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppUserTokens]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppUserTokens](
	[UserId] [uniqueidentifier] NOT NULL,
	[LoginProvider] [nvarchar](max) NULL,
	[Name] [nvarchar](max) NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AppUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[introduce]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[introduce](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](max) NOT NULL,
	[content] [nvarchar](max) NOT NULL,
	[CreateBy] [nvarchar](max) NOT NULL,
	[UpdateBy] [nvarchar](max) NOT NULL,
	[CreateAt] [datetime2](7) NULL,
	[UpdateAt] [datetime2](7) NULL,
	[typeNationPak] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_introduce] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[map]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[map](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[linkMap] [nvarchar](max) NOT NULL,
	[CreateBy] [nvarchar](max) NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdateBy] [nvarchar](max) NULL,
	[UpdatedAt] [datetime2](7) NULL,
 CONSTRAINT [PK_map] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
	[UpdateAt] [datetime2](7) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tour]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tour](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Alias] [nvarchar](max) NOT NULL,
	[Image] [nvarchar](max) NOT NULL,
	[ShortDescription] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[TotalView] [int] NULL,
	[SortOrder] [int] NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[Status] [smallint] NULL,
	[Author] [nvarchar](max) NOT NULL,
	[Source] [nvarchar](max) NULL,
 CONSTRAINT [PK_tour] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[banner]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[banner](
	[id] [bigint] IDENTITY(10,1) NOT NULL,
	[banner_cat_id] [int] NOT NULL,
	[name] [nvarchar](300) NULL,
	[src] [nvarchar](255) NULL,
	[src_mobile] [nvarchar](255) NULL,
	[link] [nvarchar](500) NULL,
	[width] [smallint] NULL,
	[height] [smallint] NULL,
	[type] [smallint] NULL,
	[status] [smallint] NULL,
	[multitext] [nvarchar](max) NULL,
	[description] [nvarchar](max) NULL,
	[sort_order] [int] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[language] [nvarchar](50) NULL,
	[id_related] [int] NULL,
 CONSTRAINT [PK_banner_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[banner_cat]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[banner_cat](
	[id] [bigint] IDENTITY(2,1) NOT NULL,
	[name] [nvarchar](300) NULL,
	[parent_id] [int] NOT NULL,
	[path] [nvarchar](100) NULL,
	[level] [smallint] NOT NULL,
	[image] [nvarchar](255) NULL,
	[status] [smallint] NULL,
	[description] [nvarchar](max) NULL,
	[sort_order] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
	[language] [nvarchar](50) NULL,
	[id_related] [int] NULL,
 CONSTRAINT [PK_banner_cat_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[boxpage]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[boxpage](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[boxpage_cat_id] [int] NOT NULL,
	[name] [nvarchar](255) NULL,
	[sub_name] [nvarchar](255) NULL,
	[src] [nvarchar](255) NULL,
	[link] [nvarchar](500) NULL,
	[status] [smallint] NOT NULL,
	[multitext] [nvarchar](max) NULL,
	[short_description] [nvarchar](max) NULL,
	[description] [nvarchar](max) NULL,
	[sort_order] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
	[language] [nvarchar](50) NULL,
	[id_related] [int] NULL,
 CONSTRAINT [PK_boxpage_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[boxpage_cat]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[boxpage_cat](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[language] [nvarchar](50) NULL,
	[parent_id] [int] NOT NULL,
	[path] [nvarchar](100) NULL,
	[level] [smallint] NOT NULL,
	[image] [nvarchar](255) NULL,
	[status] [smallint] NULL,
	[description] [nvarchar](max) NULL,
	[sort_order] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
	[id_related] [int] NULL,
 CONSTRAINT [PK_boxpage_cat_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[boxpage_media]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[boxpage_media](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[boxpage_id] [int] NULL,
	[name] [nvarchar](255) NULL,
	[path] [nvarchar](255) NULL,
	[path_video] [nvarchar](255) NULL,
	[type] [smallint] NULL,
	[sub_type] [smallint] NULL,
	[is_default] [smallint] NULL,
	[sort_order] [int] NULL,
	[created_at] [datetime] NULL,
 CONSTRAINT [PK_boxpage_media_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[dtv_bo]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[dtv_bo](
	[id] [bigint] IDENTITY(124,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[name_latinh] [nvarchar](255) NULL,
	[loai] [smallint] NULL,
	[id_dtv_lop] [int] NULL,
	[status] [smallint] NULL,
	[created_at] [datetime] NULL,
	[created_by] [nvarchar](max) NULL,
	[updated_at] [datetime] NULL,
	[updated_by] [nvarchar](max) NULL,
 CONSTRAINT [PK_dtv_bo_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[dtv_ho]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[dtv_ho](
	[id] [bigint] IDENTITY(272,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[name_latinh] [nvarchar](255) NULL,
	[loai] [smallint] NULL,
	[id_dtv_bo] [int] NULL,
	[status] [smallint] NULL,
	[created_at] [datetime] NULL,
	[created_by] [nvarchar](max) NULL,
	[updated_at] [datetime] NULL,
	[updated_by] [nvarchar](max) NULL,
 CONSTRAINT [PK_dtv_ho_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[dtv_loai]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[dtv_loai](
	[id] [bigint] IDENTITY(1753,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[name_latinh] [nvarchar](255) NULL,
	[loai] [smallint] NULL,
	[id_dtv_ho] [int] NULL,
	[muc_do_bao_ton_iucn] [smallint] NULL,
	[muc_do_bao_ton_sdvn] [smallint] NULL,
	[muc_do_bao_ton_ndcp] [smallint] NULL,
	[muc_do_bao_ton_nd64cp] [smallint] NULL,
	[status] [smallint] NULL,
	[created_at] [datetime] NULL,
	[created_by] [nvarchar](max) NULL,
	[updated_at] [datetime] NULL,
	[updated_by] [nvarchar](max) NULL,
 CONSTRAINT [PK_dtv_loai_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[dtv_loaiVqg]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[dtv_loaiVqg](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[IdDtvLoai] [int] NOT NULL,
	[ten_khac] [nvarchar](255) NULL,
	[dac_diem] [nvarchar](max) NULL,
	[gia_tri_su_dung] [nvarchar](max) NULL,
	[phan_bo] [nvarchar](255) NULL,
	[status] [smallint] NULL,
	[loai] [smallint] NULL,
	[file_dinh_kem] [nvarchar](max) NULL,
	[nguon_tai_lieu] [nvarchar](255) NULL,
	[created_at] [datetime] NULL,
	[created_by] [nvarchar](max) NULL,
	[updated_at] [datetime] NULL,
	[updated_by] [nvarchar](max) NULL,
	[KinhDo] [nvarchar](max) NULL,
	[ViDo] [nvarchar](max) NULL,
 CONSTRAINT [PK_dtv_lopVqg] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[dtv_lop]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[dtv_lop](
	[id] [bigint] IDENTITY(18,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[name_latinh] [nvarchar](255) NULL,
	[loai] [smallint] NULL,
	[id_dtv_nganh] [int] NULL,
	[status] [smallint] NULL,
	[created_at] [datetime] NULL,
	[created_by] [nvarchar](max) NULL,
	[updated_at] [datetime] NULL,
	[updated_by] [nvarchar](max) NULL,
 CONSTRAINT [PK_dtv_lop_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[dtv_nganh]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[dtv_nganh](
	[id] [bigint] IDENTITY(9,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[name_latinh] [nvarchar](255) NULL,
	[loai] [smallint] NULL,
	[status] [smallint] NULL,
	[created_at] [datetime] NULL,
	[created_by] [nvarchar](max) NULL,
	[updated_at] [datetime] NULL,
	[updated_by] [nvarchar](max) NULL,
 CONSTRAINT [PK_dtv_nganh_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[image_general]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[image_general](
	[id] [bigint] IDENTITY(9,1) NOT NULL,
	[object_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[name] [nvarchar](255) NULL,
	[title] [nvarchar](255) NULL,
	[type] [smallint] NOT NULL,
	[created_at] [datetime] NULL,
	[status] [smallint] NOT NULL,
	[mode] [smallint] NOT NULL,
	[id_dir] [int] NULL,
 CONSTRAINT [PK_image_general_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[image_general_directory]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[image_general_directory](
	[id] [int] IDENTITY(6,1) NOT NULL,
	[name] [varchar](32) NOT NULL,
	[parent_id] [int] NULL,
 CONSTRAINT [PK_image_general_directory_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[menus]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[menus](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[menu_group_id] [int] NULL,
	[language] [nvarchar](50) NULL,
	[type_menu] [smallint] NULL,
	[id_object] [int] NULL,
	[gen_url] [nvarchar](255) NULL,
	[name] [nvarchar](255) NULL,
	[link_menu] [nvarchar](255) NULL,
	[parent_id] [int] NULL,
	[path] [nvarchar](100) NULL,
	[level] [smallint] NULL,
	[image_hover] [nvarchar](255) NULL,
	[image] [nvarchar](255) NULL,
	[status] [smallint] NULL,
	[sort_order] [int] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[id_related] [int] NULL,
 CONSTRAINT [PK_menus_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[news]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[news](
	[id] [bigint] IDENTITY(6,1) NOT NULL,
	[root_news_cat_id] [int] NULL,
	[news_cat_id] [int] NULL,
	[name] [nvarchar](255) NULL,
	[alias] [nvarchar](255) NULL,
	[image] [nvarchar](255) NULL,
	[short_description] [nvarchar](max) NULL,
	[description] [nvarchar](max) NULL,
	[total_view] [int] NULL,
	[sort_order] [int] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[is_hot] [smallint] NULL,
	[is_system] [smallint] NULL,
	[status] [smallint] NULL,
	[author] [nvarchar](200) NULL,
	[source] [nvarchar](200) NULL,
	[post_at] [datetime] NULL,
	[title_seo] [nvarchar](300) NULL,
	[content_seo] [nvarchar](max) NULL,
	[key_seo] [nvarchar](255) NULL,
	[language] [nvarchar](50) NULL,
	[id_related] [int] NULL,
 CONSTRAINT [PK_news_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[news_cat]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[news_cat](
	[id] [bigint] IDENTITY(2,1) NOT NULL,
	[name] [nvarchar](300) NULL,
	[alias] [nvarchar](255) NULL,
	[parent_id] [int] NOT NULL,
	[path] [nvarchar](100) NULL,
	[level] [smallint] NOT NULL,
	[image] [nvarchar](255) NULL,
	[description] [nvarchar](max) NULL,
	[sort_order] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
	[status] [smallint] NOT NULL,
	[language] [nvarchar](50) NULL,
	[title_seo] [nvarchar](255) NULL,
	[content_seo] [nvarchar](max) NULL,
	[key_seo] [nvarchar](max) NULL,
	[id_related] [int] NULL,
 CONSTRAINT [PK_news_cat_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[news_cat_rel]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[news_cat_rel](
	[news_id] [bigint] NOT NULL,
	[news_cat_id] [bigint] NOT NULL,
	[created_at] [datetime] NULL,
 CONSTRAINT [PK_news_cat_rel_news_id] PRIMARY KEY CLUSTERED 
(
	[news_id] ASC,
	[news_cat_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[route_page]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[route_page](
	[id] [bigint] IDENTITY(2,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[route] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_route_page_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[seo_page]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[seo_page](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[route_id] [int] NOT NULL,
	[route_name] [nvarchar](255) NOT NULL,
	[page_title] [nvarchar](255) NULL,
	[page_keywords] [nvarchar](255) NULL,
	[page_description] [nvarchar](255) NULL,
	[face_title] [nvarchar](255) NULL,
	[face_image] [nvarchar](255) NULL,
	[face_description] [nvarchar](255) NULL,
	[multitext] [nvarchar](max) NULL,
	[language] [nvarchar](50) NULL,
	[id_related] [int] NULL,
 CONSTRAINT [PK_seo_page_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[site_contact]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[site_contact](
	[id] [bigint] IDENTITY(3,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[link_logo] [nvarchar](255) NULL,
	[link_logo_footer] [nvarchar](255) NULL,
	[email] [nvarchar](255) NULL,
	[phone] [nvarchar](255) NULL,
	[hotline] [nvarchar](255) NULL,
	[fax] [nvarchar](255) NULL,
	[address] [nvarchar](255) NULL,
	[link_face] [nvarchar](255) NULL,
	[link_insta] [nvarchar](255) NULL,
	[link_youtube] [nvarchar](255) NULL,
	[link_twitter] [nvarchar](255) NULL,
	[link_zalo] [nvarchar](255) NULL,
	[link_messenger] [nvarchar](255) NULL,
	[link_map] [nvarchar](max) NULL,
	[link_favicon] [nvarchar](255) NULL,
	[embed_script_head] [nvarchar](max) NULL,
	[embed_script_body_begin] [nvarchar](max) NULL,
	[embed_script_body_end] [nvarchar](max) NULL,
	[multitext] [nvarchar](max) NULL,
	[language] [nvarchar](50) NULL,
 CONSTRAINT [PK_site_contact_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[subscribe]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[subscribe](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[phone] [nvarchar](255) NULL,
	[email] [nvarchar](255) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[status] [smallint] NULL,
	[ip] [nvarchar](255) NULL,
	[type] [smallint] NULL,
	[utm_campaign] [nvarchar](255) NULL,
	[utm_medium] [nvarchar](255) NULL,
	[utm_content] [nvarchar](255) NULL,
	[utm_source] [nvarchar](255) NULL,
	[utm_term] [nvarchar](255) NULL,
	[utm_referrer] [nvarchar](255) NULL,
	[cookies] [nvarchar](1000) NULL,
	[note] [nvarchar](max) NULL,
	[phongban] [nvarchar](255) NULL,
	[object_id] [int] NULL,
	[file] [nvarchar](255) NULL,
 CONSTRAINT [PK_subscribe_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[tag]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[tag](
	[id] [bigint] IDENTITY(2,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[tag] [nvarchar](255) NULL,
	[status] [tinyint] NOT NULL,
	[page_title] [nvarchar](255) NULL,
	[page_description] [nvarchar](160) NULL,
	[title_seobox] [nvarchar](255) NULL,
	[des_seobox] [nvarchar](max) NULL,
	[feature_tag] [smallint] NULL,
 CONSTRAINT [PK_tag_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[tag_rel]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[tag_rel](
	[tag_id] [bigint] NOT NULL,
	[object_id] [bigint] NOT NULL,
	[type] [tinyint] NOT NULL,
	[sort_order] [int] NULL,
 CONSTRAINT [PK_tag_rel_tag_id] PRIMARY KEY CLUSTERED 
(
	[tag_id] ASC,
	[object_id] ASC,
	[type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dongthucvat].[user]    Script Date: 19/01/2024 8:26:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dongthucvat].[user](
	[id] [bigint] IDENTITY(22,1) NOT NULL,
	[cities_id] [bigint] NOT NULL,
	[cities_district_id] [bigint] NOT NULL,
	[first_name] [nvarchar](255) NULL,
	[password] [nvarchar](128) NULL,
	[email] [nvarchar](255) NULL,
	[phone] [nvarchar](255) NULL,
	[avatar] [nvarchar](255) NULL,
	[gender] [nvarchar](6) NULL,
	[dob] [date] NULL,
	[address] [nvarchar](255) NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
	[last_signined_time] [datetime2](0) NULL,
	[is_admin] [smallint] NOT NULL,
	[status] [smallint] NOT NULL,
	[secret_key] [nvarchar](255) NULL,
	[role] [nvarchar](255) NULL,
 CONSTRAINT [PK_user_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230807163019_initialDB', N'6.0.20')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230921082659_editLoai', N'6.0.20')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230921090847_editLoai', N'6.0.20')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230921092006_editLoai', N'6.0.20')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230921092614_editLoai', N'6.0.20')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231204081639_create_table_Tour_and_map', N'6.0.20')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231204153022_updateMap', N'6.0.20')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240113140641_updateRole', N'6.0.20')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240113145530_updateRole2', N'6.0.20')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240114090251_createIntroduce', N'6.0.20')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240114091348_updateIntroduce', N'6.0.20')
GO
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [CitiesId], [CitiesDistrictId], [Avatar], [Gender], [Dob], [Address], [CreatedAt], [UpdatedAt], [LastSigninedTime], [IsAdmin], [Status], [Roles], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'81b0366a-0d23-49c9-70f7-08dbb3fec38d', N'Nguyễn Hậu', NULL, NULL, NULL, NULL, N'1', CAST(N'2023-09-14T00:00:00.0000000' AS DateTime2), N'Hưng Yên', CAST(N'2023-09-13T09:11:38.5926348' AS DateTime2), CAST(N'2023-09-22T12:03:31.3096060' AS DateTime2), CAST(N'2024-01-19T20:12:33.4303233' AS DateTime2), 1, 1, N'Administator', N'nguyenhautlym@gmail.com', N'NGUYENHAUTLYM@GMAIL.COM', N'nguyenhautlym@gmail.com', N'NGUYENHAUTLYM@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEEp6tvJ10GYs19M6FZWloVrhXBZc+x8q15GyLXMghnkhW4nyhntYIOG+Dryj13PIXQ==', N'EJ36K3RUYPIVRUZKPCCIFEUAE27FMEUQ', N'47a9fce0-e7fb-439a-94e7-7c726dd19663', N'0987572274', 0, 0, NULL, 1, 0)
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [CitiesId], [CitiesDistrictId], [Avatar], [Gender], [Dob], [Address], [CreatedAt], [UpdatedAt], [LastSigninedTime], [IsAdmin], [Status], [Roles], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'fd797441-0343-4916-0502-08dbb45bd092', N'Đặng', NULL, NULL, NULL, NULL, N'1', CAST(N'2023-09-08T00:00:00.0000000' AS DateTime2), N'Không ở Việt Nam', CAST(N'2023-09-13T20:17:43.6926669' AS DateTime2), CAST(N'2023-12-03T19:54:16.0066948' AS DateTime2), CAST(N'2024-01-19T10:00:30.8119043' AS DateTime2), 0, 1, N'NationParkMuongTe', N'doanxem@gmail.com', N'DOANXEM@GMAIL.COM', N'doanxem@gmail.com', N'DOANXEM@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEOaDbfkfFfVWlnJxWKbdrvrWKCJDOEIoPHdiGJDQtH/T1iD9NwQdz4K1c6MtKW4Cpw==', N'UT4NTZQFJYGSRIGSDD4B56YR5VL6SBBU', N'0fc1b458-e317-4451-bca5-6d6e1f8f8fa2', N'0987654321', 0, 0, NULL, 1, 0)
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [CitiesId], [CitiesDistrictId], [Avatar], [Gender], [Dob], [Address], [CreatedAt], [UpdatedAt], [LastSigninedTime], [IsAdmin], [Status], [Roles], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'112df350-cd6f-424b-9c0c-08dbbab1ab1b', N'Test', NULL, NULL, NULL, NULL, N'1', CAST(N'2023-09-14T00:00:00.0000000' AS DateTime2), N'adadada', CAST(N'2023-09-21T21:47:24.5334163' AS DateTime2), CAST(N'2023-12-03T20:25:43.0538786' AS DateTime2), CAST(N'2024-01-19T10:29:05.1701653' AS DateTime2), 0, 1, N'NationParkNamGiang', N'abc@gmail.com', N'ABC@GMAIL.COM', N'abc@gmail.com', N'ABC@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEAzAaYNE4ITnnKsaR8PklXMNuCwLAx2JwjFXqtmj8JKgD3njB9zoScB5svPBdp2DpA==', N'7CKVNEKNUNHGCW2644HMJC5WI4YA3UD7', N'9dddc7e9-ad03-4ff0-9374-301d30b3a891', N'987654321', 0, 0, NULL, 1, 0)
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [CitiesId], [CitiesDistrictId], [Avatar], [Gender], [Dob], [Address], [CreatedAt], [UpdatedAt], [LastSigninedTime], [IsAdmin], [Status], [Roles], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'7663ae1c-ec91-4296-f130-08dc14542a2b', N'Nguyễn', NULL, NULL, NULL, NULL, N'1', CAST(N'2024-01-18T00:00:00.0000000' AS DateTime2), N'Hưng yên', CAST(N'2024-01-13T23:24:49.6719566' AS DateTime2), CAST(N'2024-01-13T23:24:49.6720165' AS DateTime2), CAST(N'2024-01-13T23:25:05.8308798' AS DateTime2), 0, 1, N'NationParkMuongTe', N'haha@gmail.com', N'HAHA@GMAIL.COM', N'haha@gmail.com', N'HAHA@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEIicNBsso9FxDfiK74ie30XUFkHlrf0mH2C8ShqySZ7bvr2fwVeOohsA4wHeo3M/kA==', N'6MFCNUKA6EZPLBEOIZCV2A6XCJZPOJR5', N'580a9519-1d76-4ece-a2ec-4309df9414f6', N'0987654321', 0, 0, NULL, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[introduce] ON 

INSERT [dbo].[introduce] ([id], [title], [content], [CreateBy], [UpdateBy], [CreateAt], [UpdateAt], [typeNationPak]) VALUES (4, N'Giới thiệu về Phần mềm cơ sở dữ liệu về các hệ sinh thái có đa dạng sinh học cao trong phạm vi rừng phòng hộ', N'<p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
120%"><b><span lang="EN-US" style="font-size:
14.0pt;line-height:120%;font-family:&quot;Times New Roman&quot;,serif">“Phần mềm quản lý
sử dụng cơ sở dữ liệu về các hệ sinh thái có đa dạng sinh học cao trong phạm vi
rừng phòng hộ”</span></b><span lang="EN-US" style="font-size:14.0pt;line-height:
120%;font-family:&quot;Times New Roman&quot;,serif"> là sản phẩm của nhiệm vụ <b>“Xác
định các hệ sinh thái có đa dạng sinh học cao trong phạm vi rừng phòng hộ và đề
xuất giải pháp bảo tồn, phát triển”.</b><o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
120%"><span lang="EN-US" style="font-size:14.0pt;line-height:120%;font-family:
&quot;Times New Roman&quot;,serif;mso-bidi-font-weight:bold">Thông tin chi tiết về nhiệm
vụ như dưới đây:<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;line-height:120%"><span lang="EN-US" style="font-size:14.0pt;line-height:120%;font-family:&quot;Times New Roman&quot;,serif">-
Tên nhiệm vụ môi trường: Xác định các hệ
sinh thái có đa dạng sinh học cao trong phạm vi rừng phòng hộ và đề xuất giải
pháp bảo tồn, phát triển;<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;line-height:120%"><span lang="EN-US" style="font-size:14.0pt;line-height:120%;font-family:&quot;Times New Roman&quot;,serif;
mso-bidi-font-weight:bold">- Đơn vị chủ quản: Bộ Nông nghiệp và Phát triển nông
thôn<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;line-height:120%"><span lang="EN-US" style="font-size:14.0pt;line-height:120%;font-family:&quot;Times New Roman&quot;,serif;
mso-bidi-font-weight:bold">- Đơn vị chủ trì: Trường Đại học Lâm nghiệp<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;line-height:120%"><span lang="EN-US" style="font-size:14.0pt;line-height:120%;font-family:&quot;Times New Roman&quot;,serif;
mso-bidi-font-weight:bold">- Chủ nhiệm nhiệm vụ: TS. Kiều Thị Dương<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;line-height:120%"><span lang="EN-US" style="font-size:14.0pt;line-height:120%;font-family:&quot;Times New Roman&quot;,serif;
mso-bidi-font-weight:bold">- Thời gian thực hiện: 36 tháng (</span><span lang="EN-US" style="font-size:14.0pt;line-height:120%;font-family:&quot;Times New Roman&quot;,serif">tháng
01/01/2022 đến tháng 31/12/2024)<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;line-height:120%"><span lang="EN-US" style="font-size:14.0pt;line-height:120%;font-family:&quot;Times New Roman&quot;,serif">-
Mục tiêu cụ thể của nhiệm vụ:<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
120%"><i><span lang="EN-US" style="font-size:
14.0pt;line-height:120%;font-family:&quot;Times New Roman&quot;,serif">+ Xây dựng được bộ
tiêu chí, chỉ số đánh giá làm cơ sở xác định hệ sinh thái có đa dạng sinh học
cao;<o:p></o:p></span></i></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
120%"><i><span lang="EN-US" style="font-size:
14.0pt;line-height:120%;font-family:&quot;Times New Roman&quot;,serif">+&nbsp; Xác định được ranh giới, diện tích và các đặc
trưng cơ bản của một số hệ sinh thái có đa dạng sinh học cao trong phạm vi rừng
phòng hộ;<o:p></o:p></span></i></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
120%"><i><span lang="EN-US" style="font-size:
14.0pt;line-height:120%;font-family:&quot;Times New Roman&quot;,serif">&nbsp;+ Đề xuất được các giải pháp thích hợp để bảo
tồn và phát triển các hệ sinh thái có đa dạng sinh học cao trong phạm vi rừng
phòng hộ.<o:p></o:p></span></i></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
120%"><i><span lang="EN-US" style="font-size:
14.0pt;line-height:120%;font-family:&quot;Times New Roman&quot;,serif">- </span></i><span lang="EN-US" style="font-size:14.0pt;line-height:120%;font-family:&quot;Times New Roman&quot;,serif">Phạm
vi thực hiện: BQL RPH Nam Giang (tỉnh Quảng Nam) và BQL RPH Mường Tè (tỉnh Lai
Châu)<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
120%"><i><span lang="EN-US" style="font-size:
14.0pt;line-height:120%;font-family:&quot;Times New Roman&quot;,serif">- </span></i><span lang="EN-US" style="font-size:14.0pt;line-height:120%;font-family:&quot;Times New Roman&quot;,serif">Sản
phẩm của nhiệm vụ:<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
120%"><span lang="EN-US" style="font-size:14.0pt;line-height:120%;font-family:
&quot;Times New Roman&quot;,serif">+ Bộ tiêu chí, chỉ số đánh giá làm cơ sở xác định hệ
sinh thái có đa dạng sinh học cao trong phạm vi rừng phòng hộ được Tổng cục Lâm
nghiệp ban hành.<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
120%"><span lang="EN-US" style="font-size:14.0pt;line-height:120%;font-family:
&quot;Times New Roman&quot;,serif">+ Báo cáo khoa học và các số liệu, dữ liệu liên quan về
kết quả điều tra, đánh giá hiện trạng về đa dạng sinh học tại các hệ sinh
thái trong phạm vi rừng phòng hộ cho 02 khu vực cấp vùng điển hình (miền Bắc và
miền Trung).<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
120%"><span lang="EN-US" style="font-size:14.0pt;line-height:120%;font-family:
&quot;Times New Roman&quot;,serif">+ 01 cơ sở dữ liệu các hệ sinh thái có đa dạng sinh học
cao trong phạm vi rừng phòng hộ (thuộc các khu vực được lựa chọn, bao gồm: bản
đồ xác định ranh giới, diện tích, hiện trạng đa dạng sinh học...) được Tổng cục
Lâm nghiệp tiếp nhận và sử dụng.<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
120%"><span lang="EN-US" style="font-size:14.0pt;line-height:120%;font-family:
&quot;Times New Roman&quot;,serif">+ 01 phần mềm quản lý sử dụng cơ sở dữ liệu về đa dạng
sinh học cho các hệ sinh thái có đa dạng sinh học cao trong phạm vi rừng phòng hộ.<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
120%"><span lang="EN-US" style="font-size:14.0pt;line-height:120%;font-family:
&quot;Times New Roman&quot;,serif">+ Báo cáo đề xuất các giải pháp thích hợp để bảo tồn
và phát triển các hệ sinh thái có đa dạng sinh học cao trong phạm vi rừng phòng
hộ được Tổng cục Lâm nghiệp tiếp nhận và sử dụng.<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
120%"><span lang="EN-US" style="font-size:14.0pt;line-height:120%;font-family:
&quot;Times New Roman&quot;,serif">+ 01 hướng dẫn về phương pháp điều tra, đánh giá và lập
bản đồ khu rừng phòng hộ có đa dạng sinh học cao áp dụng chung cho toàn quốc được
Tổng cục Lâm nghiệp ban hành.<o:p></o:p></span></p><p style="margin-right: 0px; margin-left: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; list-style: none; font-family: MontserratF; color: rgb(33, 37, 41);">





































</p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
120%"><span lang="EN-US" style="font-size:14.0pt;line-height:120%;font-family:
&quot;Times New Roman&quot;,serif">+ Bản đề xuất các giải pháp thúc đẩy ứng dụng công nghệ
địa không gian trong quản lý Vườn quốc gia, Khu bảo tồn.<o:p></o:p></span></p>', N'dấdad', N'81b0366a-0d23-49c9-70f7-08dbb3fec38d', NULL, CAST(N'2024-01-15T20:32:31.7510178' AS DateTime2), N'All')
INSERT [dbo].[introduce] ([id], [title], [content], [CreateBy], [UpdateBy], [CreateAt], [UpdateAt], [typeNationPak]) VALUES (5, N'GIỚI THIỆU VỀ BAN QUẢN LÝ RPH NAM GIANG', N'<p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;text-indent:
36.0pt;line-height:130%"><span lang="EN-US" style="font-size:14.0pt;line-height:
130%;font-family:&quot;Times New Roman&quot;,serif">Ban QLRPH Nam Giang được thành lập
theo Quyết định số 2195/QĐ-UBND ngày 11/10/2019 của UBND huyện Nam Giang, trên
cơ sở bàn giao nguyên trạng từ Ban Quản lý RPH Nam Sông Bung (trực thuộc Chi cục
Kiểm lâm tỉnh Quảng Nam). Theo Quyết định số 145/QĐ-UBND ngày 11/01/2018 của
UBND tỉnh Quảng Nam, Ban có tổng diện tích quản lý là 55.510,08 ha, trong đó diện
tích đất có rừng là: 44.188,76 ha, bao gồm rừng tự nhiên với 43.987,7 ha và rừng
trồng là 201,06 ha (theo Quyết định số 911/QĐ-BNN-TCLN ngày 19/3/2019 của Bộ
Nông nghiệp và PTNT về công bố hiện trạng rừng toàn quốc năm 2018). Lâm phận
thuộc quản lý của Ban quản lý rừng phòng hộ Nam Giang nằm trên địa bàn 11 xã,
thị trấn thuộc huyện Nam Giang, tỉnh Quảng Nam.<o:p></o:p></span></p><p class="MsoBodyText2" style="margin-bottom:0cm;text-align:justify;text-indent:
35.45pt;line-height:130%"><span lang="EN-US" style="font-size:14.0pt;line-height:
130%">Ban QLRPH Nam Giang có <span style="letter-spacing:-.1pt">trụ sở tại thôn
Bến Giằng, xã Cà Dy, huyện Nam Giang; ranh giới lâm phận tiếp giáp như sau:<o:p></o:p></span></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;text-indent:
35.45pt;line-height:130%;mso-layout-grid-align:none;text-autospace:none"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">- </span><span style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Phía Bắc giáp: Lâm phận BQL</span><span style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;"> </span><span style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">RPH Bắc Sông Bung (</span><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">h</span><span style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">uyện Tây Giang) và lâm phận BQL</span><span style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;"> </span><span style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">RPH A Vương (huyện Đông Giang</span><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">, nay là BQL RPH Đông Giang</span><span style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">)</span><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">.<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;text-indent:
35.45pt;line-height:130%;mso-layout-grid-align:none;text-autospace:none"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">- </span><span style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Phía Nam giáp: Khu Bảo tồn thiên nhiên Sông
Thanh (huyện Nam Giang)</span><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">.<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;text-indent:
35.45pt;line-height:130%;mso-layout-grid-align:none;text-autospace:none"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">- </span><span style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Phía Đông giáp: Thị trấn Thạnh Mỹ và xã Tà Bhing
(huyện Nam Giang)</span><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">.<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;text-indent:
35.45pt;line-height:130%;mso-layout-grid-align:none;text-autospace:none"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">- </span><span style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Phía Tây giáp: Nước CHDCND Lào. <o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;text-indent:
36.0pt;line-height:130%"><b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Về đa dạng thực vật:</span></b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;"> Theo Phương án quản lý rừng bền vững
giai đoạn 2021-2030 của BQL rừng phòng hộ Nam Giang, hiện </span><span lang="DE" style="font-size:14.0pt;line-height:130%;font-family:&quot;Times New Roman&quot;,serif;
mso-ansi-language:DE">đã thống kê được 760 loài Thực vật bậc cao có mạch thuộc
473 chi và 161 họ của 6 ngành thực vật khác nhau.<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;text-indent:
36.0pt;line-height:130%"><span lang="EN-US" style="font-size:14.0pt;line-height:
130%;font-family:&quot;Times New Roman&quot;,serif">Trong số 760 loài ghi nhận được tại
RPH Nam Giang, nhóm nghiên cứu tiến hành đối chiếu với sách đỏ Việt nam-2007,
IUCN-2019, Nghị định 06/2019/NĐ-CP và công ước CITES 2017 đã thống kê được 94
loài, chiếm 12,5 % phân bố trong 73 chi, 41 họ ở 3 ngành thực vật bậc cao có mạch<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;text-indent:
36.0pt;line-height:130%"><b><span style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">&nbsp; </span></b><b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Về đa dạng động
vật:</span></b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">
Theo Phương án quản lý rừng bền vững giai đoạn 2021-2030 của BQL rừng phòng hộ
Nam Giang, </span><span lang="EN-US" style="font-size:14.0pt;line-height:130%;
font-family:&quot;Times New Roman&quot;,serif">đã ghi nhận 362 loài động vật hoang dã tại
RPH Nam Giang, trong đó lớp Thú có 48 loài thuộc 28 giống, 16 họ, 5 bộ; lớp
Chim có 100 loài thuộc 73 giống, 34 họ, 12 bộ; lớp Bò sát có 100 loài thuộc 56
giống, 18 họ, 2 bộ; lớp Ếch nhái có 48 loài thuộc 20 giống, 7 họ, 1 bộ; lớp Cá
có 66 loài cá thuộc 39 giống, 11 họ, 3 bộ.<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
120%">

















</p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;text-indent:
36.0pt;line-height:130%"><span lang="EN-US" style="font-size:14.0pt;line-height:
130%;font-family:&quot;Times New Roman&quot;,serif">&nbsp;Trong tổng số 362 loài động vật được ghi nhận
trong lâm phận của BQL RPH Nam Giang có 68 loài quý hiếm, trong đó có 24 loài lớp
Thú; 11 loài thuộc lớp Chim; 28 loài thuộc lớp Bò sát; 2 loài thuộc lớp Ếch
nhái; và 3 loài thuộc lớp Cá. Trong 68 loài động vật quý hiếm có 45 loài có tên
trong SĐVN 2007; 49 loài có tên trong IUCN 2020; 39 loài có tên trong CITES với
15 loài phụ lục I và 24 loài phụ lục II; 50 loài có tên trong Nghị định 06/2019
NĐCP và 14 loài có tên trong nghị 160/2013/NĐCP.<o:p></o:p></span></p>', N'đas', N'81b0366a-0d23-49c9-70f7-08dbb3fec38d', NULL, CAST(N'2024-01-19T20:13:20.5344049' AS DateTime2), N'NationParkNamGiang')
INSERT [dbo].[introduce] ([id], [title], [content], [CreateBy], [UpdateBy], [CreateAt], [UpdateAt], [typeNationPak]) VALUES (6, N'GIỚI THIỆU VỀ BAN QUẢN LÝ RPH MƯỜNG TÈ', N'<p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Ban quản lý rừng
phòng hộ huyện Mường Tè được thành lập theo Quyết định số 1602/QĐ-UBND ngày
24/10/2008 với tổng biên chế được giao là 10 người. Đến ngày 15/10/2018, UBND tỉnh
Lai Châu ban hành Quyết định số 1277/QĐ-UBND về việc sát nhập Ban quản lý rừng
phòng hộ huyện Mường Tè và Ban quản lý rừng phòng hộ khu vực phía Bắc thuộc
UBND huyện Mường Tè, theo đó ban quản lý được giao tổng diện tích 112.028,26 ha
đất lâm nghiệp. Tuy nhiên, trên cơ sở kết quả công bố diễn biến rừng năm 2020 của
huyện Mường Tè, kết quả rà soát diện tích rừng chuyển trạng thái thành rừng và
các nguồn dữ liệu khác, Ban quản lý rừng phòng hộ đã tiến hành rà soát, xác định
diện tích rừng và đất lâm nghiệp nằm trong lâm phận Ban quản lý rừng phòng hộ
đã xác định tổng diện tích đất đơn vị đang quản lý và sử dụng ổn định là
110.766,77 ha rừng và đất rừng, trong đó có 28.449,54 ha rừng đặc dụng,
81.141,59 ha rừng phòng hộ và 1.175,64 ha rừng sản xuất.<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mường Tè là huyện biên
giới, vùng sâu, vùng xa, có đường biên giới giáp với Trung Quốc dài 130,292 km,
đi qua 6 xã vùng biên (Pa Ủ, Ka Lăng, Thu Lũm, Mù Cả, Tá Bạ, Pa Vệ Sủ) nên Mường
Tè có vị trí đặc biệt quan trọng về an ninh quốc phòng và bảo vệ chủ quyền biên
giới Quốc gia.<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Tổng diện tích tự nhiên
của huyện là 267.848,05 ha, chiếm 29,5% diện tích của tỉnh Lai Châu, đứng đầu 8
huyện, thành phố của tỉnh về diện tích. Vị trí tiếp giáp:<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><i><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Vị trí địa lý:<o:p></o:p></span></i></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
130%"><span lang="PT-BR" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Huyện Mường Tè nằm ở phía
Tây Bắc của tỉnh Lai Châu, có vị trí địa lý:<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
130%"><span lang="PT-BR" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; + Phía Bắc giáp tỉnh Vân
Nam - Trung Quốc.<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
130%"><span lang="PT-BR" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; + Phía Tây giáp huyện Mường
Nhé, tỉnh Điện Biên. <o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
130%"><span lang="PT-BR" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; + Phía Nam giáp huyện Nậm
Nhùn, tỉnh Lai Châu.<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
130%"><span lang="PT-BR" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; + Phía Đông giáp huyện Nậm
Nhùn, tỉnh Lai Châu.<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;text-indent:
36.0pt;line-height:130%"><b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Về đa dạng thực vật:</span></b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;"> Theo Phương án quản lý rừng bền vững
giai đoạn 2021-2030 của BQL rừng phòng hộ Mường Tè, </span><span lang="DE" style="font-size:14.0pt;line-height:130%;font-family:&quot;Times New Roman&quot;,serif;
mso-ansi-language:DE">đã ghi nhận </span><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">được tổng 661 loài, 424
chi, 140 họ.</span><span lang="DE" style="font-size:14.0pt;line-height:130%;
font-family:&quot;Times New Roman&quot;,serif;mso-ansi-language:DE"><o:p></o:p></span></p><div align="center">

<table class="MsoNormalTable" border="1" cellspacing="0" cellpadding="0" width="100%" style="border: none;">
 <tbody><tr style="mso-yfti-irow:0;mso-yfti-firstrow:yes;height:8.6pt">
  <td width="9%" valign="top" style="width: 9.08%; border-width: 1pt; border-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" align="center" style="margin-top:0cm;margin-right:-2.85pt;
  margin-bottom:0cm;margin-left:-2.85pt;text-align:center;line-height:130%"><b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">TT<o:p></o:p></span></b></p>
  </td>
  <td width="42%" nowrap="" valign="bottom" style="width: 42.08%; border-top-width: 1pt; border-right-width: 1pt; border-bottom-width: 1pt; border-top-color: windowtext; border-right-color: windowtext; border-bottom-color: windowtext; border-left: none; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" align="center" style="margin-top:0cm;margin-right:-2.85pt;
  margin-bottom:0cm;margin-left:-2.85pt;text-align:center;line-height:130%"><b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Bậc
  phân loại<o:p></o:p></span></b></p>
  </td>
  <td width="15%" nowrap="" valign="bottom" style="width: 15.78%; border-top-width: 1pt; border-right-width: 1pt; border-bottom-width: 1pt; border-top-color: windowtext; border-right-color: windowtext; border-bottom-color: windowtext; border-left: none; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" align="center" style="margin-top:0cm;margin-right:-2.85pt;
  margin-bottom:0cm;margin-left:-2.85pt;text-align:center;line-height:130%"><b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Họ<o:p></o:p></span></b></p>
  </td>
  <td width="15%" nowrap="" valign="bottom" style="width: 15.94%; border-top-width: 1pt; border-right-width: 1pt; border-bottom-width: 1pt; border-top-color: windowtext; border-right-color: windowtext; border-bottom-color: windowtext; border-left: none; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" align="center" style="margin-top:0cm;margin-right:-2.85pt;
  margin-bottom:0cm;margin-left:-2.85pt;text-align:center;line-height:130%"><b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Chi<o:p></o:p></span></b></p>
  </td>
  <td width="17%" nowrap="" valign="bottom" style="width: 17.14%; border-top-width: 1pt; border-right-width: 1pt; border-bottom-width: 1pt; border-top-color: windowtext; border-right-color: windowtext; border-bottom-color: windowtext; border-left: none; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" align="center" style="margin-top:0cm;margin-right:-2.85pt;
  margin-bottom:0cm;margin-left:-2.85pt;text-align:center;line-height:130%"><b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Loài<o:p></o:p></span></b></p>
  </td>
 </tr>
 <tr style="mso-yfti-irow:1;height:8.6pt">
  <td width="9%" valign="top" style="width: 9.08%; border-right-width: 1pt; border-bottom-width: 1pt; border-left-width: 1pt; border-right-color: windowtext; border-bottom-color: windowtext; border-left-color: windowtext; border-top: none; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;text-align:center;
  line-height:130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">1<o:p></o:p></span></p>
  </td>
  <td width="42%" nowrap="" valign="bottom" style="width: 42.08%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Cỏ bút tháp<o:p></o:p></span></p>
  </td>
  <td width="15%" nowrap="" valign="bottom" style="width: 15.78%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">1<o:p></o:p></span></p>
  </td>
  <td width="15%" nowrap="" valign="bottom" style="width: 15.94%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">1<o:p></o:p></span></p>
  </td>
  <td width="17%" nowrap="" valign="bottom" style="width: 17.14%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">1<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style="mso-yfti-irow:2;height:8.6pt">
  <td width="9%" valign="top" style="width: 9.08%; border-right-width: 1pt; border-bottom-width: 1pt; border-left-width: 1pt; border-right-color: windowtext; border-bottom-color: windowtext; border-left-color: windowtext; border-top: none; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;text-align:center;
  line-height:130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">2<o:p></o:p></span></p>
  </td>
  <td width="42%" nowrap="" valign="bottom" style="width: 42.08%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Ngành Thông đất<o:p></o:p></span></p>
  </td>
  <td width="15%" nowrap="" valign="bottom" style="width: 15.78%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">2<o:p></o:p></span></p>
  </td>
  <td width="15%" nowrap="" valign="bottom" style="width: 15.94%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">2<o:p></o:p></span></p>
  </td>
  <td width="17%" nowrap="" valign="bottom" style="width: 17.14%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">4<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style="mso-yfti-irow:3;height:8.6pt">
  <td width="9%" valign="top" style="width: 9.08%; border-right-width: 1pt; border-bottom-width: 1pt; border-left-width: 1pt; border-right-color: windowtext; border-bottom-color: windowtext; border-left-color: windowtext; border-top: none; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;text-align:center;
  line-height:130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">3<o:p></o:p></span></p>
  </td>
  <td width="42%" nowrap="" valign="bottom" style="width: 42.08%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Ngành Dương xỉ<o:p></o:p></span></p>
  </td>
  <td width="15%" nowrap="" valign="bottom" style="width: 15.78%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">13<o:p></o:p></span></p>
  </td>
  <td width="15%" nowrap="" valign="bottom" style="width: 15.94%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">20<o:p></o:p></span></p>
  </td>
  <td width="17%" nowrap="" valign="bottom" style="width: 17.14%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">32<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style="mso-yfti-irow:4;height:8.6pt">
  <td width="9%" valign="top" style="width: 9.08%; border-right-width: 1pt; border-bottom-width: 1pt; border-left-width: 1pt; border-right-color: windowtext; border-bottom-color: windowtext; border-left-color: windowtext; border-top: none; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;text-align:center;
  line-height:130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">4<o:p></o:p></span></p>
  </td>
  <td width="42%" nowrap="" valign="bottom" style="width: 42.08%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Ngành thông<o:p></o:p></span></p>
  </td>
  <td width="15%" nowrap="" valign="bottom" style="width: 15.78%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">2<o:p></o:p></span></p>
  </td>
  <td width="15%" nowrap="" valign="bottom" style="width: 15.94%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">2<o:p></o:p></span></p>
  </td>
  <td width="17%" nowrap="" valign="bottom" style="width: 17.14%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">2<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style="mso-yfti-irow:5;height:8.6pt">
  <td width="9%" valign="top" style="width: 9.08%; border-right-width: 1pt; border-bottom-width: 1pt; border-left-width: 1pt; border-right-color: windowtext; border-bottom-color: windowtext; border-left-color: windowtext; border-top: none; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" align="center" style="margin-bottom:0cm;text-align:center;
  line-height:130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">5<o:p></o:p></span></p>
  </td>
  <td width="42%" nowrap="" valign="bottom" style="width: 42.08%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Ngành ngọc lan<o:p></o:p></span></p>
  </td>
  <td width="15%" nowrap="" valign="bottom" style="width: 15.78%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">122<o:p></o:p></span></p>
  </td>
  <td width="15%" nowrap="" valign="bottom" style="width: 15.94%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">399<o:p></o:p></span></p>
  </td>
  <td width="17%" nowrap="" valign="bottom" style="width: 17.14%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">622<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style="mso-yfti-irow:6;mso-yfti-lastrow:yes;height:8.6pt">
  <td width="9%" valign="top" style="width: 9.08%; border-right-width: 1pt; border-bottom-width: 1pt; border-left-width: 1pt; border-right-color: windowtext; border-bottom-color: windowtext; border-left-color: windowtext; border-top: none; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">&nbsp;</span></p>
  </td>
  <td width="42%" nowrap="" valign="bottom" style="width: 42.08%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><b><i><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Tổng</span></i></b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;"><o:p></o:p></span></p>
  </td>
  <td width="15%" nowrap="" valign="top" style="width: 15.78%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">140<i><o:p></o:p></i></span></b></p>
  </td>
  <td width="15%" nowrap="" valign="top" style="width: 15.94%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">424<i><o:p></o:p></i></span></b></p>
  </td>
  <td width="17%" nowrap="" valign="top" style="width: 17.14%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 8.6pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">661<i><o:p></o:p></i></span></b></p>
  </td>
 </tr>
</tbody></table>

</div><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;text-indent:
36.0pt;line-height:130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Dựa trên danh lục thực vật gồm 661 loài đã
ghi nhận được, có tới 152 loài có giá trị bảo tồn, nguy cấp, quý hiếm. Trong đó
có 72 loài có giá trị bảo tồn theo thang phân hạng của IUCN 2021, Sách Đỏ Việt
Nam 2007 là 71 loài và Nghị định số 84/2021/NĐ-CP là 38 loài.</span><span lang="DE" style="font-size:14.0pt;line-height:130%;font-family:&quot;Times New Roman&quot;,serif;
mso-ansi-language:DE"><o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;text-indent:
36.0pt;line-height:130%"><b><span style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">&nbsp; </span></b><b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Về đa dạng động
vật:</span></b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">
Theo Phương án quản lý rừng bền vững giai đoạn 2021-2030 của BQL rừng phòng hộ Mường
Tè, </span><span lang="EN-US" style="font-size:14.0pt;line-height:130%;
font-family:&quot;Times New Roman&quot;,serif">đã ghi nhận </span><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">tổng
124 loài động vật và 60 họ, trong đó có mặt của 20 loài thú thuộc 05 bộ, 81
loài chim thuộc 10 bộ, 37 họ và 23 loài bò sát, lưỡng cư thuộc 11 họ</span><span lang="EN-US" style="font-size:14.0pt;line-height:130%;font-family:&quot;Times New Roman&quot;,serif">.<o:p></o:p></span></p><table class="MsoNormalTable" border="1" cellspacing="0" cellpadding="0" width="100%" style="border: none;">
 <thead>
  <tr style="mso-yfti-irow:0;mso-yfti-firstrow:yes;height:12.3pt">
   <td width="31%" rowspan="2" style="width: 31.26%; border-width: 1pt; border-color: windowtext; padding: 0cm 5.4pt; height: 12.3pt;">
   <p class="MsoNormal" align="center" style="margin-top:0cm;margin-right:-2.85pt;
   margin-bottom:0cm;margin-left:-2.85pt;text-align:center;line-height:130%"><b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Ngành<o:p></o:p></span></b></p>
   </td>
   <td width="33%" colspan="2" valign="top" style="width: 33.48%; border-top-width: 1pt; border-right-width: 1pt; border-bottom-width: 1pt; border-top-color: windowtext; border-right-color: windowtext; border-bottom-color: windowtext; border-left: none; padding: 0cm 5.4pt; height: 12.3pt;">
   <p class="MsoNormal" align="center" style="margin-top:0cm;margin-right:-2.85pt;
   margin-bottom:0cm;margin-left:-2.85pt;text-align:center;line-height:130%"><b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Họ<o:p></o:p></span></b></p>
   </td>
   <td width="35%" colspan="2" valign="top" style="width: 35.26%; border-top-width: 1pt; border-right-width: 1pt; border-bottom-width: 1pt; border-top-color: windowtext; border-right-color: windowtext; border-bottom-color: windowtext; border-left: none; padding: 0cm 5.4pt; height: 12.3pt;">
   <p class="MsoNormal" align="center" style="margin-top:0cm;margin-right:-2.85pt;
   margin-bottom:0cm;margin-left:-2.85pt;text-align:center;line-height:130%"><b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Loài<o:p></o:p></span></b></p>
   </td>
  </tr>
  <tr style="mso-yfti-irow:1;height:12.75pt">
   <td width="20%" valign="top" style="width: 20.88%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 12.75pt;">
   <p class="MsoNormal" align="center" style="margin-top:0cm;margin-right:-2.85pt;
   margin-bottom:0cm;margin-left:-2.85pt;text-align:center;line-height:130%"><b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Số lượng<o:p></o:p></span></b></p>
   </td>
   <td width="12%" valign="top" style="width: 12.6%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 12.75pt;">
   <p class="MsoNormal" align="center" style="margin-top:0cm;margin-right:-2.85pt;
   margin-bottom:0cm;margin-left:-2.85pt;text-align:center;line-height:130%"><b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">%<o:p></o:p></span></b></p>
   </td>
   <td width="23%" valign="top" style="width: 23.58%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 12.75pt;">
   <p class="MsoNormal" align="center" style="margin-top:0cm;margin-right:-2.85pt;
   margin-bottom:0cm;margin-left:-2.85pt;text-align:center;line-height:130%"><b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Số lượng<o:p></o:p></span></b></p>
   </td>
   <td width="11%" valign="top" style="width: 11.68%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 12.75pt;">
   <p class="MsoNormal" align="center" style="margin-top:0cm;margin-right:-2.85pt;
   margin-bottom:0cm;margin-left:-2.85pt;text-align:center;line-height:130%"><b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">%<o:p></o:p></span></b></p>
   </td>
  </tr>
 </thead>
 <tbody><tr style="mso-yfti-irow:2;height:19.85pt">
  <td width="31%" valign="top" style="width: 31.26%; border-right-width: 1pt; border-bottom-width: 1pt; border-left-width: 1pt; border-right-color: windowtext; border-bottom-color: windowtext; border-left-color: windowtext; border-top: none; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Lớp Thú<o:p></o:p></span></p>
  </td>
  <td width="20%" valign="top" style="width: 20.88%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">12<o:p></o:p></span></p>
  </td>
  <td width="12%" valign="top" style="width: 12.6%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">20,00<o:p></o:p></span></p>
  </td>
  <td width="23%" valign="top" style="width: 23.58%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">20<o:p></o:p></span></p>
  </td>
  <td width="11%" style="width: 11.68%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">16,13<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style="mso-yfti-irow:3;height:19.85pt">
  <td width="31%" valign="top" style="width: 31.26%; border-right-width: 1pt; border-bottom-width: 1pt; border-left-width: 1pt; border-right-color: windowtext; border-bottom-color: windowtext; border-left-color: windowtext; border-top: none; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Lớp Chim<o:p></o:p></span></p>
  </td>
  <td width="20%" valign="top" style="width: 20.88%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">37<o:p></o:p></span></p>
  </td>
  <td width="12%" valign="top" style="width: 12.6%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">61,67<o:p></o:p></span></p>
  </td>
  <td width="23%" valign="top" style="width: 23.58%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">81<o:p></o:p></span></p>
  </td>
  <td width="11%" style="width: 11.68%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">65,32<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style="mso-yfti-irow:4;height:19.85pt">
  <td width="31%" valign="top" style="width: 31.26%; border-right-width: 1pt; border-bottom-width: 1pt; border-left-width: 1pt; border-right-color: windowtext; border-bottom-color: windowtext; border-left-color: windowtext; border-top: none; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Lớp Bò sát<o:p></o:p></span></p>
  </td>
  <td width="20%" valign="top" style="width: 20.88%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">6<o:p></o:p></span></p>
  </td>
  <td width="12%" valign="top" style="width: 12.6%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">10,00<o:p></o:p></span></p>
  </td>
  <td width="23%" valign="top" style="width: 23.58%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">17<o:p></o:p></span></p>
  </td>
  <td width="11%" style="width: 11.68%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">13,71<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style="mso-yfti-irow:5;height:19.85pt">
  <td width="31%" valign="top" style="width: 31.26%; border-right-width: 1pt; border-bottom-width: 1pt; border-left-width: 1pt; border-right-color: windowtext; border-bottom-color: windowtext; border-left-color: windowtext; border-top: none; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Lớp Lưỡng cư<o:p></o:p></span></p>
  </td>
  <td width="20%" valign="top" style="width: 20.88%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">5<o:p></o:p></span></p>
  </td>
  <td width="12%" valign="top" style="width: 12.6%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">8,33<o:p></o:p></span></p>
  </td>
  <td width="23%" valign="top" style="width: 23.58%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">6<o:p></o:p></span></p>
  </td>
  <td width="11%" style="width: 11.68%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">4,84<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style="mso-yfti-irow:6;mso-yfti-lastrow:yes;height:19.85pt">
  <td width="31%" style="width: 31.26%; border-right-width: 1pt; border-bottom-width: 1pt; border-left-width: 1pt; border-right-color: windowtext; border-bottom-color: windowtext; border-left-color: windowtext; border-top: none; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><b><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Tổng cộng<o:p></o:p></span></b></p>
  </td>
  <td width="20%" valign="top" style="width: 20.88%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">60<b><o:p></o:p></b></span></p>
  </td>
  <td width="12%" valign="top" style="width: 12.6%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">100<b><o:p></o:p></b></span></p>
  </td>
  <td width="23%" valign="top" style="width: 23.58%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">124<b><o:p></o:p></b></span></p>
  </td>
  <td width="11%" valign="top" style="width: 11.68%; border-top: none; border-left: none; border-bottom-width: 1pt; border-bottom-color: windowtext; border-right-width: 1pt; border-right-color: windowtext; padding: 0cm 5.4pt; height: 19.85pt;">
  <p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
  130%"><span lang="EN-US" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">100<b><o:p></o:p></b></span></p>
  </td>
 </tr>
</tbody></table><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;line-height:
120%">



























</p><p class="MsoNormal" style="margin-bottom:0cm;text-align:justify;text-indent:
36.0pt;line-height:130%"><span lang="DE" style="font-size: 14pt; line-height: 130%; font-family: &quot;Times New Roman&quot;, serif;">Trong khu hệ thú gồm có 124 loài thuộc 60 họ, thì có 20
loài quý hiếm. Trong số các loài đặc hữu, quý hiếm có tới 9 loài nằm trong SĐVN
2007, 5 loài nằm trong danh mục của IUCN 2021, 17 loài trong Phụ lục của Nghị định
số 84/2021/NĐ-CP.</span><span lang="EN-US" style="font-size:14.0pt;line-height:
130%;font-family:&quot;Times New Roman&quot;,serif"><o:p></o:p></span></p>', N'fsdf', N'81b0366a-0d23-49c9-70f7-08dbb3fec38d', NULL, CAST(N'2024-01-19T20:12:55.1254454' AS DateTime2), N'NationParkMuongTe')
SET IDENTITY_INSERT [dbo].[introduce] OFF
GO
SET IDENTITY_INSERT [dbo].[map] ON 

INSERT [dbo].[map] ([Id], [Name], [Description], [linkMap], [CreateBy], [CreatedAt], [UpdateBy], [UpdatedAt]) VALUES (5, N'test 1123', N'<p>&aacute;dasdsad</p>
', N'demo2.html_ccae238d-39e0-4f67-9ce2-5ef142c16c7b.html', N'81b0366a-0d23-49c9-70f7-08dbb3fec38d', CAST(N'2023-12-05T00:31:17.8925484' AS DateTime2), NULL, NULL)
INSERT [dbo].[map] ([Id], [Name], [Description], [linkMap], [CreateBy], [CreatedAt], [UpdateBy], [UpdatedAt]) VALUES (6, N'test tin tức', N'<p>fsfsfsfds</p>
', N'demo1.html_0baf1400-7b21-4175-9411-894e7c02a202.html', N'81b0366a-0d23-49c9-70f7-08dbb3fec38d', CAST(N'2023-12-05T00:31:30.9539081' AS DateTime2), NULL, NULL)
INSERT [dbo].[map] ([Id], [Name], [Description], [linkMap], [CreateBy], [CreatedAt], [UpdateBy], [UpdatedAt]) VALUES (8, N'fsfsdsf', N'<p>fsdsfs</p>
', N'2_69993e5f-e6bb-4489-9436-b48b2bd8ed4f.jpg', N'81b0366a-0d23-49c9-70f7-08dbb3fec38d', CAST(N'2023-12-05T00:36:20.3678450' AS DateTime2), NULL, CAST(N'2023-12-05T00:42:43.8234104' AS DateTime2))
INSERT [dbo].[map] ([Id], [Name], [Description], [linkMap], [CreateBy], [CreatedAt], [UpdateBy], [UpdatedAt]) VALUES (9, N'fdgđgdg', N'<p>saddadsad</p>
', N'demo1_0abbe1be-561e-4d29-88f0-d5f86e1d16ec.html', N'81b0366a-0d23-49c9-70f7-08dbb3fec38d', CAST(N'2023-12-05T00:45:58.3770295' AS DateTime2), NULL, NULL)
SET IDENTITY_INSERT [dbo].[map] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Id], [Name], [Value], [UpdateAt]) VALUES (1, N'Phân quyền tài khoản ', N'Menber', CAST(N'2024-01-14T00:09:04.0334296' AS DateTime2))
INSERT [dbo].[Role] ([Id], [Name], [Value], [UpdateAt]) VALUES (2, N'BQL RPH Mường Tè', N'NationParkMuongTe', CAST(N'2024-01-15T20:49:59.3866466' AS DateTime2))
INSERT [dbo].[Role] ([Id], [Name], [Value], [UpdateAt]) VALUES (3, N'BQL RPH Nam Giang', N'NationParkNamGiang', CAST(N'2024-01-15T20:50:08.5741658' AS DateTime2))
INSERT [dbo].[Role] ([Id], [Name], [Value], [UpdateAt]) VALUES (4, N'Quản trị nội dung', N'Admin', NULL)
INSERT [dbo].[Role] ([Id], [Name], [Value], [UpdateAt]) VALUES (5, N'Quản trị website', N'Administator', NULL)
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[tour] ON 

INSERT [dbo].[tour] ([Id], [Name], [Alias], [Image], [ShortDescription], [Description], [TotalView], [SortOrder], [CreatedAt], [UpdatedAt], [Status], [Author], [Source]) VALUES (1, N'12312321fsdf fsdfsfssdfsfsfsfsdfdsf sdsfsdfsfsdf sfsfsfs313123131  sfsf sfdsfs fsfs dsdfsf sdfsf', N'fsdfsfsf', N'cbe181f4-dd87-4a05-8425-d0bdd93d4e4d.jpg', N'fdsfsdsf', N'<p>fsfsdsfsdfsfs<img alt="" src="/toursImage/22845f1e-0c1b-487c-8b6c-585a858497f3.jpg" style="height:280px; width:392px" /></p>
', NULL, NULL, CAST(N'2023-12-04T16:34:06.1996596' AS DateTime2), CAST(N'2024-01-07T23:09:31.0906668' AS DateTime2), 1, N'81b0366a-0d23-49c9-70f7-08dbb3fec38d', NULL)
INSERT [dbo].[tour] ([Id], [Name], [Alias], [Image], [ShortDescription], [Description], [TotalView], [SortOrder], [CreatedAt], [UpdatedAt], [Status], [Author], [Source]) VALUES (2, N'ádasd', N'adasd', N'ab02d690-f454-4047-a4d6-90854935bc5c.jpg', N'đâsd', N'<p>đ&acirc;sdasdasd</p>
', NULL, NULL, CAST(N'2024-01-07T21:47:41.9977636' AS DateTime2), NULL, 1, N'81b0366a-0d23-49c9-70f7-08dbb3fec38d', NULL)
INSERT [dbo].[tour] ([Id], [Name], [Alias], [Image], [ShortDescription], [Description], [TotalView], [SortOrder], [CreatedAt], [UpdatedAt], [Status], [Author], [Source]) VALUES (3, N'test ngành', N'test-nganh', N'5b5beed2-be90-4ab3-a9fd-ddbe848ab991.jpg', N'sádfds', N'<p>fsdsfsf</p>
', NULL, NULL, CAST(N'2024-01-07T21:47:52.7770899' AS DateTime2), NULL, 1, N'112DF350-CD6F-424B-9C0C-08DBBAB1AB1B', NULL)
INSERT [dbo].[tour] ([Id], [Name], [Alias], [Image], [ShortDescription], [Description], [TotalView], [SortOrder], [CreatedAt], [UpdatedAt], [Status], [Author], [Source]) VALUES (4, N'Test Loài 2', N'test-loai-2', N'64d7ba26-2efb-45c8-b82e-6b5a9d2024a5.jpg', N'fdsfsfs', N'<p>dsfsffsd</p>
', NULL, NULL, CAST(N'2024-01-07T21:52:57.6568198' AS DateTime2), NULL, 1, N'FD797441-0343-4916-0502-08DBB45BD092', NULL)
INSERT [dbo].[tour] ([Id], [Name], [Alias], [Image], [ShortDescription], [Description], [TotalView], [SortOrder], [CreatedAt], [UpdatedAt], [Status], [Author], [Source]) VALUES (5, N'test4324', N'test4324', N'5be6a911-e067-4f7d-bf46-f10bb4263c5c.jpg', N'423432', N'<p>fsdfsfsfsfsfs</p>
', NULL, NULL, CAST(N'2024-01-07T22:14:09.3899374' AS DateTime2), NULL, 1, N'112DF350-CD6F-424B-9C0C-08DBBAB1AB1B', NULL)
SET IDENTITY_INSERT [dbo].[tour] OFF
GO
SET IDENTITY_INSERT [dongthucvat].[banner] ON 

INSERT [dongthucvat].[banner] ([id], [banner_cat_id], [name], [src], [src_mobile], [link], [width], [height], [type], [status], [multitext], [description], [sort_order], [created_at], [updated_at], [language], [id_related]) VALUES (4, 5, N'Toàn cảnh Nam Giang', N'a5895407-ceff-41eb-963c-0488f06cb990.jpg', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, CAST(N'2021-12-20T21:36:33.000' AS DateTime), CAST(N'2023-09-22T12:03:55.343' AS DateTime), NULL, NULL)
INSERT [dongthucvat].[banner] ([id], [banner_cat_id], [name], [src], [src_mobile], [link], [width], [height], [type], [status], [multitext], [description], [sort_order], [created_at], [updated_at], [language], [id_related]) VALUES (5, 5, N'Sinh trưởng', N'0ee6cb60-9b29-4116-95a2-322ffc15e1c7.jpg', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, CAST(N'2021-12-20T21:37:00.000' AS DateTime), CAST(N'2023-09-15T16:09:34.393' AS DateTime), NULL, NULL)
INSERT [dongthucvat].[banner] ([id], [banner_cat_id], [name], [src], [src_mobile], [link], [width], [height], [type], [status], [multitext], [description], [sort_order], [created_at], [updated_at], [language], [id_related]) VALUES (6, 5, N'Rêu trên đá', N'ee6a5cd1-fbce-4bae-a009-3547ccc1b8c6.jpg', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, CAST(N'2021-12-20T21:37:30.000' AS DateTime), CAST(N'2023-09-15T16:09:44.917' AS DateTime), NULL, NULL)
INSERT [dongthucvat].[banner] ([id], [banner_cat_id], [name], [src], [src_mobile], [link], [width], [height], [type], [status], [multitext], [description], [sort_order], [created_at], [updated_at], [language], [id_related]) VALUES (7, 5, N'Hoa trắng', N'55abc0e4-9f12-4a29-ae01-81affb3f5c55.jpg', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, CAST(N'2021-12-20T21:38:06.000' AS DateTime), CAST(N'2023-09-15T16:09:55.587' AS DateTime), NULL, NULL)
INSERT [dongthucvat].[banner] ([id], [banner_cat_id], [name], [src], [src_mobile], [link], [width], [height], [type], [status], [multitext], [description], [sort_order], [created_at], [updated_at], [language], [id_related]) VALUES (8, 5, N'Mây trên đỉnh Sa Mù', N'e7e00ed1-db90-4b7c-9547-d206555c4aa6.jpg', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, CAST(N'2023-03-20T16:26:14.000' AS DateTime), CAST(N'2023-09-15T16:10:06.387' AS DateTime), NULL, NULL)
INSERT [dongthucvat].[banner] ([id], [banner_cat_id], [name], [src], [src_mobile], [link], [width], [height], [type], [status], [multitext], [description], [sort_order], [created_at], [updated_at], [language], [id_related]) VALUES (9, 5, N'Đỉnh núi Voi Mẹp', N'965f73a0-ffc8-43ec-9c59-27fdd877abd7.jpg', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, CAST(N'2023-03-20T16:27:56.000' AS DateTime), CAST(N'2023-09-15T16:10:17.477' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dongthucvat].[banner] OFF
GO
SET IDENTITY_INSERT [dongthucvat].[banner_cat] ON 

INSERT [dongthucvat].[banner_cat] ([id], [name], [parent_id], [path], [level], [image], [status], [description], [sort_order], [created_at], [updated_at], [language], [id_related]) VALUES (5, N'banner', 0, NULL, 0, N'', 1, NULL, 1, CAST(N'2023-08-10T00:04:46.570' AS DateTime), CAST(N'2023-08-10T00:04:46.667' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dongthucvat].[banner_cat] OFF
GO
SET IDENTITY_INSERT [dongthucvat].[dtv_bo] ON 

INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1, N'Bộ Náng', N'Amaryllidales', 0, 5, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (2, N'Bộ Na', N'Annanales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (3, N'Bộ Hoa tán', N'Apiales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (4, N'Bộ Nhựa ruồi', N'Aquifoliales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (5, N'Bộ Ráy', N'Arales', 0, 5, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (6, N'Bộ Cau dừa', N'Arecales', 0, 5, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (7, N'Bộ Thiên môn', N'Asparagales', 0, 5, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (8, N'Bộ Cúc', N'Asterales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (9, N'Bộ Bóng nước', N'Balsaminales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (10, N'Bộ Cáng lò', N'Betulales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (11, N'Bộ Vòi voi', N'Boraginales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (12, N'Bộ Dứa', N'Bromeliales', 0, 5, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (13, N'Bộ Hoa chuông', N'Campanulales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (14, N'Bộ Màn màn', N'Capparales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (15, N'Bộ Cẩm chướng', N'Caryophyllales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (16, N'Bộ Chân danh', N'Celastrales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (17, N'Bộ Hoa sói', N'Chloranthales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (18, N'Bộ Thài lài', N'Commelinales', 0, 5, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (19, N'Bộ Thù du', N'Cornales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (20, N'Bộ Bí', N'Cucurbitales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (21, N'Bộ Dương xỉ mộc', N'Cyatheales', 0, 10, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (22, N'Bộ Tuế', N'Cycadales', 0, 1, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (23, N'Bộ Sổ', N'Dilleniales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (24, N'Bộ Củ nâu', N'Dioscoreales', 0, 5, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (25, N'Bộ Tục đoạn', N'Dipsacales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (26, N'Bộ Côm', N'Elaeocarpales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (27, N'Bộ Mộc tặc', N'Equisetales', 0, 2, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (28, N'Bộ Đỗ quyên', N'Ericales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (29, N'Bộ Thầu dầu', N'Euphorbiales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (30, N'Bộ Đậu', N'Fabales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (31, N'Bộ Dẻ', N'Fagales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (32, N'Bộ Guột', N'Gleicheniales', 0, 10, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (33, N'Bộ Gắm', N'Gnetales', 0, 3, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (34, N'Bộ Sau sau', N'Hamamelidales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (35, N'Bộ Ráng màng', N'Hymenophyllales', 0, 10, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (36, N'Bộ Ban', N'Hypericales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (37, N'Bộ Hồi', N'Illiciales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (38, N'Bộ La dơn', N'Iridales', 0, 5, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (39, N'Bộ Hồ đào', N'Juglandales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (40, N'Bộ Bấc', N'Juncales', 0, 5, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (41, N'Bộ Hoa môi', N'Lamiales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (42, N'Bộ Long não', N'Laurales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (43, N'Bộ Lộc vừng', N'Lecythidales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (44, N'Bộ Loa kèn', N'Liliales', 0, 5, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (45, N'Bộ Lanh', N'Linales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (46, N'Bộ Thường sơn', N'Loasales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (47, N'Bộ Thông đất', N'Lycopodiales', 0, 6, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (48, N'Bộ Ngọc lan', N'Magnoliales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (49, N'Bộ Bông', N'Malvales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (50, N'Bộ Móng ngựa', N'Marattiales', 0, 8, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (51, N'Bộ Tiết dê', N'Menispermales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (52, N'Bộ Máu chó', N'Myristicales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (53, N'Bộ Sim', N'Myrtales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (54, N'Bộ Nắp ấm', N'Nepenthales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (55, N'Bộ Mai', N'Ochnales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (56, N'Bộ Nhài', N'Oleales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (57, N'Bộ Lan', N'Orchidales', 0, 5, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (58, N'Bộ Chua me đất', N'Oxalidales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (59, N'Bộ Dứa dại', N'Pandanales', 0, 5, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (60, N'Bộ Thông', N'Pinales', 0, 9, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (61, N'Bộ Hồ tiêu', N'Piperales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (62, N'Bộ Hòa thảo', N'Poales', 0, 5, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (63, N'Bộ Kim giao', N'Podocarpales', 0, 9, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (64, N'Bộ Viễn chí', N'Polygalales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (65, N'Bộ Rau răm', N'Polygonales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (66, N'Bộ Dương xỉ', N'Polypodiales ', 0, 10, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (67, N'Bộ Anh thảo', N'Primulales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (68, N'Bộ Mạ sưa', N'Proteales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (69, N'Bộ Mao lương', N'Ranunculales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (70, N'Bộ Chanh lương', N'Restionales', 0, 5, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (71, N'Bộ Táo ta', N'Rhamnales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (72, N'Bộ Hoa hồng', N'Rosales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (73, N'Bộ Cà phê', N'Rubiales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (74, N'Bộ Cam', N'Rutales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (75, N'Bộ Bèo ong', N'Salviniales', 0, 10, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (76, N'Bộ Đàn hương', N'Santalales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (77, N'Bộ Bồ hòn', N'Sapindales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (78, N'Bộ Sến', N'Sapotales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (79, N'Bộ Bòng bong', N'Schizaeales', 0, 10, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (80, N'Bộ Quyển bá', N'Selaginellales', 0, 4, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (81, N'Bộ Kim cang', N'Smilacales', 0, 5, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (82, N'Bộ Cà', N'Solanales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (83, N'Bộ Bách bộ', N'Stemonales', 0, 5, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (84, N'Bộ Bồ đề', N'Styracales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (85, N'Bộ Thông đỏ', N'Taxales', 0, 9, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (86, N'Bộ Chè', N'Theales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (87, N'Bộ Gai', N'Urticales', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (88, N'Bộ Hoa tím', N'Violales', 0, 7, 1, NULL, NULL, CAST(N'2022-11-15T16:00:12.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (89, N'Bộ Nho', N'Vitales', 0, 7, 1, NULL, NULL, CAST(N'2022-11-15T16:00:12.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (90, N'Bộ Gừng', N'Zingiberales', 0, 5, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (91, N'Bộ cá trình', N'Anguilliformes', 1, 11, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (92, N'Bộ Không đuôi', N'Anura', 1, 12, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (93, N' Bộ Yến', N'Apodiformes', 1, 13, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (94, N'Bộ guốc chẵn', N'Artiodactyla', 1, 15, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (95, N'Bộ cá Nhói', N'Beloniformes', 1, 11, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (96, N'Bộ ăn thịt', N'Carnivora ', 1, 15, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (97, N'Bộ Dơi', N'Chiroptera ', 1, 15, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (98, N' Bộ Rẽ', N'Chradriiformes', 1, 13, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (99, N' Bộ Bồ Câu', N'Columbiformes', 1, 13, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (100, N' Bộ Sả', N'Coraciiformes', 1, 13, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (101, N' Bộ Cu Cu', N'Cuculiformes', 1, 13, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (102, N'Bộ Cá chép', N'Cypriniformes', 1, 11, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (103, N'Bộ Cánh da', N'Dermoptera', 1, 15, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (104, N' Bộ Gà', N'Galliformes', 1, 13, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (105, N' Bộ Sếu', N'Gruiformes', 1, 13, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (106, N'Bộ ăn sâu bọ', N'Insectivora bowdich ', 1, 15, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (107, N'Bộ Thỏ', N'Lagomorpha', 1, 15, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (108, N' Bộ Sẻ', N'Passeriformes', 1, 13, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (109, N'Bộ cá vược', N'Percifomes', 1, 11, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (110, N'Bộ Tê tê', N'Pholidota', 1, 15, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (111, N' Bộ Gõ kiến', N'Piciformes', 1, 13, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (112, N'Bộ Linh trưởng', N'Primates', 1, 15, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (113, N' Bộ Vẹt', N'Psittaciformes', 1, 13, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (114, N'Bộ gặm nhấm', N'Rodentia ', 1, 15, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (115, N'Bộ nhiều răng', N'Scandenta', 1, 15, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (116, N'Bộ cá nheo', N'Silurifomes', 1, 11, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (117, N'Bộ Có vẩy', N'Squamata', 1, 14, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (118, N' Bộ Cú', N'Strigiformes', 1, 13, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (119, N'Bộ Lươn', N'Synbranchiformes', 1, 11, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (120, N'Bộ Rùa', N'Testudines', 1, 14, 0, NULL, NULL, CAST(N'2021-11-30T13:47:29.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (121, N' Bộ Nuốc', N'Trogoniformes', 1, 13, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_bo] ([id], [name], [name_latinh], [loai], [id_dtv_lop], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (124, N'test bộ', N'ĐÁAAD', 1, 11, 1, CAST(N'2023-12-03T20:38:42.810' AS DateTime), N'81b0366a-0d23-49c9-70f7-08dbb3fec38d', CAST(N'2023-12-03T20:38:42.810' AS DateTime), NULL)
SET IDENTITY_INSERT [dongthucvat].[dtv_bo] OFF
GO
SET IDENTITY_INSERT [dongthucvat].[dtv_ho] ON 

INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1, N'Họ Ô Rô', N' Acanthaceae', 0, 41, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (2, N'Họ thích', N' Aceraceae', 0, 77, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (3, N'Họ Dương Đào', N' Actinidiaceae', 0, 28, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (4, N'Họ Nguyệt xỉ', N' Adiantaceae', 0, 66, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (5, N'Họ Agao', N' Agavaceae', 0, 1, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (6, N'Họ Thôi Ba', N' Alangiaceae', 0, 19, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (7, N'Họ  Rau Dền', N' Amaranthaceae', 0, 15, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (8, N'Họ Lan Huệ', N' Amaryllidaceae', 0, 1, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (9, N'Họ Đào Lộn Hột', N' Anacardiaceae', 0, 74, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (10, N'Họ Trung Quân', N' Ancistrocladaceae', 0, 54, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (11, N'Họ Na', N' Annonaceae', 0, 2, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (12, N'Họ Hoa tán', N' Apiaceae', 0, 3, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (13, N'Họ Trúc Đào', N' Apocynaceae', 0, 73, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (14, N'Họ Nhựa Ruồi', N' Aquifoliaceae', 0, 4, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (15, N'Họ Môn', N' Araceae', 0, 5, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (16, N'Ngũ Gia Bì', N' Araliaceae', 0, 3, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (17, N'Họ Cau Dừa', N' Arecaceae', 0, 6, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (18, N'Họ Phòng Kỷ', N' Aristolochiaceae', 0, 61, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (19, N'Họ Thiên Lý', N' Asclepiadaceae', 0, 73, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (20, N'Họ Cau Xỉ', N' Aspleniaceae', 0, 66, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (21, N'Họ Cúc', N' Asteraceae (Compositae)', 0, 8, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (22, N'Họ Bóng nước', N' Balanophoraceae/Balsaminaceae', 0, 9, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (23, N'Họ Thu Hải Đường', N' Begoniaceae', 0, 20, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (24, N'Họ Duyên Mộc', N' Betulaceae', 0, 10, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (25, N'Họ Đinh', N' Bignoniaceae', 0, 41, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (26, N'Họ Ráng Dừa', N' Blechnaceae', 0, 66, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (27, N'Họ Bông gạo', N' Bombacaceae', 0, 49, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (28, N'Họ Vòi Voi', N' Boraginaceae', 0, 11, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (29, N'Họ Cải', N' Brassicaceae', 0, 14, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (30, N'Họ Thơm', N' Bromeliaceae', 0, 12, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (31, N'Họ Trám', N' Burceraceae', 0, 74, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (32, N'Tiết mi', N' Burmanniaceae', 0, 90, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (33, N'Họ Vang', N' Caesalpiniaceae', 0, 30, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (34, N'Họ Hoa Chuông', N' Campanulaceae', 0, 13, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (35, N'Họ Kim Ngân', N' Caprifoliaceae', 0, 25, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (36, N'Họ Chân Danh', N' Celastraceae', 0, 16, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (37, N'Họ Đỉnh tùng', N' Cephalotaxaceae', 0, 85, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (38, N'Họ cánh dơi', N' Cheiropleuriaceae', 0, 32, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (39, N'Họ Sói', N' Chloranthaceae', 0, 17, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (40, N'Họ Bứa (Măng Cụt)', N' Clusiaceae (Guttiferae )', 0, 36, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (41, N'Họ Bàng', N' Combretaceae', 0, 53, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (42, N'Họ Thài Lài', N' Commelinaceae', 0, 18, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (43, N'Họ Dây khế', N' Connaraceae', 0, 58, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (44, N'Họ Rau Muống', N' Convolvulaceae', 0, 82, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (45, N'Họ Mía dò', N' Costaceae', 0, 90, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (46, N'Họ Bầu Bí', N' Cucurbitaceae', 0, 20, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (47, N'Họ Dương Xỉ Mộc', N' Cyatheaceae', 0, 21, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (48, N'Họ Tuế', N' Cycadaceae', 0, 22, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (49, N'Họ Cói', N' Cyperaceae', 0, 40, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (50, N'Họ Đăng Tiết', N' Dennstaedtiaceae', 0, 66, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (51, N'Họ Cu li', N' Dicksoniaceae', 0, 21, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (52, N'Họ Sổ', N' Dilleniaceae', 0, 23, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (53, N'Họ Củ Nâu', N' Dioscoreaceae', 0, 24, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (54, N'Họ Dầu', N' Dipterocarpaceae', 0, 49, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (55, N'Họ Ráng áo sen', N' Dryopteridaceae', 0, 66, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (56, N'Họ Thị', N' Ebenaceae', 0, 84, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (57, N'Họ Côm', N' Elaeocarpaceae', 0, 26, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (58, N'Họ Mộc Tặc', N' Equisetaceae', 0, 27, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (59, N'Họ Đỗ quyên', N' Ericaceae', 0, 28, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (60, N'Họ Ba Mảnh Vỏ', N' Euphorbiaceae', 0, 29, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (61, N'Họ Đậu', N' Fabaceae', 0, 30, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (62, N'Họ Dẻ', N' Fagaceae', 0, 31, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (63, N'Họ Mùng Quân', N' Flacourtiaceae', 0, 88, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (64, N'Họ Mây Nước', N' Flagellariaceae', 0, 70, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (65, N'Họ Vọt, Tế', N' Gleicheniaceae', 0, 32, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (66, N'Họ Gắm', N' Gnetaceae', 0, 33, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (67, N'Họ Ráng lâm bài', N' Grammitidaceae', 0, 66, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (68, N'Họ Sau sau', N' Hamamelidaceae', 0, 34, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (69, N'Họ Mạch môn', N' Hemodoraceae (Convallariaceae)', 0, 7, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (70, N'Họ Thường sơn', N' Hydrangeaceae ', 0, 46, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (71, N'Họ  Hymenophyllaceae', N' Hymenophyllaceae', 0, 35, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (72, N'Họ Thụ Đào', N' Icacinacea', 0, 4, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (73, N'Họ Illiciaceae', N' Illiciaceae', 0, 37, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (74, N'Họ Lưỡi Đòng', N' Iridaceae', 0, 38, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (75, N'Họ Hồ Đào', N' Jugladaceae', 0, 39, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (76, N'Họ Hoa Môi', N' Lamiaceae', 0, 41, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (77, N'Họ Long Não', N' Lauraceae', 0, 42, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (78, N'Họ Gối Hạc', N' Leaceae', 0, 89, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (79, N'Họ Lộc Vừng', N' Lecythidaceae', 0, 43, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (80, N'Họ Bạch Huệ', N' Liliaceae (Convallariaceae)', 0, 44, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (81, N'Họ Mã Tiền', N' Loganiaceae', 0, 73, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (82, N'Họ Lomariposidaceae', N' Lomariposidaceae', 0, 66, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (83, N'Họ Tầm Gửi', N' Loranthaceae', 0, 76, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (84, N'Họ Thông Đất', N' Lycopodiaceae', 0, 47, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (85, N'Họ Bằng Lăng', N' Lythraceae', 0, 53, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (86, N'Họ Mộc Lan', N' Magnoliaceae', 0, 48, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (87, N'Họ Bông', N' Malvaceae', 0, 49, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (88, N'Họ Hoàng Tinh', N' Maranthaceae', 0, 90, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (89, N'Họ Móng ngựa', N' Marattiaceae', 0, 50, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (90, N'Họ Rau Bợ', N' Marsileaceae', 0, 75, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (91, N'Họ Mua', N' Melastomataceae', 0, 53, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (92, N'Họ Xoan', N' Meliaceae', 0, 74, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (93, N'Họ Dây Mối (Tiết Dê)', N' Menispermaceae', 0, 51, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (94, N'Họ Dâu Tằm', N' Moraceae', 0, 87, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (95, N'Họ Chuối', N' Musaceae', 0, 90, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (96, N'Máu chó', N' Myristicaceae', 0, 52, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (97, N'Họ Đơn Nem', N' Myrsinaceae', 0, 67, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (98, N'Họ Sim', N' Myrtaceae', 0, 53, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (99, N'Họ lam quả', N' Nyssaceae', 0, 19, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (100, N'Họ Mai', N' Ochnaceae', 0, 55, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (101, N'Họ nhài', N' Oleaceae', 0, 56, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (102, N'Họ Dừa Nước', N' Onagraceae', 0, 53, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (103, N'Họ Lân vĩ', N' Opiliaceae', 0, 76, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (104, N'Họ Lan', N' Orchidaceae', 0, 57, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (105, N'Họ lệ dương', N' Orobanchaceae', 0, 41, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (106, N'Họ Chua Me Đất', N' Oxalidaceae', 0, 58, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (107, N'Họ Dứa Gai', N' Pandanaceae', 0, 59, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (108, N'Họ Lạc Tiên', N' Passifloraceae', 0, 88, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (109, N'Họ Thông', N' Pinaceae', 0, 60, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (110, N'Họ Hồ Tiêu', N' Piperaceae', 0, 61, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (111, N'Họ  Plagiogyriaceae', N' Plagiogyriaceae', 0, 21, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (112, N'Họ Mã Đề', N' Plantaginaceae', 0, 41, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (113, N'Họ Hoà Thảo', N' Poaceae', 0, 62, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (114, N'Họ Kim Giao', N' Podocarpaceae', 0, 63, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (115, N'Họ Bần', N' Polygalaceae', 0, 53, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (116, N'Họ Bồ đề', N'Styracaceae', 0, 84, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (117, N'Họ Bồ Hòn', N'Sapindaceae', 0, 77, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (118, N'Họ Cà', N'Solanaceae', 0, 82, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (119, N'Họ Cà Phê', N'Rubiaceae', 0, 73, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (120, N'Họ Cam Quýt', N'Citrus', 0, 74, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (121, N'Họ Cỏ Roi Ngựa', N'Verbenaceae', 0, 41, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (122, N'Họ Đay', N'Malvaceae', 0, 49, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (123, N'Họ Du', N'Ulmaceae', 0, 87, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (124, N'Họ Dung', N'Symplocaceae', 0, 84, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (125, N'Họ Đước', N'Rhizophoraceae', 0, 45, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (126, N'Họ Gai', N'Cannabaceae', 0, 87, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (127, N'Họ Hoa Hồng', N'Rosaceae', 0, 72, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (128, N'Họ Mạ Xưa', N'Proteales', 0, 68, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (129, N'Họ Mao Lương', N'Ranunculaceae', 0, 69, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (130, N'Họ Nho', N'Vitaceae', 0, 89, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (131, N'Họ Rau Răm', N'Polygonaceae', 0, 65, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (132, N'Họ Rau Sam', N'Portulacaceae', 0, 15, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (133, N'Họ Sến (Hồng xiêm)', N'Nelumbonaceae', 0, 78, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (134, N'Họ Táo', N'Rhamnaceae', 0, 71, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (135, N'Họ Thanh Thất', N'Simaroubaceae', 0, 74, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (136, N'Họ Trà', N'Theaceae', 0, 86, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (137, N'Họ Trầm', N'Thymelaeaceae', 0, 49, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (138, N'Họ Trôm', N'Malvaceae', 0, 49, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (139, N'Họ Viễn Chí', N'Polygalaceae', 0, 64, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (140, N'Họ Xưn xe', N'Schisandraceae', 0, 37, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (141, N'Họ Dương Xỉ', N' Polypodiaceae', 0, 66, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (142, N'Họ Ráng seo gà', N' Pteridaceae', 0, 66, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (143, N'Họ Bòng Bong', N' Schizeaceae', 0, 79, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (144, N'Họ Quyển Bá', N' Selaginellaceae', 0, 80, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (145, N'Họ Kim Cang', N' Smilacaceae', 0, 81, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (146, N'Họ Bách Bộ', N' Stemonaceae', 0, 83, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (147, N'Họ Râu Hùm', N' Taccaceae', 0, 24, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (148, N'Họ Ráng thư dực', N' Thelypteridaceae', 0, 66, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (149, N'Họ ráng râu rồng', N' Vittariaceae', 0, 66, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (150, N'Ráng gỗ nhỏ', N' Woodsiaceae', 0, 66, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (151, N'Họ Gừng', N' Zingiberaceae', 0, 90, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (152, N'Họ Bún, Màn Màn', N'Capparaceae', 0, 14, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (153, N'Họ Phụ cánh bướm', N'Ceasalpinioideae', 0, 30, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (154, N'Họ Davaliaceae', N'Davaliaceae', 0, 66, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (155, N'Họ Phụ Đậu', N'Papilionoideae', 0, 30, 1, NULL, NULL, CAST(N'2022-11-15T16:00:30.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (156, N'Họ Phụ trinh nữ', N'Mimosoideae', 0, 30, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (157, N' Họ Hồng Hoàng', N' Bucerotidae', 1, 100, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (158, N'Họ Phường Chèo', N' Campephagidae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (159, N' Họ Ưng', N'Accipitridae', 1, 104, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (160, N'Họ Chim xanh', N'Aegithinidae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (161, N'Hộ Nhông', N'Agamidae', 1, 117, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (162, N' Họ Bồng chanh', N'Alcedinidae', 1, 100, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (163, N'Họ cá chình', N'Anguillidae', 1, 91, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (164, N' Họ Yến', N'Apodidae', 1, 93, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (165, N' Họ Diệc', N'Ardeidae', 1, 104, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (166, N'Họ Nhạn rừng', N'Artamidae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (167, N'Họ cá bám đá', N'Balitoridae', 1, 102, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (168, N'Họ cá nhói', N'Belonidae  ', 1, 95, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (169, N'Họ cá vây tia', N'Botiidae', 1, 102, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (170, N'Họ Trâu bò', N'Bovidae ', 1, 94, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (171, N'Họ Cóc', N'Bufonidae', 1, 92, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (172, N'Họ Chó', N'Canidae ', 1, 96, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (173, N' Họ Bìm Bịp', N'Centropodidae', 1, 101, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (174, N'Họ Khỉ', N'Cercopithecidae ', 1, 112, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (175, N'Họ Hươu nai', N'Cervidae ', 1, 94, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (176, N' Họ Bói cá', N'Cerylidae', 1, 100, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (177, N'Họ cá chuối', N'Channidae', 1, 109, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (178, N' Họ Chim xanh', N'Chloropseidae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (179, N' Họ Chiền chiện', N'Cisticolidae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (180, N'Họ cá trê', N'Clariidae', 1, 116, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (181, N'Họ cá chạch', N'Cobitidae', 1, 102, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (182, N'Họ Rắn nước', N'Colubridae', 1, 117, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (183, N' Họ Bồ Câu', N'Columbidae', 1, 99, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (184, N' Họ Sả rừng', N'Coraciidae', 1, 100, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (185, N' Họ Quạ', N'Corvidae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (186, N' Họ Cu Cu', N'Cuculidae', 1, 101, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (187, N'Họ Chồn dơi', N'Cynocephalidae ', 1, 103, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (188, N'Họ Cá chép', N'Cyprinidae', 1, 102, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (189, N'Họ Ếch nhái chính thức', N'Dicroglossidae', 1, 92, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (190, N'Họ Chèo bẻo', N'Dicruidae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (191, N'Họ Rắn hổ', N'Elapidae', 1, 117, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (192, N'Họ chuột voi', N'Erinaceidae ', 1, 106, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (193, N'Họ Chim di', N'Estrilidae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (194, N' Họ Mỏ rộng', N'Eurylamydae', 1, 111, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (195, N' Họ Cắt', N'Falconidae', 1, 104, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (196, N'Họ Mèo', N'Felidae ', 1, 96, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (197, N'Họ cá tỳ bà', N'Gastromyzontidae', 1, 102, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (198, N'Họ Tắc kè', N'Gekkonidae', 1, 117, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (199, N'Họ Rùa đầm', N'Geoemydidae', 1, 120, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (200, N'Họ cá bống trắng', N'Gobiidae', 1, 109, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (201, N' Họ Sả', N'Halcyonidae', 1, 100, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (202, N'Họ Cầy lỏn', N'Herpestidae ', 1, 96, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (203, N'Họ Dơi nếp mũi  ', N'Hipposideridae  ', 1, 97, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (204, N' Họ Nhạn', N'Hirundinidae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (205, N'Họ Vượn', N'Hylobatidae ', 1, 112, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (206, N'Họ Nhím', N'Hystricidae', 1, 114, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (207, N' Họ chim xanh', N'Irenidae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (208, N' Họ Bách thanh', N'Laniidae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (209, N'Họ Thỏ', N'Leporidae ', 1, 107, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (210, N'Họ Cu li', N'Loridae ', 1, 112, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (211, N'Họ Tê tê', N'Manidae ', 1, 110, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (212, N'Họ cá chạch sông', N'Mastacembelidae', 1, 119, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (213, N'Họ Dơi ma ', N'Megadermatidae ', 1, 97, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (214, N' Họ Cu rốc', N'Megalaimidae', 1, 100, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (215, N'Họ Cóc bùn', N'Megophryidae', 1, 92, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (216, N' Họ Trảu', N'Meropidae', 1, 100, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (217, N'Họ Nhái bầu', N'Microhylidae', 1, 92, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (218, N'Họ Đớp ruồi Monarch', N'Monarchidae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (219, N'Họ Chìa vôi', N'Motacillidae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (220, N'Họ Chuột', N'Muridae', 1, 114, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (221, N' Họ Đớp ruồi', N'Muscicapidae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (222, N'Họ Chồn', N'Mustelidae ', 1, 96, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (223, N' Họ Hút mật', N'Nectariniidae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (224, N'Họ cá chạch suối', N'Nemacheilidae', 1, 102, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (225, N'Họ Vàng anh', N'Oriolidae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (226, N'Họ cá tai tượng', N'Osphronemidae', 1, 109, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (227, N' Họ Bạc má', N'Paridae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (228, N' Họ Sẻ', N'Passeridae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (229, N'Họ cá rô mó', N'Percichthyidae', 1, 109, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (230, N' Họ Trĩ', N'Phasianidae', 1, 104, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (231, N' Họ Gõ kiến', N'Picidae', 1, 111, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (232, N' Họ Đuôi cụt', N'Pittidae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (233, N'Họ Rùa đầu to', N'Platysternidae', 1, 120, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (234, N'Họ cá rô biển', N'Pristolepididae', 1, 109, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (235, N' Họ Vẹt', N'Psittacidae', 1, 113, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (236, N'Họ Sóc cây', N'Pteromyidae ', 1, 114, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (237, N'Họ Dơi quả', N'Pteropodidae ', 1, 97, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (238, N' Họ Chào mào', N'Pycnonotidae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (239, N'Họ Trăn', N'Pythonidae', 1, 117, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (240, N' Họ Gà nước', N'Rallidae', 1, 105, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (241, N'Họ Ếch nhái', N'Ranidae', 1, 92, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (242, N'Họ Ếch cây', N'Rhacophoridae', 1, 92, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (243, N'Họ Dơi lá mũi', N'Rhinolophidae ', 1, 97, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (244, N'Họ Rẻ quạt', N'Rhiphiduradae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (245, N'Họ Dúi', N'Rhizomyidae', 1, 114, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (246, N'Họ Thằn lằn bóng', N'Scincidae', 1, 117, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (247, N' Họ Rẽ', N'Scolopacidae', 1, 98, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (248, N'Họ cá chiên', N'Sisoridae', 1, 116, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (249, N' Họ Trèo cây', N'Sittidae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (250, N'Họ Chuột chù', N'Soricidae G.Fischer, 1814', 1, 106, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (251, N' Họ Cú', N'Strigidae', 1, 118, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (252, N' Họ Sáo', N'Sturnidae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (253, N'Họ Lợn', N'Suidae ', 1, 94, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (254, N'Họ Chim chích', N'Sylviidae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (255, N'Họ Lươn', N'Synbranchidae', 1, 119, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (256, N'Họ chuột chũi', N'Talpidae ', 1, 106, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (257, N'Họ Rùa núi', N'Testudinidae', 1, 120, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (258, N'Họ Khướu', N'Timaliidae', 1, 108, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (259, N'Họ Cheo cheo', N'Tragulidae ', 1, 94, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (260, N'Họ Ba ba', N'Trionychidae', 1, 120, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (261, N' Họ Nuốc', N'Trogonidae', 1, 121, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (262, N'Họ Đồi', N'Tupaiidae', 1, 115, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (263, N' Họ Cun cút', N'Turnicidae', 1, 105, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (264, N'Họ Gấu', N'Ursidae ', 1, 96, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (265, N'Họ Kỳ đà', N'Varanidae', 1, 117, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (266, N'Họ Dơi muỗi', N'Vespertilionidae ', 1, 97, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (267, N'Họ Rắn lục', N'Viperidae', 1, 117, 0, NULL, NULL, CAST(N'2021-11-30T13:56:32.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (268, N'Họ Cầy', N'Viverridae ', 1, 96, 0, NULL, NULL, CAST(N'2021-11-30T13:56:31.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (269, N' Họ Vành khuyên', N'Zosteropidae', 1, 108, 1, NULL, NULL, CAST(N'2021-11-29T16:05:23.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (272, N'Nguyễn Văn A', N'1', 0, NULL, 1, CAST(N'2023-08-11T21:43:42.777' AS DateTime), N'1d6c5e6f-0993-4633-2fef-08db97f2b22e', CAST(N'2023-08-11T21:43:42.777' AS DateTime), NULL)
INSERT [dongthucvat].[dtv_ho] ([id], [name], [name_latinh], [loai], [id_dtv_bo], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (273, N'test họ', N'ĐDDẤDASDSA', 1, 91, 1, CAST(N'2023-12-03T20:38:56.303' AS DateTime), N'81b0366a-0d23-49c9-70f7-08dbb3fec38d', CAST(N'2023-12-03T20:38:56.303' AS DateTime), NULL)
SET IDENTITY_INSERT [dongthucvat].[dtv_ho] OFF
GO
SET IDENTITY_INSERT [dongthucvat].[dtv_loai] ON 

INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1, N'Thông đất ', N'Lycopodium cernua (L.) Franco & Vasc', 0, 84, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (2, N'Quyển bá doderlein', N'Selaginella doderleinii Hieron.', 0, 144, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (3, N'Quyển bá quấn', N'S. involvens (Sw.) Spring.', 0, 144, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (4, N'Quyển bá Petelo', N'S. petelotii Aston', 0, 144, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (5, N'Quyển bá trâu', N'S. repanda (Desv.) Spring', 0, 144, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (6, N'Quyển bá yếu', N'S. delicatula (Desv.) Alst.', 0, 144, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (7, N'Mộc tặc yếu', N'Equisetum  ramosissimum Devs.', 0, 58, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (8, N'Tóc xanh', N'Adiantum flabellulatum L. ', 0, 4, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (9, N'Tóc thần Philipin', N'A. philippense L.', 0, 4, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (10, N'Ráng nguyệt xỉ cứng', N'A. induratum Chr.', 0, 4, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (11, N'Nguyệt xỉ', N'A. diaphanum Bl.', 0, 4, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (12, N'Lưỡi heo', N'Antrophyum annamensis Chr. & Tard.', 0, 4, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (13, N'Ráng lưỡi heo dài', N'A. coriaceum (D. Don) Wall.', 0, 4, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (14, N'Thần mô lá mảnh', N'Cheilanthes tenuifolia (Burm. f.) Sw.', 0, 4, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (15, N'Dê xỉ giác', N'Onychium siliculosum (Desv.) C. Chr.', 0, 4, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (16, N'Ráng chò chanh', N'Pityrogramma culomelanos (L.) Link.', 0, 4, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (17, N'Ráng hình dải', N'Taenitis blechnoides (Willd.) Sw.', 0, 4, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (18, N'Can xỉ có đuôi', N'Asplenium cheilosorum O. Kuntze ex Mett', 0, 20, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (19, N'Ráng can xỉ thay đổi', N'A. varians Wall ex Hook. & Grew.', 0, 20, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (20, N'Ráng can xỉ gươm', N'A. ensiforme Wall. Ex Hook. f.', 0, 20, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (21, N'Ráng ô phụng', N'A. nidus L.', 0, 20, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (22, N'Ráng can xỉ colani', N'A. colaniae Tard.-Blot.', 0, 20, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (23, N'Ráng can xỉ bầu dục', N'A. antrophyoides Chr.', 0, 20, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (24, N'Ráng can xỉ giáp', N'A. loriceum Chr.', 0, 20, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (25, N'Ráng can xỉ đá', N'A. saxicola Rosenst', 0, 20, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (26, N'Ráng can xỉ có lông', N'A. crinicaule Hance', 0, 20, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (27, N'Ráng can xỉ Hải nam', N'A. hainanense Ching.', 0, 20, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (28, N'Cẩm cù', N'Hoya sp.', 0, 20, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (29, N'Song ly nhọn', N'Dischidia acuminata Cost.', 0, 20, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (30, N'Bông tai', N'Asclepias curassavica L.', 0, 20, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (31, N'Tổ điểu grifít', N'Asplenium griffithianum Hook.', 0, 20, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (32, N'Tổ điểu thường', N'Asplenium normale D. Don', 0, 20, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (33, N'Tổ điểu vrai', N'Asplenium wrightii Eaton ex Hook.', 0, 20, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (34, N'Tổ điểu lá gần thìa là', N'Asplenium sublaserpitiifolium Ching ex Tardieu & Ching', 0, 20, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (35, N'Quyết lá dừa', N'Blechnum orientale L.', 0, 26, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (36, N'Ráng bích hoạ háclăng', N'Woodwardia harlandii Hook.', 0, 26, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (37, N'Ráng thần trắc', N'Cheiropleuria bicuspis (Blume) C. Presl,', 0, 38, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (38, N'Ráng gỗ dày', N'Cyathea podophylla (Hook.) Copel.', 0, 47, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-11T09:06:45.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (39, N'Ráng gỗ salét', N'Cyathea salletti Tardieu & C. Chr.', 0, 47, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (40, N'Ráng tiên toạ ', N'Cyathea cotaminans (Hook.) Copel.', 0, 47, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (41, N'Ráng tiên toạ rộng', N'C. latebrosa (Hook.) Copel.', 0, 47, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-11T08:30:17.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (42, N'Tiên toạ khổng lồ', N'C. gigantea (Hook.) Holtt.', 0, 47, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (43, N'Ráng đà hoa griffit', N'Davallia griffithiana Hook.', 0, 154, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (44, N'Ráng đà hoa to', N'Davallia divaricata Blume', 0, 154, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (45, N'Ráng đăng tiết nhám', N'Dennstaedtia seabra (Hook.) Moore', 0, 50, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (46, N'Seo gà', N'Lindsaea ensiformis L.', 0, 50, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (47, N'Ráng vi lân bìa', N'Microlepia marginata (Hoult.) C. Chr.', 0, 50, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (48, N'Ráng vi lân nhám', N'M. strigosa (Thunb.) Presl.', 0, 50, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (49, N'Ráng đai dực', N'Pteridium aquilinum (L.) Kuhn.', 0, 50, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (50, N'Ráng liên sơn tròn', N'Lindsaea orbiculata (Lam.) Mett. ex Kuhn', 0, 50, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (51, N'Ráng liên sơn sáng', N'Lindsaea lucida Blume', 0, 50, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (52, N'Ráng vi lân húc-cơ', N'Microlepia hookeriana (Wall. ex Hook.) C. Presl', 0, 50, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (53, N'Ráng vi lân tam giác', N'Microlepia trapeziformis (Roxb.) Kuhn', 0, 50, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (54, N'Ráng ổ phỉ tàu', N'Sphaeromeris chinensis L.', 0, 50, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (55, N'Cẩu tích', N'Cibotium barometz (L.) Smith.', 0, 51, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-11T08:45:49.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (56, N'Lông cu li', N'Cibotium bazometz (L.) J. Sm.', 0, 51, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2022-11-17T20:45:07.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (57, N'Ráng áo lọng', N'Cyclopeltis crenata C. Chr.', 0, 55, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (58, N'Ráng xuyên quần', N'Diacalpe aspidioides Blume', 0, 55, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (59, N'Ráng cánh bần nâu', N'Dryopteris fuscipes C. Chr.', 0, 55, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (60, N'Ráng cánh bần oalích', N'Dryopteris wallichiana (Spreng.) Hyl.', 0, 55, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (61, N'Ráng cánh bần thanh', N'Dryopteris polita Roenst.,', 0, 55, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (62, N'Ráng cánh bần khác', N'Dryopteris varia (L.) Kuntze', 0, 55, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (63, N'Ráng nhiều hàng đẹp', N'Polystichum amabile (Blume) J. Sm.', 0, 55, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (64, N'Ráng yểm dực ba lưỡi', N'Tectaria triglossa Tardieu & C. Chr.', 0, 55, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (65, N'Tế, Vọt', N'Dicranopteris linearis (Burzm.) Underw.', 0, 65, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (66, N'Ráng lưỡng phân', N'D. dichotoma (Thunb.) Bernh.', 0, 65, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (67, N'Lâm bài lông', N'Grammitis dorsipila (Chr.) C. Chr. & Tard.', 0, 67, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (68, N'Ráng song tự đỉnh rộng', N'Loxogramme acroscopa (Chr.) C. Chr.', 0, 67, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (69, N'Ráng trăm dực nha trang', N'Ctenopteris nhatrangensis (C. Chr. & Tardieu', 0, 67, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (70, N'Ráng lâm bài nêm', N'Grammitis cuneifolia Copel.', 0, 67, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (71, N'Thường sơn', N'Dichroa febrifuga Lour.', 0, 70, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (72, N'Thường sơn lông', N'Dichroa hirsuta Gagnep.', 0, 70, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (73, N'Ráng màng poilan', N'Hymenophyllum poilanei Tardieu & C. Chr.,', 0, 71, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (74, N'Ráng màng gẫy có tai', N'Crepidomanes auriculatum (Blume) K. Iwats.', 0, 71, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (75, N'Móng ngựa trung', N'Angiopteris annamensis C. Ch & Tard.', 0, 89, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (76, N'Móng ngựa nam', N'A. cochinchinensis de Vriese', 0, 89, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (77, N'Hiển dực', N'A. evecta (Forst.) Hoffm.', 0, 89, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (78, N'Hiển dực cọ', N'A. palmaeformis (Cav.) Chr.', 0, 89, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (79, N'Ráng ma', N'A. repandula de Vriese', 0, 89, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (80, N'Cổ hiển', N'Archangiopteris cadieri Tard. & Christ', 0, 89, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (81, N'Rau bợ', N'Marsilea quadriflia L.', 0, 90, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (82, N'Rau bợ răng', N'M. crenata Prese.', 0, 90, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (83, N'Ráng bích xỉ thừa', N'Bolbitis appendiculata (Willd.) K. Iwats.', 0, 82, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (84, N'Ráng bích xỉ hình tim', N'Bolbitis subcordata (Copel.) Ching ex C. Chr.', 0, 82, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (85, N'Thạch tùng răng cưa', N'Huperzia serrata (Thunb.) Trevis.', 0, 84, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2022-11-17T20:55:14.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (86, N'Ráng long cuốc', N'Alaomorpha coronans (Mett.) Copel.', 0, 141, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (87, N'Quyết tiến lá chân vịt', N'Colysis digitata (Bak.) Ching', 0, 141, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (88, N'Quyết tiêu', N'C. henryi', 0, 141, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (89, N'Ráng cổ lý bầu dục', N'Colysis pothifolia (D. Don) Presl.', 0, 141, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (90, N'Ráng đuôi phượng, Tắc kè đá', N'Drynaria bonii Christ.', 0, 141, 0, 25, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-11T09:09:27.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (91, N'Cốt toái bổ lá to', N'Drynaria quercifolia (L.) J.Sm.', 0, 141, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (92, N'Ráng bạch thiệt', N'Leptochilus axillaris (Cav.) Kaulf.', 0, 141, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (93, N'Ráng mảnh diệp', N'Lemmaphyllum micrpophyllum C. Chr.', 0, 141, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (94, N'Ráng quần lân có mũi', N'Lemmaphyllum subprostratum (C.Chr.) C.Chr. & Tardieu ', 0, 141, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (95, N'Ráng vi quần hancock', N'Microsorum hancockii (Back.) Ching', 0, 141, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (96, N'Ráng vi quần đốm', N'M. punctatum (L.) Copel.', 0, 141, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (97, N'Ráng thư hàng', N'Phymatorus nigrescens (Bl.) Pic.Ser.', 0, 141, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (98, N'Ổ rồng', N'Platycerium coronarium (Koen.) Desv.', 0, 141, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (99, N'Ổ rồng cánh', N'P. grande A. Cunn. ex J. Sm.', 0, 141, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (100, N'Ráng mạc lưỡi', N'P. lingua (Thunb.) Farw.', 0, 141, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (101, N'Ráng hòa mạc lá dài', N'Pyrrosia longifolia (Burm.) Morton.', 0, 141, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (102, N'Ráng da rồng trung', N'Belvisia annamensis (C. Chr.) Tagawa', 0, 141, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (103, N'Ráng cổ lý phai', N'Colysis hemionitideus (Wall. ex Mett.) Copel.', 0, 141, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (104, N'Ráng cổ lý vu', N'Colysis wui (C. Chr.) Ching', 0, 141, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (105, N'Ráng ngón tay bề mặt', N'Neocheiropteris superficialis (Blume) Bosman', 0, 141, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (106, N'Ráng ổ chìm lưỡi hươu', N'Phymatosorus scolopendria (Burm.f.) Ric. Serm.', 0, 141, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (107, N'Ráng tai chuột đồng tiền', N'Pyrrosia nummularifolia (Sw.) Ching', 0, 141, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (108, N'Seo gà', N'Pteris biaurita L.', 0, 142, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (109, N'Ráng chân xỉ hình gươm', N'P. ensiformis Burm.f.', 0, 142, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (110, N'Ráng chân xỉ greville', N'P. grevilleana Wall. ex Ag.', 0, 142, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (111, N'Ráng chân xỉ', N'P. linearis Poir.', 0, 142, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (112, N'Ráng chân xỉ eo', N'P. decrescens Chr.', 0, 142, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (113, N'Ráng chân xỉ finet', N'P. finotii Chr.', 0, 142, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (114, N'Chân xỉ gân đỏ', N'Porphyrophlebia C.chr&Ching', 0, 142, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (115, N'Ráng sẹo gà đặc biệt', N'Pteris insignis Mett.', 0, 142, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (116, N'Ráng sẹo gà dài', N'Pteris longipes D. Don', 0, 142, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (117, N'Ráng seo gà ', N'Pteris multifida Poir.', 0, 142, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (118, N'Quyết đuôi lông chim', N'Pteris semipinnata L.', 0, 142, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (119, N'Cỏ rết', N'P. vittata L.', 0, 142, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (120, N'Ráng bình chu', N'Plagiogyria adnata (Blume) Bedd.', 0, 111, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (121, N'Bòng bong tai', N'Lygodium auriculatum (Willd.) Alst', 0, 143, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (122, N'Bòng bong tơ', N'L. conferme C. Chr.', 0, 143, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (123, N'Bòng bong lá liễu', N'L. flexuosum (L.) Sw.', 0, 143, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (124, N'Hải kim sa', N'L. japonicum (Thunb.) Sw.', 0, 143, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (125, N'Bòng bong lá nhỏ', N'L. microstachyum Desv.', 0, 143, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (126, N'Bòng bong lá liễu', N'L. salicifolium Presl.', 0, 143, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (127, N'Quyết long bắc', N'Cyclosorus balansae', 0, 148, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (128, N'Dương xỉ thường', N'Cyclosorus parasiticus (L.) Farw.', 0, 148, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (129, N'Ráng thận', N'Pronephrium sp.', 0, 148, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (130, N'Ráng thận đỏ', N'Pronephrium lakhimpurense (Rosenst.) Holttum', 0, 148, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (131, N'Ráng thận trần', N'Pronephrium nudatum (Roxb.) Holttum', 0, 148, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (132, N'Ráng thận lượn sóng', N'Pronephrium repandum (Fée) Holttum', 0, 148, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (133, N'Ráng bạc tự thường', N'Stegnogramma dictyoclinoides Ching', 0, 148, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (134, N'Ráng râu rồng ăm bôi', N'Vittaria amboinensis Fée', 0, 149, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (135, N'Ráng râu rồng kéo dài', N'Vittaria elongata Sw.', 0, 149, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (136, NULL, N'Athyrium mackinonii', 0, 150, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (137, N'Ráng sông quần xẻ', N'Diplazium pinnatifido-pinnatum (Hook.) Moore', 0, 150, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (138, N'Song quần', N'D. conterminum Christ', 0, 150, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (139, N'Ráng song quần đa túc', N'D. polypodiodes Bl.', 0, 150, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (140, N'Đỉnh tùng', N'Cephalotaxus manii Hook. f.', 0, 37, 24, 25, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (141, N'Thiên tuế gân chìm', N'Cycas immersa Craib. ', 0, 48, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (142, N'Gắm bẹt', N'Gnetum gnemonoides Brongn.', 0, 66, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (143, N'Gắm lá rộng', N'Gnetum latifolium Blume.', 0, 66, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2022-11-15T17:15:57.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (144, N'Gắm', N'G. leptostachyum Bl.', 0, 66, 27, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (145, N'Gắm núi', N'G. montanum Margf.', 0, 66, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (146, NULL, N'G. formosum Margf.', 0, 66, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (147, N'Sam bông núi đất', N'Keteeleria everyana Mast.', 0, 109, 25, 25, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (148, N'Thông nàng', N'Dacrycarpus imbricatus (Bl.) de Laub.', 0, 114, 27, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (149, N'Thông tre lá dài', N'Podocarpus neriifolius D. Don.', 0, 114, 27, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (150, N'Thông tre lá ngắn', N'P. pilgeri Foxw.', 0, 114, 27, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (151, N'Kim giao núi đất', N'Nageia wallichiana (C. Presl.) O. Kuntze', 0, 114, 27, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (152, N'Hoàng đàn giả', N'Dacrydium elatum (Roxb.) Wall. ex Hook', 0, 114, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2022-11-15T17:25:00.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (153, N'Ô rô núi', N'Acanthus leucostachyus Wall.', 0, 1, 27, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (154, N'Phẩm rô', N'Baphicacanthus cusia', 0, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (155, N'Chuỳ hoa tím', N'Strobilanthes hossei Wang,', 0, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (156, NULL, N'Asystasia gangetica (L.). T.', 0, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (157, NULL, N'Clinacanthus nutans (Burm.f.) Lindau.', 0, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (158, N'Nổ', N'Dipteracanthus repens (L.) Hassk.', 0, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (159, N'Đình lình', N'Hygrophila incana', 0, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (160, NULL, N'Isoglossa inermis (R. Ben) B. Hans.', 0, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (161, N'Xuân tiết bông', N'J. ventricosa Wall.', 0, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (162, N'Xuân tiết ', N'Justica fragilis Wall.', 0, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (163, N'Nhuỵ thập thảo', N'Staurogyne bella Brem.', 0, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (164, N'Nhụy chập', N'Stauroryne glauca', 0, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (165, N'Nhụy thập', N'Staurogyne petelotii', 0, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (166, N'Chuỳ hoa', N'Strobilanthes tonkinensis Lind.', 0, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (167, N'Cát đằng', N'Thunbergia alata Boy ex Sims', 0, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (168, N'Thích núi cao, Sau sau núi', N'Acer aff. campbellii Hook. f. & Thoms. ex Hiern', 0, 2, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (169, N'Thích mười nhị', N'Acer laurinum Hasski', 0, 2, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (170, N'Thích bắc bộ', N'Acer tonkinensis Lecomte', 0, 2, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (171, N'Sổ đá', N'Saurauja roxburghii Wall.', 0, 3, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (172, N'Sổ đá rè pan', N'S. nepanlensis DC.', 0, 3, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (173, N'Thôi chanh lá thuôn', N'Alangium salviifolium Wargern.', 0, 6, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (174, N'Thôi chanh', N'A. chinensis (Lour.) Harm', 0, 6, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (175, N'Thôi ba', N'Alangium tonkinense', 0, 6, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (176, N'Nang', N'Alangium nidley', 0, 6, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (177, N'Dền gai', N'Amaranthus spinosus L. ', 0, 7, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (178, N'Dền', N'A. tricolor L.', 0, 7, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (179, N'Dền xanh', N'A. viridis L.', 0, 7, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (180, N'Cỏ xước', N'Achyranthes aspera L.', 0, 7, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (181, N'Cỏ xước 2 răng ', N'A. bidentata Bl.', 0, 7, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (182, N'Rau dệu', N'Alternanthera paronychioides A. St. Hilaire.', 0, 7, 0, 26, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-11T09:15:10.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (183, N'Mào gà', N'Celosia argentea L.', 0, 7, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (184, N'Dâu gia xoan', N'Allospondias lakonensis (Pierre) Stap.', 0, 9, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (185, N'Long cóc', N'Dracuntomelon schmidii Tard.', 0, 9, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (186, N'Sơn lá đơn', N'Gluta gracilis Evr.', 0, 9, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (187, N'Xoài hôi', N'Mangifera foetida Lour.', 0, 9, 24, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (188, N'Xoài', N'M. indica L.', 0, 9, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (189, N'Muối', N'Rhus javanica L.', 0, 9, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (190, N'Xưng đào', N'Semecarpus anacardiopsis Evr. & Tard.', 0, 9, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (191, N'Xưng trung bộ', N'Semecarpus annamensis', 0, 9, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (192, N'Sơn lắc', N'Toxicodendron succedana (L.) Mold.', 0, 9, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (193, N'Trung quân', N'Ancistrocladus tectorius (Lour.) Merr.', 0, 10, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (194, N'Na', N'Annona squamosa L.', 0, 11, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (195, N'Mãng cầu', N'A. muricata L.', 0, 11, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (196, N'Công chúa', N'Artabotrus fragrans', 0, 11, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (197, N'Huyệt hùng Wray', N'Cyathostemma Wrayi King', 0, 11, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (198, N'Gié núi', N'Desmos chinhensis (Fin & Gagn) Merr', 0, 11, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (199, N'Giẻ nam bộ', N'Desmos cochinchinensis Lour.', 0, 11, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (200, N'Giác đế nhiều noãn', N'Goniothalamus multiovulatus Ast.', 0, 11, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (201, N'Lèo heo', N'Enicosanthellum sp.', 0, 11, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (202, N'Cách thư', N'Fissistigma oldhami (Heml.) Merr.', 0, 11, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (203, N'Bàn thư không cọng', N'Meiogyne subsessilis (Ast.) Sincl. ', 0, 11, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (204, NULL, N'Mitrephora poilei Weerasooriya & R. M. K. Saunders', 0, 11, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (205, N'Mạo đài', N'Mitrephora phanrangensis', 0, 11, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (206, N'Tháp hình', N'Orophera thorelii Pierre', 0, 11, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (207, N'Tháp hình', N'Orophera polycarpa', 0, 11, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (208, NULL, N'Polyalthia blume', 0, 11, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (209, N'Quần đầu', N'Polyalthia clemensorum Ast.', 0, 11, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (210, N'Quần đầu xanh', N'Polyalthia viridis', 0, 11, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (211, N'Mã trích', N'P. jucunda (Pierre) Fin. & Gagn.', 0, 11, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (212, N'Quần đầu nhiều bông', N'Polyalthia floribunda Ast', 0, 11, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (213, N'Bồ quả lá to', N'Uvaria cordata (Dun.) Wall. ex Alston', 0, 11, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (214, N'Bồ quả tái', N'U. lurida Hook. f. & Thoms.', 0, 11, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (215, N'Giền', N'Xylopia vielana Pierre ex Fin & Gagn.', 0, 11, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (216, N'Rau má', N'Centella asiatica (L.) Urb.', 0, 12, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (217, N'Xà xàng', N'Cnidium monnierii (L.) Cusson ', 0, 12, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (218, N'Mùi tàu', N'Eryngium foetidum L.', 0, 12, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (219, N'Rau má nhỏ', N'Hydnocotyle sibthorpioides Lamk.', 0, 12, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (220, N'Khồm', N'Trachyspermum roxburghianum (DC.) Crai.', 0, 12, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (221, N'Mò cua', N'Alstonia scholaris (L.) R. Br.', 0, 13, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (222, N'Ngôn chum', N'Alyxia racemosa Pit.', 0, 13, 27, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (223, N'Ngôn reinward', N'Alyxia reinwardtii Blume', 0, 13, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (224, N'Ngôn thái', N'Alyxia siamensis Pit', 0, 13, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (225, N'Bù liêu dây leo', N'Bousingonia makongense Pierre in Pl.', 0, 13, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (226, N'Thừng mực', N'Holarrhena pubescens (Buch.-Ham) Wall. ex G. Don', 0, 13, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (227, N'Hồ liên nhỏ', N'H. curtisii King & Gamble', 0, 13, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (228, N'Bèn bai', N'Hunteria zeylanica (Retz.) Gardn. & Thw.', 0, 13, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (229, N'Cốp', N'Kopsia harmandiana Pierre ex Pit.', 0, 13, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (230, N'Giom', N'Melodinus annamense Pit. ', 0, 13, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (231, N'Mạc sang hoa nhỏ', N'Parabarium micranthum (A. DC.) Pierre ex Spire', 0, 13, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (232, N'So cam', N'Pottsia indora Pit.', 0, 13, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (233, N'Ba gạc căm bốt', N'Rauvolfia cambodiana Pierre ex Pit', 0, 13, NULL, 25, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (234, N'Ba gạc vòng', N'Rauvolfia verticillata (Lour.) Baill.', 0, 13, NULL, 25, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (235, N'Sừng dê', N'Strophanthus divaricatus (Lour.) Hook. et Arn.', 0, 13, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (236, N'Lài châu', N'Tabernaemontana bovina Lour. ', 0, 13, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (237, N'Lài trâu lá nhỏ', N'Tabernaemontana bufalina Lour.', 0, 13, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (238, N'Lòng mức Trung bộ', N'Wrightia annamensis Eb. & Dub.', 0, 13, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (239, N'Lòng mức ngờ', N'Wrightia dubia', 0, 13, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (240, N'Bùi nam bộ', N'Ilex cochinchinensis (Lour.) Loesen', 0, 14, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (241, N'Bùi có răng', N'I. crenata Thunb.', 0, 14, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (242, N'Bùi bắc bộ', N'I. tonkiniana Loesen', 0, 14, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (243, N'Bùi ba hoa', N'I. triflora Bl. ', 0, 14, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (244, N'Cuồng', N'Aralia armata Seem.', 0, 16, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (245, N'Đơn Châu chấu', N'Aralia tnaranensis Ha', 0, 16, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (246, NULL, N'Brassaiopsis glomerulata (Bl.) Regel.', 0, 16, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (247, N'Phong hà', N'Dendropanax chevalieri (R. Vig.) Merr.', 0, 16, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (248, N'Diện bạch', N'Dendropanax poilanei Bai', 0, 16, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (249, N'Đại đinh hai hạt', N'Macropanax dispermus (Bl.) Kuntz.', 0, 16, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (250, N'Chân chim', N'Schefflera octophylla (Lour.) Harms.', 0, 16, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (251, N'Chân chim Vidal', N'S. vidaliana Shang.', 0, 16, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (252, N'Chân chim cầu', N'Schefflera globulifera Grushv&Skvorst ', 0, 16, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (253, N'Chân chim Pa cô', N'Schefflera pacoensis', 0, 16, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (254, N'Nhật phiến', N'Treevesia palmata (Roxb. & Lindl.) Visiani', 0, 16, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (255, N'Rễ gió, Sơn dịch', N'Aristolochia contorta Bunge ', 0, 18, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (256, N'Sơn dịch dây leo', N'Aristolochia piperrei H. Lec', 0, 18, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (257, N'Sơn dịch', N'Aristolochia pothieri', 0, 18, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (258, NULL, N'A. tagala Chamiss', 0, 18, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (259, N'Biến hoá núi cao, Trần thiên thảo', N'Asarum balansae Franch in Morot.', 0, 18, 1, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-11T09:21:28.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (260, N'Bông tai', N'Asclepias curassavica L.', 0, 19, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (261, N'Ân lân', N'Criptolepsis buchananii Roem & Sch.', 0, 19, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (262, N'Ẩn lân balansa', N'Criptolepis balansae', 0, 19, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (263, N'Song ly nhọn', N'Dischidia acuminata Cost.', 0, 19, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (264, N'Song ly Balansa', N'Dischidia balansae Cost…', 0, 19, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (265, N'Hồ da ký sinh', N'hoya parasitica', 0, 19, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (266, N'Hồ da trẻ', N'Hoya pubens', 0, 19, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (267, NULL, N'Marsdenia Sp', 0, 19, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (268, N'Ngũ giác', N'Pentaoacme brachganthum', 0, 19, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (269, N'Hà thủ ô nam', N'Streptocaulon juventus (Lour.) Merr.', 0, 19, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (270, N'Thiên lý', N'Telosma cordata (Burm.f.) Merr.', 0, 19, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (271, N'Cỏ cứt lợn', N'Ageratum conyzoides L.', 0, 21, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (272, N'Tuyến hùng lá to', N'Adenostemma macrophyllum', 0, 21, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (273, N'Hoa sinh  viên', N'Bidens bipinnata L.', 0, 21, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (274, N'Xương sông', N'Blumea lanceolata (Roxb.) Druce', 0, 21, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (275, N'Kim đấu', N'Blumea lacera', 0, 21, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (276, N'Cỏ sữa', N'Cirsium japonicum Maxim', 0, 21, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (277, N'Rau tàu bay', N'Crassocephalum crepidioides (Benth.) ', 0, 21, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (278, N'Cỏ mực', N'Eclipta prostrata (L.) L.', 0, 21, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (279, N'Cỏ lào', N'Eupatorium odoratum L.', 0, 21, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-07-11T08:04:00.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (280, N'Rau cóc', N'Grangea maderaspatann (L.) Poir.', 0, 21, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (281, N'Hy thiêm', N'Sigesbeckia orientalis L.', 0, 21, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (282, N'Quỳ', N'Tithonia diversifolia (Hemsl.) A. Gray', 0, 21, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (283, N'Bạch đầu ông', N'Vernonia cinerea (L.) Less', 0, 21, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (284, N'Bạch đầu to', N'V. macrachaenia Gagn.', 0, 21, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (285, N'Nấm đất', N'Balanophora aff. laxiflora Hemsl.', 0, 22, 4, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-07-11T09:24:14.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (286, N'Bóng nước hoa tím', N'Impatien sp.', 0, 22, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (287, N'Móc tai chìa khóa', N'Impatiens claviger', 0, 22, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (288, N'Thu hải đường không cánh', N'Begonia aptera Bl.', 0, 23, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2022-11-23T13:41:26.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (289, N'Thu hải đường cuống ngắn', N'begonia abbreviata', 0, 23, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2022-11-23T13:38:47.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (290, N'Mắt đá', N'B. boisiana Gagn.', 0, 23, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (291, N'Chân vịt tía', N'B. eberhardtii Gagn.', 0, 23, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (292, N'Thu hải đường hoa thơm', N'Begonia handelii Irmsch.', 0, 23, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (293, N'Duyên mộc', N'Carpinus viminea Lindl. in Wall.', 0, 24, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (294, N'Núc nác', N'Oroxylon indicum (L.) vent ', 0, 25, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (295, N'Rè', N'Rademachera eberhardtii Dop.', 0, 25, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (296, N'Rè trung quốc', N'R. sinica (Hance) Hemsl.', 0, 25, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (297, NULL, N'Stereospermum colais (Dillw.) Mabb', 0, 25, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (298, N'Khé núi', N'S. neuranthum Kurz.', 0, 25, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (299, N'Gạo rừng', N'Bombac ceiba L.', 0, 27, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (300, N'Gòn', N'Ceiba pentandra (L.) Gagn.', 0, 27, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (301, N'Tâm mộc', N'Cordia grandis Roxb. ', 0, 28, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (302, N'Tai mèo, Vông vàng', N'Cynoglossum zeylanicum (Vahl.) Thunb ex Lehm', 0, 28, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (303, N'Vòi voi', N'Heliotropium indicum L.', 0, 28, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (304, N'Bò cạp', N'Tournefortia gaudichaudii Gagn.', 0, 28, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (305, N'Cải ngọt', N'Brassica intergrifolia (West.) O. B. Schultz', 0, 29, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (306, N'Cải bẹ', N'B. junca (L.)', 0, 29, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (307, N'Cải bắp', N'B. oleracea L. var. capitata', 0, 29, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (308, N'Cải củ', N'Raphanus sativus var. longipinnatus Bail.', 0, 29, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (309, N'Cải đất', N'Rorippa dubia (Pers) Hara.', 0, 29, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (310, NULL, N'Burcera serrata Wall. ex Colebr.', 0, 31, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (311, N'Cà ná mũi nhọn', N'B. subulatum Guill.', 0, 31, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (312, N'Trám trắng', N'Canarium album (Lour.) Raeusch ex DC.', 0, 31, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (313, N'Trám hồng', N'C. bengalense Roxb.', 0, 31, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (314, N'Trám chim', N'C. parvum Leenh.', 0, 31, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (315, N'Móng bò thân leo', N'Bauhinia galpinii N.E. Br. ', 0, 33, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (316, N'Móc mèo ', N'Caesalpinia bonduc (L.) Roxb.', 0, 33, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (317, N'Ngân đằng', N'Codonopsis celebica (Blume) Thuan', 0, 34, 5, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-07-11T12:01:21.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (318, N'Đẳng sâm', N'Codonopsis javanica (Blume.) Hook.f', 0, 34, 0, 25, 32, NULL, 1, NULL, NULL, CAST(N'2022-11-15T16:48:55.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (319, N'Lô bình tích lan', N'Lobelia zeylanica L.', 0, 34, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (320, N'Lô bình', N'L. sinensis Lour.', 0, 34, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (321, N'Rau tai voi', N'Pentaphragma sinense Hemsl. & Wils.', 0, 34, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (322, N'Sâm ruộng', N'Wahlenbergia marginata (Thunb.) A. DC.', 0, 34, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (323, N'Cáp lá nhọn', N'Capparis acutifolia Sw.', 0, 152, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (324, N'Dây lùng bung', N'Capparis cantoniensis Lour.', 0, 152, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (325, N'Cáp lá xa lị', N'C. pyrifolia Lamk.', 0, 152, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (326, N'Cáp bàn mạo', N'C. radula Gagn.', 0, 152, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (327, N'Màn màn tím', N'Cleome chelidonii L. f. ', 0, 152, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (328, N'Màn màn trắng', N'C. gynandra L.', 0, 152, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (329, N'Màn màn trĩn', N'C. viscosa L.', 0, 152, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (330, N'Bún to', N'Crateva magna (Lour.) DC.', 0, 152, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2022-11-15T15:57:12.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (331, N'Bún', N'C. nurvala Buch. Ham', 0, 152, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (332, N' Trứng quốc', N'Stixis scandens Lour.', 0, 152, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (333, N'Kim ngân', N'Lonicera japonica Thunb.', 0, 35, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (334, N'Kim ngân hoa to', N'L. macrantha (D. Don) Sprengel', 0, 35, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (335, N'Cơm cháy', N'Sambucus simpsonii Rehder.', 0, 35, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (336, N'Cơm cháy hooke', N'S. hookeri Rehder', 0, 35, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (337, N'Vót dôm', N'Vibrum punctatum Buch. Ham ex D. Don', 0, 35, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (338, N'Chân danh', N'Euonymus javanicus Bl.', 0, 36, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (339, N'Chân danh hoa thưa', N'E. laxiflorus Champ. in B & H', 0, 36, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (340, N'Lõa châu', N'Gymnosporia chevalieri Tard.', 0, 36, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (341, N'Loá', N'Maytenus stylosa (Pierre) Lob. Callen', 0, 36, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (342, N'Chóp mau tái', N'Salacia pallens Pierre', 0, 36, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (343, N'Chóp mau cụt ', N'Salacia verrucosa Wight', 0, 36, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (344, N'Xưng da trung bộ', N'Siphonodon annamensis (Lec.) Merr.', 0, 36, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (345, N'Còng trắng', N'Calophyllum dryobalanoides Pierr.', 0, 40, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (346, N'Thành ngạnh nam', N'Cratoxylon cochinchinensis (Lour.) Bl.', 0, 40, 0, 26, 0, NULL, 1, NULL, NULL, CAST(N'2023-07-11T12:15:35.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (347, N'Thành ngạnh', N'Cratoxylum maingayi Dyers in Hook. f.', 0, 40, 0, 26, 0, NULL, 1, NULL, NULL, CAST(N'2023-07-11T12:21:36.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (348, N'Bứa', N'Garcinia cochinchinensis (Lour.) Choiw.', 0, 40, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (349, N'Vàng nghệ', N'Garcinia handburyl', 0, 40, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (350, N'Bứa lằn đen', N'Garcinia nigrolineata', 0, 40, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (351, N'Bứa lửa', N'G. fusca Pierr.', 0, 40, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (352, N'Bứa lá tròn', N'G. oblongifolia Champ. ex Benth.', 0, 40, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (353, N'Bứa ', N'G. planchonii Pierr.', 0, 40, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (354, N'Sơn Vé', N'G.mergnensis Wight', 0, 40, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (355, N'Vàng nghệ', N'Garcinia gaudichaudii', 0, 40, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (356, N'Sói đay', N'Chloranthus crectus (Benth. & Hook.f.) Verdc.', 0, 39, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (357, N'Sói gié', N'Chloranthus spicatus', 0, 39, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (358, N'Sói rừng', N'Sarcandra glabra', 0, 39, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (359, N'Dây giun', N'Quiqualis indica L.', 0, 41, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (360, N'Quả giùm', N'Connarus paniculatus Roxb.', 0, 43, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (361, NULL, N'Roureopis stenopetala (Griff.) Schellenb.', 0, 43, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (362, N'Dây cựa gà', N'Rourea minor (Gaertn.) Aubl.', 0, 43, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (363, N'Bìm thuỷ', N'Hewittia scandens (Milne) Mabberly', 0, 44, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (364, N'Rau muống', N'Ipomoea aquatica Forssk ', 0, 44, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (365, N'Khoai lang', N'I. batatas (L.) Lamk', 0, 44, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (366, N'Bìm trắng', N'Jacmontia paniculata (Burm. f.) Hall.f.', 0, 44, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (367, N'Bìm vàng', N'Merremia hederacea (Burm. f.) Hall. f.', 0, 44, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (368, N'Bìm long', N'M. hirta (L.) Merr.', 0, 44, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (369, N'Bìm lá nho', N'M. vitifolia (Burm. f.) Hall. f.', 0, 44, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (370, N'Bìm núi', N'Prana volubilis Burm. f.', 0, 44, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (371, N'Bìm ba răng', N'Xenostegia tridentata (L.) Austin & Staples', 0, 44, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (372, N'Bí đao', N'Benincasia hispida (Thunb.) Cogn.', 0, 46, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (373, N'Bát', N'Coccinia grandis (L.) Voigt', 0, 46, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (374, N' Bí rợ', N'Cucurbita maxima Duch. ex Lam', 0, 46, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (375, N' Bí ngô', N'C. moschata Duch. ex Lam', 0, 46, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (376, N'Bí đỏ', N'C. pepo L.', 0, 46, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (377, N'Dưa chuột', N'Cucurmis sativus L.', 0, 46, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (378, N' Dưa gang', N'C. sativus var. conomon  (Thunb.) Mak', 0, 46, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (379, N'Chân vịt', N'Diplocyclos palmatus (L.) Jeffrey', 0, 46, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (380, N' Cứt quạ', N'Gymnopetalum cochinchinensis (Lour.) Kurz.', 0, 46, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (381, N'Cứt quạ lá nguyên', N'G. integrifolium (Roxb.) Kurz.', 0, 46, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (382, N'Thư tràng thưa', N'Gynostemma laxum wall Cogn', 0, 46, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (383, N'Thư tràng 5 lá', N'Gynostemma pentaphyllum', 0, 46, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (384, N'Đài hái', N'Hogsonia macrocarpa (Bl.) Cogn', 0, 46, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (385, N'Mướp khía', N'Luffa acutangula (L.) Roxb.', 0, 46, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (386, N'Mướp hương', N'L. cylindrica (L.) M. J. Roem', 0, 46, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (387, N' Khổ qua', N'Momordia charantia L.', 0, 46, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (388, N'Gấc', N'M. cochinchinensis (Lour.) Spreng', 0, 46, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (389, N'Cầu qua nhám', N'Mukia maderaspatana (L.) M. J. Roem', 0, 46, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (390, N'Cầu qua di diệp', N'Solena heterophylla Lour. ', 0, 46, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (391, N'Làu xác', N'Trichosanthes tricuspidata Lour.', 0, 46, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (392, N'Hồng bì', N'Trichosanthes rubrithoscayla', 0, 46, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (393, N'Cầu qua trái trắng', N'Zehneria indica (Lour.) Keyr.', 0, 46, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (394, N'Sổ bà', N'Dillenia indica L.', 0, 52, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (395, N'Sổ ngũ thư', N'Dillenia pentagyna Roxb.', 0, 52, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (396, N'Long tía', N'D. turbinata Fin & Gagn.', 0, 52, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (397, N'Dây chìu', N'Tetrcera sarmentosa (L.) Vahl', 0, 52, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (398, N'Dây chiều tứ giác', N'T. scandens (L.) Merr.', 0, 52, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (399, N'Dầu hoa to', N'Dipterocapus grandiflorus Blco ', 0, 54, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (400, N'Dầu', N'D. hasseltii Bl.', 0, 54, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (401, N'Dầu cà luân', N'D. kerrii King.', 0, 54, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (402, NULL, N'Dipterocarpus Sp', 0, 54, 23, 25, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (403, N'Hồng', N'Diospyros kaki L.f.', 0, 56, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (404, NULL, N'D. cauliflora Bl.', 0, 56, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (405, N'Thị roi', N'Diospyros frutescens Bl. ', 0, 56, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (406, N'Săng đen', N'D. lancaefolia Roxb. ', 0, 56, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (407, N'Thị hoa dài', N'D. longebracteata Lec', 0, 56, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (408, N'Thị sen', N'Diospyros lotus', 0, 56, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (409, N'Trâm', N'D. martabarica C. B. Cl.', 0, 56, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (410, N'Thị thường', N'D. moi Lec', 0, 56, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (411, N'Thị mít', N'D. pilosula (A. DC.) Hiern.', 0, 56, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (412, N'Thị chồi hung', N'D. rufogemmata Lec', 0, 56, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (413, N'Thi đốt cao', N'Diospyros susarticulata', 0, 56, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (414, N'Gai nang ', N'Sloanea sinensis (Hance) Hemsl.', 0, 57, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (415, N'Côm nhật', N'Elaeocarpus japonicus Sieb. & Zucc.', 0, 57, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (416, N'Côm bông lớn', N'Elaeocarpus grandiflorus J. E. Smith.', 0, 57, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (417, N'Côm lá hẹp', N'E. angustifolius Bl.', 0, 57, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (418, NULL, N'E. griffithii (Wight.) A. Gray', 0, 57, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (419, N'Rù rì', N'E. hainamensis Oliv. ', 0, 57, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (420, N'Côm sừng to', N'Elaeocarpus macroceras', 0, 57, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (421, N'Côm biên', N'E. limitanus Hand. Mazz', 0, 57, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (422, N'Côm có cuống', N'E. petiolatus (Jack.) Wall. ex Kurz.', 0, 57, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (423, N'Côm lá bẹ', N'E. stipulatus Bl.', 0, 57, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (424, N'Côm trâu', N'Elaeocarpus sylvestris (Lour.) Poir. in Lamk. ', 0, 57, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (425, N'Đỗ quyên hoa trắng', N'Rhododendron aff. fleuryi Dop', 0, 59, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2022-11-15T17:11:21.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (426, N'Đỗ quyên sim', N'R .simsii Planch.', 0, 59, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (427, N'Trợ hoa', N'Enkianthus quinqueflorus Lour.', 0, 59, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (428, N'Châu thụ', N'Gaultheria fragrantissima Wall., ', 0, 59, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (429, N'Bọ nẹt', N'Alchornia rugosa (Lour.) Muell.-Arg.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (430, N'Bọ nẹt lá đay', N'A. tiliaefolia (Benth.) Muell.-Arg.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (431, N'Trẩu', N'Aleurites cordata (Thumb.) R. Br. ex Steu', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (432, N'Chòi mòi lá nhọn', N'Antidesma bunius Spreng.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (433, N'Chòi mòi', N'A. ghaesembilla Gaertn', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (434, N'Chòi mòi poilane', N'Antidesma poilanne', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (435, N'Chòi mòi', N'Antidesma fruticosa', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (436, N'Chòi mòi hải nam', N'A. hainanensis Merr.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (437, N'Chòi mòi vân nam', N'A. yunnanensis Pax & Hoffm.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (438, N'Tai nghé', N'Aporusa ficifolia H. Baillon ', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (439, N'Thàu táu hạt tròn', N'A. sphaerospermum Gagn.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (440, N'Tai nghé', N'Aporusan tetrapleura', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (441, N'Dâu da', N'Baccaurea silvestris Lour.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (442, N'Nhội', N'Bischofia javanica Bl.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (443, N'Dé', N'Breynia angustifolia Hook.f.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (444, N'Bù cu vẽ', N'B. fruticosa (L.) Hook.f.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (445, N'Đỏm long', N'Bridelia monoica (Lour.) Merr.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (446, N'Bi điền xoan', N'Bridelia ovata Dcne.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (447, N'Bọ bét', N'Claoxylon hainamensis', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (448, N'Mọ lá dài', N'Claoxylon longifolium (Bl.) Endl. ex Hassk.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (449, N'Cù đèn đà nẵng', N'Croton touranensis Gagnep.', 0, 60, 5, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-07-11T12:05:42.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (450, N'Ba đậu lá nhạt', N'Croton cascarilloides Raeusch', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (451, N'Cù đèn biên thùy', N'Croton limitincola Croiz', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (452, N'Vạng trứng', N'Endospermum chinense Benth.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (453, N'Cỏ sữa lông', N'Euphorbia hirta L.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (454, N'Cỏ sữa an', N'E. indica Lamk.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (455, N'Cỏ sữa tròn', N'E. orbiculata Miq.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (456, N'Trạng nguyên', N'E. pulcherrima Jacq.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (457, N'Cỏ sữa đất', N'E. thymifolia L.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (458, N'Mao hoa', N'Emismanthus sinensis', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (459, N'Trao tráo', N'Excoecaria indica', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (460, N'Sóc đỏ', N'Glochidion rubrum Bl.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (461, N'Sóc cứng', N'Glochidion rigidum', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (462, N'Sóc', N'G. zaylanicum A. Jus', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (463, N'Thanh cước', N'Leptopus clarkei', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (464, N'Rù rì', N'Homonoia riparis Lour.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (465, N'Lá nến', N'Macaranga balansae Gagn.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (466, N'Ba soi', N'M. denticulata (Bl.) Muell.-Arg', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (467, N'Máu bầu', N'M. henricorum Hemsl.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (468, N'Ba bét trắng', N'Mallotus apelta Muell.-Arg.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (469, N'Ba bét', N'M. barbatus Muell.-Arg.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (470, N'Ruối trái vàng', N'Mallotus chrysocarpus', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (471, N'Bùm bụp trung bộ', N'M. floribundus (Bl.) Muell.-Arg', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (472, N'Bụp đuôi to', N'M. macrostachyus (Miq.) Muell.-Arg.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (473, N'Ba bét nam', N'M. paniculata (Lamk.) Muell.-Arg.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (474, N'Cánh kiến', N'M. phillippensis (Lamk.) Muell.-Arg.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (475, N'Bụp tràn', N'M. repandus (Willd.) Muell.-Arg.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (476, N'Bụp trắng', N'M. tetracocus (Roxb.) kurz.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (477, N'Ruối', N'Mallotus thorelii', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (478, N'Sắn', N'Manihot esculanta Crantz.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (479, N'Cám heo, ruối trái tròn', N'Mallotus oblongifolius (Miq) Maell – Arg', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (480, N'Óc tốt', N'Ostodes paniculata Blume ', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (481, N'Chó đẻ răng cưa', N'Phyllanthus debilis klein ex Willd.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (482, N'Diệp hạ châu đo đỏ', N'Phyllanthus rubescens Beille', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (483, N'Chùm ruột', N'P. emblica L.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (484, N'Phèn đen', N'P. reticulata Poir. ', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (485, N'Đỏ ngọn', N'P. rube Spreng.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (486, N'Chó đẻ', N'P. urinaria L.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (487, N'Vảy óc', N'Phyllanthus welwitschianus', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (488, N'Tam thụ hùng long chim', N'Trigonostemon murtonii', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (489, N'Sòi tía', N'Sapium discolor. (Benth.) Muell.-Arg.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (490, N'Sòi lá tròn', N'S. rotundifolium Hemsl.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (491, N'Sòi trắng', N'S. sebiferum (L.) Roxb.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (492, N'Rau ngót', N'Sauropus androgynus (L.) Merr.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (493, N'Bóng nẻ', N'Securinega vilosa (Willd.) Pax & Hoffm.', 0, 60, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (495, N'Cánh dơi', N'Bauhinia bracteaca (Benth.) Baker', 0, 153, NULL, NULL, NULL, NULL, 1, NULL, NULL, CAST(N'2022-06-01T15:39:19.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (496, N'Móng bò mấu', N'B. clemensiorum Merr.', 0, 153, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (497, N'Móng bò curit', N'B. curtisii Prain. ', 0, 153, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (498, N'Móng bò lakon', N'B. lakhonensis Gagn.', 0, 153, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (499, N'Móng bò xanh', N'Bauhinia  viridescens Desv.', 0, 153, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (500, N'Móng bò lông', N'B. hirsuta Weimnann. ', 0, 153, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (501, N'Móng bò', N'B. saccocalyx Pierre.', 0, 153, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (502, N'Vuốt hùm', N'Caesalpinia bonduc (L.) Roxb.', 0, 153, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (503, N'Keo rừng', N'C. latisilliqua (Cav.) Hatt', 0, 153, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (504, N'Vuốt hùm', N'C. mimax Hance', 0, 153, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (505, N'Móc mèo', N'C. mimosoides Lamk.', 0, 153, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (506, N'Muồng trâu', N'Cassia alrata L.', 0, 153, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (507, N'Xây, Xoay', N'Dialium cochinchinensis Pierre', 0, 153, 27, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (508, N'Lim xanh', N'Erythrophleum fordii Oliv', 0, 153, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-11T09:29:20.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (509, N'Ràng ràng lào', N'Ormisia laoensis', 0, 153, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (510, N'Ràng ràng trái gỗ', N'Ormosia xylocarpa Chun', 0, 153, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (511, N'Ràng ràng cambodia', N'Ormosia combodiana', 0, 153, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (512, N'Mát giết cá', N'Milletia piscidia (Roxb.) W & Arn', 0, 153, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (513, N'Lim vàng', N'Peltophorum dasyrrachis (Miq.) Kurz.', 0, 153, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (514, N'Lim sẹt', N'P. pterocarpum (A.P.de Cand.) Back. ex Heyrne', 0, 153, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (515, N'Cóc kèn', N'Perris Sp', 0, 153, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (516, N'Vàng anh', N'Saraca indica L.', 0, 153, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (517, N'Gõ dầu', N'Sindora tonkinensis A. Chev. ex K. & S. S. Lars.', 0, 153, 27, 24, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (518, N'Me ăn lá', N'Acacia concinna (Willd.) A. DC. ', 0, 156, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (519, N'Sống rắn trung quốc', N'Albizia chinensis (Osb.) Merr.', 0, 156, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (520, N'Sống rắn', N'A. corniculata (Lour.) Pruce', 0, 156, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (521, N'Đái bò', N'A. lucidior (Steud.) I. Niels.', 0, 156, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (522, N'Cứt ngựa', N'Archidendron balansae (Oliv.) I. Niels.', 0, 156, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (523, N'Cổ áo', N'A. bauchei. (Gagn.) I. Niels', 0, 156, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (524, NULL, N'A. chevalieri (Kost.) I. Niels.', 0, 156, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (525, N'Mán đỉa', N'Archidendron clypearia (Jack) ', 0, 156, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (526, N'Doi bắc bộ', N'Archidendron tonkinensis', 0, 156, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (527, N'Dái heo', N'A. robinsonii (Gagn.) I. Niels.', 0, 156, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (528, N'Bàm bàm', N'Entada phaseoloides (L.) Merr.', 0, 156, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (529, N'Xấu hổ móc', N'Mimosa diplotricha C. Wright ex Sauvalle', 0, 156, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (530, N'Xấu hổ', N'M. pudica L.', 0, 156, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (531, N'Lạc', N'Arachis hypogea L.', 0, 155, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (532, N'Bánh nem', N'Bowringia calicarpa Champ.', 0, 155, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (533, N'Lục lạc trắng', N'Crotalaria incana L.', 0, 155, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (534, N'Lục lạc cánh', N'C. bialata Schrank', 0, 155, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (535, N'Bàm bàm', N'Dalbergia entadoides Pierre ex Gagn.', 0, 155, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (536, N'Sóng lá', N'D. polyadelpha Prain.', 0, 155, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (537, N'Trắc dây', N'Dalbergia rimosa Roxb', 0, 155, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-11T08:07:57.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (538, N'Cóc kèn núi', N'Deris acuminata (Grah.) Benth.', 0, 155, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (539, N'Dây lim', N'D. indica Benn. Nim', 0, 155, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (540, N'Đồng tiền', N'Desmodium pulchellum (L.) Benth.', 0, 155, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (541, N'Tràng quả 3 lá', N'D. triflorum DC.', 0, 155, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (542, N'Tràng quả', N'D. zonantum Miq.', 0, 155, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (543, N'Vông đồng', N'Erythrina fusca Lour. ', 0, 155, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (544, N'Vông nem', N'E. variegata L.', 0, 155, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (545, N'Chàm long', N'Indigofera hirsuta L.', 0, 155, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (546, N'Chàm 3 lá', N'I. trifolia L.', 0, 155, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (547, N'Thàn mát', N'Milletia ichthyotona Drake', 0, 155, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (548, N'Cổ gai', N'M. ebehardtii Gagn.', 0, 155, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (549, N'Ràng ràng lào', N'Ormosia laosensis Niyodham.', 0, 155, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (550, N'Ràng ràng xanh', N'Ormosia pinnata (Lour.) Merr.', 0, 155, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (551, N'Đậu ma', N'Pueraria phaseoloides (Roxb.) Benth.', 0, 155, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (552, N'Cốt khí tía', N'Tephrosia purpurea (L.) Prers.', 0, 155, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (553, N'Đậu xanh', N'Vigna radiata (L.) Wilczek.', 0, 155, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (554, N'Đậu đen', N'V. unguiculata (L.) Walp.', 0, 155, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (555, N'Dẻ giáp', N'Castanopsis  armata Spach.', 0, 62, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (556, N'Kha thụ sừng nai', N'C. ceratacantha Rehd. & Wils.', 0, 62, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (557, NULL, N'C. dongchoensis Hiek & Cam.', 0, 62, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (558, N'Cà ổi ấn', N'C. indica (Roxb.) A.D.C. in Seem.', 0, 62, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (559, N'Cà ổi sapa', N'Castanopsis lecomtei Hick. & Camus ', 0, 62, NULL, 25, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (560, N'Kha tử quảng trị', N'C. quangtriensis Hick & Cam.', 0, 62, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (561, N'Kha tử Sepon', N'C. teheponensis Hick & Cam.', 0, 62, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (562, N'Kha thụ Hải vân', N'C. nebulorum A. Cam.', 0, 62, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (563, N'Kha thụ trung bộ', N'Castanopsis annainensis', 0, 62, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (564, N'Cà ổi bắc bộ', N'Castanopsis tonkiensis Seem', 0, 62, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (565, N'Dẻ gié dòn', N'Lithocarpus ahabdostachya (Hick. & Cam.) A. Cam.', 0, 62, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (566, N'Dẻ ai lao', N'L. ailaoensis A. Cam', 0, 62, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (567, N'Sối đá lá mác', N'Lithocarpus balansae (Drake) A. Camus', 0, 62, 5, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-07-11T12:08:02.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (568, N'Sồi', N'L. corneus (Lour.) Rehd.', 0, 62, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (569, N'Dẻ núi', N'L. dinhensis (Hick. & Cam) Barn.', 0, 62, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (570, N'Dẻ lỗ, Dẻ cau', N'L. fenestratus (Roxb.) Rehd.', 0, 62, NULL, 25, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (571, N'Dẻ garrett, Sồi đá bộp', N'Lithocarpus garettiana (Craib.) A. Cam.', 0, 62, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (572, N'Dẻ bán cầu', N'L. haemispherica (Drake) Cam.', 0, 62, NULL, 25, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (573, N'Dẻ Jackson', N'L. jacksoniana A. Cam.', 0, 62, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (574, N'Dẻ trái nhỏ', N'L. microsperma A. Cam.', 0, 62, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (575, N'Dẻ háo âm', N'Lithocarpus ombrophylus A. Camus ', 0, 62, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (576, N'Dẻ nhiều vảy', N'L. pachylepis A. Cam.', 0, 62, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (577, N'Giẻ rừng', N'Lithocarpus silvicolarum (Hance) Chun', 0, 62, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (578, N'Sồi lá tròn', N'Q. arbutifolia Hick. & Cam.', 0, 62, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (579, N'Sồi lá tre', N'Q. bambusaefolia Hance in Seem', 0, 62, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (580, N'Sồi Gomez', N'Q. gomeziana A. Cam.', 0, 62, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (581, N'Sồi đấu to', N'Quercus macrocallyx Hick & Cam', 0, 62, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (582, N'Chìa vôi', N'Casearia balansae Gagn.', 0, 63, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (583, N'Nuốt chụm', N'C. gromerata Roxb.', 0, 63, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (584, N'Nuốt lá màng', N'C. membranacea Hance.', 0, 63, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (585, N'Mùng quân', N'Flacourtia rukkam Zoll. & Morr.', 0, 63, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (586, N'Chà van sến', N'Homalium ceylanicaum (Gardn.) Benth.', 0, 63, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (587, N'Chà van', N'H. myrandrum Merr.', 0, 63, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (588, N'Nhọ nồi', N'Hydnocarpus annamensis (Gagn.) Lese. & Sleum.', 0, 63, 25, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (589, N'Lọ nồi ô rô', N'H. ilicifolia King', 0, 63, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (590, N'Lọ nồi', N'H. kurzii (King) Warb.', 0, 63, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (591, N'Sau sau', N'Liquidambar farmosana Hance', 0, 68, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (592, N'Hồng quang rừng', N'Rhodoleia championii Hook.f.', 0, 68, 27, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (593, N'Chắp tay', N'Symingtonia populnea (Griff.) Steem.', 0, 68, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (594, N'Mao hùng', N'Gomphadra tetrandra (Wall.) Sleum', 0, 72, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (595, N'Cuống vàng', N'Gonocaryum lobbianum (Miers) Kurz', 0, 72, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (596, N'Mộc thông', N'Iodes cirrhosa Turcz ', 0, 72, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (597, N'Hồi lá mỏng', N'Illicium tenuifolium (Ridl.) Smith.', 0, 73, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (598, N'Chẹo', N'Engelhardia roxburghiana Wall.', 0, 75, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (599, N'Chẹo bông', N'E. spicata Lesch. ex Bl.', 0, 75, 27, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (600, N'Chẹo có răng', N'E. serrata Bl.', 0, 75, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (601, N'Cơi', N'Pterocarya stenoptera C. DC.', 0, 75, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (602, N'Tía tô', N'Coleus scutellaroides (l.) Benth.', 0, 76, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (603, N'Bạch thiệt ', N'Leucas aspera (Willd.) Link', 0, 76, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (604, N'Húng lũi', N'Mentha quatica L.', 0, 76, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (605, N'Đại hồi hoa nhỏ', N'Illicium parviflorun', 0, 76, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (606, N'Tu hùng tai', N'Pogostemon auricularia Phamhoang', 0, 76, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (607, N'Râu mèo thảo', N'Orthosiphon spiralis (Lour.) Merr.', 0, 76, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (608, N'Tía tô thảo', N'Perilla frutescens (Thunb.) Hand.-Mazz.', 0, 76, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (609, N'Cửu thảo ', N'Salvia plebeia R. Br.', 0, 76, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (610, N'Thuẫn ấn độ', N'Scutellaria indica L.', 0, 76, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (611, N'Vàng trắng bắc bộ', N'Alsecodaphne tonkinensis Liouho', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (612, N'Vàng trắng long', N'Alsecodaphne velutina', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (613, N'Két sét', N'Beilschmiedia ferruginea Liouho', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (614, N'Két rất dai', N'Beilschmiedia percoriacea', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (615, N'May phòng', N'Caryodapnosis tonkinensis (Lec.) A. Shaw', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (616, N'Tơ xanh', N'Cassytha filiformis L.', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (617, N'Re hương', N'Cinnamomum glaucescens (Buch. Hamilt.) Drury', 0, 77, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-11T12:33:19.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (618, N'Trèn gân hình thang', N'C. scalarinervium Kost', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (619, N'Cửu mộc', N'Cinnamomum parthenoxylon (Jack.) Meisn.', 0, 77, 7, 23, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-11T12:39:39.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (620, N'Quế lá tù', N'C. bejolgota (Buch.-Ham.) Sweet.', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (621, N'Quế rành', N'Cinnamomum burmannii', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (622, N'Long não', N'C. camphora (L.) J. S. Prest', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (623, N'Vù hương', N'Cinnamomum balansae Lec.', 0, 77, 4, 25, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-11T12:29:57.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (624, N'Cà duối trung bộ', N'Cryptocarya annamensis Allen.', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (625, N'Cà duối trắng', N'C. ferrea Bl.', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (626, N'Cà duối', N'C. petelotii Kost.', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (627, N'Cà duối tam hùng', N'Dehaasia triandra Merr.', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (628, N'Khuyết hùng đỏ', N'Ediandra rubescens (Bl.) Mi', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (629, N'Liên đàn chun', N'Lindera chunii Merr.', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (630, N'Bời lời', N'Litsea balansae Lec.', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (631, N'Màng tang', N'L. cubeba (Lour.) Pers.', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (632, N'Bời lời nhớt', N'L. glutinosa (Lour.) Rob.', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (633, NULL, N'Litseacubeba Sp', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (634, N'Bời lời lá nhục đậu', N'Litsea myristicaefolia', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (635, N'Bời lời bắc bộ', N'Litsea rubescens', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (636, N'Liên đàn', N'Lindera meissneri', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (637, N'Liên đàn', N'Lindera nacusua', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (638, N'Rè', N'Machilus platycarpa Chun.', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (639, N'Bời lời trung bộ', N'Neolitsea chuii Merr.', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (640, N'Tân bời lời', N'Neolitsea sericea', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (641, N'Dẹ', N'Syndiclis lotungensis', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (642, N'Kháo long', N'Persea velutina (Champ.) Kost.', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (643, N'Sụ thon', N'Phoebe attenuata Necc. ', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (644, N'Sụ quảng trị', N'P. sheareri Gamble', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (645, N'Re trắng lá to', N'Phoebe tavoyana (Meisn.) Hook. f.', 0, 77, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (646, N'Gối an', N'Leea indica (Burm.f.) Merr.', 0, 78, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (647, N'Củ gối', N'L. thorelli Gagn.', 0, 78, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (648, N'Gối có mũi', N'L. manillensis Walp.', 0, 78, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (649, N'Gối hạc', N'L. rubra Bl. ex Spreng.', 0, 78, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (650, N'Lộc vừng', N'Barringtonia acutangula (L.) Gaertn.', 0, 79, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (651, N'Chiếc hardtii', N'B. eberhardtii Gagn.', 0, 79, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (652, N'Chiếc chùm', N'B. macrocarpa Hassk.', 0, 79, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (653, N'Tim lang', N'Barringtonia racemosa', 0, 79, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (654, N'Vừng quả to', N'Careya sphaerica Roxb.', 0, 79, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (655, N'Lá ngón', N'Gelsemium elegans (Gardn. & Champ.) Benth.', 0, 81, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2022-11-17T20:42:21.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (656, N'Trai', N'Fagraea fragrans Roxb. ', 0, 81, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (657, N'Trai tai', N'F. auriculata Jack.', 0, 81, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (658, N'Củ chi', N'Strychnos angustifolia Benth.', 0, 81, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (659, N'Hoàng nàn, Mã tiền lông', N'S. ignatii Bergius', 0, 81, NULL, 25, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (660, N'Củ chi trứng', N'S. ovata Hill', 0, 81, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (661, N'Củ chi láng', N'S. vanpruckii', 0, 81, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (662, N'Ngũ hung', N'Dendrophtoe pentandra (L.) Miq.', 0, 83, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (663, N'Thu loan', N'Ginalloa siamica Crai', 0, 83, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (664, N'Đại cán', N'Macrosolen robinsonii (Gamble) Dance', 0, 83, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (665, N'Hạt mộc trung quốc', N'Taxillus chinensis (DC.) Dance', 0, 83, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (666, N'Tầm gửi sau sau', N'Viscum liquidambaricum Hay', 0, 83, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (667, N'Bằng lăng lá xoan', N'Lagerstroemia ovalifolia Teijsm & Binn.', 0, 85, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (668, N'Bằng lăng láng', N'L. duperreana Pierre ex Gagn.', 0, 85, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (669, N'Săng lẻ lông', N'L. tomentosa Presl. ', 0, 85, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (670, N'Giổi xanh', N'Michelia mediocris Dandy', 0, 86, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (671, N'Giổi trơn', N'M. faveolata Merr. ex Dandy', 0, 86, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (672, N'Giổi gang, Giổi xương', N'Paramichelia baillonii (Pierre) Hu. Kuidui', 0, 86, 0, 25, 0, NULL, 1, NULL, NULL, CAST(N'2023-07-11T12:44:26.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (673, N'Bụp vang', N'Abemoschatus moschatus Medicus', 0, 87, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (674, N'Bụp lá cò ke', N'Hibiscus grewiaefolius Hassk.', 0, 87, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (675, N'Dâm bụt', N'H. rosa-sinensis L.', 0, 87, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (676, N'Xương chua', N'H. surattensis L.', 0, 87, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (677, N'Ké đồng tiền', N'Sida cordifolia L.', 0, 87, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (678, N'Bái', N'S. acuta Burm.f.', 0, 87, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (679, N'Ké hoa vàng', N'S. rhombifolia L.', 0, 87, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (680, N'Ké hoa đào', N'Urena lobata L.', 0, 87, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (681, N'Đa hình không cuống', N'Allomorphia subsessilis Craib.', 0, 91, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (682, N'Đa hình cây', N'Allomorphia arborescens Guillaum', 0, 91, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (683, NULL, N'Blastus borneensis Cogn', 0, 91, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (684, N'Bo', N'B. cochinchinensis Lour. ', 0, 91, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (685, N'Ân đằng', N'Diplectria barbata Frank & Roos', 0, 91, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (686, N'Chèn', N'Medinilla assamica (C. B. Cl.) Chen', 0, 91, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (687, N'Mua Bauche', N'Melastoma bauchei Guill.', 0, 91, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (688, N'Mua nhám', N'M. eberhartii Guill.', 0, 91, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (689, N'Mua thường', N'M. normale D. Don', 0, 91, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (690, N'Sầm', N'Memecylon edule Roxb.', 0, 91, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (691, N'Sầm núi', N'M. scutellatum (Lour.) Naud.', 0, 91, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (692, N'Mua tép', N'Osbeckia chinensis L. ', 0, 91, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (693, N'An bích sao', N'O. stellata Buch.-Ham ex D. Don', 0, 91, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (694, N'Sắc tứ tơ', N'Oxyspora balansari (Cogn) Max. Var.Setosa', 0, 91, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (695, N'Nhĩ hung', N'Otanthera annamica (Guill.) C. Hance', 0, 91, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (696, N'Mua bò', N'Phyllagathis prostrata C. Hance', 0, 91, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (697, N'Me đá', N'Phyllagathis gangicalcarata', 0, 91, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (698, N'Giã lưỡng tai', N'Pseudodissochaeta lanceolata Nayar.', 0, 91, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (699, N'Sơn linh đứng', N'Sonerila erecta Jack', 0, 91, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (700, N'Ngâu trung bộ', N'Aglaia annamensis Pell.', 0, 92, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (701, N'Ngâu raman', N'Aglaia lawii', 0, 92, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (702, N'Ngâu mum, dái ngựa nước', N'Aglaia Spectabilis (miq) Jain&Binn', 0, 92, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (703, N'Gội nước', N'Aphanamixis polystachya', 0, 92, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (704, N'Gội đỏ', N'Amoora dasyclada (How & Chen) C.V.Wu', 0, 92, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (705, N'Gội tía', N'Aglaia spectabilis (Miq.) Jain & Bennet = A. gigantea Pierre ', 0, 92, 0, 25, 0, NULL, 1, NULL, NULL, CAST(N'2023-07-11T12:50:27.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (706, N'Gội ít hạt', N'A. oligosperma (Pierre) Pell.', 0, 92, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (707, N'Lát hoa', N'Chukrasia tabularis A. Jus.', 0, 92, 6, 25, 0, NULL, 1, NULL, NULL, CAST(N'2023-07-11T12:52:51.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (708, N'Cà muối', N'Cipadessa baccifera Pell.', 0, 92, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (709, N'Chò vảy', N'Dysoxylum hainanensis Merr.', 0, 92, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (710, N'Huỳnh đàn', N'Dysoxylum juglans (Hance) Pell.', 0, 92, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (711, N'Xoan', N'Melia azedarach. L. ', 0, 92, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (712, N'Huỳnh  đàn', N'Sandoricum binectariferum Hook.f.', 0, 92, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (713, N'Dái ngựa', N'Swietenia macrophylla Kingin Hook', 0, 92, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (714, N'Dây vằng đắng', N'Coscinium fenestratum (Gagn.) Colebr.', 0, 93, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-11T12:56:07.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (715, N'Dây hồ đằng, Mốt trơn', N'Cissampelos  Pareira L.', 0, 93, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (716, N'Dây song bảo', N'Diploclisia glaucescens (Bl.) Diel', 0, 93, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (717, N'Hoàng đằng', N'Fibraurea tinctoria Lour.', 0, 93, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-11T12:23:56.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (718, N'Dây mề gà', N'Limacia scandens Lour.', 0, 93, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (719, N'Phi đằng', N'Pycnarrhena poilanei (Gagn.) Forman.', 0, 93, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (720, N'Bình vôi nhật, Thiên kim đằng', N'Stephania japonica (Thunb.) Miers.', 0, 93, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-11T13:01:55.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (721, N'Bình vôi', N'Stephania glabra', 0, 93, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (722, N'Bình vôi', N'Stephania rotunda Lour.', 0, 93, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-11T13:03:57.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (723, N'Sui', N'Antiaris toxicaria (Pers.) Lesch.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (724, N'Trôi, mít chua', N'Artocarpus borneensis Merr.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (725, N'Mít nài', N'A. melinoxyla Gagn.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (726, N'Chay ăn trầu', N'A. nitida Trec', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (727, N'Dướng', N'Broussonetia papyrifera (L.) L`. Her ex Vent.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (728, N'Đa tía', N'Ficus altissima Bl.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (729, N'Vả', N'F. auriculata Lour.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (730, N'Si', N'F. benjamina L.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (731, N'Sung sống', N'Ficus costata', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (732, N'Da nước', N'Fisus depressa', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (733, N'Ngái long', N'F. fulva Reinw. ex Bl.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (734, N'Da trụi', N'F. glaberrima Bl.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (735, N'Vú bò', N'F. heterophylla L.f.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (736, N'Ngái long', N'Ficus hirta Vahl.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (737, N'Ngái', N'F. hispida L.f.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (738, N'Da gân', N'F. nervosa Heyne ex Roth.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (739, N'Sung tì bà', N'F. pandurata Hance', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (740, N'Thằn lằn', N'F. pumila L.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (741, N'Sung nằm', N'Ficus prostrata', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (742, N'Sung', N'F. Racemosa', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (743, N'Rù rì', N'F. subpyrifomis Hook & Arn.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (744, N'Da cua', N'F. sumatrana Miq.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (745, N'Sung kiêu', N'Ficus superba (Miq.) Miq.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (746, N'Da bông', N'F. vasculosa Wall. ex Miq.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (747, N'Xung xanh', N'F. virens Ait.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (748, N'Sung', N'Ficus subincisa', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (749, N'Gai mang', N'Maclura cochinchinensis (Lour.) Corner.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (750, N'Duối leo', N'Pleicospermum andamanicum King', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (751, N'Sung trung bộ', N'Semecarous annamensis', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (752, N'Ruối rừng', N'Streblus indicus (Bur.) Corn.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (753, NULL, N'Streblus taxoides (Heyne) Kurz.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (754, N'Tèo nông', N'Streblus tonkinensis', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (755, N'Quít Núi', N'S. laxiflorus (Hutch.) Corn.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (756, N'Duối tích lan', N'S. zeylanicus (Thw) Kurz.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (757, N'Duối đôi', N'Taxotrophis caudata Hutch.', 0, 94, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (758, N'Xăng máu', N'Horsfieldia thorelii Lec.', 0, 96, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (759, N'Máu chó lá nhỏ', N'Knema conferta', 0, 96, 5, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-07-11T13:11:19.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (760, N'Máu chó thanh', N'Knema elegans Warb. ', 0, 96, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (761, N'Máu cho lưu linh', N'K. erratica (Hook.f.th) Sincl.', 0, 96, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (762, N'Máu chó cầu', N'K. globularia (Lamk.) Warb.', 0, 96, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (763, N'Máu chó lá lớn', N'Knema pierei', 0, 96, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (764, N'Cơm nguội mầu', N'Ardisia colorata Roxb.', 0, 97, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (765, N'Cơm nguội', N'A. aciphylla Pit', 0, 97, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (766, N'Kha nèo', N'A. expansa Pit.', 0, 97, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (767, N'Cơm nguội lá lớn', N'A. gigantifolia Stapf.', 0, 97, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (768, N'Cơm nguội Harman', N'A. harmandii Pierre', 0, 97, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (769, N'Cây móc chắc', N'A. lecomtei Pit', 0, 97, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (770, N'Cơm nguội đỏ chói', N'A. miniata Pit', 0, 97, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (771, N'Cơm nguội 5 cạnh', N'A. quiquegona Bl.', 0, 97, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (772, N'Lóc choc', N'A. racemosa Mez.', 0, 97, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (773, N'Lá khôi', N'Ardisia silvestris Pit. ', 0, 97, 0, 25, 0, NULL, 1, NULL, NULL, CAST(N'2022-11-17T20:39:37.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (774, N'Cơm nguội sao', N'A. stellifera Pit', 0, 97, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (775, N'Cơm nguội nhuộm', N'A. tinctoria Pit.', 0, 97, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (776, N'Cơm nguội lông, Cơm nguội áo', N'Ardisia villosa Roxb. ', 0, 97, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (777, N'Cơm nguội the', N'Ardisia villosoides Walker', 0, 97, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (778, N' Rè ngút', N'Embelia ribes Burm.f.', 0, 97, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (779, N'Rè sét', N'E. ferruginea Wall.', 0, 97, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (780, N'Thiên lý hương', N'Embelia parviflora Wall. ex A. DC.', 0, 97, 0, 25, 0, NULL, 1, NULL, NULL, CAST(N'2022-11-23T10:20:54.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (781, N'Đơn nem', N'Maesa perlarius (Lour.) Merr', 0, 97, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (782, N'Đơn hồng', N'M. ramentacea Wall.', 0, 97, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (783, N'Đơn trung quốc', N'M. sinensis A.DC.', 0, 97, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (784, N'Đồng răng cưa', N'M. indica Wall. in Roxb.', 0, 97, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (785, N'Đồng cơm', N'M. membranacea A.DC.', 0, 97, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (786, N'Đồng trâm', N'Maesa subdentata A.DC', 0, 97, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (787, N'Vối', N'Cleistocalyx nervosum DC.', 0, 98, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (788, N'Ổi', N'Psidium guajava L.', 0, 98, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (789, N'Sim', N'Rhodomyrtus tomentosa (Ait.) Hacck.', 0, 98, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (790, N'Tràm lá nhỏ', N'Syzygium abotivum (Gagn.) Merr & Perry', 0, 98, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (791, N'Tràm bloc', N'S. bullockii (Hance) Merr. Perry', 0, 98, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (792, N'Tràm núi', N'S. levinii (Merr.) Merr. & Perry', 0, 98, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (793, N'Trâm lá tù', N'S. oblatum (Roxb.) A.M. & J.M Cowan', 0, 98, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (794, N'Sắn thuyền', N'S. polyanthum (Wight.) Walp.', 0, 98, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (795, N'Trâm to', N'Syzygium tephrodes', 0, 98, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (796, N'Tràm lá dài', N'S. jambos (Gagn.) Merr & Perry', 0, 98, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (797, N'Tràm vỏ đỏ', N'S. zeylanicum (L.) DC.', 0, 98, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (798, N'Trâm trắng', N'S. wightianum Wall.', 0, 98, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (799, N'Mai sọc', N'Gomphia striata (V. Tiegh.) C.F. Wei', 0, 100, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (800, N'Mai cánh lõm', N'G. serrata (Gaertn.) Kanis ', 0, 100, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (801, N'Huỳnh mai', N'Ochna integerrium (Lour.) Merr. ', 0, 100, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (802, N'Lá vằng, Chè vằng', N'Jasminum subtriplinrrve C. L. Blume', 0, 101, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-07-11T08:21:32.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (803, N'Râm trung quốc', N'Ligustrum sinensis Lour.', 0, 101, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (804, N'Hổ bì', N'Linociera ramiflora (Roxb.) Wall. ex G. Don - ', 0, 101, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (805, N'Tráng luân sinh', N'Linociera verticillata Gagnep.', 0, 101, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (806, N'Rau dừa nước', N'Ludwidgia adscendens (L.) Hara', 0, 102, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (807, N'Rau mương', N'L. octovalvis (Jacq.) Raven', 0, 102, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (808, N'Rau dừa đa niên', N'L. perennis L.', 0, 102, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (809, N'Rau sắng', N'Melientha suavis Pierre', 0, 103, NULL, 25, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (810, N'Lệ dương', N'Aeginetia indica L.', 0, 105, 0, 25, 0, NULL, 1, NULL, NULL, CAST(N'2022-11-17T20:43:16.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (811, N'Khế', N'Averrhoa calambola L.', 0, 106, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (812, N'Sinh diệp mắc cỡ', N'Biophytum sensitivum (Lour.) DC.', 0, 106, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (813, N'Chua me đất hoa vàng', N'Oxalis corniculata L.', 0, 106, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (814, N'Me đất', N'Oxalis corymbosa DC.', 0, 106, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (815, N'Lạc tiên', N'Passiflora foetida L.', 0, 108, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (816, N'Càng của', N'Peperomia pullucida Kunth.', 0, 110, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (817, N'Trầu không', N'Pipe betle L.', 0, 110, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2022-11-23T13:42:48.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (818, N'Lá lốt', N'P. lolot. C. DC.', 0, 110, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (819, N'Tiêu', N'P. nigrum L.', 0, 110, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (820, N'Tiêu dạng tiêu đen', N'Piper pseudonigrum DC.', 0, 110, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (821, N'Tiêu trên đá', N'P. saxicola C. DC.', 0, 110, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (822, N'Mã đề', N'Plantago asiatica  L. ', 0, 112, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (823, N'Kích nhũ chùm ngắn', N'Polygala brachystachya DC.', 0, 139, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (824, N'Kích nhũ có lông', N'P. erioptera DC.', 0, 139, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (825, N'Kích nhũ lào', N'P. laotica Gagn.', 0, 139, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (826, N'Viễn chí bắc hộ', N'Polygata tonkinensis', 0, 139, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (827, N'Samon quảng đông', N'Solomonia cantoniensis Lour.', 0, 139, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (828, N'Săng ớt mốc', N'Xanthophyllum glaucum Wall.', 0, 139, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (829, N'Săng ớt mốc', N'X. silvestre Gagn.', 0, 139, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (830, N'Nghể châu', N'Polygonum barbatum L.', 0, 131, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (831, N'Nghể không lông', N'P. glabrum Will.', 0, 131, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (832, N'Nghể ruộng', N'P. persicaria Meissn.', 0, 131, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (833, NULL, N'P. tomentosum Willd.', 0, 131, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (834, N'Sam lá nhỏ', N'Portulaca pilosa L.', 0, 132, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (835, N'Rau sam', N'P. oleracea L.', 0, 132, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (836, N'Quắn trung bộ', N'Helicia cochinchinensis Lour.', 0, 128, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (837, N'Dung', N'Helicia grandifolia', 0, 128, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (838, N'Quắn cuống dài', N'H. longepetiolata Merr & Chun', 0, 128, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (839, N'Quắn', N'H. nilagirica Bedd.', 0, 128, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (840, NULL, N'H. obovatifolia Merr. & Chunn.', 0, 128, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (841, N'Quắn có cuống', N'H. petiolaris Benn.', 0, 128, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (842, N'Song quắn', N'Heliciopsis terminalis (Kurz.) Sleumer', 0, 128, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (843, N'Phong quỳ', N'Anemone poilanei Gagn.', 0, 129, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (844, N'Phòng quỳ Sumtra', N'A. sumatrana De Vriese', 0, 129, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (845, N'Râu ông lão', N'Clematis chinensis Retz.', 0, 129, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (846, N'Vàng kim cang', N'C. smilacifolia Wall.', 0, 129, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (847, N'Rút zế', N'Berchemia loureiriana  Lec.', 0, 134, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (848, N'Dây gồ an', N'Gouania javanica Miq.', 0, 134, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (849, N'Chanh chau', N'Sagerelia theezan (L.) Brogn.', 0, 134, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (850, N'Dây đồng', N'Ventilago hermandiana Pierre', 0, 134, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (851, N'Táo', N'Zizyphus cambodiana Pierre', 0, 134, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (852, N'Táo rừng', N'Z. oenoplia (L.) Mill.', 0, 134, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (853, N'Táo nhám', N'Z. rugosus Lamk. ', 0, 134, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (854, N'Táo', N'Z. maurantiana Lamk.', 0, 134, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (855, N'Xăng mã chè', N'Carallia brachiata (Lour.) Merr.', 0, 125, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (856, N'Xăng mã răng cưa', N'C. suffruticosa Ridl.', 0, 125, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (857, N'Dáp', N'Photinia prunifolia (H & A.) Lindl.', 0, 127, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (858, N'Xoan đào', N'Prunus arborea (Hook.f.) Kalm.', 0, 127, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (859, N'Dương đào', N'Raphiolepsis indica (L.) Lindl. ex ker.', 0, 127, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (860, N'Mâm xôi', N'Rubus alcaefolius L.', 0, 127, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (861, N'Ngấy lá nhọn', N'Rubus asper Wall. ex Don ', 0, 127, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (862, N'Ngấy trắng', N'R. cochinchinensis Card.', 0, 127, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (863, N'Ngấy biền màu', N'R. moluccanus (Bl.) Kalm.', 0, 127, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (864, N'Ngấy', N'R. multibracteatus Levl. & Van', 0, 127, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (865, N'Ngấy nhiều lá chét', N'R. niveus Thunb.', 0, 127, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (866, N'Ngấy lá nhỏ', N'R. pavifolius L.', 0, 127, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (867, N'Găng sai hoa', N'Aidia pycnantha (Drake) Tirveng', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (868, N'Thúc', N'Adina petelotii', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (869, N'Đài khoai răng nhỏ', N'Aidia oxyodonta var microdonta Pit', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (870, N'Mãi táp, Găng', N'Aidia pycnantha var Sp', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (871, N'Căng long', N'Canthium grabrum Bl.', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (872, N'Chim chich', N'Fagerlindia depauperata (Drake) Tirv.', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (873, N'Dành dành', N'Gardenia angustifolia (L.) Merr.', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (874, N'An điền 2 hoa', N'Hedyotis biflora (L.) Lam', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (875, N'Cóc mắn', N'H. corymbosa (L.) Lam', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (876, N'An điền lan', N'H. diffusa Willd.', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (877, N'An điền to', N'H. grandis (Pit.) ', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (878, N'An điền áo', N'H. vestica R. Br. ex G. Don', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (879, N'An điền', N'Hedyotis philippinensis', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (880, N'Trang đỏ', N'Ixora chinensis Lam.', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (881, N'Mẫu đơn hồng', N'Ixora rosea', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (882, N'Trang trắng', N'I. finlaysoniana Wall.', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (883, NULL, N'Lasianthus condorensis Pierre ex Pit', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (884, N'Nhàu', N'Morinda citifolia L.', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (885, N'Ba kích', N'Morinda officinalis How.', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (886, N'Nhàu lông', N'Morinda villosa Hook.f.', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (887, N'Nhàu nam bộ', N'Morinda cochinchinensis', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (888, N'Nhàu nhuộm', N'Morinda tomentosa', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (889, N'Ba kích tím', N'Morinda officinalis', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (890, N'Bướm bạc không cánh', N'Mussaenda aptera Pit.', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (891, N'Bướm bạc căm bốt', N'M. cambodiana Pierre.', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (892, N'Gáo', N'Neonauclea purpurea (Roxb.) Merr', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (893, N'Huỳnh bá', N'Nauclea officinalis ', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (894, N'Găng', N'Oxyceros vidalii Tirw.', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (895, N'Mơ leo', N'Paederia scandens (Lour.) Merr.', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (896, N'Lấu đỏ', N'Psychotria rubra (Lour.) Poit.', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (897, N'Lấu', N'P. samentosa Bl.', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (898, N'Dây mơ, thúi địt', N'Paederia foetida L', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (899, N'Lấu trang', N'Psychotria Pseudo', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (900, N'Lấu rừng', N'Psychotria Silvestris', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (901, N'Lấu bắc bộ', N'Psychotria tonkinensis', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (902, N'Lấu', N'Psychotria ovoidea', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (903, N'Găng nhỏ', N'Randia canthioides Champ.', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (904, N'Găng trâu', N'R. spinosa Bl.', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (905, N'Hoàng hương', N'Saposma annamense Pierre', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (906, N'Đồng quáu', N'Uncaria homomalla Miq', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (907, N'Mẫu câu đằng lá lớn', N'Uncaria macrophylla Wall.', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (908, N'Trèn lá rộng', N'Tarenna latifolia', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (909, N'Trèn thon', N'tarenna attenuata', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (910, N'Hoắc quang', N'Wendlandia paniculata (Roxb.) DC', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (911, N'Hoành cành', N'Xanthophytum kwangtungensis', 0, 119, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (912, N'Bưởi bung', N'Acronychia pedunculata (L.) Miq.', 0, 120, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (913, N'Tiểu quật', N'Atalantia sessiliflora Guill.', 0, 120, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (914, N'Chanh ta', N'Citrus aurantifolia (Chritm.) Sw.', 0, 120, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (915, N'Quýt', N'C. deliciosa Ten', 0, 120, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (916, N'Bưởi', N'C. grandis (Lour.) Osb.', 0, 120, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (917, N'Chanh', N'C. limonia Osb.', 0, 120, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (918, N'Cam ', N'C. nobilis Lour', 0, 120, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (919, N'Hoàng bì', N'Clausena lansium', 0, 120, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (920, N'Củ khỉ', N'Clausena indica (Dez.) Oliv.', 0, 120, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (921, N'Ba gạc', N'Euodia lepta (Spreng) Merr ', 0, 120, NULL, 25, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (922, N'Ba chạc lá xoan', N'E. melifolia Benth.', 0, 120, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (923, N'Cơm rượu', N'Glycosmis cyanocarpa (Bl.) Spr.', 0, 120, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (924, N'Màu cau tía', N'Glycosmis cymosa', 0, 120, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (925, N'Cơm rượu xoan', N'G. ovoidae Pierre', 0, 120, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (926, NULL, N'G. sapindoides Lindl ex Oliv', 0, 120, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (927, N'Trang xạ', N'Luvunga sarmentosa (Bl.) Kurz', 0, 120, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (928, N'Mắt trâu', N'Micromelum minutum (Forst.) W.&A', 0, 120, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (929, N'Nguyệt quế', N'Murray paniculata (L.) Jack', 0, 120, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (930, N'Xáo leo', N'Paramignya scandens (Griff.) Craib. ', 0, 120, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (931, N'Tầm xong', N'Severinia monophylla (L.) Tan', 0, 120, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (932, N'Hoàng lực', N'Zanthoxylum aviceniae (Lamk.) DC', 0, 120, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (933, N'Hoàng lực tròn', N'Z. nitidum (Lamk.) DC ', 0, 120, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (934, N'Trường mật', N'Amesiodendron chinense (Merr.) Hu', 0, 117, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (935, N'Trường', N'Arytera littoralis Bl.', 0, 117, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (936, N'Tầm phỏng', N'Cardiospermum halicacabum L.', 0, 117, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (937, NULL, N'Dimocarpus fumatus (Bl.) Leenh.', 0, 117, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (938, N'Nhãn', N'D. longan Lour.', 0, 117, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (939, N'Vải', N'Litchi sinensis Radlk.', 0, 117, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (940, N'Nây', N'Mischocarpus poilanei Gagn.', 0, 117, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (941, N'Trôm mặt', N'Nephelium milliferum Gagn.', 0, 117, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (942, N'Trường mật', N'Paviesia annamensis Pierre', 0, 117, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (943, N'Trường', N'Pometia pinnata J. R.& Forst.', 0, 117, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (944, N'Săng sáp', N'Donella lanceolata (Bl.) Aubr.', 0, 133, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (945, N'Sến mật, Sến dưa', N'Madhuca pasquieri (Dub.) H.J.Lam', 0, 133, 5, 24, 0, NULL, 1, NULL, NULL, CAST(N'2023-07-11T13:27:27.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (946, N'Nhạn', N'Planchonella annamensis Pierre ex Dub.', 0, 133, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (947, N'Cheo', N'Xantolis dongnaiensis (Dub.) Aubr.', 0, 133, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (948, N'Sưn xe trung bộ', N'Kadsura roxburghiana Arnott.', 0, 140, 0, 25, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-11T13:33:11.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (949, N'Thanh thất', N'Ailanthus triphysa (Dennst.) Alst', 0, 135, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (950, N'Sầu đâu', N'Brucea javanica (L.) Merr.', 0, 135, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (951, N'Bá bệnh', N'Eurycoma harmandiana Pierre', 0, 135, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (952, N'Hải sơn', N'Harrisonia perforata (Bl.) Merr', 0, 135, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (953, N'Ớt', N'Capsicum frutescens L.', 0, 118, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (954, N'Thù lù', N'Physalis angulata L. ', 0, 118, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (955, N'Lulu', N'Solanum americanum Midl.', 0, 118, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (956, N'La', N'S. erianthum D. Don', 0, 118, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (957, N'Cà hung', N'Solanum ferox L.', 0, 118, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (958, N'Cà tím', N'S. melogena L.', 0, 118, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (959, N'Cà bò', N'S. procumbens Lour.', 0, 118, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (960, N'Cà nồng', N'S. torvum Swartz.', 0, 118, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (961, N'Cà 3 thuỳ', N'S. trilobatum L.', 0, 118, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (962, N'Cà pháo', N'S. undatum Poir.', 0, 118, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (963, N'Phay', N'Duabanga grandiflora (DC.) Walp.', 0, 115, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (964, N'Cây bông vàng, tai mèo', N'Abroma angustata L.', 0, 138, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (965, N'Bích nữ lông', N'Byttneria  pilosa Roxb.', 0, 138, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (966, N'Bích nữ', N'B. andamensis Kurz.', 0, 138, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (967, N'Ổ kén', N'Helicteres angustifolia L.', 0, 138, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (968, N'Ổ kén hẹp', N'H. angustifolia Pierre.', 0, 138, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (969, N'Tổ kén', N'Helicteres glabriuscula', 0, 138, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (970, N'Dó chuột', N'H. hirsuta Lour.', 0, 138, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (971, N'Dó trin', N'H. viscida Bl.', 0, 138, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (972, N'Ổ kén', N'Helicteres sp', 0, 138, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (973, N'Huỳnh', N'Helitiera cochinchinensis (Pierre) Kost.', 0, 138, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (974, N'Lòng mang', N'Pterospermum diversifolium Bl.', 0, 138, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (975, N'Lòng mang lá dị dạng', N'P. heterophyllum. Hance', 0, 138, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (976, N'Màng kiêng', N'P. truncatolobatum Gagn.', 0, 138, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (977, N'Lười ươi', N'Scaphium macropodium L.', 0, 138, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (978, N'Sãng cánh', N'Sterculia alata Roxb.', 0, 138, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (979, N'Trâm cuống mãnh', N'Sterculia Gracilipes Pierre', 0, 138, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (980, NULL, N'Sterculia Sp', 0, 138, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (981, N'Trôm dài màng ', N'S. hymenocalyx K. Schum', 0, 138, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (982, N'Trôm', N'S. hyposticta Miq.', 0, 138, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (983, N'Sảng', N'S. lanceolata Cav.', 0, 138, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (984, N'Đua đũa đông dương', N'Rehderodendron indochinense H.Li', 0, 116, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (985, N'An tức lá bạc', N'Ityrax Argeatifolins', 0, 116, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (986, N'Dung có tuyến', N'Symplocos  adenophylla Wall. ex O. Don', 0, 124, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (987, N'Dung trung bộ', N'Symplocos annanensis', 0, 124, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (988, N'Dung khác thường', N'S. anomala Brand. ', 0, 124, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (989, N'Dung lá hẹp', N'S. cochinchinensis (Lour.) Nooteb.', 0, 124, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (990, N'Dung 2 lá dài', N'S. disepala Guill. ', 0, 124, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (991, N'Dung lá thon', N'S. lanceolata Sieb. & Zucc', 0, 124, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (992, N'Dung chum', N'S. paniculata (Thunb.) Druce', 0, 124, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (993, N'Dung thòng', N'S. pendula Wight.', 0, 124, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (994, N'Rum đỏ', N'Adinandra annamensis Gagn.', 0, 136, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (995, N' Sum đỏ điều', N'A. rubropunctata Merr. & Chun', 0, 136, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (996, N'Chà hoa hồng', N'Camellia assimilis Champ. ex Benth.', 0, 136, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (997, NULL, N'C. dormoyana (Pierr.) Senly', 0, 136, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (998, N'Trà', N'C. sinensis (L.) O. Ktze', 0, 136, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (999, N'Linh lá Sởi', N'Eurya cerasifolia (D.Don) Kob.', 0, 136, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1000, N'Trơn trà Trung bộ', N'E. annamensis Gagn.', 0, 136, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1001, N'Linh lá Sơ ri', N'E. cerasifolia (D. Don.) Kob.', 0, 136, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1002, N'Linh Bắc bộ', N'E. tonkinensis Gagn.', 0, 136, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1003, N'Súm', N'Eurya nitida ', 0, 136, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1004, N'Linh chà', N'Eurya stenophylla', 0, 136, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1005, N'Gò đồng nách', N'Gordonia axillaris (Roxb. ex Ker-Gawl.) Endl. ', 0, 136, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1006, N'Gò đồng Bắc bộ', N'Godonia tonkinensis Pit.', 0, 136, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1007, N'Thạch châu', N'Pyrenaria poilaneana  Gagn.', 0, 136, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1008, N'Thạch châu', N'Pyrenaria garretiana', 0, 136, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1009, N'Vối thuốc', N'Schima wallichii DC. Korth.', 0, 136, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1010, N'Giang núi', N'Ternstroemia japonica Thunb.', 0, 136, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1011, N'Tam thư', N'Tristylium aff. ochnaceum (DC.) Merr. ', 0, 136, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1012, N'Dó trầm, Trầm hương', N'Aquilaria crassna Pierre ex Lec', 0, 137, 3, 24, 0, NULL, 1, NULL, NULL, CAST(N'2023-07-11T13:44:33.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1013, N'Dó bai lon', N'A. baillonii Pierre. ex Lec.', 0, 137, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1014, N'Dó miết', N'Wikstroemia poilanei Leandri', 0, 137, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1015, N'Bố dại', N'Corchorus nestuans L.', 0, 122, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1016, N'Bù lốt ', N'Grewia bulot Gagn.', 0, 122, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1017, N'Cò kè', N'G. eberhardtii H. Lec.', 0, 122, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1018, N'Bung lai', N'G. paniculata Roxb. ex DC', 0, 122, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1019, N'Cò ke cánh sao, Meo', N'Grewia astropetala Pierre', 0, 122, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1020, N'Gai đầu lông', N'Triumfetta pseudocana Spragua & Craib.', 0, 122, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1021, N'Gai đầu hình thoi', N'T. bactramia L.', 0, 122, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1022, N'Ngát trơn', N'Gironniera cuspidata (Bl.) Pl. ex Kurz.', 0, 123, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1023, N'Ki gân bằng', N'G. subequalis Pl.', 0, 123, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1024, N'Sếu đông', N'G. orientalis Thunb.', 0, 123, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1025, N'Hu day lá nhỏ', N'Trema cannabina Lour.', 0, 123, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1026, N'Hu đay', N'T. orientasis (L.) Bl.', 0, 123, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1027, N'Đay suối', N'Boemeria tonkinensis Gagn.', 0, 126, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1028, N'Đề gia vảy', N'Debregeasia squamata King.f. ', 0, 126, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1029, N'Han voi', N'Dendrocnide urentissima (Gagn.) Chev.', 0, 126, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1030, N'Cao hung', N'Elatostema cuneatum Wight.', 0, 126, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1031, N'Cao hùng cắt hai', N'E. dissectum Wedd.', 0, 126, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1032, N'Han tím', N'Laportea interrupta (Gauld.) Chew.', 0, 126, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1033, N'Han bò', N'L. thorelii Gagn.', 0, 126, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1034, N'Phu lệ', N'Pellonia eberhardtii Gagn.', 0, 126, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1035, N'Mồng nhỏ', N'P. cristulata Gagn.', 0, 126, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1036, N'Rum thơm', N'Poikilospermum  suaveolens (Bl.) Merr.', 0, 126, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1037, N'Bo mẩn', N'Pouzolzia zeylanica (L.) Benn.', 0, 126, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1038, N'Thuốc vòi lông', N'P. hirta Hassk.', 0, 126, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1039, N'Nai bắc bộ', N'Villebrunea tonkinensis Gagn.', 0, 126, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1040, N'Nai', N'V. frutescens  Bl. ', 0, 126, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1041, N'Túc cầu', N'Callicarpa acutidens Schauer ', 0, 121, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1042, N'Ngọc nữ gaudichau', N'Clerodendrum gaudichaudii Dop', 0, 121, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1043, N'Ngọc nữ colebrook', N'Clerodendrum colebrookiamum Walp.', 0, 121, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1044, N'Ngọc nữ', N'Clerodendrum Sp', 0, 121, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1045, N'Ngọc nữ Wallich', N'Clerodendrum wallichi Merr', 0, 121, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1046, N'Tu hú gỗ', N'Callicarpa arborea Roxb. ', 0, 121, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1047, N'Từ châu', N'Callicarpa Giarchiana', 0, 121, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1048, N'Túc cầu', N'C. longifolia Lam', 0, 121, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1049, N'Đắng cảy', N'Clerodendrum cyrtophyllum Turz', 0, 121, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1050, N'Ngọc nữ đỏ', N'C. paniculatum L. ', 0, 121, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1051, N'Ngọc nữ', N'C. schmidtii C.B.Cl.', 0, 121, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1052, N'Lõi thọ', N'Gmelia arborea Roxb.', 0, 121, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1053, N'Tu hú', N'G. asiatica L.', 0, 121, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1054, N'Bông ổi', N'Lantana camara L.', 0, 121, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1055, N'Cách balan', N'Premna balansae Dop.', 0, 121, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1056, N'Cách', N'P. serratifolia L.', 0, 121, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1057, N'Cách leo', N'Premna scandens', 0, 121, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1058, N'Thọ ', N'Tsoongia axillariflora Merr.', 0, 121, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1059, N'Bình linh đá', N'Vitex pierreana P. Dop.', 0, 121, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1060, N'Bình linh', N'V. sumatrana King & Gamble', 0, 121, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1061, N'Ngũ chảo', N'V. negundo L.', 0, 121, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1062, N'Đẹn 3 lá', N'V. trifolia (O. Ktze) Mold', 0, 121, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1063, N'Roi ngựa', N'Verbena officinalis L.', 0, 121, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1064, N'Song nho trung bộ', N'Ampelopsis annamensis Gagn.', 0, 130, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1065, N'Chè dây', N'Ampelopsis cantiniensis Planch.', 0, 130, 6, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-07-11T13:51:47.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1066, N'Vác sừng nhỏ', N'Cayratia corniculata (Benth.) Gagnep.', 0, 130, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1067, N'Vác chân vịt', N'Cayratia palmata Gagn.', 0, 130, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1068, N'Dây vác', N'C. trifolia (L.) Domino', 0, 130, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1069, N'Hồ đằng', N'Cissus astrotricha Gagn.', 0, 130, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1070, N'Hồ đằng mũi giáo', N'C. hastata Pl.', 0, 130, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1071, N'Hồ đằng 6 cạnh', N'C. hexangularis Thor. ex Gagn.', 0, 130, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1072, N'Chìa vôi', N'C. modeccoides Pl.', 0, 130, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1073, N'Tứ thư hoa trên thân', N'Tetrastigma cauliflorum Merr. ', 0, 130, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1074, N'Tứ thư thân dẹp', N'Tetrastigma planicaule (Hook. f.) Gagnep. ', 0, 130, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1075, N'Tứ thư mũi', N'Tetrastigma apiculatum Gagn..', 0, 130, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1076, N'Tứ thư', N'Tetrastigma subsuberosum', 0, 130, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1077, N'Nho đất', N'Vitis balanseana Pl.', 0, 130, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1078, N'Liên đằng', N'Illigera celebica Miq..', 0, 130, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1079, N'Liên đằng hoa nhỏ', N'Illigera rhodantha', 0, 130, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1080, N'Tai voi', N'Chirita colaniae ', 0, 130, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1081, N'Huyết giác', N'Dracaena cochinchnensis (Lour.) Merr.', 0, 5, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1082, N'Bồng bồng', N'Dracaena angustifolia', 0, 5, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1083, N'Phất thủ mảnh', N'D. gracilis Wall.', 0, 5, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1084, N'Phất thủ căm bot', N'D. cambodia Pierre ex Gagn.', 0, 5, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1085, N'Lưỡi cọp', N'Sanseviera hyacinthoides (L.) Druce', 0, 5, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1086, N'Cồ nốc song đích', N'Curculigo disticha Gagn.', 0, 8, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1087, N'Cồ nốc mảnh', N'C. gracilis Wall.', 0, 8, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1088, N'Cỏ nốc annam', N'Curculigo annamitica Gagn', 0, 8, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1089, N'Bồ bồ núi', N'Acorus tatarinowi Schott. ', 0, 15, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1090, N'Thạch xương bồ lá nhỏ', N'Acorus gramieus', 0, 15, 6, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-07-11T13:47:32.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1091, N'Ráy mũi', N'Alocasia cuspidata Engler.', 0, 15, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1092, N'Ráy nằm', N'A. decumbens Buchet.', 0, 15, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1093, NULL, N'Amorphophyllus mekongensis Engler. & Gegrm', 0, 15, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1094, N'Thiên niên kiện', N'Homalonema occulta (Lour.) Schott.', 0, 15, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1095, N'Cơm lênh', N'Pothos augustifolius Presl.', 0, 15, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1096, NULL, N'P. gigantipes Buchet', 0, 15, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1097, N'Cơm lênh', N'P. repens (Lour.) Druce', 0, 15, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1098, N'Ráy leo', N'P. scandens L. ', 0, 15, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1099, N'Ráy vân nam', N'P. yunanensis Engler', 0, 15, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1100, N'Bán hạ rẻ', N'Typhonium blumei Nich', 0, 15, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1101, N'Đuôi phượng', N'Raphidophora decursiva (Roxb.) Schot.', 0, 15, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2022-11-15T17:14:18.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1102, N'Trâm đài', N'raphidophora hookeri', 0, 15, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1103, N'Đoác', N'Arenga pinnata (Wurmb.) Merr.', 0, 17, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1104, N'Phướn', N'arenga caudata', 0, 17, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1105, N'Mây', N'Calamus henryanus Becc', 0, 17, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1106, N'Mây roi', N'C. flagellum Griff.', 0, 17, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1107, N'Song bột, Mây bột', N'Calamus poilanei Conr.', 0, 17, 0, 24, 0, NULL, 1, NULL, NULL, CAST(N'2023-07-11T13:55:36.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1108, N'Mây mật', N'C. tetradactylus Hance', 0, 17, 27, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1109, N'Đùng đình ngứa', N'Caryota urens L', 0, 17, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1110, N'Đùng đình Bắc sơn', N'C. bacsonensis Magalon', 0, 17, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1111, N'Đùng đình', N'Caryota sympactala Gagnep.', 0, 17, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1112, N'Mây rút', N'Daemonorops pierreanus Becc', 0, 17, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1113, N'Mây dạ', N'Korthalsia laciniosa Mart.', 0, 17, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1114, N'Lá nón', N'Licuala centralis  Henderson, N.K.Ban & N.Q.Dung', 0, 17, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1115, N'Lá nón đăk rông', N'L. dakrongensis A.J.Hend., N.K.Ban & B.V.Thanh', 0, 17, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1116, N'Trụi thành', N'Licuala elegans Magalon ', 0, 17, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1117, N'Mật cật to', N'L. grandis Wendl.', 0, 17, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1118, N'Ra bàn nạo', N'L. radula Gagn.', 0, 17, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1119, N'Kè Bắc bộ', N'Livistona tonkinensis Magalon', 0, 17, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1120, N'Cau chuột', N'Pinanga duperreana Pierre ex Gagn.', 0, 17, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1121, N'Lụi', N'Rhapis excelsa (Thunb.) Henry ex. Rehd.', 0, 17, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1122, N'Lụi lào', N'Rhaphis  laoensis Becc.', 0, 17, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1123, N'Thơm', N'Ananas comosus (L.) Merr.', 0, 30, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1124, N'Lâm trai', N'Amischolotype mollissima (Bl.) Hassk.', 0, 42, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1125, N'Đầu riều', N'Commelina benganlensis L.', 0, 42, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1126, N'Trai trắng', N'C. communis L.', 0, 42, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1127, N'Bích trai', N'Cyanotis axillaris L.', 0, 42, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1128, N'Loã trai lá xoan', N'Dictyospermum ovalifolium Wight', 0, 42, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1129, N'Đầu riều không lông', N'Floscopa glabratus Hassk', 0, 42, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1130, N'Đầu riều leo', N'F. scandens Lour.', 0, 42, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1131, N'Thài lài trung quốc', N'Murdannia loriformis (Hassk.) R. S. Rao & Kammathy', 0, 42, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1132, N'Trai ', N'Murdannia spectabilis (Kurz) Faden', 0, 42, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1133, N'Loã trai soắn', N'M. spirata (L.) Bruckner.', 0, 42, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1134, N'Bạng hoa', N'Tradescentia discolor L''Herit .', 0, 42, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1135, N'Mía dò hoa trắng', N'Costus speciosus (Koenig ex Retz.) J. E. Smith.', 0, 45, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1136, N'Cói túi ấn', N'Carex indica L.', 0, 49, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1137, N'Kiết rộng', N'Carex spatiosa Boott', 0, 49, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1138, N'Cỏ bạc đầu', N'Cyperus dubius Rottb.', 0, 49, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1139, N'Cỏ cú', N'C. halpan L.', 0, 49, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1140, N'Hương phụ', N'C. rottundus L.', 0, 49, 6, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-07-11T14:09:45.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1141, N'Cỏ cú nhỏ', N'C. pumilus L. ', 0, 49, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1142, N'Cỏ 3 cạnh', N'C. trialatus (Boeck) Kern', 0, 49, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1143, N'Cỏ chác', N'Fimbristylis miliacea (L.) Vahl.', 0, 49, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1144, N'Cỏ bạc đầu', N'Kyllinga nemoralis (J.R. & G.Forst) Dandy ex Hutch. & Dalz', 0, 49, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1145, N'Hoàng thảo hến', N'Scirpus juncoides Roxb. ', 0, 49, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1146, N'Hoàng thảo', N'S. massfeldianus Kuk.', 0, 49, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1147, N'Hoàng thảo xiêm ', N'S. siamensis (C.B.Clarck.) Kern.', 0, 49, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1148, N'Củ tím', N'Dioscorea alata L.', 0, 53, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1149, N'Củ nâu', N'D. cirrhosa Prain. & Burk.', 0, 53, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1150, N'Củ mài', N'D. glabra Roxb.', 0, 53, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1151, N'Khoai dãi, khoai trời', N'Dioscorea bulbifera L..', 0, 53, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1152, N'Mây nước', N'Flagellaria indica L.', 0, 64, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1153, N'Xà thảo', N'Liriope spicata Lour.', 0, 69, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1154, N'Cao cẳng', N'Ophiopogon reptan Hook.f.', 0, 69, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1155, N'Xà thảo lá dài', N'O. longifolius Dene ', 0, 69, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1156, N'Bì xà', N'O. peliosanthoides W & Arn.', 0, 69, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1157, N'Xà bì', N'Ophiopogon tonkinensis', 0, 69, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1158, N'Rẻ quạt', N'Belamcandra chinensis (L) DC. ', 0, 74, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1159, N'Sâm đại hành', N'Eleuthrine bulbosa (Mill.) Urban.', 0, 74, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1160, N'Xương quạt hương lâu', N'Dianella nemorosa Lam. ex Schiller.f', 0, 80, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1161, N'Song bào móng', N'Disporum calcaratum D. Don ', 0, 80, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1162, N'Song bào đá', N'Disporum trabeculatum Gagn.', 0, 80, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1163, N'Bần hướng', N'Oligobotrya henryi Bak.', 0, 80, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1164, N'Hưu túc', N'Paris polyphylla Sm.', 0, 80, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1165, N'Bẩy lá một hoa', N'Paris chinensis Franch.', 0, 80, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2022-11-15T15:48:11.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1166, N'Hoàng tinh', N'Polygonatum kingianum coll.et Hemsl', 0, 80, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1167, N'Hoàng tinh rằn', N'Calathea clossoni Hort.', 0, 88, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1168, N'Dong nếp', N'Phrynium dispermum Gagn.', 0, 88, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1169, N'Chuối rừng', N'Musa aucuminata Colla.', 0, 95, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1170, N'Lan yên ngựa vạch', N'Acanthephippium striatum Lindl.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-11T14:25:21.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1171, N'Giáng hương', N'Aerides falcata Lindl.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-18T09:59:12.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1172, N'Giáng hương hồng nhạn', N'Aerides odorata Lour', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-18T10:03:42.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1173, N'Lan cang cua thân ngắn', N'Agrostophyllum brevipes King & Pantl.', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1174, N'Xích thủ', N'Agrostophyllum planicaule (Lindl.) Reichb.f.', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1175, N'Lan gấm', N'Anoectochilus cetaceus Blume', 0, 104, NULL, NULL, 31, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1176, N'Gia thuỳ', N'A. lylei Rolfe ex Downies ', 0, 104, 0, 0, 31, NULL, 1, NULL, NULL, CAST(N'2022-11-23T13:58:14.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1177, N'Lan kim tuyến', N'Anoectochilus roxburghii (Wall.) Lindl.', 0, 104, NULL, NULL, 31, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1178, N'Sậy lan', N'Arundina graminifolia (D.Don) Hochr.', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1179, N'Cầu diệp', N'Bulbophyllum poilanei Gagn.', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1180, N'Lan lọng tà', N'Bulbophyllum retusiusculum Rchb.f.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-18T10:16:35.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1181, N'Lan lọng đầu', N'B. sigaldiae Guill.', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1182, N'Lan lọng tán', N'B. umbellatum Lindl.', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1183, N'Lan bầu rượu', N'Calanthe aleizettii Gagn.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-18T10:26:44.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1184, N'Kiều lan', N'Calanthe triplicata (Willem.) Ames.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-18T10:30:05.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1185, N'Kiều lan', N'Calanthe lyroglossa', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1186, N'Trung lan', N'Cephalantheropsis obcordata (Lindl.) Ormerod', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-18T10:33:18.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1187, N'Vòi sừng lùn', N'Ceratostylis siamensis Downie', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1188, N'Miệng kín hai gai', N'Cleisostoma birmanicum (Schltr.) Garay', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-03-20T16:17:15.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1189, N'Miệng kín buông rủ', N'C. williamsonii (Rchb.f.) Garay', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1190, N'Tuyết ngọn', N'Coelogyne mooreana Sander ex Rolfe', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-18T10:38:04.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1191, N'Lan thanh đạm', N'Coelogyne ovalis Lindl.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-03-20T16:15:00.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1192, N'Tản lan', N'Corymborkis veratrifolia (Reinw.) Bl.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-18T10:42:13.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1193, N'Đoản kiếm', N'Cymbidium banaense Gagn.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-18T10:51:53.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1194, N'Lan kiếm lá giáo', N'Cymbidium lancifolium Hook.f.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-18T10:53:44.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1195, N'Bích ngọc', N'Cymbidium dayanum Reichb. F', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-03-20T16:09:32.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1196, N'Thuỷ tiên hường', N'Dendrobium amabile (Lour.) O''brien ', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-03-20T16:06:07.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1197, N'Ngọc điểm, Thuỷ tiên', N'Dendrobium farmeri Paxt.', 0, 104, 0, 25, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-18T13:38:13.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1198, N'Kim điệp', N'Dendrobium fimbriatum Hook.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-18T13:42:31.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1199, N'Thạch hộc hoa tím', N'D. hercoglossum Rchb.f.', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1200, N'Vảy rắn', N'Dendrobium lindleyi Steudel.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-03-20T15:39:52.000' AS DateTime), N'20')
GO
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1201, N'Hoàng thảo thạch hộc', N'Dendrobium loddigesii Rolfe', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-03-20T15:19:19.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1202, N'Thạch hộc', N'Dendrobium nobile Steudel', 0, 104, 0, 24, 32, NULL, 1, NULL, NULL, CAST(N'2023-03-20T15:13:29.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1203, N'Hường lan', N'Dendrobium parciflorum Reichb.f.ex Lindl', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-03-20T15:05:33.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1204, N'Thủy tiên phi', N'Dendrobium phi E.Christenson', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-03-20T15:05:12.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1205, N'Lan trăm', N'D. terminale Par. & Rchb.f.', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1206, N'Thuỷ tiên', N'Dendrobium thyrsiflorum Reichb.f.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-03-20T15:04:08.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1207, N'Hoàng thảo xoắn', N'Dendrobium tortile', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-03-20T14:51:58.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1208, N'Lưỡng giả búi', N'Didymoplexiopsis khiriwongensis Seidenf.', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1209, N'Thượng lan', N'Epipogium roseum (D.Don) Lindl.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-18T14:26:03.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1210, N'Nỉ lan', N'Eria amica Reichb.f.f', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-18T14:29:48.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1211, N'Nỉ lan', N'Eria corneri Reichb.f.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-18T14:31:31.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1212, N'Nỉ lan cầu', N'Eria globulifera Seidenf.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-18T14:33:19.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1213, N'Nỉ lan lá mác', N'E. lactiflora Aver.', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1214, N'Nỉ lan lá tả tơi', N'Eria pannea Lindl.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-03-20T14:41:36.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1215, N'Nỉ lan bé', N'Eria pusilla (Griff.) Lindl.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-18T14:36:04.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1216, N'Nỉ lan hẹp', N'Eria siamensis Schlechter', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-18T14:36:37.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1217, N'Nỉ lan thao', N'Eri thao Gagnep.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-03-20T14:46:59.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1218, N'Xích lan', N'Erythrodes hirsuta (Griff.) Ormerod', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1219, N'Xích lan', N'Erythrorchis ochobiensis (Hary.) Gray', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-18T14:38:56.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1220, N'Luân lan hoa vàng', N'Eulophia flava (Lindl.) Hook. F', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1221, N'Hà biện răng', N'Herbenaria dentata (Sw.) Schltr.', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1222, N'Lan kiến cò', N'Herbenaria rhodocheita Hance', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1223, N'Hà biện hoa xanh', N'H. viridiflora (Sw.) R.Br.', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1224, N'Phiên thần hai môi', N'Hetaeria anomala (Lindl.) Hook.f.', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1225, N'Lan tóc tiên', N'Holcoglossum subulifolium (Rchb.f.) ', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-03-20T14:25:57.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1226, N'Nhẵn diệp bầu dục', N'Liparis elliptica Wight', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-03-20T14:16:11.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1227, N'Lan cánh nhạn', N'L. tixieri Guillaum.', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1228, N'Lan lá gấm', N'Ludisia discolor (Ker-Gawl.) A.Rich.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2022-11-23T15:01:34.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1229, N'Lan gấm', N'L. zollingeri Rchb.f.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-03-20T14:11:28.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1230, N'Lan tuyến tơ', N'Anoectochilus setaceus', 0, 104, 0, 24, 31, NULL, 1, NULL, NULL, CAST(N'2023-03-20T14:10:40.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1231, N'Phi hành mũi dài', N'Mischobulbum ovifolium (Tsi & S.C.Chen) Aver.', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1232, N'Vân diệp hoa nhỏ', N'Nephelaphyllum tenuiflorum Blume', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-03-20T13:50:59.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1233, N'Nơ lan', N'Neuwiedia balansae Baill. ex Gagnep.', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1234, N'Lan quạt sâu róm', N'Oberonia longibracteata Lindl.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-03-20T13:42:28.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1235, N'Lan quạt', N'Otochilus sp.', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1236, N'Vệ hài', N'Paphiopedilum amabile Hall. f.', 0, 104, 0, 0, 31, NULL, 1, NULL, NULL, CAST(N'2023-03-20T13:43:05.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1237, N'Lan hài vân', N'Paphiopedilum appletonianum (Gower) Rolfe forma tridentatum Aver.', 0, 104, 0, 0, 31, NULL, 1, NULL, NULL, CAST(N'2023-03-20T13:43:12.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1238, N'Túc thiệt', N'Podochilus intermedius Aver.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-03-20T13:51:53.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1239, N'Huyết nhung', N'Renanthera coccinea Lour.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-03-20T13:52:30.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1240, N'Đuôi cáo', N'Rhynchostylis retusa (L.) Bl.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-03-20T13:52:06.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1241, N'Nang lan chồi', N'Schoenorchis gemmata (Lindl.) J.J.Smith', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-03-20T09:39:39.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1242, N'Hổ bí', N'Staurochlilis fasciatus', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-03-20T10:03:55.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1243, N'Tài lan xanh nâu', N'Tainia viridifusca (Hook.) Benth. & Hook.f.', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1244, N'Lan củ chén', N'Thecostele alata (Roxb.) Par. & Rchb.f.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2022-11-23T13:50:36.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1245, N'Ái trụ lùn', N'Thelasis pygmaea (Griff.) Blume', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-18T16:15:58.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1246, N'Mao tử trung', N'Thrixspermum sp.nov.', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1247, N'Tam lan mũi', N'Trias nasuta (Rchb.f.) Stapf.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-18T16:21:18.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1248, N'Lan chùm ba', N'T. nummularia Aver. et Averyanova', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1249, N'Mao lan', N'Trichotosia pulvinata (Lindl.) Kraenzl.', 0, 104, 0, 0, 32, NULL, 1, NULL, NULL, CAST(N'2023-07-18T16:27:52.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1250, N'Thơ sinh', N'Zeuxine aphylla sp.nov.', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1251, N'Thơ sinh hoa vàng', N'Z. flava (Wall. ex Lindl.) Trimen', 0, 104, NULL, NULL, 32, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1252, N'Dứa bắc bộ', N'Pandanus tonkinensis Mart. ex Stone', 0, 107, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1253, N'Dứa cam', N'P. affinis Kurz.', 0, 107, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1254, N'Dứa nhỏ', N'Pandanus humilis Lour', 0, 107, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1255, N'Lồ ô', N'Bambusa balcoa Roxb.', 0, 113, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1256, N'Tre gai', N'B. blumeana Schultes ', 0, 113, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1257, N'Cỏ móc', N'Centhotheca lappacea (L.) Desv.', 0, 113, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1258, N'Cỏ may', N'Chrysopogon aciculatus (Retz) Trin', 0, 113, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1259, N'Ý dĩ', N'Coix lacryma Jobi L.', 0, 113, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1260, N'Cỏ chỉ', N'Cynodon dactylon (L.) Pers', 0, 113, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1261, N'Giang', N'Dendrocalamus patellaris Gamble', 0, 113, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1262, N'Tre rắn', N'D. sinuata (Gamble) Holtt.', 0, 113, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1263, N'Cỏ lông vực', N'Echinochloa colonum (L.) Link', 0, 113, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1264, N'Mần trầu', N'Eleusine indica (L.) Gaertn', 0, 113, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-07-18T16:35:18.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1265, N'Lau', N'Erianthus arundinaceus (Retz.) Jeswiet', 0, 113, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1266, N'Cỏ tranh', N'Imperata cylindrica (L.) P.Beauv.', 0, 113, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1267, N'Cỏ rác', N'Isachne dispa Trin', 0, 113, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1268, N'Chè vè', N'Miscanthus floridulus (Labill.) Warb. ex Schum & Lauterb.', 0, 113, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1269, N'Lúa', N'Oryza sativa L.', 0, 113, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1270, N'Cỏ đắng', N'Paspalum scrobiculatum L.', 0, 113, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1271, N'Sậy', N'Phragmites vallatoria (L.) Veldk.', 0, 113, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1272, N'Mía', N'Saccharum officinarum L.', 0, 113, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1273, N'Lách', N'S. spontaneum L.', 0, 113, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1274, N'Sâu dóm', N'Setaria pumila (Poir.) Roem. & Schult.', 0, 113, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1275, N'Trúc gai', N'Sinarundinaria griffithiana (Munro) Chalo & Rens', 0, 113, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1276, N'Đót, chít', N'Thysanolaena maxima (Roxb.) O. Ktze.', 0, 113, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1277, N'Ngô', N'Zea mays L.', 0, 113, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1278, N'Kim cang móng bò', N'Smilax bauhinioides Kunth.', 0, 145, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1279, N'Kim cang', N'S. corbularia Kunth.', 0, 145, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1280, N'Kim cang ganepain.', N'S. ganepainii Koy.', 0, 145, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1281, N'Thổ phục linh', N'S. glabra Roxb.', 0, 145, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1282, N'Kim cang thon', N'S. lanceifolia Roxb.', 0, 145, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1283, N'Kim cang chùm', N'S. paniculata Gagn.', 0, 145, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1284, N'Kim cang hở', N'S. riparia A.&C.DC ', 0, 145, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1285, N'Khúc khắc – Kim cang', N'Smilax china', 0, 145, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1286, N'Bách bộ củ', N'Stemona tuberosa Lour. ', 0, 146, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-07-10T08:44:03.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1287, N'Râu hùm', N'Tacca chantrieri Andre', 0, 147, 0, 25, 0, NULL, 1, NULL, NULL, CAST(N'2023-03-20T13:53:12.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1288, N'Vùi dâu', N'T. plantaginea (Hance) Drenth', 0, 147, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2021-11-28T09:57:02.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1289, N'Hạ túc, Ngãi rợm', N'T. intergrifolia Ker.-Gawl.', 0, 147, NULL, 25, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1290, N'Gừng trung quốc', N'Alpinia chinensis (Retz.) Rosacoe', 0, 151, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1291, N'Mè tré', N'Alpinia globosa (Lour.) Horan.', 0, 151, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1292, N'Riềng', N'Alpinia officina Hance', 0, 151, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1293, NULL, N'Catimbium bracteatum Rox', 0, 151, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1294, N'Lô ba', N'Globba pendula Roxb.', 0, 151, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1295, N'Ngải tiên', N'Hedychium stenopetalum Lodd.', 0, 151, NULL, NULL, NULL, NULL, 1, NULL, NULL, CAST(N'2022-06-01T15:39:28.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1296, N'Tiết mi', N'Thismia tentaculata', 0, 32, NULL, NULL, NULL, NULL, 1, NULL, NULL, CAST(N'2022-06-01T15:39:27.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1297, N'Song đinh việt nam', N'Diplopanax vietnamensis', 0, 99, NULL, NULL, NULL, NULL, 1, NULL, NULL, CAST(N'2021-11-29T16:07:16.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1298, N'Chuột voi đồi', N'Hylomys suillus (Müller, 1839)', 1, 192, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1299, N'Chuột chũi', N'Euroscaptor sp.', 1, 256, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1300, N'Chuột chù đuôi đen', N'Crocidura attenuata Milne-Edwards, 1872', 1, 250, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1301, N'Đồi', N'Tupaia glis (Diard,1820)', 1, 262, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1302, N'Chồn dơi', N'Cynocephalus variegatus (Audebert,1799)', 1, 187, NULL, 24, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1303, N'Dơi chó ấn', N'Cynopterus sphinx (Vahl, 1797)', 1, 237, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1304, N'Dơi ăn mật hoa lớn', N'Macroglosus subrinus (K. Andersen, 1911)', 1, 237, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1305, N'Dơi quả lưỡi dài', N'Eonycteris spelaea (Dobson, 1871)', 1, 237, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1306, N'Dơi quả không đuôi lớn', N'Megaerops niphanae(Yenbutra and Felten, 1983)', 1, 237, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1307, N'Dơi quả núi cao', N'Sphaerias blanfordi (Thomas, 1891)', 1, 237, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1308, N'Dơi ma bắc', N'Megaderma lyra (E. Geoffroy, 1810)', 1, 213, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1309, N'Dơi lá đuôi', N'Rhinolophus affinis (Horsfield, 1823)', 1, 243, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1310, N'Dơi lá mũi nhỏ', N'Rhinolophus pusillus (Temmicki, 1834)', 1, 243, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1311, N'Dơi lá mũi ô-gút', N'Rhinolophus cf. Pusillus (Blyth, 1844)', 1, 243, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1312, N'Dơi lá tai dài', N'Rhinolophus macrotis Blyth, 1844', 1, 243, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1313, N'Dơi lá péc-xôn', N'Rhinolophus pearsonii Horsfield, 1851', 1, 243, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1314, N'Dơi lá nam á', N'Rhinolophus cf.microglobosus Csorba and Jenkins, 1998', 1, 243, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1315, N'Dơi lá quạt', N'Rhinolophus paradoxolophus (Bourret, 1951)', 1, 243, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1316, N'Dơi lá tô-ma', N'Rhinolophus thomasi (K. Andersen, 1905)', 1, 243, NULL, 25, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1317, N'Dơi nếp mũi quạ', N'Hipposideros armiger (Hodgson, 1835)', 1, 203, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1318, N'Dơi nếp mũi lông đen', N'Hipposideros cineraceus Blyth, 1853', 1, 203, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1319, N'Dơi nếp mũi xám', N'Hipposideros larvatus (Horsfield, 1823)', 1, 203, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1320, N'Dơi nếp mũi xinh', N'Hipposideros pomona K.Adersen, 1918', 1, 203, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1321, N'Dơi nếp mũi ba lá', N'Aselliscus stoliczkanus (Dobson, 1871)', 1, 203, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1322, N'Dơi tai sọ cao', N'Myotis siligorensis (Horsfield, 1855)', 1, 266, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1323, N'Dơi mũi ống tai tròn', N'Murina cyclotis (Dobson, 1872)', 1, 266, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1324, N'Dơi mũi ống lông chân', N'Murina tubinaris (Scully, 1881)', 1, 266, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1325, N'Dơi muỗi sọ nhỏ', N'Pipistrellus paterculus (Thomas, 1915)', 1, 266, 26, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1326, N'Dơi', N'Pipistrellus sp.', 1, 266, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1327, N'Dơi', N'Myotis muricola', 1, 266, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1328, N'Dơi chân đệm thịt', N'Tylonycteris pachypus (Temminck, 1840)', 1, 266, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1329, N'Dơi mũi ống', N'Murina sp.', 1, 266, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1330, N'Dơi mũi ống', N'Murina beelzebub (Son, Furey, Csorba, 2011)', 1, 266, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1331, N'Dơi mũi nhẵn', N'Kerivoula sp', 1, 266, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1332, N'Dơi mũi nhẵn lớn', N'Kerivoula titania Bates, (Struebig, Hayes, Furey, Mya, Thong, Son, Harrison, Csorba, Francis, 2007)', 1, 266, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1333, N'Cu li lớn', N'Nycticebus coucang (Boddaert, 1875)', 1, 210, 25, 25, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1334, N'Cu li nhỏ', N'Nycticebus pygmaeus (Bonhote, 1907)', 1, 210, 4, 25, 41, 41, 1, NULL, NULL, CAST(N'2023-08-02T09:40:30.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1335, N'Khỉ đuôi lợn', N'Macaca nemestrina (Linnaeus, 1767)', 1, 174, 5, 25, 42, NULL, 1, NULL, NULL, CAST(N'2023-08-02T10:33:26.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1336, N'Khỉ vàng', N'Macaca mulatta (Zimmermann, 1870)', 1, 174, 0, 26, 42, NULL, 1, NULL, NULL, CAST(N'2023-08-02T10:37:08.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1337, N'Khỉ mặt đỏ', N'Macaca arctoides (Geoffroy, 1831)', 1, 174, 5, 25, 42, NULL, 1, NULL, NULL, CAST(N'2023-08-02T10:35:05.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1338, N'Chà vá chân nâu', N'Pygathrix nemaeus  (Linnaeus, 1771)', 1, 174, 3, 24, 41, NULL, 1, NULL, NULL, CAST(N'2023-08-02T09:26:54.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1339, N'Voọc Hà Tĩnh', N'Trachypithecus laotum hatinhensis (Dao 1970)', 1, 174, 4, 24, 41, NULL, 1, NULL, NULL, CAST(N'2023-08-02T15:09:12.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1340, N'Vượn đen má trắng', N'Hylobates concolor leucogenys (Ogiby, 1840)', 1, 205, 24, 24, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1341, N'Vượn siki', N'Nomascus siki', 1, 205, 24, 24, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1342, N'Sói đỏ', N'Cuon alpinus (Pallas, 1811)     ', 1, 172, 24, 24, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1343, N'Gấu ngựa', N'Ursus thibetanus (G. Cuvier, 1823)     ', 1, 264, 25, 24, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1344, N'Gấu chó', N'Ursus malayanus (Raffles, 1821)', 1, 264, 25, 24, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1345, N'Chồn vàng', N'Martes flavigula (Boddaert, 1785)', 1, 222, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-08-02T09:31:26.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1346, N'Chồn bạc má bắc', N'Melogale moschata(Gray, 1831)', 1, 222, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1347, N'Chồn bạc má nam', N'Melogale personata(Gray, 1831)', 1, 222, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-08-02T09:29:25.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1348, N'Triết bụng vàng', N'Mustela kathiah (Hodgson, Jour. As. Soc. Beng. IV. P. 702)', 1, 222, 25, 25, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1349, N'Lửng lợn', N'Arctonyx collaris  (F. Cuvier, 1825)        ', 1, 222, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1350, N'Rái cá vuốt bé', N'Aonyx cinerea (Illiger, 1815)    ', 1, 222, 25, 25, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1351, N'Rái cá thường', N'Lutra lutra (Linnaeus,1758)', 1, 222, 8, 25, 41, NULL, 1, NULL, NULL, CAST(N'2023-08-02T14:12:58.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1352, N'Cầy giông', N'Viverra zibetha (Linnaeus,1758)', 1, 268, 0, 0, 42, NULL, 1, NULL, NULL, CAST(N'2023-08-02T09:13:39.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1353, N'Cầy hương', N'Viverricula indica (Desmares, 1817) ', 1, 268, NULL, NULL, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1354, N'Cầy tai trắng', N'Arctogalidia trivirgata(Grey,1832)', 1, 268, 26, 26, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1355, N'Cầy vòi mốc', N'Paguma larvata(H.Smith, 1827)', 1, 268, 0, 0, 42, NULL, 1, NULL, NULL, CAST(N'2023-08-02T09:24:56.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1356, N'Cầy vòi đốm', N'Paradoxurut hermaphroditus        (Pallas, 1777)', 1, 268, 0, 0, 42, NULL, 1, NULL, NULL, CAST(N'2023-08-02T09:19:47.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1357, N'Cầy gấm', N'Prionodon pardicolor (Hodgson, 1842)', 1, 268, 0, 25, 41, NULL, 1, NULL, NULL, CAST(N'2023-08-02T09:10:57.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1358, N'Cầy mực', N'Arctictis binturong(Raffles, 1821)', 1, 268, 25, 24, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1359, N'Cầy vằn bắc', N'Chrotogale owstoni(Thomas, 1912)', 1, 268, 25, 25, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1360, N'Cầy lỏn', N'Herpestes javanicus(Geoffroy 1818)', 1, 202, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1361, N'Cầy móc cua', N'Herspestes urva( Hogdson, 1836)', 1, 202, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-08-02T09:16:31.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1362, N'Mèo rừng', N'Prionailurus bengalensis (Kerr, 1792) ', 1, 196, 0, 0, 42, NULL, 1, NULL, NULL, CAST(N'2023-08-02T14:10:14.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1363, N'Beo lửa', N'Catopuma temminckii (Vigors et Horsfield,1827)', 1, 196, 29, 24, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1364, N'Mèo gấm', N'Pardofelis marmorata( Martin, 1837)', 1, 196, 25, 25, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1365, N'Báo gấm', N'Pardofelis nebulosa (Griffithi,1821)', 1, 196, 25, 24, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1366, N'Báo hoa mai', N'Panthera pardus (Linnaeus,1758)', 1, 196, 25, 24, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1367, N'Hổ', N'Panthera tigris (Linnaeus,1758)', 1, 196, 24, 23, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1368, N'Lợn rừng', N'Sus scrofa( Linnaeus,1758)', 1, 253, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1369, N'Cheo cheo java ', N'Tragulus javanicus (Osbeck, 1765)', 1, 259, NULL, 25, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1370, N'Nai', N'Cervus unicolor (Kerr,1792)', 1, 175, 25, 25, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1371, N'Mang (Hoẵng)', N'Muntiacus muntjak (Zimmermann,1780)', 1, 175, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1372, N'Mang lớn', N'Megamuntiacus vuquangensis(Do Tuoc at al., 1994)', 1, 175, 24, 25, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1373, N'Mang Trường Sơn', N'Muntiacus truongsonensis', 1, 175, 0, 25, 41, 41, 1, NULL, NULL, CAST(N'2023-08-02T14:07:51.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1374, N'Bò tót', N'Bos gaurus Smith, 1827', 1, 170, 25, 24, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1375, N'Sơn dương', N'Capricornis sumatraensis (Bechstein, 1799)', 1, 170, 5, 24, 41, NULL, 1, NULL, NULL, CAST(N'2023-08-02T14:58:09.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1376, N'Sao la', N'Pseudoryx nghetinhensis (Dung et al., 1993)', 1, 170, 23, 24, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1377, N'Tê tê Java', N'Manis javanica (Desmarest 1822)', 1, 211, 3, 24, 41, NULL, 1, NULL, NULL, CAST(N'2023-08-02T15:00:38.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1378, N'Tê tê vàng', N'Manis pentadactyla (Linnaeus,1758)', 1, 211, 26, 24, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1379, N'Sóc đen', N'Ratufa bicolor (Sparrmann, 1778)', 1, 236, 0, 25, 42, NULL, 1, NULL, NULL, CAST(N'2023-08-02T14:53:52.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1380, N'Sóc bay', N'Hylopetes sp.', 1, 236, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1381, N'Sóc bụng đỏ', N'Callosciurus erythraeus (Pallas, 1779)', 1, 236, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-06-20T16:29:50.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1382, N'Sóc bụng xám', N'Callosciurus inornatus(Gray, 1867)', 1, 236, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1383, N'Sóc má đào, Sóc mõm hung', N'Dremomys rufigenis (Blanford, 1878)', 1, 236, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1384, N'Sóc chuột Hải Nam', N'Tamiops maritimus (Bonhote, 1900)', 1, 236, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1385, N'Sóc vằn lưng', N'Menetes berdmorei (Blyth, 1849)', 1, 236, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1386, N'Sóc chân vàng', N'Callosciurus flavimanus (Geoffroy, 1831)', 1, 236, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1387, N'Sóc chuột lửa', N'Tamiops rodoilphei  (Milne-Edwwards, 1867)', 1, 236, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1388, N'Sóc bay lớn', N'Petaurista philippensis (Ellios, 1839)', 1, 236, 0, 25, 42, NULL, 1, NULL, NULL, CAST(N'2023-08-02T14:51:51.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1389, N'Dúi má đào', N'Rhizomys sumatrensis', 1, 245, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1390, N'Dúi mốc lớn', N'Rhizomys pruinosus (Blyth, 1851)', 1, 245, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1391, N'Chuột đất lớn ', N'Bandicota indica (Bechstein, 1800)', 1, 220, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1392, N'Chuột mốc bé ', N'Berylmys cf. berdmorei (Blyth, 1851)', 1, 220, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1393, N'Chuột mốc lớn ', N'Berylmys cf. bowersi (Anderson, 1879)', 1, 220, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1394, N'Chuột núi đuôi dài ', N'Leopoldamys cf. sabanus (Thomas, 1887)', 1, 220, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1395, N'Chuột su-ri ', N'Maxomys surifer  (Miller, 1900)', 1, 220, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1396, N'Chuột nhắt ', N'Mus pahari', 1, 220, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1397, N'Chuột hươu bé ', N'Niviventer cf. fulvescens (Gray, 1847)', 1, 220, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1398, N'Chuột lang-bi-an ', N'Niviventer cf. langbianis (Robinson et Kloss, 1922)', 1, 220, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1399, N'Chuột núi đông dương ', N'Niviventer cf. tenaster  (Thomas, 1916 )', 1, 220, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1400, N'Chuột lắt', N'Rattus exulans (Peale. 1848)', 1, 220, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1401, N'Chuột', N'Rattus nitidus', 1, 220, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1402, N'Chuột', N'Rattus sp sp.', 1, 220, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1403, N'Nhím đuôi ngắn', N'Hystrix brachyurus (Linnaeus, 1758)', 1, 206, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1404, N'Đon', N'Atherurus macrourus (Linnaeus, 1758)', 1, 206, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-08-02T09:48:55.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1405, N'Thỏ xám ', N'Lepus peguensis', 1, 209, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1406, N'Thỏ nâu', N'Lepus nigricollis( Cuvier,1823)', 1, 209, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1407, N'Thỏ vằn', N'Nesolagus timminsi(Averianov,Abranov,Tikhonov, 2000)', 1, 209, 4, 24, 41, NULL, 1, NULL, NULL, CAST(N'2023-08-02T15:04:57.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1408, N'Đa đa (gà gô)', N'Francolinus pintadeanus', 1, 230, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1409, N'Gà so ngực gụ', N'Arborophila brunneopectus', 1, 230, 0, 26, 42, NULL, 1, NULL, NULL, CAST(N'2023-08-02T10:17:30.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1410, N'Gà so họng trắng', N'A. chloropus', 1, 230, 0, 0, 42, NULL, 1, NULL, NULL, CAST(N'2023-08-02T10:15:17.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1411, N'Gà so Trung bộ', N'A. charltonii', 1, 230, NULL, NULL, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1412, N'Gà rừng', N'Gallus gallus', 1, 230, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-06-20T16:01:12.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1413, N'Gà lôi trắng', N'Lophura nycthemera', 1, 230, 0, 26, 41, NULL, 1, NULL, NULL, CAST(N'2023-08-02T10:04:46.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1414, N'Gà lôi lam mào trắng', N'L. edwardsi', 1, 230, 23, 24, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1415, N'Gà lôi hông tía', N'Lophura diardi (Bonaparte, 1856)', 1, 230, 0, 25, 42, NULL, 1, NULL, NULL, CAST(N'2023-08-02T10:01:30.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1416, N'Gà tiền mặt vàng', N'Polyplectron bicalcaratum', 1, 230, NULL, NULL, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1417, N'Trĩ sao', N'Rheinardia ocellata', 1, 230, 29, 25, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1418, N'Cò lửa lùn', N'Ixobrychus sinensis', 1, 165, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1419, N'Cò hương', N'Dupetor flavicollis', 1, 165, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1420, N'Cò xanh', N'Butorides striata', 1, 165, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1421, N'Cò bợ', N'Ardeola bacchus', 1, 165, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1422, N'Cắt nhỏ bụng trắng', N'Microhierax melanoleucos', 1, 195, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1423, N'Diều ăn Ong', N'Pernis ptilorhynchus', 1, 159, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1424, N'Diều cá bé', N'Ichthyophaga humilis', 1, 159, 29, 25, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1425, N'Diều hoa Miến Điện', N'Spilornis cheela', 1, 159, 0, 0, 42, NULL, 1, NULL, NULL, CAST(N'2023-08-02T09:58:14.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1426, N'Ưng xám', N'Accipiter trivirgatus', 1, 159, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1427, N'Ưng Ấn Độ', N'A. badius', 1, 159, 0, 0, 42, NULL, 1, NULL, NULL, CAST(N'2023-08-02T15:06:48.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1428, N'Ưng', N'A. gularis', 1, 159, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1429, N'Diều Ân Độ', N'Butastur indicus', 1, 159, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1430, N'Đại bàng Mã Lai', N'Ictinaetus malayensis', 1, 159, 0, 0, 42, NULL, 1, NULL, NULL, CAST(N'2023-08-02T09:45:55.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1431, N'Đại bàng bụng hung', N'Hieraaetus kienerii', 1, 159, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1432, N'Diều núi', N'S. nipalensis', 1, 159, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1433, N'Cuốc ngực trắng', N'Amaurornis phoenicurus', 1, 240, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1434, N'Cun cút lưng nâu', N'Turnix suscitator', 1, 263, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1435, N'Rẽ gà', N'Scolopax rusticola', 1, 247, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1436, N'Cu ngói', N'Streptopelia tranquebarica', 1, 183, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1437, N'Cu sen', N'Streptopelia orientalis', 1, 183, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1438, N'Cu gáy', N'Streptopelia chinensis', 1, 183, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1439, N'Cu luồng', N'Chalcophaps indica', 1, 183, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1440, N'Gầm ghì vằn', N'Macropygia unchall', 1, 183, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1441, N'Cu xanh khoang cổ', N'Treron  bicinctus', 1, 183, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1442, N'Cu xanh mỏ quặp', N'Treron curvirostra', 1, 183, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1443, N'Cu xanh đuôi nhọn', N'Treron apicauda', 1, 183, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1444, N'Gầm ghì lưng nâu', N'Ducula badia', 1, 183, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-06-20T16:20:09.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1445, N'Vẹt lùn', N'Loriculus vernalis', 1, 235, NULL, NULL, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1446, N'Chèo chẹo lớn', N'Cuculus sparverioides', 1, 186, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1447, N'Bắt cô trói cột', N'Cuculus micropterus', 1, 186, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1448, N'Tìm vịt', N'Cacomantis merulinus', 1, 186, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1449, N'Cu cu đen', N'Surniculus lugubris', 1, 186, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1450, N'Tu hú', N'Eudynamys scolopaceus', 1, 186, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1451, N'Phướn nhỏ', N'Phaenicophaeus tristis', 1, 186, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1452, N'Phướn đất', N'Carprococcyx renauldi', 1, 186, NULL, 25, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1453, N'Bìm bịp lớn', N'Centropus sinensis', 1, 173, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-06-20T15:24:04.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1454, N'Bìm bịp nhỏ', N'C. bengalensis', 1, 173, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1455, N'Cú mèo Latusơ', N'Otus spilocephalus', 1, 251, NULL, NULL, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1456, N'Cú mèo khoang cổ', N'O. bakkamoena', 1, 251, NULL, NULL, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1457, N'Cú vọ mặt trắng', N'Glaucidium brodiei', 1, 251, NULL, NULL, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1458, N'Cú vọ', N'Glaucidium cuculoides', 1, 251, 0, 0, 42, NULL, 1, NULL, NULL, CAST(N'2023-08-02T09:43:05.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1459, N'Yến đuôi cứng bụng trắng', N'Hirundapus cochinchinensis', 1, 164, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1460, N'Yến cọ', N'Cypsiurus balasiensis', 1, 164, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1461, N'Yến hông trắng', N'Apus affinis', 1, 164, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1462, N'Nuốc bụng đỏ', N'Harpactes erythrocephalus', 1, 261, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1463, N'Yểng quạ', N'Eurystomas orientalis', 1, 184, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1464, N'Sả hung', N'Halycon coromanda', 1, 201, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1465, N'Sả đầu đen', N'Halcyon pileata', 1, 201, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1466, N'Sả đầu nâu', N'Halcyon smyrnensis', 1, 201, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1467, N'Bồng chanh đỏ', N'Ceyx erythacus', 1, 162, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1468, N'Bồng chanh rừng', N'Alcedo hercules', 1, 162, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1469, N'Bồng chanh', N'Alcedo atthis', 1, 162, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1470, N'Bói cá lớn', N'Megaceryle lugubris', 1, 176, NULL, 25, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1471, N'Trảu lớn', N'Nyctyornis athertoni', 1, 216, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1472, N'Trẩu ngực nâu', N'Merops philippinus', 1, 216, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1473, N'Niệc nâu', N'Anorrhinus austeni', 1, 157, 29, 25, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1474, N'Cao cát bụng trắng', N'Anthracoceros albirostris', 1, 157, NULL, NULL, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1475, N'Hồng hoàng', N'Buceros bicornis', 1, 157, 0, 25, 41, NULL, 1, NULL, NULL, CAST(N'2023-08-02T10:18:40.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1476, N'Thầy chùa đít đỏ', N'Megalaima lagrandieri', 1, 214, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1477, N'Cu rốc đầu xám', N'M. lineata', 1, 214, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1478, N'Thầy chùa đầu xám', N'M. faiostricta', 1, 214, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1479, N'Cu rốc đầu vàng', N'M. franklinii', 1, 214, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1480, N'Gõ kiến lùn đầu vàng', N'Picumnus innominatus', 1, 231, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1481, N'Gõ kiến lùn mày trắng', N'Sasia ochracea', 1, 231, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1482, N'Rufous Woodpecker (Gõ kiến nâu)', N'Celeus brachyurus', 1, 231, 1, 24, 41, 42, 1, NULL, NULL, CAST(N'2024-01-14T23:25:59.423' AS DateTime), N'81b0366a-0d23-49c9-70f7-08dbb3fec38d')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1483, N'Gõ kiến xanh cánh đỏ', N'Picus chlorolophus', 1, 231, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1484, N'Gõ kiến xanh gáy vàng', N'Picus flavinucha', 1, 231, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1485, N'Gõ kiến xanh cổ đỏ', N'Picus rabieri', 1, 231, 29, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1486, N'Gõ kiến nâu cổ đỏ', N'Blythipicus pyrrhotis', 1, 231, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1487, N'Mỏ rộng xanh', N'Psarisomus dalhousiae', 1, 194, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1488, N' Mỏ rộng hung', N'Serilophus lunatus', 1, 194, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1489, N'Đuôi cụt đầu xám', N'Pitta soror', 1, 232, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1490, N'Đuôi cụt bụng vằn', N'P. elliotii', 1, 232, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1491, N'Nhạn rừng', N'Artamus fuscus', 1, 166, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-06-20T16:25:29.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1492, N'Chim nghệ lớn', N'Aegithina lafresnayei', 1, 160, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1493, N'Phường chèo nâu', N'Tephrodornis gularis', 1, 158, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1494, N'Phường chèo xám lớn', N'Coracina macei', 1, 158, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1495, N'Phường chèo xám', N'C. melaschistos', 1, 158, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1496, N'Phường chèo nhỏ', N'Pericrocotus divaricatus', 1, 158, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1497, N'Phường chèo đỏ lớn', N'Pericrocotus flammeus', 1, 158, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1498, N'Phường chèo đen', N'Hemipus picatus', 1, 158, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1499, N'Bách thanh', N'Lanius schach', 1, 208, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1500, N'Đớp ruồi xanh gáy đen', N'Hypothymis azurea', 1, 218, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1501, N'Thiên đường đuôi phướn', N'Terpsiphone paradisi', 1, 218, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1502, N'Tử anh', N'Oriolus  traillii', 1, 225, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1503, N'Chèo bẻo', N'Dicrurus macrocercus', 1, 190, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-06-20T15:51:20.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1504, N'Chèo bẻo xám', N'D. leucophaeus', 1, 190, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1505, N'Chèo bẻo mỏ quạ', N'D. annectans', 1, 190, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1506, N'Chèo bẻo rừng', N'D. aeneus', 1, 190, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1507, N'Chèo bẻo cờ đuôi bằng', N'D. remifer', 1, 190, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1508, N'Chèo bẻo bờm', N'D. hottenttus', 1, 190, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1509, N'Chèo bẻo cờ đuôi chẻ', N'D. paradiseus', 1, 190, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1510, N'Rẻ quạt họng trắng', N'Rhipidura albicollis', 1, 244, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1511, N'Giẻ cùi vàng', N'Urocissa whiteheadi', 1, 185, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1512, N'Giẻ cùi bụng vàng', N'Cissa hypoleuca', 1, 185, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1513, N'Chim khách', N'Crypsirina temia', 1, 185, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1514, N'Chim khách đuôi cờ', N'Temnurus temnurus', 1, 185, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1515, N'Quạ đen', N'Corvus macrohynchos', 1, 185, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1516, N'Chim mào vàng', N'Melanochlora sultanea', 1, 227, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1517, N'Nhạn bụng trắng', N'Hirundo rustica', 1, 204, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1518, N'Nhạn bụng xám', N'H. daurica', 1, 204, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1519, N'Nhạn hông trắng Á Châu', N'Delichon dasypus', 1, 204, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1520, N'Chiền chiện bụng vàng', N'Prinia flaviventris', 1, 179, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1521, N'Chiền chiện bụng hung', N'P. inornata', 1, 179, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1522, N'Chào mào', N'Pycnonotus jocosus', 1, 238, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1523, N'Bông lau tai trắng', N'P. aurigaster', 1, 238, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1524, N'Cành cạch nhỏ', N'Iole propinqua', 1, 238, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1525, N'Cành cạch lớn', N'Alophoixus pallidus', 1, 238, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1526, N'Cành cạch núi ', N'Hypsipetes mcclellandii', 1, 238, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1527, N'Cành cạch đen', N'Hypsipetes leucocephalus', 1, 238, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-06-20T15:35:11.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1528, N'Chích bông đuôi dài', N'Orthotomus sutorius', 1, 254, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1529, N'Chích bông cánh vàng', N'O. atrogularis', 1, 254, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1530, N'Chích Á Châu', N'Urosphena squameiceps', 1, 254, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1531, N'Chích họng trắng', N'Phylloscopus armandii', 1, 254, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1532, N'Chích mày vàng', N'P. inornatus', 1, 254, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1533, N'Chích phương bắc', N'P. borealis', 1, 254, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1534, N'Chích đuôi xám', N'P. reguloides', 1, 254, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1535, N'Chích vành khuyên', N'Abroscopus affinis', 1, 254, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1536, N'Chích đớp ruồi mỏ vàng', N'A. supercilliaris', 1, 254, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1537, N'Chuối tiêu họng đốm', N'Pellorneum albiventre', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1538, N'Chuối tiêu ngực đốm', N'P. ruficeps', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1539, N'Chuối tiêu đất', N'Trichostoma tickelli', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1540, N'Chuối tiêu đuôi ngắn', N'Malacopteron cinereum', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1541, N'Họa mi đất mỏ dài', N'Pomatorhinus hypoleucos', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1542, N'Hoạ mi đất mày trắng', N'P. schisticeps', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1543, N'Hoạ mi đất ngực luốc', N'P. ruficollis', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1544, N'Hoạ mi đất mỏ đỏ', N'P. ocharaciceps', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1545, N'Khướu mỏ dài', N'Jabouilleia danjjoui', 1, 258, 29, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1546, N'Khướu đá đuôi ngắn', N'Napothera brevicaudata', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1547, N'Khướu đá nhỏ', N'N. epilepidota', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1548, N'Khướu bụi đầu đỏ', N'Stachyris ruficeps', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1549, N'Khướu bụi vàng', N'S. chrysea', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1550, N'Khướu bụi đầu đen', N'S. nigriceps', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1551, N'Khướu đá nhỏ đốm cổ', N'Stachyris striolata', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1552, N'Chích chạch má vàng', N'Macronous gularis', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1553, N'Chích chạch má xám', N'Macronous kelleyi', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1554, N'Hoạ mi nhỏ', N'Timalia pileata', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1555, N'Khướu đầu trắng', N'Garrulax leucolophus', 1, 258, NULL, NULL, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1556, N'Khướu khoang cổ', N'G. monileger', 1, 258, NULL, NULL, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1557, N'Khướu xám', N'G. maesi', 1, 258, NULL, NULL, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1558, N'Khướu bạc má', N'G. chinensis', 1, 258, NULL, NULL, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1559, N'Khướu đầu xám', N'G. vassali', 1, 258, NULL, NULL, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1560, N'Khướu mỏ quặp mày trắng', N'Pteruthius flaviscapis', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1561, N'Khướu mỏ quặp tai đen', N'P. melanotis', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1562, N'Khướu đuôi dài', N'Gampsorhynchus torquatus', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1563, N'Khướu lùn cánh xanh', N'Minla cyanouroptera', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1564, N'Lách tác vành mắt', N'Alcippe peracensis', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1565, N'Lách tách mày đen', N'Alcippe grotei', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1566, N'Lách tách má xám', N'Alcippe morrisonia', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1567, N'Khướu mào bụng trắng', N'Yuhina zantholeuca', 1, 258, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1568, N'Vành khuyên họng vàng', N'Zosterops palpebrosus', 1, 269, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1569, N'Chim lam', N'Irena puella', 1, 207, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1570, N'Trèo cây trán đen', N'Sitta frontalis', 1, 249, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1571, N'Yểng', N'Gracula religiosa', 1, 252, NULL, NULL, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1572, N'Sáo nâu', N'Acridotheres tristis', 1, 252, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1573, N'Sáo mỏ vàng', N'A.  cinereus', 1, 252, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1574, N'Sáo đen', N'A. cristatellus', 1, 252, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1575, N'Sáo đá Trung Quốc ', N'S. sinensis', 1, 252, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1576, N'Sáo sậu', N'Sturnus nigricollis', 1, 252, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-06-20T15:28:39.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1577, N'Hoét xanh', N'Myophonus caeruleus', 1, 221, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1578, N'Oanh đuôi đỏ', N'Luscinia sibilans', 1, 221, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1579, N'Oanh sườn hung', N'Tarsiger cyanurus', 1, 221, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1580, N'Chích choè', N'Copsychus saularis', 1, 221, 0, 0, 0, NULL, 1, NULL, NULL, CAST(N'2023-06-20T15:56:28.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1581, N'Chích choè lửa', N'C. malabaricus', 1, 221, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1582, N'Chích chòe nước trán trắng', N'Enicurus schistaceus', 1, 221, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1583, N'Chích chòe nước đầu trắng', N'Enicurus leschenaulti', 1, 221, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1584, N'Sẻ bụi đầu đen', N'Saxicola torquatus', 1, 221, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1585, N'Sẻ bụi xám', N'Saxicola ferrea', 1, 221, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1586, N'Hoét đá', N'Monticola solitarius', 1, 221, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1587, N'Đớp ruồi nâu', N'Muscicapa daurica', 1, 221, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1588, N'Đớp ruồi Mugi', N'Ficedula mugimaki', 1, 221, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1589, N'Đớp ruồi họng đỏ', N'F. parva', 1, 221, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1590, N'Đớp ruồi họng trắng', N'F. monileger', 1, 221, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1591, N'Đớp ruồi xanh xám', N'Eumyias thalassina', 1, 221, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1592, N'Đớp ruồi họng trắng', N'Cyornis concretus', 1, 221, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1593, N'Đớp ruồi Hải Nam', N'C. hainanus', 1, 221, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1594, N'Đớp ruồi họng hung', N'C. banyumas', 1, 221, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1595, N'Đớp ruồi đầu xám', N'Culicicapa ceylonensis', 1, 221, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1596, N'Chim xanh Nam bộ', N'Chloropsis cochinchinensis', 1, 178, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1597, N'Chim xanh hông vàng', N'C. hardwickii', 1, 178, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1598, N'Chim sâu vàng lục', N'D. concolor', 1, 223, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1599, N'Chim sâu lưng đỏ', N'Dicaeum cruentatum', 1, 223, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1600, N'Hút mật bụng vạch', N'Hypogramma hypogrammicum', 1, 223, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1601, N'Hút mật họng tím', N'Nectarinia jugularis', 1, 223, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1602, N'Hút mật họng vàng', N'Aethopyga gouldiae', 1, 223, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1603, N'Hút mật đuôi nhọn', N'A. christinae', 1, 223, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1604, N'Hút mật ngực đỏ', N'A. saturata', 1, 223, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1605, N'Hút mật đỏ', N'Aethopyga siparaja', 1, 223, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1606, N'Bắp chuối mỏ dài', N'Arachnothera longirostra', 1, 223, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1607, N'Bắp chuối đốm đen', N'A. magna', 1, 223, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1608, N'Sẻ nhà', N'Passer montanus', 1, 228, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1609, N'Di cam', N'Lonchura striata', 1, 193, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1610, N'Chìa vôi trắng', N'Motacilla alba', 1, 219, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1611, N'Chìa vôi núi', N'M. cinerea', 1, 219, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1612, N'Chim manh lớn', N'Anthus richardi', 1, 219, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1613, N'Chim manh Vân Nam', N'A. hodgsoni', 1, 219, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1614, N'Rồng đất', N'Physignathus cocincinus', 1, 161, 25, 25, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1615, N'Ô rô vẩy', N'Acanthosaura lepidogaster', 1, 161, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1616, N'Nhông em-ma', N'Calotes emma', 1, 161, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1617, N'Thạch sùng ngón giả bốn vạch', N'Cyrtodactylus pseudoquadrivirrgatus', 1, 198, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1618, N'Tắc kè', N'Gekko gecko', 1, 198, NULL, 25, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1619, N'Thạch sùng đuôi thùy', N'Ptychozoon lionotum', 1, 198, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1620, N'Thằn lằn bóng hoa', N'Eutropis multifasciata', 1, 246, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1621, N'Thằn lằn co-ri-vo', N'Scincella reevesii', 1, 246, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1622, N'Thằn lằn phe-no ấn độ', N'Sphenomorphus indicus ', 1, 246, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1623, N'Thằn lằn tai nam bộ', N'Tropidophorus cocincinensis', 1, 246, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1624, N'Kỳ đà hoa', N'Varanus salvator', 1, 265, NULL, 24, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1625, N'Trăn đất', N'Python molurus', 1, 239, 25, 23, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1626, N'Rắn mai gầm lát', N'Calamaria cf. pavimentata', 1, 182, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1627, N'Rắn roi thường', N'Ahaetulla prasina', 1, 182, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1628, N'Rắn ráo quảng tây', N'Boiga guangiensis', 1, 182, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1629, N'Rắn leo cây ngân sơn', N'Dendrelaphis ngansonensis', 1, 182, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1630, N'Rắn khuyết ẩn', N'Lycondon ruhstrati', 1, 182, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1631, N'Rắn khuyết fut-sing', N'Lycodon futsingensis', 1, 182, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1632, N'Rắn khuyết đốm', N'Lycodon fasciatus', 1, 182, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1633, N'Rắn khiếm sp', N'Oligodon sp', 1, 182, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1634, N'Rắn ráo trâu', N'Ptyas mucosa', 1, 182, NULL, 24, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1635, N'Rắn ri cá', N'Homalopsis buccata', 1, 182, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1636, N'Rắn sãi mép trắng', N'Amphiesma leucomystax', 1, 182, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1637, N'Rắn bình mũi trung bộ', N'Parahelicops annamensis', 1, 182, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1638, N'Rắn hoa cỏ vàng', N'Rhabdophis cf. chrysargos', 1, 182, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1639, N'Rắn hoa cỏ nhỏ', N'Rhabdophis subminiatus', 1, 182, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1640, N'Rắn nước', N'Xenochrophis flavipunctatus', 1, 182, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1641, N'Rắn hổ mây ham - ton ', N'Pareas hamptoni', 1, 182, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1642, N'Rắn cạp nong', N'Bungarus fasciatus', 1, 191, NULL, 24, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1643, N'Rắn hổ mang trung quốc', N'Naja atra', 1, 191, 25, NULL, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1644, N'Rắn hổ mang một mắt kính', N'Naja kaouthia', 1, 191, NULL, NULL, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1645, N'Rắn hổ mang chúa', N'Ophiophagus hannah', 1, 191, 25, 23, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1646, N'Rắn lục mép trắng', N'Cryptelytrops albolabris', 1, 267, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1647, N'Rắn lục cườm ', N'Protobothrops mucrosquamatus', 1, 267, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1648, N'Rắn lục von - gen', N'Viridovipera vogeli', 1, 267, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1649, N'Rùa đầu to', N'Platysternon megacephalum', 1, 233, 24, 24, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1650, N'Rùa hộp bua-re', N'Cuora bourreti', 1, 199, 23, NULL, 41, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1651, N'Rùa vàng', N'Coura cyclornata', 1, 199, NULL, 23, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1652, N'Rùa hộp trán vàng', N'Cuora galbinifrons', 1, 199, 23, 24, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1653, N'Rùa sa nhân', N'Cuora mouhotii', 1, 199, 24, NULL, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1654, N'Rùa đất se-pon', N'Cyclemys tcheponensis', 1, 199, NULL, NULL, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1655, N'Rùa bốn mắt', N'Sacalia quadriocellata', 1, 199, 24, NULL, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1656, N'Rùa núi viền', N'Manouria impressa ', 1, 257, 25, 25, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1657, N'Ba ba gai', N'Palea steindachneri', 1, 260, 24, 25, 42, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1658, N'Cóc nhà', N'Duttaphrynus melanostictus', 1, 171, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1659, N'Cóc rừng', N'Ingerophrynus galeatus', 1, 171, NULL, 25, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1660, N'Cóc tai to', N'Ingerophrynus macrotis', 1, 171, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1661, N'Cóc mắt trung gian', N'Brachytarsophrys intermedia ', 1, 215, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1662, N'Cóc mày sần', N'Leptolalax tuberosus', 1, 215, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1663, N'Cóc mày au-re-us', N'Leptolalax aureus', 1, 215, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1664, N'Cóc núi han – x', N'Ophryophryne hansi', 1, 215, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1665, N'Cóc núi miệng nhỏ', N'Ophryophryne microstoma', 1, 215, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1666, N'Cóc mắt bên', N'Xenophrys major', 1, 215, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1667, N'Nhái bầu hoa', N'Microhyla fissipes', 1, 217, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1668, N'Nhái bầu hay - mon', N'Microhyla heymonsi', 1, 217, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1669, N'Nhái bầu hoa cương', N'Microhyla marmorata', 1, 217, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1670, N'Nhái bầu vân', N'Microhyla pulchra', 1, 217, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1671, N'Ngóe', N'Fejervarya limnocharis', 1, 189, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1672, N'Ếch đồng', N'Hoplobatrachus rugulosus', 1, 189, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1673, N'Ếch hat - che', N'Limnonectes hascheanus', 1, 189, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1674, N'Ếch trơn', N'Limnonectes kuhlii', 1, 189, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1675, N'Ếch poi-lan', N'Limnonectes poilani', 1, 189, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1676, N'Ếch trơn châu á', N'Limnonectes cf. asianensis', 1, 189, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1677, N'Ếch Lim-bo-gi', N'Limnonectes limbogri ', 1, 189, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1678, N'Ếch nhẽo nguyễn', N'Limnonectes cf. nguyenorum', 1, 189, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1679, N'Ếch gai sần', N'Quasipaa verrucospinosa', 1, 189, 29, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1680, N'Ếch at-ti-gua', N'Hylarana attigua', 1, 241, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1681, N'Chẫu', N'Hylarana guentheri', 1, 241, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1682, N'Ếch suối', N'Hylarana nigrovittata', 1, 241, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1683, N'Ếch xanh', N'Odorrana chloronota', 1, 241, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1684, N'Ếch mo-rap-ka', N'Odorrana morafkai', 1, 241, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1685, N'Ếch mồ côi', N'Odorrana cf. orba', 1, 241, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1686, N'Hiu hiu', N'Rana johnsi', 1, 241, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1687, N'Nhái cây bà nà', N'Kurixalus banaensis', 1, 242, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1688, N'Ếch cây gin-xiu', N'Philautus jinxiuensis', 1, 242, 25, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1689, N'Ếch cây mép trắng', N'Polypedates leucomystax', 1, 242, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1690, N'Ếch cây trung bộ', N'Rhacophorus annamensis', 1, 242, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1691, N'Ếch cây nếp da mông', N'Rhacophurus exechopygus', 1, 242, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1692, N'Ếch cây ki-o', N'Rhacophorus kio', 1, 242, NULL, 24, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1693, N'Ếch cây ooc-lop', N'Rhacophurus orlovi', 1, 242, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1694, N'Ếch cây sần việt nam', N'Theloderma cf. vietnamense', 1, 242, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1695, N'Cá cân', N'Barbodes semifasciolatus (GÜNTHER, 1868)', 1, 188, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1696, N'Cá nút', N'Crossocheilus reticulatus (Fowler, 1934)', 1, 188, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1697, N'Cá sứt môi', N'Garra fuliginosa (Fowler, 1934)', 1, 188, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1698, N'Cá mương', N'Hemiculter leucisculus (Basilewsky, 1855) ', 1, 188, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1699, N'Cá sỉnh (cá niên)', N'Onychostoma gerlachi (Peters, 1881)', 1, 188, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1700, N'Cá xanh', N'Onychostoma sp', 1, 188, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1701, N'Cá cháo', N'Opsariichthys uncirostris (Gunther, 1874)', 1, 188, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1702, N'Cá xảm 8 sọc ', N'Opsarius pulchellus (Smith, 1931) ', 1, 188, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1703, N'Cá sao', N'Poropuntius sp', 1, 188, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1704, N'Cá mại sọc', N'Rasbora paviana (Tirant, 1885) ', 1, 188, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1705, N'Cá mại sọc bên (cá mại sọc)', N'Rasbora steineri', 1, 188, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1706, N'Cá Chạch suối sọc ', N'Schistura fasciolata (Nichols & C. H.    Pope, 1927)  ', 1, 224, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1707, N'Cá Đép cao  ', N'Sewellia sp2', 1, 197, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1708, N'Cá vây băng', N'Vanmanenia serrilineata (Kottelat, 2000)', 1, 197, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1709, N'Cá vây băng thường', N'Anamia normani (Hora, 1931', 1, 167, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1710, N'Cá chạch hoa', N'Cobitis taenia (Linnaeus, 1758)', 1, 181, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1711, N'Cá heo râu', N'Lepidocephalichthys  hasselti (Valenciennes, 1846)', 1, 181, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1712, N'Cá heo', N'Yasuhikotakia eos (Taki, 1972)', 1, 169, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1713, N'Cá trê  ', N'Clarias fuscus (Lacepede, 1803)', 1, 180, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1714, N'Cá chiên suối', N'Glyptothorax macromaculatus (Li, 1984)', 1, 248, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1715, N'Lươn đồng                                                           ', N'Monopterus albus (Zouiew, 1793)            ', 1, 255, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1716, N'Lươn cuchia', N'Monopterus cuchia (F. Hamilton, 1822)', 1, 255, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1717, N'Cá chạch sông (cá lấu)', N'Mastacembelus armatus (Lacepede, 1803)', 1, 212, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1718, N'Cá chạch sông ', N'Macrognathus pancalus  (Hamilton, 1822)', 1, 212, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1719, N'Cá Bống sọc ngang', N'Cryptrocentrus sp ', 1, 200, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1720, N'Cá bống mắt      ', N'Rhinogobius ocellatus (Fowler, 1937)', 1, 200, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1721, N'Cá chành đục (cá trầu núi)', N'Channa gachua  (Hamilton, 1822)', 1, 177, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1722, N'Cá quả ', N'Channa striata (Bloch, 1792)', 1, 177, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1723, N'Cá rô', N'Pristolepis fasciata (Bleeker, 1851) ', 1, 234, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1724, N'Cá rô mó', N'Coreoperca whiteheadi (Boulenger, 1900)', 1, 229, NULL, NULL, NULL, NULL, 1, NULL, NULL, CAST(N'2022-02-22T17:00:52.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1725, N'Cá đuôi cờ', N'Macropodus opercularis (Linnaeus, 1758)', 1, 226, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1726, N'Cá nhói', N'Xenentodon cancila ', 1, 168, NULL, NULL, NULL, NULL, 1, NULL, NULL, CAST(N'2022-06-02T22:07:03.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1727, N'Cá chình hoa', N'Anguilla marmorata (Quoy & Gaimard, 1824)', 1, 163, 25, 25, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1730, N'Nai ', N'Rusa unicolor', 1, 175, 0, 0, 0, NULL, 1, CAST(N'2021-12-05T09:13:19.000' AS DateTime), N'20', CAST(N'2023-06-20T16:25:53.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1734, N'Kim tuyến đá vôi', N'Anoectochilus calcareus', 0, 104, 0, 24, 31, NULL, 1, CAST(N'2023-07-11T13:41:05.000' AS DateTime), N'20', CAST(N'2023-07-11T13:41:08.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1735, N'Hoàng tinh hoa trắng', N'Disporopsis longifolia Craib', 0, 69, 0, 25, 32, NULL, 1, CAST(N'2023-07-11T14:01:47.000' AS DateTime), N'20', CAST(N'2023-07-11T14:10:57.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1736, N'Cói hoa xòe', N'Cyperus diffusus Vahl.', 0, 49, 6, 0, 0, NULL, 1, CAST(N'2023-07-11T14:06:41.000' AS DateTime), N'20', CAST(N'2023-07-11T14:06:43.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1737, N'Chân rết giả', N'Appendicula reflexa', 0, 104, 0, 0, 32, NULL, 1, CAST(N'2023-07-18T10:08:44.000' AS DateTime), N'20', CAST(N'2023-07-18T10:08:52.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1738, N'Lan lọng đầu', N'Bulbophyllum sigaldiae Guill', 0, 104, 0, 0, 32, NULL, 1, CAST(N'2023-07-18T10:22:49.000' AS DateTime), N'20', CAST(N'2023-07-18T10:22:55.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1740, N'Lan lệ dương', N'Cyrtosia javanica', 0, 104, 0, 0, 32, NULL, 1, CAST(N'2023-07-18T11:01:09.000' AS DateTime), N'20', CAST(N'2023-07-18T11:01:18.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1741, N'Hồng cầu', N'Dendrobium aduncum', 0, 104, 0, 0, 32, NULL, 1, CAST(N'2023-07-18T13:33:31.000' AS DateTime), N'20', CAST(N'2023-07-18T13:33:50.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1742, N'Ngọc vân sáp', N'Dendrobium crepidatum Lindl. & Paxton 1850', 0, 104, 0, 0, 32, NULL, 1, CAST(N'2023-07-18T13:36:57.000' AS DateTime), N'20', CAST(N'2023-07-18T13:36:59.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1743, N'Thạch hộc hoa tím', N'Dendrobium hercoglossum Rchb. f. 1886', 0, 104, 0, 0, 32, NULL, 1, CAST(N'2023-07-18T13:45:27.000' AS DateTime), N'20', CAST(N'2023-07-18T13:45:40.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1744, N'Hoàng thảo một hoa', N'Dendrobium unicum Seidenfaden 1970', 0, 104, 0, 0, 32, NULL, 1, CAST(N'2023-07-18T13:50:10.000' AS DateTime), N'20', CAST(N'2023-07-18T13:50:21.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1745, N'Long tu', N'Dendrobium primulinum Lindley 1858', 0, 104, 0, 0, 32, NULL, 1, CAST(N'2023-07-18T13:55:12.000' AS DateTime), N'20', CAST(N'2023-07-18T13:55:14.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1746, N'Lăm tăm', N'Dendrobium terminale Par. & Rchb. f. 1874', 0, 104, 0, 0, 32, NULL, 1, CAST(N'2023-07-18T14:07:13.000' AS DateTime), N'20', CAST(N'2023-07-18T14:07:29.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1747, N'Ái lan lá rộng', N'Dienia ophrydis', 0, 104, 0, 0, 32, NULL, 1, CAST(N'2023-07-18T14:14:01.000' AS DateTime), N'20', CAST(N'2023-07-18T14:14:07.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1748, N'Nỉ lan thao', N'Eria thao Gagnep', 0, 104, 0, 0, 32, NULL, 1, CAST(N'2023-07-18T14:20:08.000' AS DateTime), N'20', CAST(N'2023-07-18T14:20:10.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1749, N'Nhẵn diệp gân', N' Liparis nervosa', 0, 104, 0, 0, 32, NULL, 1, CAST(N'2023-07-18T14:41:33.000' AS DateTime), N'20', CAST(N'2023-07-18T14:51:04.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1750, N'Tiêm nang lan', N'Kingidium deliciosum', 0, 104, 0, 0, 32, NULL, 1, CAST(N'2023-07-18T16:09:25.000' AS DateTime), N'20', CAST(N'2023-07-18T16:09:32.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1751, N'Gà so họng hung', N'Arborophila rufogularis', 1, 230, 0, 0, 42, NULL, 1, CAST(N'2023-08-02T10:09:31.000' AS DateTime), N'20', CAST(N'2023-08-02T10:09:33.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1752, N'Khướu má hung', N'Garrulax castanotis', 1, 258, 0, 0, 42, NULL, 1, CAST(N'2023-08-02T14:04:50.000' AS DateTime), N'20', CAST(N'2023-08-02T14:04:52.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1755, N'Test Loài', NULL, 0, 1, 0, 0, 0, NULL, 1, CAST(N'2023-09-18T11:19:06.810' AS DateTime), N'7665e39a-567b-4233-971e-08dbb1bc5e0f', CAST(N'2023-09-18T11:19:06.810' AS DateTime), NULL)
INSERT [dongthucvat].[dtv_loai] ([id], [name], [name_latinh], [loai], [id_dtv_ho], [muc_do_bao_ton_iucn], [muc_do_bao_ton_sdvn], [muc_do_bao_ton_ndcp], [muc_do_bao_ton_nd64cp], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1756, N'test loài', N'DFSFSDF', 1, 157, 0, 0, 0, 0, 1, CAST(N'2023-12-03T20:39:42.397' AS DateTime), N'81b0366a-0d23-49c9-70f7-08dbb3fec38d', CAST(N'2023-12-03T20:39:42.397' AS DateTime), NULL)
SET IDENTITY_INSERT [dongthucvat].[dtv_loai] OFF
GO
SET IDENTITY_INSERT [dongthucvat].[dtv_loaiVqg] ON 

INSERT [dongthucvat].[dtv_loaiVqg] ([id], [IdDtvLoai], [ten_khac], [dac_diem], [gia_tri_su_dung], [phan_bo], [status], [loai], [file_dinh_kem], [nguon_tai_lieu], [created_at], [created_by], [updated_at], [updated_by], [KinhDo], [ViDo]) VALUES (2, 0, N'fsfsfs', N'<p>fsfsfs</p>
', N'fsfsf', N'fsdsf', 1, 1, N'13b6b6c3-694d-4c78-b223-2d8e696089bb.jpg,ddc3b1fa-38a1-4cc0-9d73-7996abde1a9d.jpg', N'fsdfsfs', CAST(N'2023-09-21T16:40:50.953' AS DateTime), N'fd797441-0343-4916-0502-08dbb45bd092', CAST(N'2023-09-21T16:40:50.953' AS DateTime), NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_loaiVqg] ([id], [IdDtvLoai], [ten_khac], [dac_diem], [gia_tri_su_dung], [phan_bo], [status], [loai], [file_dinh_kem], [nguon_tai_lieu], [created_at], [created_by], [updated_at], [updated_by], [KinhDo], [ViDo]) VALUES (4, 1482, N'adasadada', N'<h1><strong>gđgdgdgdgd</strong></h1>
', NULL, N'dadadad', 1, 1, N',998d037c-77ae-49d2-acfd-ee2bb50dd2f9.jpg', NULL, CAST(N'2023-09-21T20:36:02.173' AS DateTime), N'fd797441-0343-4916-0502-08dbb45bd092', CAST(N'2023-12-10T21:13:07.073' AS DateTime), N'fd797441-0343-4916-0502-08dbb45bd092', N'102.8730807088087', N'22.3808094863484')
INSERT [dongthucvat].[dtv_loaiVqg] ([id], [IdDtvLoai], [ten_khac], [dac_diem], [gia_tri_su_dung], [phan_bo], [status], [loai], [file_dinh_kem], [nguon_tai_lieu], [created_at], [created_by], [updated_at], [updated_by], [KinhDo], [ViDo]) VALUES (5, 2, N'Test2', NULL, NULL, N'fsđfs', 1, 0, N'', NULL, CAST(N'2023-09-21T20:38:56.910' AS DateTime), N'fd797441-0343-4916-0502-08dbb45bd092', CAST(N'2023-12-10T21:13:41.827' AS DateTime), N'fd797441-0343-4916-0502-08dbb45bd092', N'102.66714382016096', N'22.448602717008647')
INSERT [dongthucvat].[dtv_loaiVqg] ([id], [IdDtvLoai], [ten_khac], [dac_diem], [gia_tri_su_dung], [phan_bo], [status], [loai], [file_dinh_kem], [nguon_tai_lieu], [created_at], [created_by], [updated_at], [updated_by], [KinhDo], [ViDo]) VALUES (6, 1298, N'test', N'<p>dđa&acirc;sdad</p>
', N'sadasdsad', N'fsdsfs', 1, 1, N'4a7c1c17-2c63-4676-9f6f-0b987bccda6a.jpg,40dfdb8a-c0b8-4485-9c31-f2be06d1fe0c.jpg,45a3ba24-a319-436e-b8ea-166960542f0e.jpg,da601e51-59c2-4382-9f5b-0827437a7285.jpg,11ba6815-832d-4cbb-9d4f-05349772416a.jpg,0a3a3671-5556-434e-9c61-8ee2722ef510.jpg,08937ee9-483c-4bd6-810a-4aa88ae05c4f.jpg', NULL, CAST(N'2023-12-04T00:11:29.040' AS DateTime), N'112df350-cd6f-424b-9c0c-08dbbab1ab1b', CAST(N'2024-01-19T10:26:00.600' AS DateTime), N'112df350-cd6f-424b-9c0c-08dbbab1ab1b', N'107.61784174540549', N'15.570524724772596')
INSERT [dongthucvat].[dtv_loaiVqg] ([id], [IdDtvLoai], [ten_khac], [dac_diem], [gia_tri_su_dung], [phan_bo], [status], [loai], [file_dinh_kem], [nguon_tai_lieu], [created_at], [created_by], [updated_at], [updated_by], [KinhDo], [ViDo]) VALUES (7, 1298, N'test', N'<p>asdsdaaaa</p>
', N'ssadđá', N'đsấđá', 1, 1, N'289547bc-6e16-41ac-bcfa-c4aa83cc63ed.jpg,7f06651a-0b2c-450e-a748-5a36ce1142ad.jpg', NULL, CAST(N'2023-12-04T21:32:32.697' AS DateTime), N'81b0366a-0d23-49c9-70f7-08dbb3fec38d', CAST(N'2023-12-11T15:18:16.723' AS DateTime), N'81b0366a-0d23-49c9-70f7-08dbb3fec38d', N'102.96878844327449', N'22.21334334403581')
INSERT [dongthucvat].[dtv_loaiVqg] ([id], [IdDtvLoai], [ten_khac], [dac_diem], [gia_tri_su_dung], [phan_bo], [status], [loai], [file_dinh_kem], [nguon_tai_lieu], [created_at], [created_by], [updated_at], [updated_by], [KinhDo], [ViDo]) VALUES (8, 1309, N'ádsasd', N'<p>ddassasdas</p>
', N'ddấdad', N'ádadasd', 1, 1, N'68e75617-2181-4105-815f-1da45d8e16d2.jpg,46476f6e-283a-47aa-8ccc-2b02549edfa2.jpg', N'dââsad', CAST(N'2023-12-04T22:01:37.793' AS DateTime), N'81b0366a-0d23-49c9-70f7-08dbb3fec38d', CAST(N'2023-12-04T22:01:37.797' AS DateTime), NULL, N'80.34141974879473', N'17.048381917488342')
INSERT [dongthucvat].[dtv_loaiVqg] ([id], [IdDtvLoai], [ten_khac], [dac_diem], [gia_tri_su_dung], [phan_bo], [status], [loai], [file_dinh_kem], [nguon_tai_lieu], [created_at], [created_by], [updated_at], [updated_by], [KinhDo], [ViDo]) VALUES (9, 1300, N'fsfdsfs', N'<p>dấdấdada</p>
', N'ádsadad', N'fsdsf', 1, 1, N'bc24911e-defb-4032-9fec-d66788c8e5f0.jpg,4a8a8d85-66eb-4e6a-8fd9-1fd4f5ba82bc.jpg', NULL, CAST(N'2023-12-04T22:01:59.103' AS DateTime), N'81b0366a-0d23-49c9-70f7-08dbb3fec38d', CAST(N'2023-12-04T22:15:55.677' AS DateTime), N'81b0366a-0d23-49c9-70f7-08dbb3fec38d', N'82.74702895230693', N'16.469801918236133')
INSERT [dongthucvat].[dtv_loaiVqg] ([id], [IdDtvLoai], [ten_khac], [dac_diem], [gia_tri_su_dung], [phan_bo], [status], [loai], [file_dinh_kem], [nguon_tai_lieu], [created_at], [created_by], [updated_at], [updated_by], [KinhDo], [ViDo]) VALUES (11, 1298, N'fsfsfs', N'<p>&aacute;dasda</p>
', N'đâsda', N'sdfsf', 0, 1, N'', N'fsdfdsf', CAST(N'2023-12-10T21:14:46.803' AS DateTime), N'fd797441-0343-4916-0502-08dbb45bd092', CAST(N'2023-12-10T21:14:46.803' AS DateTime), NULL, N'102.75771554083816', N'22.375729995229708')
INSERT [dongthucvat].[dtv_loaiVqg] ([id], [IdDtvLoai], [ten_khac], [dac_diem], [gia_tri_su_dung], [phan_bo], [status], [loai], [file_dinh_kem], [nguon_tai_lieu], [created_at], [created_by], [updated_at], [updated_by], [KinhDo], [ViDo]) VALUES (12, 1301, N'đâsd', N'<p>&aacute;dasdasd</p>
', N'dấdd', N'ádasd', 1, 1, N'', N'đâ', CAST(N'2023-12-10T21:15:04.953' AS DateTime), N'fd797441-0343-4916-0502-08dbb45bd092', CAST(N'2023-12-10T21:15:04.953' AS DateTime), NULL, N'102.74548972385229', N'22.38449197348969')
INSERT [dongthucvat].[dtv_loaiVqg] ([id], [IdDtvLoai], [ten_khac], [dac_diem], [gia_tri_su_dung], [phan_bo], [status], [loai], [file_dinh_kem], [nguon_tai_lieu], [created_at], [created_by], [updated_at], [updated_by], [KinhDo], [ViDo]) VALUES (13, 1, N'fsdfsdf', NULL, NULL, N'sdfsdf', 1, 0, N'', N'fsdfs', CAST(N'2023-12-10T21:15:22.150' AS DateTime), N'fd797441-0343-4916-0502-08dbb45bd092', CAST(N'2023-12-10T21:15:22.150' AS DateTime), NULL, N'102.92880825207544', N'22.445429607486194')
INSERT [dongthucvat].[dtv_loaiVqg] ([id], [IdDtvLoai], [ten_khac], [dac_diem], [gia_tri_su_dung], [phan_bo], [status], [loai], [file_dinh_kem], [nguon_tai_lieu], [created_at], [created_by], [updated_at], [updated_by], [KinhDo], [ViDo]) VALUES (14, 1, N'fsdfsdf', N'<p>fsdfsf</p>
', N'sfsdfsf', N'sdfdsfsd', 1, 0, N'', N'fsdfs', CAST(N'2023-12-10T21:15:36.197' AS DateTime), N'fd797441-0343-4916-0502-08dbb45bd092', CAST(N'2023-12-10T21:15:56.307' AS DateTime), N'fd797441-0343-4916-0502-08dbb45bd092', N'102.83952587663659', N'22.238387044289606')
INSERT [dongthucvat].[dtv_loaiVqg] ([id], [IdDtvLoai], [ten_khac], [dac_diem], [gia_tri_su_dung], [phan_bo], [status], [loai], [file_dinh_kem], [nguon_tai_lieu], [created_at], [created_by], [updated_at], [updated_by], [KinhDo], [ViDo]) VALUES (15, 2, N'ffsdfdsf', N'<p>sdfs</p>
', N'fsdfs', N'fsdfsdfs', 1, 0, N'', NULL, CAST(N'2023-12-10T21:34:13.993' AS DateTime), N'112df350-cd6f-424b-9c0c-08dbbab1ab1b', CAST(N'2024-01-19T10:26:23.690' AS DateTime), N'112df350-cd6f-424b-9c0c-08dbbab1ab1b', N'107.62458826610008', N'15.508471734131')
INSERT [dongthucvat].[dtv_loaiVqg] ([id], [IdDtvLoai], [ten_khac], [dac_diem], [gia_tri_su_dung], [phan_bo], [status], [loai], [file_dinh_kem], [nguon_tai_lieu], [created_at], [created_by], [updated_at], [updated_by], [KinhDo], [ViDo]) VALUES (16, 1, N'test', N'<p>fssfsdf</p>
', N'dffsdsfs', N'fsdsf', 1, 0, N'', NULL, CAST(N'2024-01-19T10:26:36.123' AS DateTime), N'112df350-cd6f-424b-9c0c-08dbbab1ab1b', CAST(N'2024-01-19T10:26:54.357' AS DateTime), N'112df350-cd6f-424b-9c0c-08dbbab1ab1b', N'107.68718934478707', N'15.615894913962965')
SET IDENTITY_INSERT [dongthucvat].[dtv_loaiVqg] OFF
GO
SET IDENTITY_INSERT [dongthucvat].[dtv_lop] ON 

INSERT [dongthucvat].[dtv_lop] ([id], [name], [name_latinh], [loai], [id_dtv_nganh], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1, N'Lớp Tuế', N'Cycadopsida', 0, 3, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_lop] ([id], [name], [name_latinh], [loai], [id_dtv_nganh], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (2, N'Lớp Mộc tặc', N'Equisetopsida', 0, 2, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_lop] ([id], [name], [name_latinh], [loai], [id_dtv_nganh], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (3, N'Lớp Gắm', N'Gnetopsida', 0, 3, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_lop] ([id], [name], [name_latinh], [loai], [id_dtv_nganh], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (4, N'Lớp Quyển bá', N'Isoetopsida', 0, 4, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_lop] ([id], [name], [name_latinh], [loai], [id_dtv_nganh], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (5, N'Lớp Loa kèn', N'Liliopsida', 0, 1, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_lop] ([id], [name], [name_latinh], [loai], [id_dtv_nganh], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (6, N'Lớp Thông đất', N'Lycopodiopsida', 0, 4, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_lop] ([id], [name], [name_latinh], [loai], [id_dtv_nganh], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (7, N'Lớp Ngọc lan', N'Magnoliopsida', 0, 1, 1, NULL, NULL, CAST(N'2022-11-15T15:59:18.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_lop] ([id], [name], [name_latinh], [loai], [id_dtv_nganh], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (8, N'Lớp Móng ngựa', N'Marattiopsida', 0, 5, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_lop] ([id], [name], [name_latinh], [loai], [id_dtv_nganh], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (9, N'Lớp Thông', N'Pinopsida', 0, 3, 1, NULL, NULL, CAST(N'2022-11-15T15:59:11.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_lop] ([id], [name], [name_latinh], [loai], [id_dtv_nganh], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (10, N'Lớp Dương xỉ', N'Polypodiopsida', 0, 5, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_lop] ([id], [name], [name_latinh], [loai], [id_dtv_nganh], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (11, N'LỚP CÁ VÂY TIA', N'ACTINOPTERYGII', 1, 6, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_lop] ([id], [name], [name_latinh], [loai], [id_dtv_nganh], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (12, N'LỚP LƯỠNG CƯ', N'AMPHIBIA', 1, 6, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_lop] ([id], [name], [name_latinh], [loai], [id_dtv_nganh], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (13, N'LỚP CHIM', N'AVES', 1, 6, 0, NULL, NULL, CAST(N'2021-11-30T11:24:17.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_lop] ([id], [name], [name_latinh], [loai], [id_dtv_nganh], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (14, N'LỚP BÒ SÁT', N'LEPTILIA', 1, 6, 0, NULL, NULL, CAST(N'2021-11-30T11:24:13.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_lop] ([id], [name], [name_latinh], [loai], [id_dtv_nganh], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (15, N'LỚP THÚ', N'MAMMALIA', 1, 6, 1, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[dtv_lop] ([id], [name], [name_latinh], [loai], [id_dtv_nganh], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (18, N'adadad', N'AA', 1, 6, 1, CAST(N'2023-09-20T22:03:59.773' AS DateTime), N'7665e39a-567b-4233-971e-08dbb1bc5e0f', CAST(N'2023-09-20T22:03:59.773' AS DateTime), NULL)
INSERT [dongthucvat].[dtv_lop] ([id], [name], [name_latinh], [loai], [id_dtv_nganh], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (20, N'test lớp', N'DẤDADA', 1, 6, 1, CAST(N'2023-12-03T20:38:22.710' AS DateTime), N'81b0366a-0d23-49c9-70f7-08dbb3fec38d', CAST(N'2023-12-03T20:38:22.710' AS DateTime), NULL)
SET IDENTITY_INSERT [dongthucvat].[dtv_lop] OFF
GO
SET IDENTITY_INSERT [dongthucvat].[dtv_nganh] ON 

INSERT [dongthucvat].[dtv_nganh] ([id], [name], [name_latinh], [loai], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (1, N'NGÀNH THỰC VẬT HẠT KÍN', N'ANGIOSPERMAE', 0, 1, NULL, NULL, CAST(N'2021-11-29T11:20:09.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_nganh] ([id], [name], [name_latinh], [loai], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (2, N'NGÀNH MỘC TẶC', N'EQUISETOPHYTA', 0, 1, NULL, NULL, CAST(N'2021-11-29T11:20:08.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_nganh] ([id], [name], [name_latinh], [loai], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (3, N'NGÀNH HẠT TRẦN', N'GYMNOSPERMAE', 0, 1, NULL, NULL, CAST(N'2021-11-29T11:20:08.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_nganh] ([id], [name], [name_latinh], [loai], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (4, N'NGÀNH THÔNG ĐẤT', N'LYCOPODIOPHYTA', 0, 1, NULL, NULL, CAST(N'2021-11-30T15:45:36.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_nganh] ([id], [name], [name_latinh], [loai], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (5, N'NGÀNH DƯƠNG XỈ', N'POLYPODIOPHYTA', 0, 1, NULL, NULL, CAST(N'2021-11-29T11:20:06.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_nganh] ([id], [name], [name_latinh], [loai], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (6, N'NGÀNH CÓ DÂY SỐNG', N'CHORDATA', 1, 1, NULL, NULL, CAST(N'2023-08-04T09:09:41.000' AS DateTime), N'20')
INSERT [dongthucvat].[dtv_nganh] ([id], [name], [name_latinh], [loai], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (9, N'test ngành', N'dấdadsada', 1, 1, CAST(N'2023-09-20T16:38:29.400' AS DateTime), N'7665e39a-567b-4233-971e-08dbb1bc5e0f', CAST(N'2023-09-20T16:38:29.400' AS DateTime), NULL)
INSERT [dongthucvat].[dtv_nganh] ([id], [name], [name_latinh], [loai], [status], [created_at], [created_by], [updated_at], [updated_by]) VALUES (15, N'test ngành', N'CHORDATA1', 1, 1, CAST(N'2023-12-03T19:38:43.610' AS DateTime), N'81b0366a-0d23-49c9-70f7-08dbb3fec38d', CAST(N'2023-12-03T19:38:43.610' AS DateTime), NULL)
SET IDENTITY_INSERT [dongthucvat].[dtv_nganh] OFF
GO
SET IDENTITY_INSERT [dongthucvat].[image_general] ON 

INSERT [dongthucvat].[image_general] ([id], [object_id], [user_id], [name], [title], [type], [created_at], [status], [mode], [id_dir]) VALUES (1, 0, 1, N'root/editor/2021/12/21/03/08/scr1640009288_6326.png', NULL, 1, CAST(N'2021-12-20T21:08:08.000' AS DateTime), 1, 0, 0)
INSERT [dongthucvat].[image_general] ([id], [object_id], [user_id], [name], [title], [type], [created_at], [status], [mode], [id_dir]) VALUES (2, 0, 1, N'root/editor/2021/12/21/03/08/scr1640009317_5452.png', NULL, 1, CAST(N'2021-12-20T21:08:37.000' AS DateTime), 1, 0, 0)
INSERT [dongthucvat].[image_general] ([id], [object_id], [user_id], [name], [title], [type], [created_at], [status], [mode], [id_dir]) VALUES (3, 0, 1, N'root/editor/2021/12/21/03/10/scr1640009443_2388.png', NULL, 1, CAST(N'2021-12-20T21:10:43.000' AS DateTime), 1, 0, 0)
INSERT [dongthucvat].[image_general] ([id], [object_id], [user_id], [name], [title], [type], [created_at], [status], [mode], [id_dir]) VALUES (4, 0, 1, N'root/editor/2021/12/21/03/11/scr1640009490_3668.png', NULL, 1, CAST(N'2021-12-20T21:11:30.000' AS DateTime), 1, 0, 0)
INSERT [dongthucvat].[image_general] ([id], [object_id], [user_id], [name], [title], [type], [created_at], [status], [mode], [id_dir]) VALUES (5, 0, 1, N'root/editor/2021/12/21/17/20/scr1640060410_3004.png', NULL, 1, CAST(N'2021-12-21T11:20:10.000' AS DateTime), 1, 0, 0)
INSERT [dongthucvat].[image_general] ([id], [object_id], [user_id], [name], [title], [type], [created_at], [status], [mode], [id_dir]) VALUES (6, 0, 1, N'root/editor/2021/12/21/17/21/scr1640060476_2861.png', NULL, 1, CAST(N'2021-12-21T11:21:16.000' AS DateTime), 1, 0, 0)
INSERT [dongthucvat].[image_general] ([id], [object_id], [user_id], [name], [title], [type], [created_at], [status], [mode], [id_dir]) VALUES (7, 0, 1, N'root/editor/2021/12/21/17/27/scr1640060829_575.png', NULL, 1, CAST(N'2021-12-21T11:27:09.000' AS DateTime), 1, 0, 5)
INSERT [dongthucvat].[image_general] ([id], [object_id], [user_id], [name], [title], [type], [created_at], [status], [mode], [id_dir]) VALUES (8, 0, 1, N'root/editor/2021/12/21/17/28/scr1640060909_9397.png', NULL, 1, CAST(N'2021-12-21T11:28:30.000' AS DateTime), 1, 0, 5)
SET IDENTITY_INSERT [dongthucvat].[image_general] OFF
GO
SET IDENTITY_INSERT [dongthucvat].[image_general_directory] ON 

INSERT [dongthucvat].[image_general_directory] ([id], [name], [parent_id]) VALUES (1, N'Root', 0)
INSERT [dongthucvat].[image_general_directory] ([id], [name], [parent_id]) VALUES (5, N'map', 0)
SET IDENTITY_INSERT [dongthucvat].[image_general_directory] OFF
GO
SET IDENTITY_INSERT [dongthucvat].[news] ON 

INSERT [dongthucvat].[news] ([id], [root_news_cat_id], [news_cat_id], [name], [alias], [image], [short_description], [description], [total_view], [sort_order], [created_at], [updated_at], [is_hot], [is_system], [status], [author], [source], [post_at], [title_seo], [content_seo], [key_seo], [language], [id_related]) VALUES (1, NULL, 1, N'Giới thiệu về Nam Giang', N'gioi-thieu-ve-bac-huong-hoa', NULL, N'Giới thiệu về Bắc Hướng Hoá', N'<p><strong>I.&nbsp;Giới thiệu chung:</strong></p>

<p><strong>1</strong><strong>. Vị tr&iacute; địa l&yacute;</strong></p>

<p>Khu BTTN Bắc Hướng H&oacute;a nằm về ph&iacute;a T&acirc;y của tỉnh Quảng Trị v&agrave; thuộc ph&iacute;a Nam của dải Trường Sơn Bắc, c&aacute;ch th&agrave;nh phố Đ&ocirc;ng H&agrave; khoảng 100 km theo quốc lộ 9 đến thị trấn Khe Sanh v&agrave; đường Hồ Ch&iacute; Minh nh&aacute;nh T&acirc;y.</p>

<p>- Vị tr&iacute; tọa độ địa l&yacute;:</p>

<p>&nbsp; &nbsp; &nbsp; &nbsp;+ Từ 16 043&#39;22&rsquo;&rsquo; - 16059&rsquo;55&rsquo;&rsquo; vĩ độ Bắc.</p>

<p>&nbsp; &nbsp; &nbsp; &nbsp;+ Từ 106033&#39; - 106047&rsquo;03&rsquo;&rsquo; kinh độ Đ&ocirc;ng</p>

<p>- Về ranh giới:</p>

<p>+ Ph&iacute;a Bắc gi&aacute;p ranh giới tỉnh Quảng B&igrave;nh (khoảng 20 km).</p>

<p>+ Ph&iacute;a Nam gi&aacute;p c&aacute;c x&atilde;: Hướng Linh, Hướng Sơn v&agrave; Hướng Ph&ugrave;ng.</p>

<p>+ Ph&iacute;a Đ&ocirc;ng gi&aacute;p với 3 huyện Gio Linh, Vĩnh Linh, Đakr&ocirc;ng.</p>

<p>+ Ph&iacute;a T&acirc;y gi&aacute;p nước Cộng h&ograve;a d&acirc;n chủ nh&acirc;n d&acirc;n L&agrave;o.</p>

<p><strong><em>- Bản đồ, trụ sở cơ quan</em></strong></p>

<p><em>(Bản đồ c&oacute; file đ&iacute;nh k&egrave;m)</em></p>

<p>&nbsp;</p>

<p><img alt="" src="http://bachuonghoa.vnuforest.com/uploads/up/root/editor/2021/12/21/17/27/scr1640060829_575.png" /></p>

<p><img alt="" src="http://bachuonghoa.vnuforest.com/uploads/up/root/editor/2021/12/21/17/28/scr1640060909_9397.png" /></p>

<p><strong>2</strong><strong>. Cơ cấu tổ chức của BQL</strong></p>

<p><strong>2.1. Văn ph&ograve;ng Ban quản l&yacute;</strong></p>

<p>a) L&atilde;nh đạo Ban gồm: Gi&aacute;m đốc v&agrave; 01 Ph&oacute; gi&aacute;m đốc.</p>

<p>b) Ph&ograve;ng chuy&ecirc;n m&ocirc;n gồm: 02 ph&ograve;ng</p>

<p>+ Ph&ograve;ng Kế hoạch - Tổng hợp: 03 vi&ecirc;n chức, 01 hợp đồng 68 (l&aacute;i xe).</p>

<p>+ Ph&ograve;ng Khoa học kỹ thuật v&agrave; Hợp t&aacute;c quốc tế: 04 vi&ecirc;n chức</p>

<p><strong>2.2. C&aacute;c Trạm quản l&yacute; bảo vệ rừng trực thuộc:</strong> 04 trạm gồm:</p>

<p>+ Trạm quản l&yacute; bảo vệ rừng Cựp: 04 vi&ecirc;n chức.</p>

<p>+ Trạm quản l&yacute; bảo vệ rừng Nguồn R&agrave;o: 01 vi&ecirc;n chức.</p>

<p>+ Trạm quản l&yacute; bảo vệ rừng Trĩa: 03 vi&ecirc;n chức.</p>

<p>+ Trạm quản l&yacute; bảo vệ rừng Hướng Linh: 03 vi&ecirc;n chức.</p>

<p>Tổng số bi&ecirc;n chế được giao theo quyết định số 3985/QĐ-UBND ng&agrave;y 31/12/2020 của UBND tỉnh về việc điều chỉnh danh mục vị tr&iacute; việc l&agrave;m v&agrave; số người l&agrave;m việc của Ban quản l&yacute; Khu BTTN Bắc Hướng H&oacute;a l&agrave; 28 người, thực tế hiện nay chỉ mới bố tr&iacute; 21 người, c&ograve;n thiếu 07 người. N&ecirc;n bi&ecirc;n chế c&aacute;c Ph&ograve;ng, Trạm c&ograve;n thiếu nhiều, một số vi&ecirc;n chức phải ki&ecirc;m nhiệm nhiều việc l&agrave;m g&acirc;y kh&oacute; khăn trong thực hiện nhiệm vụ.</p>

<p><strong>3.</strong> <strong>C&ocirc;ng tr&igrave;nh nghi&ecirc;n cứu đa dạng sinh học từ trước đến nay</strong></p>

<p>- Điều tra khu hệ c&aacute; năm 2021</p>

<p>- Điều tra khu hệ b&ograve; s&aacute;t ếch nh&aacute;i năm 2018-2019</p>

<p>- Điều tra thực vật bậc cao dưới 800m năm 2017-2018</p>

<p>- Điều tra l&acirc;m sản ngo&agrave;i gỗ năm 2019-2020</p>

<p>- Điều tra thực vật hạt trần năm 2020</p>

<p>- Điều tra khu hệ c&ocirc;n tr&ugrave;ng năm 2021-2022</p>

<p>- Điều tra c&aacute;c lo&agrave;i chim, th&uacute; nguy cấp, qu&yacute; hiếm năm 2021-2022</p>

<p>- Điều tra thực vật ngoại lại năm 2021</p>

<p>- Điều tra thực vật qu&yacute; hiếm năm 2021-2022</p>

<p><strong>II. Mục ti&ecirc;u chung:&nbsp;</strong></p>

<p>Bảo vệ chặt chẽ diện t&iacute;ch rừng hiện c&oacute;; bảo tồn ĐDSH bao gồm nguồn gen sinh vật, c&aacute;c lo&agrave;i động thực vật qu&yacute; hiếm, đặc biệt l&agrave; c&aacute;c lo&agrave;i đang bị đe dọa ở Việt Nam; khai th&aacute;c v&agrave; sử dụng bền vững c&aacute;c tiềm năng của rừng như đa dạng sinh học, cảnh quan, dịch vụ m&ocirc;i trường rừng, sinh th&aacute;i v&agrave; c&aacute;c c&ocirc;ng tr&igrave;nh của Khu BTTN; đồng thời tạo c&ocirc;ng ăn việc l&agrave;m, tăng thu nhập cho người lao động; ổn định sinh kế người d&acirc;n sống trong v&ugrave;ng đệm; n&acirc;ng cao nhận thức về quản l&yacute; rừng bền vững; từng bước ho&agrave;n thiện hệ thống kết cấu hạ tầng g&oacute;p phần giữa vững ăn ninh &ndash; quốc ph&ograve;ng cho khu vực. Với những tiềm năng v&agrave; gi&aacute; trị về mặt khoa học bảo tồn,&nbsp; định hướng Khu BTTN Bắc Hướng H&oacute;a th&agrave;nh Vườn quốc gia Bắc Hướng H&oacute;a, đồng thời ho&agrave;n thiện cơ sở dữ liệu x&acirc;y dựng bộ ti&ecirc;u ch&iacute; để đăng k&yacute; th&agrave;nh lập Vườn Di sản ASEAN trong thời gian tới <em>(Theo phương &aacute;n Quản l&yacute; rừng bền vững).</em></p>

<p><strong><em>Mục ti&ecirc;u Giai đoạn 2021-2025.</em></strong></p>

<p>a) Quản l&yacute; tốt diện t&iacute;ch rừng đặc dụng được giao quản l&yacute;; Bảo vệ hệ sinh th&aacute;i, c&aacute;c lo&agrave;i động vật rừng, thực vật rừng hiện c&oacute; trong Khu bảo tồn, trong đ&oacute; ch&uacute; trọng c&aacute;c lo&agrave;i động thực vật đặc hữu, qu&yacute; hiếm được ghi trong s&aacute;ch đỏ Việt Nam v&agrave; Thế giới</p>

<p>b) &Aacute;p dụng c&aacute;c biện ph&aacute;p kỹ thuật l&acirc;m sinh nhằm duy tr&igrave; ổn định cấu tr&uacute;c tự nhi&ecirc;n của rừng trong ph&acirc;n khu bảo vệ nghi&ecirc;m ngặt; phục hồi cầu tr&uacute;c rừng tự nhi&ecirc;n trong ph&acirc;n khu phục hồi sinh th&aacute;i, DVHC đảm bảo tăng khả năng ph&ograve;ng hộ đầu nguồn S&ocirc;ng Bến Hải, Hiếu, R&agrave;o Qu&aacute;n......</p>

<p>c) Đẩy mạnh c&aacute;c hoạt động nghi&ecirc;n cứu khoa học nhằm ho&agrave;n thiện hệ thống cơ sở dữ liệu đa dạng sinh học của Khu bảo tồn; Tận dụng c&aacute;c nguồn t&agrave;i nguy&ecirc;n thi&ecirc;n nhi&ecirc;n, t&agrave;i nguy&ecirc;n sinh th&aacute;i v&agrave; nh&acirc;n văn trong khu vực để đầu tư v&agrave; ph&aacute;t triển du lịch sinh th&aacute;i, nghỉ dưỡng, giải tr&iacute; trong rừng đặc dụng</p>

<p>d) Ph&aacute;t triển kinh tế x&atilde; hội v&ugrave;ng đệm th&ocirc;ng qua c&aacute;c hoạt động đầu tư từ Chương tr&igrave;nh, dự &aacute;n đầu tư ph&aacute;t triển v&ugrave;ng đệm.</p>

<p>&nbsp;</p>
', 19, NULL, CAST(N'2021-10-28T22:28:35.000' AS DateTime), CAST(N'2023-09-22T12:10:18.470' AS DateTime), 1, NULL, 1, NULL, NULL, CAST(N'2022-03-07T16:05:45.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[news] ([id], [root_news_cat_id], [news_cat_id], [name], [alias], [image], [short_description], [description], [total_view], [sort_order], [created_at], [updated_at], [is_hot], [is_system], [status], [author], [source], [post_at], [title_seo], [content_seo], [key_seo], [language], [id_related]) VALUES (5, 1, 1, N'HIỆU QUẢ CỦA CÔNG TÁC PHỐI KẾT HỢP TRONG HOẠT ĐỘNG TUYÊN TRUYỀN PHỔ BIẾN GIÁO DỤC PHÁP LUẬT', N'hieu-qua-cua-cong-tac-phoi-ket-hop-trong-hoat-dong-tuyen-truyen-pho-bien-giao-duc-phap-luat', N'root/news/2023/08/02/14/57/21690941443_4756.jpg', N'', N'<p style="margin-top:8px; margin-bottom:8px; text-align:justify; text-indent:36.0pt"><span style="font-size:12pt"><span style="background:white"><span new="" roman="" style="font-family:" times=""><span lang="VI" style="font-size:14.0pt"><span style="color:#222222">X</span></span><span style="font-size:14.0pt"><span style="color:#222222">&aacute;c định c&ocirc;ng t&aacute;c tuy&ecirc;n truyền, phổ biến, gi&aacute;o dục ph&aacute;p luật phải thực hiện thường xuy&ecirc;n, li&ecirc;n tục</span></span> <span style="font-size:14.0pt"><span style="color:#222222">với nhiều h&igrave;nh thức kh&aacute;c nhau để kịp thời ph&ocirc;̉ bi&ecirc;́n c&aacute;c văn bản ph&aacute;p luật mới ban h&agrave;nh, li&ecirc;n quan thiết thực đến nhiệm vụ ch&iacute;nh trị của cơ quan, đơn vị, địa phương v&agrave; đời sống của c&aacute;n bộ, </span></span><span lang="VI" style="font-size:14.0pt"><span style="color:#222222">N</span></span><span style="font-size:14.0pt"><span style="color:#222222">h&acirc;n d&acirc;n, g&oacute;p phần tạo sự lan tỏa, n&acirc;ng cao &yacute; thức chấp h&agrave;nh ph&aacute;p luật trong mọi tầng lớp </span></span><span lang="VI" style="font-size:14.0pt"><span style="color:#222222">N</span></span><span style="font-size:14.0pt"><span style="color:#222222">h&acirc;n d&acirc;n tr&ecirc;n địa b&agrave;n </span></span><span lang="VI" style="font-size:14.0pt"><span style="color:#222222">x&atilde;</span></span><span style="font-size:14.0pt"><span style="color:#222222"> đi v&agrave;o chiều s&acirc;u v&agrave; c&oacute; sức lan tỏa s&acirc;u rộng hơn.</span></span></span></span></span></p>

<p style="margin-top:8px; margin-bottom:8px; text-align:justify; text-indent:36.0pt"><span style="font-size:12pt"><span style="background:white"><span new="" roman="" style="font-family:" times=""><span lang="VI" style="font-size:14.0pt"><span style="color:#222222">T</span></span><span style="font-size:14.0pt"><span style="color:#222222">rong thời gian </span></span><span lang="VI" style="font-size:14.0pt"><span style="color:#222222">qua</span></span><span style="font-size:14.0pt"><span style="color:#222222">, </span></span><span lang="VI" style="font-size:14.0pt"><span style="color:#222222">UBND </span></span><span style="font-size:14.0pt"><span style="color:#222222">x&atilde; </span></span><span lang="VI" style="font-size:14.0pt"><span style="color:#222222">Hướng Sơn </span></span><span style="font-size:14.0pt"><span style="color:#222222">đ&atilde; th&agrave;nh lập tổ c&ocirc;ng t&aacute;c tuy&ecirc;n truyền ph&aacute;p luật (</span></span><span lang="VI" style="font-size:14.0pt"><span style="color:#222222">Tổ</span></span><span style="font-size:14.0pt"><span style="color:#222222"> 886) bao gồm tất cả c&aacute;c ban ng&agrave;nh, đo&agrave;n thể v&agrave; đơn vị đ</span></span><span lang="VI" style="font-size:14.0pt"><span style="color:#222222">&oacute;</span></span><span style="font-size:14.0pt"><span style="color:#222222">ng qu&acirc;n tr&ecirc;n địa b&agrave;n tham gia</span></span><span lang="VI" style="font-size:14.0pt"><span style="color:#222222"> (C&ocirc;ng an x&atilde;, kiểm l&acirc;m địa b&agrave;n, lực lượng bảo vệ rừng chuy&ecirc;n tr&aacute;ch, y tế, ban chỉ huy qu&acirc;n sự x&atilde;....)</span></span><span style="font-size:14.0pt"><span style="color:#222222">, nhằm </span></span><span lang="VI" style="font-size:14.0pt"><span style="color:#222222">ph&aacute;t huy vai tr&ograve; phối kết hợp trong thực hiện nhiệm vụ cũng như </span></span><span style="font-size:14.0pt"><span style="color:#222222">n&acirc;ng cao hiệu quả c&ocirc;ng t&aacute;c tuy&ecirc;n truyền, hạn chế tối đ&atilde; c&aacute;c cuộc họp th&ocirc;n ri&ecirc;ng lẽ</span></span><span lang="VI" style="font-size:14.0pt"><span style="color:#222222"> th&ocirc;ng qua hai h&igrave;nh thức (tuy&ecirc;n truyền trực tiếp th&ocirc;ng qua họp th&ocirc;n v&agrave; tuy&ecirc;n truyền lưu động bằng loa di động)</span></span><span style="font-size:14.0pt"><span style="color:#222222">.</span></span></span></span></span></p>

<p style="margin-top:8px; margin-bottom:8px; text-align:justify; text-indent:36.0pt"><span style="font-size:12pt"><span style="background:white"><span new="" roman="" style="font-family:" times=""><span lang="VI" style="font-size:14.0pt"><span style="color:#222222">Tham gia Tổ c&ocirc;ng t&aacute;c 886 của x&atilde; Hướng Sơn, lực lượng chuy&ecirc;n tr&aacute;ch bảo vệ rừng của Ban quản l&yacute; Khu bảo tồn thi&ecirc;n nhi&ecirc;n Bắc Hướng H&oacute;a (Trạm quản l&yacute; bảo vệ rừng Nguồn r&agrave;o) đ&atilde; tham gia t&iacute;ch cực, phổ biến c&aacute;c nội dung li&ecirc;n quan đến vai tr&ograve;, lợi &iacute;ch của t&agrave;i nguy&ecirc;n rừng; t&aacute;c hại của việc ph&aacute; rừng mang lại; c&ocirc;ng t&aacute;c ph&ograve;ng ch&aacute;y chữa ch&aacute;y rừng v&agrave;o m&ugrave;a kh&ocirc;, m&ugrave;a đốt nương l&agrave;m rẫy; c&aacute;c biện ph&aacute;p ph&ograve;ng ch&aacute;y rừng; biện ph&aacute;p bảo tồn một số lo&agrave;i động thực vật rừng nguy cấp qu&yacute; hiếm cần ưu ti&ecirc;n bảo vệ tại địa phương.</span></span></span></span></span></p>

<p style="margin-top:8px; margin-bottom:8px; text-align:justify; text-indent:36.0pt"><span style="font-size:12pt"><span style="background:white"><span new="" roman="" style="font-family:" times=""><span lang="VI" style="font-size:14.0pt"><span style="color:#222222">Sau hơn 03 th&aacute;ng triển khai thực hiện, 100% (6/6 th&ocirc;n) người d&acirc;n tại x&atilde; Hướng Sơn đ&atilde; tham gia t&iacute;ch cực v&agrave; n&acirc;ng cao tr&aacute;ch nhiệm trong c&ocirc;ng t&aacute;c quản l&yacute; bảo vệ rừng, ph&ograve;ng ch&aacute;y chữa ch&aacute;y rừng. Tr&ecirc;n địa b&agrave;n x&atilde; Hướng Sơn đến nay kh&ocirc;ng c&oacute; t&igrave;nh trạng người d&acirc;n x&acirc;m canh x&acirc;m lấn rừng đặc dụng l&agrave;m nương rẫy, kh&ocirc;ng x&atilde;y ra t&igrave;nh trạng x&acirc;m hại t&agrave;i nguy&ecirc;n rừng, bẫy bắt động vật rừng.</span></span></span></span></span></p>

<p style="margin-top:8px; margin-bottom:8px; text-align:justify; text-indent:36.0pt"><span style="font-size:12pt"><span style="background:white"><span new="" roman="" style="font-family:" times=""><span lang="VI" style="font-size:14.0pt"><span style="color:#222222">Hy vọng trong thời gian tới, Tổ 886 x&atilde; Hướng Sơn sẽ ph&aacute;t huy hơn nữa về sự phối hợp trong c&ocirc;ng t&aacute;c tuy&ecirc;n truyền phổ biến gi&aacute;o dục ph&aacute;t luật; đổi mới, đa dạng h&oacute;a h&igrave;nh thức tiếp cận ph&aacute;p luật cho người d&acirc;n, triển khai c&oacute; hiệu quả Ng&agrave;y ph&aacute;p luật Việt Nam 09/11/2023.</span></span></span></span></span></p>

<p style="margin-top:8px; margin-bottom:8px; text-align:justify; text-indent:36.0pt"><span style="font-size:12pt"><span new="" roman="" style="font-family:" times=""><i><span lang="VI" style="font-size:14.0pt">Tin v&agrave; b&agrave;i: Trần Anh Đức- BQL Khu BTTN Bắc Hướng H&oacute;a</span></i></span></span></p>
', 8, 0, CAST(N'2023-08-02T08:57:23.000' AS DateTime), CAST(N'2023-08-02T08:59:35.000' AS DateTime), 1, 0, 1, NULL, NULL, CAST(N'2023-08-02T08:59:35.000' AS DateTime), N'', N'', N'', N'vi', NULL)
INSERT [dongthucvat].[news] ([id], [root_news_cat_id], [news_cat_id], [name], [alias], [image], [short_description], [description], [total_view], [sort_order], [created_at], [updated_at], [is_hot], [is_system], [status], [author], [source], [post_at], [title_seo], [content_seo], [key_seo], [language], [id_related]) VALUES (9, NULL, 1, N'test-tin tức', N'test-tin-tuc', N'76ad21de-9e67-4e09-abba-aad081622c41.jpg', N'đoán xem', N'<p>hahahaddasadasdsa<img alt="" src="/newsImage/46ea4253-306e-4e65-a4f8-f5e1f80d659a.jpg" style="height:315px; width:257px" /></p>

<p>buồn cười thế nhỉ =))&nbsp;</p>

<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas feugiat consequat diam. Maecenas metus. Vivamus diam purus, cursus a, commodo non, facilisis vitae, nulla. Aenean dictum lacinia tortor. Nunc iaculis, nibh non iaculis aliquam, orci felis euismod neque, sed ornare massa mauris sed velit. Nulla pretium mi et risus. Fusce mi pede, tempor id, cursus ac, ullamcorper nec, enim. Sed tortor. Curabitur molestie. Duis velit augue, condimentum at, ultrices a, luctus ut, orci. Donec pellentesque egestas eros. Integer cursus, augue in cursus faucibus, eros pede bibendum sem, in tempus tellus justo quis ligula. Etiam eget tortor. Vestibulum rutrum, est ut placerat elementum, lectus nisl aliquam velit, tempor aliquam eros nunc nonummy metus. In eros metus, gravida a, gravida sed, lobortis id, turpis. Ut ultrices, ipsum at venenatis fringilla, sem nulla lacinia tellus, eget aliquet turpis mauris non enim. Nam turpis. Suspendisse lacinia. Curabitur ac tortor ut ipsum egesta</p>

<p><img alt="" src="/newsImage/ca705af4-0803-4e44-b9b3-9460a58299f2.jpg" style="height:315px; width:350px" /></p>
', 17, 0, NULL, NULL, 1, 0, 1, NULL, NULL, CAST(N'2023-12-03T21:51:38.497' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[news] ([id], [root_news_cat_id], [news_cat_id], [name], [alias], [image], [short_description], [description], [total_view], [sort_order], [created_at], [updated_at], [is_hot], [is_system], [status], [author], [source], [post_at], [title_seo], [content_seo], [key_seo], [language], [id_related]) VALUES (13, NULL, 1, N'test', N'test', N'd7d0cb65-2c99-4020-88fe-56ff84963b55.jpg', N'fsfsfsdfs', N'<p>hbjbjhbjh</p>
', 2, 0, NULL, NULL, 1, 0, 1, NULL, NULL, CAST(N'2024-01-09T00:32:30.777' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dongthucvat].[news] ([id], [root_news_cat_id], [news_cat_id], [name], [alias], [image], [short_description], [description], [total_view], [sort_order], [created_at], [updated_at], [is_hot], [is_system], [status], [author], [source], [post_at], [title_seo], [content_seo], [key_seo], [language], [id_related]) VALUES (14, NULL, 1, N'Test Loài', N'test-loai', N'878d8110-8aae-4051-af62-e8d078a0ea11.webp', N'sgsdsdg', N'<p>adasdsadsadasdasdasda</p>
', 1, 0, NULL, NULL, 1, 0, 1, N'fd797441-0343-4916-0502-08dbb45bd092', NULL, CAST(N'2024-01-09T20:26:32.183' AS DateTime), NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dongthucvat].[news] OFF
GO
SET IDENTITY_INSERT [dongthucvat].[news_cat] ON 

INSERT [dongthucvat].[news_cat] ([id], [name], [alias], [parent_id], [path], [level], [image], [description], [sort_order], [created_at], [updated_at], [status], [language], [title_seo], [content_seo], [key_seo], [id_related]) VALUES (1, N'giới thiệu', N'gioi-thieu', 0, N'0/1', 1, NULL, N'', 0, CAST(N'2021-10-28T22:28:01.000' AS DateTime), CAST(N'2021-10-28T22:28:01.000' AS DateTime), 0, N'vi', N'', N'', N'', NULL)
SET IDENTITY_INSERT [dongthucvat].[news_cat] OFF
GO
INSERT [dongthucvat].[news_cat_rel] ([news_id], [news_cat_id], [created_at]) VALUES (1, 1, NULL)
INSERT [dongthucvat].[news_cat_rel] ([news_id], [news_cat_id], [created_at]) VALUES (2, 1, NULL)
INSERT [dongthucvat].[news_cat_rel] ([news_id], [news_cat_id], [created_at]) VALUES (4, 1, NULL)
INSERT [dongthucvat].[news_cat_rel] ([news_id], [news_cat_id], [created_at]) VALUES (5, 1, NULL)
GO
SET IDENTITY_INSERT [dongthucvat].[route_page] ON 

INSERT [dongthucvat].[route_page] ([id], [name], [route]) VALUES (1, N'Trang chủ', N'site/index')
SET IDENTITY_INSERT [dongthucvat].[route_page] OFF
GO
SET IDENTITY_INSERT [dongthucvat].[site_contact] ON 

INSERT [dongthucvat].[site_contact] ([id], [name], [link_logo], [link_logo_footer], [email], [phone], [hotline], [fax], [address], [link_face], [link_insta], [link_youtube], [link_twitter], [link_zalo], [link_messenger], [link_map], [link_favicon], [embed_script_head], [embed_script_body_begin], [embed_script_body_end], [multitext], [language]) VALUES (1, N'BAN QUẢN LÝ KHU BẢO TỒN THIÊN NHIÊN BẮC HƯỚNG HOÁ', N'root/sitecontact/2021/11/29/17/59/log1638161991_8671.png', N'root/sitecontact/2021/11/29/17/13/log1638159210_1596.png', N'info@vnuforest.com.vn', N'(0233) 379 7225', N'(0233) 379 7225', N' Nơi cuộc sống 
An Bình Thịnh Vượng', N'xã Hướng Phùng, huyện Hướng Hóa, tỉnh Quảng Trị', N'https://www.facebook.com/', N'', N'https://www.youtube.com/', N'https://twitter.com/?lang=vi', N'https://chat.zalo.me/', N'', N'', N'', N'', N'', N'', NULL, N'vi')
INSERT [dongthucvat].[site_contact] ([id], [name], [link_logo], [link_logo_footer], [email], [phone], [hotline], [fax], [address], [link_face], [link_insta], [link_youtube], [link_twitter], [link_zalo], [link_messenger], [link_map], [link_favicon], [embed_script_head], [embed_script_body_begin], [embed_script_body_end], [multitext], [language]) VALUES (2, N'Times Garden Hạ Long', N'root/sitecontact/2021/10/22/16/47/log1634874446_7572.png', N'root/sitecontact/2021/10/22/17/03/log1634875409_4154.png', N'info@timesgarden.com.vn', N'(+84 24) 32 062 119 ', N'0243.206.2119', N' Nơi cuộc sống 
An Bình Thịnh Vượng', N'Tầng 8, Tháp Tây, Tòa nhà Hancorp,  Số 72 Trần Đăng Ninh, P. Dịch Vọng, Cầu Giấy, Hà Nội', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'en')
SET IDENTITY_INSERT [dongthucvat].[site_contact] OFF
GO
SET IDENTITY_INSERT [dongthucvat].[tag] ON 

INSERT [dongthucvat].[tag] ([id], [name], [tag], [status], [page_title], [page_description], [title_seobox], [des_seobox], [feature_tag]) VALUES (1, N'a', N'a', 1, NULL, NULL, NULL, NULL, 0)
SET IDENTITY_INSERT [dongthucvat].[tag] OFF
GO
INSERT [dongthucvat].[tag_rel] ([tag_id], [object_id], [type], [sort_order]) VALUES (1, 2, 1, 0)
GO
SET IDENTITY_INSERT [dongthucvat].[user] ON 

INSERT [dongthucvat].[user] ([id], [cities_id], [cities_district_id], [first_name], [password], [email], [phone], [avatar], [gender], [dob], [address], [created_at], [updated_at], [last_signined_time], [is_admin], [status], [secret_key], [role]) VALUES (3, 1, 0, N'Administrator', N'$2y$13$5sd0Si3Pnab5Adav7RtkG.AwXWMhPv3YEHeFwhlEJJuXvrTV57cjy', N'administrator@gmail.com', N'', NULL, N'FEMALE', NULL, NULL, CAST(N'2020-10-27T17:40:41.000' AS DateTime), CAST(N'2023-07-03T10:03:21.000' AS DateTime), CAST(N'2023-07-03T10:03:21.0000000' AS DateTime2), 1, 1, NULL, N'administrator')
INSERT [dongthucvat].[user] ([id], [cities_id], [cities_district_id], [first_name], [password], [email], [phone], [avatar], [gender], [dob], [address], [created_at], [updated_at], [last_signined_time], [is_admin], [status], [secret_key], [role]) VALUES (20, 0, 0, N'Admin Bắc Hướng Hoá', N'$2y$13$RxtJ25TACEYq/PfXwrAQPeI337tEN0hg9kKALaKmohSxl8s85FjeS', N'admin@bachuonghoa.com', N'0978111003', NULL, N'MALE', NULL, NULL, CAST(N'2021-10-29T20:49:05.000' AS DateTime), CAST(N'2023-08-04T12:38:55.000' AS DateTime), CAST(N'2023-08-04T12:38:55.0000000' AS DateTime2), 1, 1, NULL, N'administrator')
SET IDENTITY_INSERT [dongthucvat].[user] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [news$alias]    Script Date: 19/01/2024 8:26:13 CH ******/
ALTER TABLE [dongthucvat].[news] ADD  CONSTRAINT [news$alias] UNIQUE NONCLUSTERED 
(
	[alias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [id_cat]    Script Date: 19/01/2024 8:26:13 CH ******/
CREATE NONCLUSTERED INDEX [id_cat] ON [dongthucvat].[news]
(
	[news_cat_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [is_hot]    Script Date: 19/01/2024 8:26:13 CH ******/
CREATE NONCLUSTERED INDEX [is_hot] ON [dongthucvat].[news]
(
	[is_hot] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [status]    Script Date: 19/01/2024 8:26:13 CH ******/
CREATE NONCLUSTERED INDEX [status] ON [dongthucvat].[news]
(
	[status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [news_cat$idx_alias]    Script Date: 19/01/2024 8:26:13 CH ******/
ALTER TABLE [dongthucvat].[news_cat] ADD  CONSTRAINT [news_cat$idx_alias] UNIQUE NONCLUSTERED 
(
	[alias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [route_page$name]    Script Date: 19/01/2024 8:26:13 CH ******/
ALTER TABLE [dongthucvat].[route_page] ADD  CONSTRAINT [route_page$name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [route_page$route]    Script Date: 19/01/2024 8:26:13 CH ******/
ALTER TABLE [dongthucvat].[route_page] ADD  CONSTRAINT [route_page$route] UNIQUE NONCLUSTERED 
(
	[route] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [seo_page$unique]    Script Date: 19/01/2024 8:26:13 CH ******/
ALTER TABLE [dongthucvat].[seo_page] ADD  CONSTRAINT [seo_page$unique] UNIQUE NONCLUSTERED 
(
	[route_id] ASC,
	[language] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [site_contact$language_unique]    Script Date: 19/01/2024 8:26:13 CH ******/
ALTER TABLE [dongthucvat].[site_contact] ADD  CONSTRAINT [site_contact$language_unique] UNIQUE NONCLUSTERED 
(
	[language] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [tag$tag]    Script Date: 19/01/2024 8:26:13 CH ******/
ALTER TABLE [dongthucvat].[tag] ADD  CONSTRAINT [tag$tag] UNIQUE NONCLUSTERED 
(
	[tag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [status]    Script Date: 19/01/2024 8:26:13 CH ******/
CREATE NONCLUSTERED INDEX [status] ON [dongthucvat].[tag]
(
	[status] ASC,
	[feature_tag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [status_2]    Script Date: 19/01/2024 8:26:13 CH ******/
CREATE NONCLUSTERED INDEX [status_2] ON [dongthucvat].[tag]
(
	[status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [user$email]    Script Date: 19/01/2024 8:26:13 CH ******/
ALTER TABLE [dongthucvat].[user] ADD  CONSTRAINT [user$email] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [FK_acc]    Script Date: 19/01/2024 8:26:13 CH ******/
CREATE NONCLUSTERED INDEX [FK_acc] ON [dongthucvat].[user]
(
	[cities_district_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [FK_acc__city_id]    Script Date: 19/01/2024 8:26:13 CH ******/
CREATE NONCLUSTERED INDEX [FK_acc__city_id] ON [dongthucvat].[user]
(
	[cities_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [index_email]    Script Date: 19/01/2024 8:26:13 CH ******/
CREATE NONCLUSTERED INDEX [index_email] ON [dongthucvat].[user]
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [index_phone]    Script Date: 19/01/2024 8:26:13 CH ******/
CREATE NONCLUSTERED INDEX [index_phone] ON [dongthucvat].[user]
(
	[phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [status]    Script Date: 19/01/2024 8:26:13 CH ******/
CREATE NONCLUSTERED INDEX [status] ON [dongthucvat].[user]
(
	[status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[introduce] ADD  DEFAULT (N'') FOR [typeNationPak]
GO
ALTER TABLE [dongthucvat].[banner] ADD  DEFAULT ((0)) FOR [banner_cat_id]
GO
ALTER TABLE [dongthucvat].[banner] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dongthucvat].[banner] ADD  DEFAULT (NULL) FOR [src]
GO
ALTER TABLE [dongthucvat].[banner] ADD  DEFAULT (NULL) FOR [src_mobile]
GO
ALTER TABLE [dongthucvat].[banner] ADD  DEFAULT (NULL) FOR [link]
GO
ALTER TABLE [dongthucvat].[banner] ADD  DEFAULT ((0)) FOR [width]
GO
ALTER TABLE [dongthucvat].[banner] ADD  DEFAULT ((0)) FOR [height]
GO
ALTER TABLE [dongthucvat].[banner] ADD  DEFAULT ((0)) FOR [type]
GO
ALTER TABLE [dongthucvat].[banner] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dongthucvat].[banner] ADD  DEFAULT ((0)) FOR [sort_order]
GO
ALTER TABLE [dongthucvat].[banner] ADD  DEFAULT (NULL) FOR [created_at]
GO
ALTER TABLE [dongthucvat].[banner] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dongthucvat].[banner] ADD  DEFAULT (NULL) FOR [language]
GO
ALTER TABLE [dongthucvat].[banner] ADD  DEFAULT (NULL) FOR [id_related]
GO
ALTER TABLE [dongthucvat].[banner_cat] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dongthucvat].[banner_cat] ADD  DEFAULT ((0)) FOR [parent_id]
GO
ALTER TABLE [dongthucvat].[banner_cat] ADD  DEFAULT (NULL) FOR [path]
GO
ALTER TABLE [dongthucvat].[banner_cat] ADD  DEFAULT ((0)) FOR [level]
GO
ALTER TABLE [dongthucvat].[banner_cat] ADD  DEFAULT (NULL) FOR [image]
GO
ALTER TABLE [dongthucvat].[banner_cat] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dongthucvat].[banner_cat] ADD  DEFAULT (NULL) FOR [sort_order]
GO
ALTER TABLE [dongthucvat].[banner_cat] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dongthucvat].[banner_cat] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dongthucvat].[banner_cat] ADD  DEFAULT (NULL) FOR [language]
GO
ALTER TABLE [dongthucvat].[banner_cat] ADD  DEFAULT (NULL) FOR [id_related]
GO
ALTER TABLE [dongthucvat].[boxpage] ADD  DEFAULT ((0)) FOR [boxpage_cat_id]
GO
ALTER TABLE [dongthucvat].[boxpage] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dongthucvat].[boxpage] ADD  DEFAULT (NULL) FOR [sub_name]
GO
ALTER TABLE [dongthucvat].[boxpage] ADD  DEFAULT (NULL) FOR [src]
GO
ALTER TABLE [dongthucvat].[boxpage] ADD  DEFAULT (NULL) FOR [link]
GO
ALTER TABLE [dongthucvat].[boxpage] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dongthucvat].[boxpage] ADD  DEFAULT ((0)) FOR [sort_order]
GO
ALTER TABLE [dongthucvat].[boxpage] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dongthucvat].[boxpage] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dongthucvat].[boxpage] ADD  DEFAULT (NULL) FOR [language]
GO
ALTER TABLE [dongthucvat].[boxpage] ADD  DEFAULT (NULL) FOR [id_related]
GO
ALTER TABLE [dongthucvat].[boxpage_cat] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dongthucvat].[boxpage_cat] ADD  DEFAULT (NULL) FOR [language]
GO
ALTER TABLE [dongthucvat].[boxpage_cat] ADD  DEFAULT ((0)) FOR [parent_id]
GO
ALTER TABLE [dongthucvat].[boxpage_cat] ADD  DEFAULT (NULL) FOR [path]
GO
ALTER TABLE [dongthucvat].[boxpage_cat] ADD  DEFAULT ((0)) FOR [level]
GO
ALTER TABLE [dongthucvat].[boxpage_cat] ADD  DEFAULT (NULL) FOR [image]
GO
ALTER TABLE [dongthucvat].[boxpage_cat] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dongthucvat].[boxpage_cat] ADD  DEFAULT (NULL) FOR [sort_order]
GO
ALTER TABLE [dongthucvat].[boxpage_cat] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dongthucvat].[boxpage_cat] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dongthucvat].[boxpage_cat] ADD  DEFAULT (NULL) FOR [id_related]
GO
ALTER TABLE [dongthucvat].[boxpage_media] ADD  DEFAULT (NULL) FOR [boxpage_id]
GO
ALTER TABLE [dongthucvat].[boxpage_media] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dongthucvat].[boxpage_media] ADD  DEFAULT (NULL) FOR [path]
GO
ALTER TABLE [dongthucvat].[boxpage_media] ADD  DEFAULT (NULL) FOR [path_video]
GO
ALTER TABLE [dongthucvat].[boxpage_media] ADD  DEFAULT (NULL) FOR [type]
GO
ALTER TABLE [dongthucvat].[boxpage_media] ADD  DEFAULT (NULL) FOR [sub_type]
GO
ALTER TABLE [dongthucvat].[boxpage_media] ADD  DEFAULT (NULL) FOR [is_default]
GO
ALTER TABLE [dongthucvat].[boxpage_media] ADD  DEFAULT (NULL) FOR [sort_order]
GO
ALTER TABLE [dongthucvat].[boxpage_media] ADD  DEFAULT (NULL) FOR [created_at]
GO
ALTER TABLE [dongthucvat].[dtv_bo] ADD  CONSTRAINT [DF__dtv_bo__name__503BEA1C]  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dongthucvat].[dtv_bo] ADD  CONSTRAINT [DF__dtv_bo__name_lat__51300E55]  DEFAULT (NULL) FOR [name_latinh]
GO
ALTER TABLE [dongthucvat].[dtv_bo] ADD  CONSTRAINT [DF__dtv_bo__loai__5224328E]  DEFAULT (NULL) FOR [loai]
GO
ALTER TABLE [dongthucvat].[dtv_bo] ADD  CONSTRAINT [DF__dtv_bo__id_dtv_l__531856C7]  DEFAULT (NULL) FOR [id_dtv_lop]
GO
ALTER TABLE [dongthucvat].[dtv_bo] ADD  CONSTRAINT [DF__dtv_bo__status__540C7B00]  DEFAULT (NULL) FOR [status]
GO
ALTER TABLE [dongthucvat].[dtv_bo] ADD  CONSTRAINT [DF__dtv_bo__created___55009F39]  DEFAULT (NULL) FOR [created_at]
GO
ALTER TABLE [dongthucvat].[dtv_bo] ADD  CONSTRAINT [DF__dtv_bo__updated___56E8E7AB]  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dongthucvat].[dtv_ho] ADD  CONSTRAINT [DF__dtv_ho__name__58D1301D]  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dongthucvat].[dtv_ho] ADD  CONSTRAINT [DF__dtv_ho__name_lat__59C55456]  DEFAULT (NULL) FOR [name_latinh]
GO
ALTER TABLE [dongthucvat].[dtv_ho] ADD  CONSTRAINT [DF__dtv_ho__loai__5AB9788F]  DEFAULT (NULL) FOR [loai]
GO
ALTER TABLE [dongthucvat].[dtv_ho] ADD  CONSTRAINT [DF__dtv_ho__id_dtv_b__5BAD9CC8]  DEFAULT (NULL) FOR [id_dtv_bo]
GO
ALTER TABLE [dongthucvat].[dtv_ho] ADD  CONSTRAINT [DF__dtv_ho__status__5CA1C101]  DEFAULT (NULL) FOR [status]
GO
ALTER TABLE [dongthucvat].[dtv_ho] ADD  CONSTRAINT [DF__dtv_ho__created___5D95E53A]  DEFAULT (NULL) FOR [created_at]
GO
ALTER TABLE [dongthucvat].[dtv_ho] ADD  CONSTRAINT [DF__dtv_ho__updated___5F7E2DAC]  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dongthucvat].[dtv_loai] ADD  CONSTRAINT [DF__dtv_loai__name__6166761E]  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dongthucvat].[dtv_loai] ADD  CONSTRAINT [DF__dtv_loai__name_l__625A9A57]  DEFAULT (NULL) FOR [name_latinh]
GO
ALTER TABLE [dongthucvat].[dtv_loai] ADD  CONSTRAINT [DF__dtv_loai__loai__634EBE90]  DEFAULT (NULL) FOR [loai]
GO
ALTER TABLE [dongthucvat].[dtv_loai] ADD  CONSTRAINT [DF__dtv_loai__id_dtv__6442E2C9]  DEFAULT (NULL) FOR [id_dtv_ho]
GO
ALTER TABLE [dongthucvat].[dtv_loai] ADD  CONSTRAINT [DF__dtv_loai__muc_do__681373AD]  DEFAULT (NULL) FOR [muc_do_bao_ton_iucn]
GO
ALTER TABLE [dongthucvat].[dtv_loai] ADD  CONSTRAINT [DF__dtv_loai__muc_do__690797E6]  DEFAULT (NULL) FOR [muc_do_bao_ton_sdvn]
GO
ALTER TABLE [dongthucvat].[dtv_loai] ADD  CONSTRAINT [DF__dtv_loai__muc_do__69FBBC1F]  DEFAULT (NULL) FOR [muc_do_bao_ton_ndcp]
GO
ALTER TABLE [dongthucvat].[dtv_loai] ADD  CONSTRAINT [DF__dtv_loai__muc_do__6AEFE058]  DEFAULT (NULL) FOR [muc_do_bao_ton_nd64cp]
GO
ALTER TABLE [dongthucvat].[dtv_loai] ADD  CONSTRAINT [DF__dtv_loai__status__6BE40491]  DEFAULT (NULL) FOR [status]
GO
ALTER TABLE [dongthucvat].[dtv_loai] ADD  CONSTRAINT [DF__dtv_loai__create__6CD828CA]  DEFAULT (NULL) FOR [created_at]
GO
ALTER TABLE [dongthucvat].[dtv_loai] ADD  CONSTRAINT [DF__dtv_loai__update__6EC0713C]  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dongthucvat].[dtv_lop] ADD  CONSTRAINT [DF__dtv_lop__name__70A8B9AE]  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dongthucvat].[dtv_lop] ADD  CONSTRAINT [DF__dtv_lop__name_la__719CDDE7]  DEFAULT (NULL) FOR [name_latinh]
GO
ALTER TABLE [dongthucvat].[dtv_lop] ADD  CONSTRAINT [DF__dtv_lop__loai__72910220]  DEFAULT (NULL) FOR [loai]
GO
ALTER TABLE [dongthucvat].[dtv_lop] ADD  CONSTRAINT [DF__dtv_lop__id_dtv___73852659]  DEFAULT (NULL) FOR [id_dtv_nganh]
GO
ALTER TABLE [dongthucvat].[dtv_lop] ADD  CONSTRAINT [DF__dtv_lop__status__74794A92]  DEFAULT (NULL) FOR [status]
GO
ALTER TABLE [dongthucvat].[dtv_lop] ADD  CONSTRAINT [DF__dtv_lop__created__756D6ECB]  DEFAULT (NULL) FOR [created_at]
GO
ALTER TABLE [dongthucvat].[dtv_lop] ADD  CONSTRAINT [DF__dtv_lop__updated__7755B73D]  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dongthucvat].[dtv_nganh] ADD  CONSTRAINT [DF__dtv_nganh__name__793DFFAF]  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dongthucvat].[dtv_nganh] ADD  CONSTRAINT [DF__dtv_nganh__name___7A3223E8]  DEFAULT (NULL) FOR [name_latinh]
GO
ALTER TABLE [dongthucvat].[dtv_nganh] ADD  CONSTRAINT [DF__dtv_nganh__loai__7B264821]  DEFAULT (NULL) FOR [loai]
GO
ALTER TABLE [dongthucvat].[dtv_nganh] ADD  CONSTRAINT [DF__dtv_nganh__statu__7C1A6C5A]  DEFAULT (NULL) FOR [status]
GO
ALTER TABLE [dongthucvat].[dtv_nganh] ADD  CONSTRAINT [DF__dtv_nganh__creat__7D0E9093]  DEFAULT (NULL) FOR [created_at]
GO
ALTER TABLE [dongthucvat].[dtv_nganh] ADD  CONSTRAINT [DF__dtv_nganh__updat__7EF6D905]  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dongthucvat].[image_general] ADD  DEFAULT ((0)) FOR [object_id]
GO
ALTER TABLE [dongthucvat].[image_general] ADD  DEFAULT ((0)) FOR [user_id]
GO
ALTER TABLE [dongthucvat].[image_general] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dongthucvat].[image_general] ADD  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dongthucvat].[image_general] ADD  DEFAULT ((0)) FOR [type]
GO
ALTER TABLE [dongthucvat].[image_general] ADD  DEFAULT (NULL) FOR [created_at]
GO
ALTER TABLE [dongthucvat].[image_general] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dongthucvat].[image_general] ADD  DEFAULT ((0)) FOR [mode]
GO
ALTER TABLE [dongthucvat].[image_general] ADD  DEFAULT ((0)) FOR [id_dir]
GO
ALTER TABLE [dongthucvat].[image_general_directory] ADD  DEFAULT ((0)) FOR [parent_id]
GO
ALTER TABLE [dongthucvat].[menus] ADD  DEFAULT (NULL) FOR [menu_group_id]
GO
ALTER TABLE [dongthucvat].[menus] ADD  DEFAULT (NULL) FOR [language]
GO
ALTER TABLE [dongthucvat].[menus] ADD  DEFAULT (NULL) FOR [type_menu]
GO
ALTER TABLE [dongthucvat].[menus] ADD  DEFAULT (NULL) FOR [id_object]
GO
ALTER TABLE [dongthucvat].[menus] ADD  DEFAULT (NULL) FOR [gen_url]
GO
ALTER TABLE [dongthucvat].[menus] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dongthucvat].[menus] ADD  DEFAULT (NULL) FOR [link_menu]
GO
ALTER TABLE [dongthucvat].[menus] ADD  DEFAULT ((0)) FOR [parent_id]
GO
ALTER TABLE [dongthucvat].[menus] ADD  DEFAULT (NULL) FOR [path]
GO
ALTER TABLE [dongthucvat].[menus] ADD  DEFAULT ((0)) FOR [level]
GO
ALTER TABLE [dongthucvat].[menus] ADD  DEFAULT (NULL) FOR [image_hover]
GO
ALTER TABLE [dongthucvat].[menus] ADD  DEFAULT (NULL) FOR [image]
GO
ALTER TABLE [dongthucvat].[menus] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dongthucvat].[menus] ADD  DEFAULT (NULL) FOR [sort_order]
GO
ALTER TABLE [dongthucvat].[menus] ADD  DEFAULT (NULL) FOR [created_at]
GO
ALTER TABLE [dongthucvat].[menus] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dongthucvat].[menus] ADD  DEFAULT (NULL) FOR [id_related]
GO
ALTER TABLE [dongthucvat].[news] ADD  DEFAULT (NULL) FOR [root_news_cat_id]
GO
ALTER TABLE [dongthucvat].[news] ADD  DEFAULT ((0)) FOR [news_cat_id]
GO
ALTER TABLE [dongthucvat].[news] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dongthucvat].[news] ADD  DEFAULT (NULL) FOR [alias]
GO
ALTER TABLE [dongthucvat].[news] ADD  DEFAULT (NULL) FOR [image]
GO
ALTER TABLE [dongthucvat].[news] ADD  DEFAULT ((0)) FOR [total_view]
GO
ALTER TABLE [dongthucvat].[news] ADD  DEFAULT ((0)) FOR [sort_order]
GO
ALTER TABLE [dongthucvat].[news] ADD  DEFAULT (NULL) FOR [created_at]
GO
ALTER TABLE [dongthucvat].[news] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dongthucvat].[news] ADD  DEFAULT ((0)) FOR [is_hot]
GO
ALTER TABLE [dongthucvat].[news] ADD  DEFAULT ((0)) FOR [is_system]
GO
ALTER TABLE [dongthucvat].[news] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dongthucvat].[news] ADD  DEFAULT (NULL) FOR [author]
GO
ALTER TABLE [dongthucvat].[news] ADD  DEFAULT (NULL) FOR [source]
GO
ALTER TABLE [dongthucvat].[news] ADD  DEFAULT (NULL) FOR [post_at]
GO
ALTER TABLE [dongthucvat].[news] ADD  DEFAULT (NULL) FOR [title_seo]
GO
ALTER TABLE [dongthucvat].[news] ADD  DEFAULT (NULL) FOR [key_seo]
GO
ALTER TABLE [dongthucvat].[news] ADD  DEFAULT (NULL) FOR [language]
GO
ALTER TABLE [dongthucvat].[news] ADD  DEFAULT (NULL) FOR [id_related]
GO
ALTER TABLE [dongthucvat].[news_cat] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dongthucvat].[news_cat] ADD  DEFAULT (NULL) FOR [alias]
GO
ALTER TABLE [dongthucvat].[news_cat] ADD  DEFAULT ((0)) FOR [parent_id]
GO
ALTER TABLE [dongthucvat].[news_cat] ADD  DEFAULT (NULL) FOR [path]
GO
ALTER TABLE [dongthucvat].[news_cat] ADD  DEFAULT ((0)) FOR [level]
GO
ALTER TABLE [dongthucvat].[news_cat] ADD  DEFAULT (NULL) FOR [image]
GO
ALTER TABLE [dongthucvat].[news_cat] ADD  DEFAULT ((0)) FOR [sort_order]
GO
ALTER TABLE [dongthucvat].[news_cat] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dongthucvat].[news_cat] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dongthucvat].[news_cat] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dongthucvat].[news_cat] ADD  DEFAULT (NULL) FOR [language]
GO
ALTER TABLE [dongthucvat].[news_cat] ADD  DEFAULT (NULL) FOR [title_seo]
GO
ALTER TABLE [dongthucvat].[news_cat] ADD  DEFAULT (NULL) FOR [id_related]
GO
ALTER TABLE [dongthucvat].[news_cat_rel] ADD  DEFAULT (NULL) FOR [created_at]
GO
ALTER TABLE [dongthucvat].[seo_page] ADD  DEFAULT (NULL) FOR [page_title]
GO
ALTER TABLE [dongthucvat].[seo_page] ADD  DEFAULT (NULL) FOR [page_keywords]
GO
ALTER TABLE [dongthucvat].[seo_page] ADD  DEFAULT (NULL) FOR [page_description]
GO
ALTER TABLE [dongthucvat].[seo_page] ADD  DEFAULT (NULL) FOR [face_title]
GO
ALTER TABLE [dongthucvat].[seo_page] ADD  DEFAULT (NULL) FOR [face_image]
GO
ALTER TABLE [dongthucvat].[seo_page] ADD  DEFAULT (NULL) FOR [face_description]
GO
ALTER TABLE [dongthucvat].[seo_page] ADD  DEFAULT (NULL) FOR [language]
GO
ALTER TABLE [dongthucvat].[seo_page] ADD  DEFAULT (NULL) FOR [id_related]
GO
ALTER TABLE [dongthucvat].[site_contact] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dongthucvat].[site_contact] ADD  DEFAULT (NULL) FOR [link_logo]
GO
ALTER TABLE [dongthucvat].[site_contact] ADD  DEFAULT (NULL) FOR [link_logo_footer]
GO
ALTER TABLE [dongthucvat].[site_contact] ADD  DEFAULT (NULL) FOR [email]
GO
ALTER TABLE [dongthucvat].[site_contact] ADD  DEFAULT (NULL) FOR [phone]
GO
ALTER TABLE [dongthucvat].[site_contact] ADD  DEFAULT (NULL) FOR [hotline]
GO
ALTER TABLE [dongthucvat].[site_contact] ADD  DEFAULT (NULL) FOR [fax]
GO
ALTER TABLE [dongthucvat].[site_contact] ADD  DEFAULT (NULL) FOR [address]
GO
ALTER TABLE [dongthucvat].[site_contact] ADD  DEFAULT (NULL) FOR [link_face]
GO
ALTER TABLE [dongthucvat].[site_contact] ADD  DEFAULT (NULL) FOR [link_insta]
GO
ALTER TABLE [dongthucvat].[site_contact] ADD  DEFAULT (NULL) FOR [link_youtube]
GO
ALTER TABLE [dongthucvat].[site_contact] ADD  DEFAULT (NULL) FOR [link_twitter]
GO
ALTER TABLE [dongthucvat].[site_contact] ADD  DEFAULT (NULL) FOR [link_zalo]
GO
ALTER TABLE [dongthucvat].[site_contact] ADD  DEFAULT (NULL) FOR [link_messenger]
GO
ALTER TABLE [dongthucvat].[site_contact] ADD  DEFAULT (NULL) FOR [link_favicon]
GO
ALTER TABLE [dongthucvat].[site_contact] ADD  DEFAULT (NULL) FOR [language]
GO
ALTER TABLE [dongthucvat].[subscribe] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dongthucvat].[subscribe] ADD  DEFAULT (NULL) FOR [phone]
GO
ALTER TABLE [dongthucvat].[subscribe] ADD  DEFAULT (NULL) FOR [email]
GO
ALTER TABLE [dongthucvat].[subscribe] ADD  DEFAULT (NULL) FOR [created_at]
GO
ALTER TABLE [dongthucvat].[subscribe] ADD  DEFAULT (NULL) FOR [updated_at]
GO
ALTER TABLE [dongthucvat].[subscribe] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dongthucvat].[subscribe] ADD  DEFAULT (NULL) FOR [ip]
GO
ALTER TABLE [dongthucvat].[subscribe] ADD  DEFAULT ((0)) FOR [type]
GO
ALTER TABLE [dongthucvat].[subscribe] ADD  DEFAULT (NULL) FOR [utm_campaign]
GO
ALTER TABLE [dongthucvat].[subscribe] ADD  DEFAULT (NULL) FOR [utm_medium]
GO
ALTER TABLE [dongthucvat].[subscribe] ADD  DEFAULT (NULL) FOR [utm_content]
GO
ALTER TABLE [dongthucvat].[subscribe] ADD  DEFAULT (NULL) FOR [utm_source]
GO
ALTER TABLE [dongthucvat].[subscribe] ADD  DEFAULT (NULL) FOR [utm_term]
GO
ALTER TABLE [dongthucvat].[subscribe] ADD  DEFAULT (NULL) FOR [utm_referrer]
GO
ALTER TABLE [dongthucvat].[subscribe] ADD  DEFAULT (NULL) FOR [cookies]
GO
ALTER TABLE [dongthucvat].[subscribe] ADD  DEFAULT (NULL) FOR [phongban]
GO
ALTER TABLE [dongthucvat].[subscribe] ADD  DEFAULT (NULL) FOR [object_id]
GO
ALTER TABLE [dongthucvat].[subscribe] ADD  DEFAULT (NULL) FOR [file]
GO
ALTER TABLE [dongthucvat].[tag] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dongthucvat].[tag] ADD  DEFAULT (NULL) FOR [tag]
GO
ALTER TABLE [dongthucvat].[tag] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dongthucvat].[tag] ADD  DEFAULT (NULL) FOR [page_title]
GO
ALTER TABLE [dongthucvat].[tag] ADD  DEFAULT (NULL) FOR [page_description]
GO
ALTER TABLE [dongthucvat].[tag] ADD  DEFAULT (NULL) FOR [title_seobox]
GO
ALTER TABLE [dongthucvat].[tag] ADD  DEFAULT ((0)) FOR [feature_tag]
GO
ALTER TABLE [dongthucvat].[tag_rel] ADD  DEFAULT ((0)) FOR [sort_order]
GO
ALTER TABLE [dongthucvat].[user] ADD  DEFAULT ((0)) FOR [cities_id]
GO
ALTER TABLE [dongthucvat].[user] ADD  DEFAULT ((0)) FOR [cities_district_id]
GO
ALTER TABLE [dongthucvat].[user] ADD  DEFAULT (NULL) FOR [first_name]
GO
ALTER TABLE [dongthucvat].[user] ADD  DEFAULT (NULL) FOR [password]
GO
ALTER TABLE [dongthucvat].[user] ADD  DEFAULT (NULL) FOR [email]
GO
ALTER TABLE [dongthucvat].[user] ADD  DEFAULT (NULL) FOR [phone]
GO
ALTER TABLE [dongthucvat].[user] ADD  DEFAULT (NULL) FOR [gender]
GO
ALTER TABLE [dongthucvat].[user] ADD  DEFAULT (NULL) FOR [dob]
GO
ALTER TABLE [dongthucvat].[user] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dongthucvat].[user] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dongthucvat].[user] ADD  DEFAULT (NULL) FOR [last_signined_time]
GO
ALTER TABLE [dongthucvat].[user] ADD  DEFAULT ((0)) FOR [is_admin]
GO
ALTER TABLE [dongthucvat].[user] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dongthucvat].[user] ADD  DEFAULT (NULL) FOR [secret_key]
GO
ALTER TABLE [dongthucvat].[user] ADD  DEFAULT (NULL) FOR [role]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.`user`' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'FUNCTION',@level1name=N'enum2str$user$gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.`user`' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'FUNCTION',@level1name=N'norm_enum$user$gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.`user`' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'FUNCTION',@level1name=N'str2enum$user$gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.banner' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'TABLE',@level1name=N'banner'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.banner_cat' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'TABLE',@level1name=N'banner_cat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.boxpage' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'TABLE',@level1name=N'boxpage'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.boxpage_cat' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'TABLE',@level1name=N'boxpage_cat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.boxpage_media' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'TABLE',@level1name=N'boxpage_media'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.dtv_bo' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'TABLE',@level1name=N'dtv_bo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.dtv_ho' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'TABLE',@level1name=N'dtv_ho'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.dtv_loai' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'TABLE',@level1name=N'dtv_loai'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.dtv_lop' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'TABLE',@level1name=N'dtv_lop'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.dtv_nganh' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'TABLE',@level1name=N'dtv_nganh'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.image_general' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'TABLE',@level1name=N'image_general'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.image_general_directory' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'TABLE',@level1name=N'image_general_directory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.menus' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'TABLE',@level1name=N'menus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.news' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'TABLE',@level1name=N'news'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.news_cat' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'TABLE',@level1name=N'news_cat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.news_cat_rel' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'TABLE',@level1name=N'news_cat_rel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.route_page' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'TABLE',@level1name=N'route_page'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.seo_page' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'TABLE',@level1name=N'seo_page'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.site_contact' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'TABLE',@level1name=N'site_contact'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.subscribe' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'TABLE',@level1name=N'subscribe'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.tag' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'TABLE',@level1name=N'tag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.tag_rel' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'TABLE',@level1name=N'tag_rel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'dongthucvat.`user`' , @level0type=N'SCHEMA',@level0name=N'dongthucvat', @level1type=N'TABLE',@level1name=N'user'
GO
USE [master]
GO
ALTER DATABASE [DongThucVat] SET  READ_WRITE 
GO
