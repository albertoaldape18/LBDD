USE [PuntoVenta]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Sucursales]') AND type in (N'U'))
ALTER TABLE [dbo].[Sucursales] DROP CONSTRAINT IF EXISTS [FK_Sucursales_Empleados]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Puestos]') AND type in (N'U'))
ALTER TABLE [dbo].[Puestos] DROP CONSTRAINT IF EXISTS [FK_Puestos_Sucursales]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Puestos]') AND type in (N'U'))
ALTER TABLE [dbo].[Puestos] DROP CONSTRAINT IF EXISTS [FK_Puestos_Empleados]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Facturas]') AND type in (N'U'))
ALTER TABLE [dbo].[Facturas] DROP CONSTRAINT IF EXISTS [FK_Facturas_Sucursales]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Facturas]') AND type in (N'U'))
ALTER TABLE [dbo].[Facturas] DROP CONSTRAINT IF EXISTS [FK_Facturas_Empleados]
GO
/****** Object:  Table [dbo].[Ventas]    Script Date: 22/09/2018 12:12:37 a. m. ******/
DROP TABLE IF EXISTS [dbo].[Ventas]
GO
/****** Object:  Table [dbo].[Sucursales]    Script Date: 22/09/2018 12:12:37 a. m. ******/
DROP TABLE IF EXISTS [dbo].[Sucursales]
GO
/****** Object:  Table [dbo].[Puestos]    Script Date: 22/09/2018 12:12:37 a. m. ******/
DROP TABLE IF EXISTS [dbo].[Puestos]
GO
/****** Object:  Table [dbo].[Facturas]    Script Date: 22/09/2018 12:12:37 a. m. ******/
DROP TABLE IF EXISTS [dbo].[Facturas]
GO
/****** Object:  Table [dbo].[Empleados]    Script Date: 22/09/2018 12:12:37 a. m. ******/
DROP TABLE IF EXISTS [dbo].[Empleados]
GO
USE [master]
GO
/****** Object:  Database [PuntoVenta]    Script Date: 22/09/2018 12:12:37 a. m. ******/
DROP DATABASE IF EXISTS [PuntoVenta]
GO
/****** Object:  Database [PuntoVenta]    Script Date: 22/09/2018 12:12:37 a. m. ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'PuntoVenta')
BEGIN
CREATE DATABASE [PuntoVenta]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PuntoVenta', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\PuntoVenta.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PuntoVenta_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\PuntoVenta_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
END
GO
ALTER DATABASE [PuntoVenta] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PuntoVenta].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PuntoVenta] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PuntoVenta] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PuntoVenta] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PuntoVenta] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PuntoVenta] SET ARITHABORT OFF 
GO
ALTER DATABASE [PuntoVenta] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PuntoVenta] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PuntoVenta] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PuntoVenta] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PuntoVenta] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PuntoVenta] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PuntoVenta] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PuntoVenta] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PuntoVenta] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PuntoVenta] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PuntoVenta] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PuntoVenta] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PuntoVenta] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PuntoVenta] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PuntoVenta] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PuntoVenta] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PuntoVenta] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PuntoVenta] SET RECOVERY FULL 
GO
ALTER DATABASE [PuntoVenta] SET  MULTI_USER 
GO
ALTER DATABASE [PuntoVenta] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PuntoVenta] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PuntoVenta] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PuntoVenta] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PuntoVenta] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'PuntoVenta', N'ON'
GO
ALTER DATABASE [PuntoVenta] SET QUERY_STORE = OFF
GO
USE [PuntoVenta]
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
USE [PuntoVenta]
GO
/****** Object:  Table [dbo].[Empleados]    Script Date: 22/09/2018 12:12:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Empleados]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Empleados](
	[id_empleado] [int] NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[fotogrfia] [image] NOT NULL,
	[fecha_nacimiento] [date] NOT NULL,
	[telefono] [int] NOT NULL,
	[direccion] [text] NOT NULL,
	[salario] [float] NOT NULL,
	[nom_puesto] [varchar](1) NOT NULL,
	[nom_sucursal] [text] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Facturas]    Script Date: 22/09/2018 12:12:38 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Facturas]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Facturas](
	[id_factura] [int] NOT NULL,
	[id_sucursal] [int] NOT NULL,
	[nom_sucursal] [text] NOT NULL,
	[fechahora] [datetime] NOT NULL,
	[nombre] [text] NOT NULL,
	[firma] [image] NOT NULL,
	[cantidad] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_factura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Puestos]    Script Date: 22/09/2018 12:12:38 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Puestos]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Puestos](
	[id_puesto] [int] NOT NULL,
	[nom_puesto] [varchar](1) NOT NULL,
	[sueldobase] [float] NOT NULL,
	[pagohoraextra] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_puesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Sucursales]    Script Date: 22/09/2018 12:12:38 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Sucursales]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Sucursales](
	[id_sucursal] [int] NOT NULL,
	[nom_sucursal] [text] NOT NULL,
	[ubicacion] [text] NOT NULL,
	[telefono] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_sucursal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Ventas]    Script Date: 22/09/2018 12:12:39 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ventas]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Ventas](
	[num_caja] [int] NOT NULL,
	[articulos] [text] NOT NULL,
	[suma_monto] [float] NOT NULL,
	[fechahora] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[num_caja] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Facturas_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[Facturas]'))
ALTER TABLE [dbo].[Facturas]  WITH CHECK ADD  CONSTRAINT [FK_Facturas_Empleados] FOREIGN KEY([id_factura])
REFERENCES [dbo].[Empleados] ([id_empleado])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Facturas_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[Facturas]'))
ALTER TABLE [dbo].[Facturas] CHECK CONSTRAINT [FK_Facturas_Empleados]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Facturas_Sucursales]') AND parent_object_id = OBJECT_ID(N'[dbo].[Facturas]'))
ALTER TABLE [dbo].[Facturas]  WITH CHECK ADD  CONSTRAINT [FK_Facturas_Sucursales] FOREIGN KEY([id_factura])
REFERENCES [dbo].[Sucursales] ([id_sucursal])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Facturas_Sucursales]') AND parent_object_id = OBJECT_ID(N'[dbo].[Facturas]'))
ALTER TABLE [dbo].[Facturas] CHECK CONSTRAINT [FK_Facturas_Sucursales]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Puestos_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[Puestos]'))
ALTER TABLE [dbo].[Puestos]  WITH CHECK ADD  CONSTRAINT [FK_Puestos_Empleados] FOREIGN KEY([id_puesto])
REFERENCES [dbo].[Empleados] ([id_empleado])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Puestos_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[Puestos]'))
ALTER TABLE [dbo].[Puestos] CHECK CONSTRAINT [FK_Puestos_Empleados]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Puestos_Sucursales]') AND parent_object_id = OBJECT_ID(N'[dbo].[Puestos]'))
ALTER TABLE [dbo].[Puestos]  WITH CHECK ADD  CONSTRAINT [FK_Puestos_Sucursales] FOREIGN KEY([id_puesto])
REFERENCES [dbo].[Sucursales] ([id_sucursal])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Puestos_Sucursales]') AND parent_object_id = OBJECT_ID(N'[dbo].[Puestos]'))
ALTER TABLE [dbo].[Puestos] CHECK CONSTRAINT [FK_Puestos_Sucursales]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Sucursales_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[Sucursales]'))
ALTER TABLE [dbo].[Sucursales]  WITH CHECK ADD  CONSTRAINT [FK_Sucursales_Empleados] FOREIGN KEY([id_sucursal])
REFERENCES [dbo].[Empleados] ([id_empleado])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Sucursales_Empleados]') AND parent_object_id = OBJECT_ID(N'[dbo].[Sucursales]'))
ALTER TABLE [dbo].[Sucursales] CHECK CONSTRAINT [FK_Sucursales_Empleados]
GO
USE [master]
GO
ALTER DATABASE [PuntoVenta] SET  READ_WRITE 
GO
