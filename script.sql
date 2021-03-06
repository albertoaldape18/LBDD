USE [PuntodeVenta]
GO
/****** Object:  Table [dbo].[Ventas]    Script Date: 07/09/2018 09:47:15 p. m. ******/
DROP TABLE IF EXISTS [dbo].[Ventas]
GO
/****** Object:  Table [dbo].[Sucursales]    Script Date: 07/09/2018 09:47:15 p. m. ******/
DROP TABLE IF EXISTS [dbo].[Sucursales]
GO
/****** Object:  Table [dbo].[Puestos]    Script Date: 07/09/2018 09:47:15 p. m. ******/
DROP TABLE IF EXISTS [dbo].[Puestos]
GO
/****** Object:  Table [dbo].[Facturas]    Script Date: 07/09/2018 09:47:15 p. m. ******/
DROP TABLE IF EXISTS [dbo].[Facturas]
GO
/****** Object:  Table [dbo].[Empleados]    Script Date: 07/09/2018 09:47:15 p. m. ******/
DROP TABLE IF EXISTS [dbo].[Empleados]
GO
USE [master]
GO
/****** Object:  Database [PuntodeVenta]    Script Date: 07/09/2018 09:47:15 p. m. ******/
DROP DATABASE IF EXISTS [PuntodeVenta]
GO
/****** Object:  Database [PuntodeVenta]    Script Date: 07/09/2018 09:47:15 p. m. ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'PuntodeVenta')
BEGIN
CREATE DATABASE [PuntodeVenta]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PuntodeVenta', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\PuntodeVenta.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PuntodeVenta_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\PuntodeVenta_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
END
GO
ALTER DATABASE [PuntodeVenta] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PuntodeVenta].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PuntodeVenta] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PuntodeVenta] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PuntodeVenta] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PuntodeVenta] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PuntodeVenta] SET ARITHABORT OFF 
GO
ALTER DATABASE [PuntodeVenta] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PuntodeVenta] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PuntodeVenta] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PuntodeVenta] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PuntodeVenta] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PuntodeVenta] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PuntodeVenta] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PuntodeVenta] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PuntodeVenta] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PuntodeVenta] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PuntodeVenta] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PuntodeVenta] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PuntodeVenta] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PuntodeVenta] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PuntodeVenta] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PuntodeVenta] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PuntodeVenta] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PuntodeVenta] SET RECOVERY FULL 
GO
ALTER DATABASE [PuntodeVenta] SET  MULTI_USER 
GO
ALTER DATABASE [PuntodeVenta] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PuntodeVenta] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PuntodeVenta] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PuntodeVenta] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PuntodeVenta] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'PuntodeVenta', N'ON'
GO
ALTER DATABASE [PuntodeVenta] SET QUERY_STORE = OFF
GO
USE [PuntodeVenta]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
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
USE [PuntodeVenta]
GO
/****** Object:  Table [dbo].[Empleados]    Script Date: 07/09/2018 09:47:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Empleados]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Empleados](
	[id_empleado] [varchar](8) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[fotogrfia] [image] NULL,
	[fecha_nacimiento] [date] NOT NULL,
	[telefono] [int] NULL,
	[direccion] [text] NULL,
	[salario] [float] NULL,
	[nom_puesto] [varchar](1) NULL,
	[nom_sucursal] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Facturas]    Script Date: 07/09/2018 09:47:16 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Facturas]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Facturas](
	[id_factura] [int] NULL,
	[id_sucursal] [int] NULL,
	[nom_sucursal] [text] NULL,
	[fechahora] [datetime] NULL,
	[nombre] [text] NULL,
	[firma] [image] NULL,
	[cantidad] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Puestos]    Script Date: 07/09/2018 09:47:17 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Puestos]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Puestos](
	[id_puesto] [int] NULL,
	[nom_puesto] [varchar](1) NULL,
	[sueldobase] [float] NULL,
	[pagohoraextra] [float] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Sucursales]    Script Date: 07/09/2018 09:47:17 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Sucursales]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Sucursales](
	[id_sucursal] [int] NULL,
	[nom_sucursal] [text] NULL,
	[ubicacion] [text] NULL,
	[telefono] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Ventas]    Script Date: 07/09/2018 09:47:18 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ventas]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Ventas](
	[num_caja] [int] NULL,
	[articulos] [text] NULL,
	[suma_monto] [float] NULL,
	[fechahora] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
USE [master]
GO
ALTER DATABASE [PuntodeVenta] SET  READ_WRITE 
GO
