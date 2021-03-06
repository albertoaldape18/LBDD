--INTEGRANTES DEL EQUIPO
--Martínez González Pedro Antonio
--Sierra Ruiz Andres Sebastian
--Almendarez Aldape Juan Alberto

USE [master]
GO
/****** Object:  Database [Punto_venta]    Script Date: 26/10/2018 01:36:25 p. m. ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'Punto_venta')
BEGIN
CREATE DATABASE [Punto_venta]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Punto_venta', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Punto_venta.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Punto_venta_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Punto_venta_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
END
GO
ALTER DATABASE [Punto_venta] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Punto_venta].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Punto_venta] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Punto_venta] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Punto_venta] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Punto_venta] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Punto_venta] SET ARITHABORT OFF 
GO
ALTER DATABASE [Punto_venta] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Punto_venta] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Punto_venta] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Punto_venta] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Punto_venta] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Punto_venta] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Punto_venta] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Punto_venta] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Punto_venta] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Punto_venta] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Punto_venta] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Punto_venta] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Punto_venta] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Punto_venta] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Punto_venta] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Punto_venta] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Punto_venta] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Punto_venta] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Punto_venta] SET  MULTI_USER 
GO
ALTER DATABASE [Punto_venta] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Punto_venta] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Punto_venta] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Punto_venta] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Punto_venta] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Punto_venta] SET QUERY_STORE = OFF
GO
USE [Punto_venta]
GO
/****** Object:  UserDefinedFunction [dbo].[Costo_Por_unidades]    Script Date: 26/10/2018 01:36:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  UserDefinedFunction [dbo].[Costo_Total]    Script Date: 26/10/2018 01:36:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  UserDefinedFunction [dbo].[Costo_Total1]    Script Date: 26/10/2018 01:36:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Costo_Total1]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'create function [dbo].[Costo_Total1](@v1 int, @id int)
returns int
as 
begin
declare @compra int;
select @compra = Producto_B.costo_compra
from Producto_B where Producto_B.id_producto=@id
	RETURN (@compra * @v1) 
end ' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[CostoTotal]    Script Date: 26/10/2018 01:36:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  UserDefinedFunction [dbo].[NumeroAlCuadrado]    Script Date: 26/10/2018 01:36:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NumeroAlCuadrado]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[NumeroAlCuadrado] (@v1 float)
RETURNS FLOAT
AS
BEGIN
	 RETURN (@v1 * @v1)
END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[suma]    Script Date: 26/10/2018 01:36:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[suma]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'create function [dbo].[suma](@v1 int , @v2 int )
returns int
as 
begin 
	RETURN @v1 + @v2
end ' 
END
GO
/****** Object:  Table [dbo].[Producto_B]    Script Date: 26/10/2018 01:36:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Producto_B]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Producto_B](
	[id_producto] [int] NOT NULL,
	[nombre] [varchar](50) NULL,
	[costo_compra] [decimal](18, 0) NULL,
	[precio_venta] [decimal](18, 0) NULL,
	[id_Categoria] [int] NULL,
	[id_proveedor] [int] NULL,
	[descripcion] [varchar](150) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Categoria]    Script Date: 26/10/2018 01:36:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Categoria]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Categoria](
	[id_Categoria] [int] NOT NULL,
	[nombre] [varchar](20) NULL,
	[descripcion] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_Categoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Almacen_C]    Script Date: 26/10/2018 01:36:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Almacen_C]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Almacen_C](
	[registro] [int] NOT NULL,
	[Fecha] [date] NULL,
	[id_producto] [int] NULL,
	[Existencia] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[registro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  View [dbo].[Reporte_Almacen1]    Script Date: 26/10/2018 01:36:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[Reporte_Almacen1]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[Reporte_Almacen1] as (
select Almacen_C.id_producto, Producto_B.nombre, Almacen_C.Existencia, Almacen_C.Fecha, 
Producto_B.costo_compra, Producto_B.precio_venta,  sum(costo_compra*.16) as iva
from Almacen_C, Categoria left join Producto_B on id_producto= Producto_B.id_producto
where Almacen_C.id_producto= Producto_B.id_producto
group by Almacen_C.id_producto, Producto_B.nombre, Almacen_C.Existencia, Almacen_C.Fecha, 
Producto_B.costo_compra, Producto_B.precio_venta)' 
GO
/****** Object:  Table [dbo].[telefono_a]    Script Date: 26/10/2018 01:36:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[telefono_a]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[telefono_a](
	[id_telefono] [int] NOT NULL,
	[num_telefono] [varchar](12) NULL,
	[zona] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_telefono] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Empleado_C]    Script Date: 26/10/2018 01:36:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Empleado_C]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Empleado_C](
	[id_empleado] [int] NOT NULL,
	[nombre] [varchar](50) NULL,
	[foto] [image] NULL,
	[edad] [int] NULL,
	[estatura] [decimal](18, 0) NULL,
	[peso] [decimal](18, 0) NULL,
	[id_direccion] [int] NULL,
	[id_telefono] [int] NULL,
	[sexo] [bit] NULL,
	[salario] [money] NULL,
	[id_puesto] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[direccion_b]    Script Date: 26/10/2018 01:36:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[direccion_b]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[direccion_b](
	[id_direccion] [int] NOT NULL,
	[calle] [varchar](50) NULL,
	[numero] [int] NULL,
	[colonia] [varchar](50) NULL,
	[municipio] [varchar](50) NULL,
	[estado] [varchar](50) NULL,
	[pais] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_direccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  View [dbo].[Reporte_Empleado1]    Script Date: 26/10/2018 01:36:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[Reporte_Empleado1]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[Reporte_Empleado1] as (
select Empleado_C.id_empleado ,Empleado_C.nombre, Empleado_C.edad, direccion_b.numero, direccion_b.calle,
	direccion_b.municipio, direccion_b.estado, telefono_a.num_telefono, Empleado_C.salario, sum(Empleado_C.salario*.16) as iva_sueldo
from Empleado_C, direccion_b left join telefono_a on id_telefono= telefono_a.id_telefono
where (Empleado_C.id_direccion=direccion_b.id_direccion) and (Empleado_C.id_telefono=telefono_a.id_telefono)
group by Empleado_C.id_empleado ,Empleado_C.nombre, Empleado_C.edad, direccion_b.numero, direccion_b.calle,
	direccion_b.municipio, direccion_b.estado, telefono_a.num_telefono, Empleado_C.salario)' 
GO
/****** Object:  Table [dbo].[puesto_b]    Script Date: 26/10/2018 01:36:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[puesto_b]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[puesto_b](
	[id_puesto] [int] NOT NULL,
	[n_puesto] [varchar](25) NULL,
	[nivel] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_puesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  View [dbo].[Puestos1]    Script Date: 26/10/2018 01:36:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[Puestos1]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[Puestos1] as (
select Empleado_C.id_empleado, puesto_b.n_puesto, puesto_b.nivel, Empleado_C.salario, sum(Empleado_C.salario*.16) as iva_sueldo
from Empleado_C 
right join puesto_b on Empleado_C.id_puesto=puesto_b.id_puesto
where Empleado_C.id_puesto=puesto_b.id_puesto
group by Empleado_C.id_empleado, puesto_b.n_puesto, puesto_b.nivel, Empleado_C.salario)' 
GO
/****** Object:  Table [dbo].[Sucursal_C]    Script Date: 26/10/2018 01:36:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Sucursal_C]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Sucursal_C](
	[id_sucursal] [int] NOT NULL,
	[id_telefono] [int] NULL,
	[codigo_p] [int] NULL,
	[id_direccion] [int] NULL,
	[id_listaE] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_sucursal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Caja_E]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Caja_E]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Caja_E](
	[id_compra] [int] NOT NULL,
	[FyH] [datetime] NULL,
	[monto] [money] NULL,
	[pago] [money] NULL,
	[id_sucursal] [int] NULL,
	[id_Factura] [int] NULL,
	[cambio]  AS ([pago]-[monto]),
PRIMARY KEY CLUSTERED 
(
	[id_compra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  View [dbo].[ReporteVentas1]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ReporteVentas1]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[ReporteVentas1] as (
select Caja_E.id_compra, Caja_E.FyH, Sucursal_C.id_sucursal, Caja_E.cambio, Caja_E.monto, Caja_E.pago, sum(Caja_E.monto*.16) as iva_pago 
from Caja_E
right join Sucursal_C on Sucursal_C.id_sucursal= Caja_E.id_sucursal
group by Caja_E.id_compra, Caja_E.FyH, Sucursal_C.id_sucursal, Caja_E.cambio, Caja_E.monto, Caja_E.pago)' 
GO
/****** Object:  Table [dbo].[Proveedor_E]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Proveedor_E]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Proveedor_E](
	[id_proveedor] [int] NOT NULL,
	[RFC] [int] NULL,
	[n_comercial] [varchar](50) NULL,
	[n_oficial] [varchar](50) NULL,
	[id_direccion] [int] NULL,
	[id_insumo] [int] NULL,
	[id_telefono] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  View [dbo].[ReporteEmpleado1]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ReporteEmpleado1]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[ReporteEmpleado1] as (
select Proveedor_E.id_proveedor,Proveedor_E.RFC ,Proveedor_E.n_comercial,direccion_b.numero, 
direccion_b.calle, direccion_b.municipio, direccion_b.estado, telefono_a.num_telefono, Producto_B.costo_compra, MAX( Producto_B.costo_compra*.16) as IVA_compra
from Proveedor_E, telefono_a, Almacen_C,Producto_B
left join direccion_b on direccion_b.id_direccion=id_direccion
where (Proveedor_E.id_direccion=direccion_b.id_direccion) and (Proveedor_E.id_telefono = telefono_a.id_telefono) and (Proveedor_E.id_proveedor=Producto_B.id_proveedor)
group by Proveedor_E.id_proveedor,Proveedor_E.RFC ,Proveedor_E.n_comercial,direccion_b.numero, 
direccion_b.calle, direccion_b.municipio, direccion_b.estado, telefono_a.num_telefono, Producto_B.costo_compra)' 
GO
/****** Object:  View [dbo].[hj]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[hj]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[hj]
as (select id_empleado, nombre, id_puesto, id_telefono
from Empleado_C 
where id_empleado=2489562)' 
GO
/****** Object:  View [dbo].[Emp]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[Emp]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[Emp]
as (select id_empleado, nombre, id_puesto, id_telefono
from Empleado_C 
where id_empleado=2489562)' 
GO
/****** Object:  View [dbo].[Puestos]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[Puestos]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[Puestos] as (
select Empleado_C.id_empleado, puesto_b.n_puesto, puesto_b.nivel, Empleado_C.salario, sum(Empleado_C.salario*.16) as iva_sueldo
from Empleado_C right join puesto_b on Empleado_C.id_puesto=puesto_b.id_puesto
where Empleado_C.id_puesto=puesto_b.id_puesto
group by Empleado_C.id_empleado, puesto_b.n_puesto, puesto_b.nivel, Empleado_C.salario)
' 
GO
/****** Object:  View [dbo].[ReporteVentas]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ReporteVentas]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[ReporteVentas] as (
select Caja_E.id_compra, Caja_E.FyH, Sucursal_C.id_sucursal, Caja_E.cambio, Caja_E.monto, Caja_E.pago, sum(Caja_E.monto*.16) as iva_pago 
from Caja_E
right join Sucursal_C on Sucursal_C.id_sucursal= Caja_E.id_sucursal
group by Caja_E.id_compra, Caja_E.FyH, Sucursal_C.id_sucursal, Caja_E.cambio, Caja_E.monto, Caja_E.pago)' 
GO
/****** Object:  View [dbo].[ReporteEmpleado]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ReporteEmpleado]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[ReporteEmpleado] as (
select Proveedor_E.id_proveedor,Proveedor_E.RFC ,Proveedor_E.n_comercial,direccion_b.numero, 
direccion_b.calle, direccion_b.municipio, direccion_b.estado, telefono_a.num_telefono
from Proveedor_E, telefono_a, Almacen_C
left join direccion_b on direccion_b.id_direccion=id_direccion
where (Proveedor_E.id_direccion=direccion_b.id_direccion) and (Proveedor_E.id_telefono = telefono_a.id_telefono)
group by Proveedor_E.id_proveedor,Proveedor_E.RFC ,Proveedor_E.n_comercial,direccion_b.numero, 
direccion_b.calle, direccion_b.municipio, direccion_b.estado, telefono_a.num_telefono)' 
GO
/****** Object:  Table [dbo].[listaEmpleado]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[listaEmpleado]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[listaEmpleado](
	[id_sucursal] [int] NULL,
	[id_empleado] [int] NULL
) ON [PRIMARY]
END
GO
/****** Object:  View [dbo].[EmpleadosEnTienda]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[EmpleadosEnTienda]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[EmpleadosEnTienda] as (
	SELECT Sucursal_C.id_sucursal, Empleado_C.nombre, listaEmpleado.id_empleado from Empleado_C, Sucursal_C left join listaEmpleado on id_empleado = listaEmpleado.id_empleado
	WHERE (Empleado_C.id_empleado = listaEmpleado.id_empleado) AND Sucursal_C.id_sucursal = listaEmpleado.id_sucursal
	GROUP BY Sucursal_C.id_sucursal, Empleado_C.nombre, listaEmpleado.id_empleado
)' 
GO
/****** Object:  Table [dbo].[Servicio_Descripcion]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Servicio_Descripcion]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Servicio_Descripcion](
	[id_Servicio] [int] NOT NULL,
	[Descripcion] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_Servicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Servicios1]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Servicios1]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Servicios1](
	[id_S] [int] NOT NULL,
	[id_proveedor] [int] NULL,
	[id_Servicio] [int] NULL,
	[id_Domicilio] [int] NULL,
	[Costo] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_S] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  View [dbo].[ReporteCostoTipoServicio]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ReporteCostoTipoServicio]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[ReporteCostoTipoServicio] as (
	SELECT Servicios1.id_S, Servicio_Descripcion.Descripcion, Servicios1.Costo from Servicios1 left join Servicio_Descripcion on Servicios1.id_Servicio = Servicio_Descripcion.id_Servicio
	GROUP BY Servicios1.id_S, Servicio_Descripcion.Descripcion, Servicios1.Costo
)
' 
GO
/****** Object:  View [dbo].[ReporteDireccionProveedores]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ReporteDireccionProveedores]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[ReporteDireccionProveedores] as (
	SELECT Proveedor_E.n_comercial, direccion_b.calle, direccion_b.numero , direccion_b.colonia, direccion_b.municipio, direccion_b.estado from Proveedor_E left join direccion_b on Proveedor_E.id_direccion = direccion_b.id_direccion
	GROUP BY Proveedor_E.n_comercial, direccion_b.calle, direccion_b.numero , direccion_b.colonia, direccion_b.municipio, direccion_b.estado
)' 
GO
/****** Object:  View [dbo].[ReporteDireccionEmpleados]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ReporteDireccionEmpleados]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[ReporteDireccionEmpleados] as (
	SELECT Empleado_C.nombre, direccion_b.calle, direccion_b.numero , direccion_b.colonia, direccion_b.municipio, direccion_b.estado from Empleado_C left join direccion_b on Empleado_C.id_direccion = direccion_b.id_direccion
	GROUP BY Empleado_C.nombre, direccion_b.calle, direccion_b.numero , direccion_b.colonia, direccion_b.municipio, direccion_b.estado
)
' 
GO
/****** Object:  View [dbo].[ReporteTelefonosEmpleados]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ReporteTelefonosEmpleados]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [dbo].[ReporteTelefonosEmpleados] as (
	SELECT Empleado_C.nombre, telefono_a.zona, telefono_a.num_telefono from Empleado_C left join telefono_a on Empleado_C.id_telefono = telefono_a.id_telefono
	GROUP BY Empleado_C.nombre, telefono_a.zona, telefono_a.num_telefono
)' 
GO
/****** Object:  View [dbo].[Reporte_Almacen]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  Table [dbo].[Detalle_Factura2]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Detalle_Factura2]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Detalle_Factura2](
	[id_Factura] [int] NULL,
	[codigo_articulo] [int] NULL,
	[Cantidad] [decimal](18, 0) NULL,
	[Importe] [decimal](18, 0) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Empleados]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Empleados]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Empleados](
	[id_empleado] [int] NOT NULL,
	[nombre] [varchar](50) NULL,
	[foto] [image] NULL,
	[edad] [int] NULL,
	[estatura] [decimal](18, 0) NULL,
	[peso] [decimal](18, 0) NULL,
	[id_direccion] [int] NULL,
	[id_telefono] [int] NULL,
	[sexo] [bit] NULL,
	[salario] [money] NULL,
	[id_puesto] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Factura2]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Factura2]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Factura2](
	[id_Factura] [int] NOT NULL,
	[codigo_cliente] [int] NULL,
	[fecha_factura] [date] NULL,
	[id_tipoP] [int] NULL,
	[id_IVA] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_Factura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[insumo_a]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[insumo_a]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[insumo_a](
	[id_insumo] [int] NULL,
	[id_producto] [int] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[IVA]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IVA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IVA](
	[id_IVA] [int] NOT NULL,
	[Tipo] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_IVA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[listaC_C]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[listaC_C]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[listaC_C](
	[id_compra] [int] NULL,
	[producto_id] [int] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Logs]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Logs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Logs](
	[id_log] [varchar](500) NULL,
	[fecha_borradoFactura] [datetime] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Respaldo_E]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Respaldo_E]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Respaldo_E](
	[id_empleado] [int] NOT NULL,
	[nombre] [varchar](50) NULL,
	[foto] [image] NULL,
	[edad] [int] NULL,
	[estatura] [decimal](18, 0) NULL,
	[peso] [decimal](18, 0) NULL,
	[id_direccion] [int] NULL,
	[id_telefono] [int] NULL,
	[sexo] [bit] NULL,
	[salario] [money] NULL,
	[id_puesto] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Respaldo_Emplados2]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Respaldo_Emplados2]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Respaldo_Emplados2](
	[id_empleado] [int] NOT NULL,
	[nombre] [varchar](50) NULL,
	[foto] [image] NULL,
	[edad] [int] NULL,
	[estatura] [decimal](18, 0) NULL,
	[peso] [decimal](18, 0) NULL,
	[id_direccion] [int] NULL,
	[id_telefono] [int] NULL,
	[sexo] [bit] NULL,
	[salario] [money] NULL,
	[id_puesto] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Respaldo_Empleados]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Respaldo_Empleados]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Respaldo_Empleados](
	[id_empleado] [int] NOT NULL,
	[nombre] [varchar](50) NULL,
	[foto] [image] NULL,
	[edad] [int] NULL,
	[estatura] [decimal](18, 0) NULL,
	[peso] [decimal](18, 0) NULL,
	[id_direccion] [int] NULL,
	[id_telefono] [int] NULL,
	[sexo] [bit] NULL,
	[salario] [money] NULL,
	[id_puesto] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[TipoPagoFacura]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TipoPagoFacura]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TipoPagoFacura](
	[id_tipoP] [int] NOT NULL,
	[Tipo] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_tipoP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
INSERT [dbo].[Almacen_C] ([registro], [Fecha], [id_producto], [Existencia]) VALUES (178969, CAST(N'2018-10-22' AS Date), 98636, 10)
INSERT [dbo].[Almacen_C] ([registro], [Fecha], [id_producto], [Existencia]) VALUES (178970, CAST(N'2018-10-08' AS Date), 98636, 69)
INSERT [dbo].[Categoria] ([id_Categoria], [nombre], [descripcion]) VALUES (4565, N'dulce', N'zona de dulces')
INSERT [dbo].[Detalle_Factura2] ([id_Factura], [codigo_articulo], [Cantidad], [Importe]) VALUES (444665, 34745656, CAST(3 AS Decimal(18, 0)), CAST(100 AS Decimal(18, 0)))
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (11288, N'calle2', 332, N'colonia4', N'municipio1', N'NL', N'MX')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (11289, N'calle2', 788, N'colonia2', N'municipio3', N'NL', N'MX')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (22392, N'calle3', 102, N'colonia2', N'municipio2', N'NL', N'MX')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (22393, N'calle3', 889, N'colonia2', N'municipio3', N'NL', N'MX')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (48788, N'calle1', 784, N'colonia4', N'municipio4', N'NL', N'MX')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (48789, N'calle4', 115, N'colonia1', N'municipio2', N'NL', N'MX')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (56701, N'calle1', 756, N'colonia 1', N'municipio 1', N'NL', N'Mexico')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (56703, N'calle3', 785, N'colonia2', N'municipio2', N'NL', N'MX')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (56800, N'calle2', 896, N'colonia 2', N'municipio 2', N'NL', N'Mexico')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (56841, N'calle4', 756, N'colonia1', N'municipio1', N'NL', N'MX')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (56870, N'calle1', 744, N'colonia4', N'municipio3', N'NL', N'MX')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (56902, N'calle3', 146, N'colonia 3', N'municipio 3', N'NL', N'Mexico')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (57003, N'calle4', 898, N'colonia 4', N'municipio 4', N'NL', N'Mexico')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (58004, N'calle5', 898, N'colonia 5', N'municipio 5', N'NL', N'Mexico')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (58044, N'calle3', 986, N'colonia1', N'municipio3', N'NL', N'MX')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (58045, N'calle2', 454, N'colonia2', N'municipio2', N'NL', N'MX')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (58086, N'calle3', 149, N'colonia2', N'municipio4', N'NL', N'MX')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (59005, N'calle6', 632, N'colonia 6', N'municipio 6', N'NL', N'Mexico')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (59086, N'calle3', 149, N'colonia2', N'municipio4', N'NL', N'MX')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (60006, N'calle7', 956, N'colonia 7', N'municipio 7', N'NL', N'Mexico')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (60007, N'calle4', 237, N'colonia4', N'municipio4', N'NL', N'MX')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (61007, N'calle8', 365, N'colonia 8', N'municipio 8', N'NL', N'Mexico')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (61008, N'calle1', 172, N'colonia3', N'municipio1', N'NL', N'MX')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (61009, N'calle1', 200, N'colonia3', N'municipio1', N'NL', N'MX')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (62008, N'calle9', 69, N'colonia 9', N'municipio 9', N'NL', N'Mexico')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (63009, N'calle10', 14, N'colonia 10', N'municipio 10', N'NL', N'Mexico')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (64010, N'calle11', 412, N'colonia 11', N'municipio 11', N'NL', N'Mexico')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (65011, N'calle12', 501, N'colonia 12', N'municipio 12', N'NL', N'Mexico')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (66012, N'calle13', 212, N'colonia 13', N'municipio 13', N'NL', N'Mexico')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (67013, N'calle14', 582, N'colonia 14', N'municipio 14', N'NL', N'Mexico')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (68014, N'calle15', 789, N'colonia 15', N'municipio 15', N'NL', N'Mexico')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (69015, N'calle16', 982, N'colonia 16', N'municipio 16', N'NL', N'Mexico')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (70016, N'calle17', 301, N'colonia 17', N'municipio 17', N'NL', N'Mexico')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (70089, N'calle2', 199, N'colonia3', N'municipio2', N'NL', N'MX')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (71017, N'calle18', 658, N'colonia 18', N'municipio 18', N'NL', N'Mexico')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (72018, N'calle19', 236, N'colonia 19', N'municipio 19', N'NL', N'Mexico')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (77841, N'calle4', 145, N'colonia3', N'municipio1', N'NL', N'MX')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (77842, N'calle4', 963, N'colonia1', N'municipio1', N'NL', N'MX')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (86771, N'calle2', 804, N'colonia3', N'municipio3', N'NL', N'MX')
INSERT [dbo].[direccion_b] ([id_direccion], [calle], [numero], [colonia], [municipio], [estado], [pais]) VALUES (90014, N'calle1', 458, N'colonia4', N'municipio4', N'NL', N'MX')
INSERT [dbo].[Empleado_C] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (1225478, N'Fernando Cepeda', NULL, 19, CAST(2 AS Decimal(18, 0)), CAST(65 AS Decimal(18, 0)), 58045, 95805, 0, 15000.0000, 45698)
INSERT [dbo].[Empleado_C] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (1244787, N'Gonzalo Yado', NULL, 23, CAST(2 AS Decimal(18, 0)), CAST(78 AS Decimal(18, 0)), 70089, 45601, 0, 21000.0000, 69654)
INSERT [dbo].[Empleado_C] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (1458544, N'Jennifer Gonzalez', NULL, 32, CAST(2 AS Decimal(18, 0)), CAST(85 AS Decimal(18, 0)), 11288, 45034, 1, 15000.0000, 45698)
INSERT [dbo].[Empleado_C] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (2489562, N'Sebas Sierra', NULL, 21, CAST(2 AS Decimal(18, 0)), CAST(60 AS Decimal(18, 0)), 64010, 66410, 1, 25000.0000, 36971)
INSERT [dbo].[Empleado_C] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (3256899, N'Jesus Zavala', NULL, 22, CAST(2 AS Decimal(18, 0)), CAST(65 AS Decimal(18, 0)), 60007, 66007, 0, 20000.0000, 69654)
INSERT [dbo].[Empleado_C] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (3358788, N'Ricardo Ofarril', NULL, 31, CAST(2 AS Decimal(18, 0)), CAST(75 AS Decimal(18, 0)), 61008, 66108, 0, 30000.0000, 76767)
INSERT [dbo].[Empleado_C] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (3358798, N'Ricardo Ofarril', NULL, 31, CAST(2 AS Decimal(18, 0)), CAST(75 AS Decimal(18, 0)), 61008, 66108, 0, 30000.0000, 76767)
INSERT [dbo].[Empleado_C] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (3691587, N'Ana S Pulido', NULL, 18, CAST(2 AS Decimal(18, 0)), CAST(80 AS Decimal(18, 0)), 63009, 66309, 1, 25000.0000, 36971)
INSERT [dbo].[Empleado_C] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (4125877, N'Teresa Urbina', NULL, 24, CAST(2 AS Decimal(18, 0)), CAST(59 AS Decimal(18, 0)), 59086, 95906, 1, 10000.0000, 13658)
INSERT [dbo].[Empleado_C] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (4896258, N'Erik T Garcia', NULL, 23, CAST(2 AS Decimal(18, 0)), CAST(60 AS Decimal(18, 0)), 66012, 66612, 0, 5000.0000, 13658)
INSERT [dbo].[Empleado_C] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (5896243, N'Alberto A Gonzalez', NULL, 19, CAST(2 AS Decimal(18, 0)), CAST(85 AS Decimal(18, 0)), 65011, 66511, 1, 15000.0000, 45698)
INSERT [dbo].[Empleado_C] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (6987459, N'Pedro A Martinez', NULL, 20, CAST(2 AS Decimal(18, 0)), CAST(90 AS Decimal(18, 0)), 62008, 66208, 0, 35000.0000, 76767)
INSERT [dbo].[Empleado_C] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (7621562, N'Tennet Aguirre', NULL, 19, CAST(2 AS Decimal(18, 0)), CAST(65 AS Decimal(18, 0)), 72018, 67218, 1, 35000.0000, 36971)
INSERT [dbo].[Empleado_C] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (7627862, N'Tomás Rodriguez', NULL, 19, CAST(2 AS Decimal(18, 0)), CAST(85 AS Decimal(18, 0)), 77842, 45301, 0, 35000.0000, 76767)
INSERT [dbo].[Empleado_C] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (7854588, N'Hector Trejo', NULL, 25, CAST(2 AS Decimal(18, 0)), CAST(80 AS Decimal(18, 0)), 22393, 56801, 0, 25000.0000, 36971)
INSERT [dbo].[Empleado_C] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (8897548, N'Yewen Zaho', NULL, 21, CAST(2 AS Decimal(18, 0)), CAST(82 AS Decimal(18, 0)), 61009, 67108, 0, 22000.0000, 69654)
INSERT [dbo].[Empleado_C] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (9865188, N'Samuel K García ', NULL, 36, CAST(2 AS Decimal(18, 0)), CAST(85 AS Decimal(18, 0)), 67013, 66713, 0, 45000.0000, 76767)
INSERT [dbo].[Empleado_C] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (9865288, N'Sebastian Suarez', NULL, 36, CAST(2 AS Decimal(18, 0)), CAST(85 AS Decimal(18, 0)), 48789, 45890, 0, 25000.0000, 36971)
INSERT [dbo].[Empleados] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (2489562, N'Sebas Sierra', NULL, 21, CAST(2 AS Decimal(18, 0)), CAST(60 AS Decimal(18, 0)), 64010, 66410, 1, 25000.0000, 36971)
INSERT [dbo].[Empleados] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (3691587, N'Ana S Pulido', NULL, 18, CAST(2 AS Decimal(18, 0)), CAST(80 AS Decimal(18, 0)), 63009, 66309, 1, 25000.0000, 36971)
INSERT [dbo].[Empleados] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (4896258, N'Erik T Garcia', NULL, 23, CAST(2 AS Decimal(18, 0)), CAST(60 AS Decimal(18, 0)), 66012, 66612, 0, 5000.0000, 13658)
INSERT [dbo].[Empleados] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (5896243, N'Alberto A Gonzalez', NULL, 19, CAST(2 AS Decimal(18, 0)), CAST(85 AS Decimal(18, 0)), 65011, 66511, 1, 15000.0000, 45698)
INSERT [dbo].[Empleados] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (6987459, N'Pedro A Martinez', NULL, 20, CAST(2 AS Decimal(18, 0)), CAST(90 AS Decimal(18, 0)), 62008, 66208, 0, 35000.0000, 76767)
INSERT [dbo].[Empleados] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (7621562, N'Tennet Aguirre', NULL, 19, CAST(2 AS Decimal(18, 0)), CAST(65 AS Decimal(18, 0)), 72018, 67218, 1, 35000.0000, 36971)
INSERT [dbo].[Empleados] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (9865188, N'Samuel K García ', NULL, 36, CAST(2 AS Decimal(18, 0)), CAST(85 AS Decimal(18, 0)), 67013, 66713, 0, 45000.0000, 76767)
INSERT [dbo].[Factura2] ([id_Factura], [codigo_cliente], [fecha_factura], [id_tipoP], [id_IVA]) VALUES (444663, 119434, CAST(N'2018-10-24' AS Date), 22771, 11771)
INSERT [dbo].[Factura2] ([id_Factura], [codigo_cliente], [fecha_factura], [id_tipoP], [id_IVA]) VALUES (444665, 119435, CAST(N'2018-10-25' AS Date), 22771, 11771)
INSERT [dbo].[insumo_a] ([id_insumo], [id_producto]) VALUES (45100, 56800)
INSERT [dbo].[insumo_a] ([id_insumo], [id_producto]) VALUES (45200, 56701)
INSERT [dbo].[insumo_a] ([id_insumo], [id_producto]) VALUES (45300, 86771)
INSERT [dbo].[insumo_a] ([id_insumo], [id_producto]) VALUES (45400, 90014)
INSERT [dbo].[insumo_a] ([id_insumo], [id_producto]) VALUES (45500, 56870)
INSERT [dbo].[insumo_a] ([id_insumo], [id_producto]) VALUES (45600, 48788)
INSERT [dbo].[insumo_a] ([id_insumo], [id_producto]) VALUES (45700, 77841)
INSERT [dbo].[insumo_a] ([id_insumo], [id_producto]) VALUES (45800, 22392)
INSERT [dbo].[insumo_a] ([id_insumo], [id_producto]) VALUES (45900, 11289)
INSERT [dbo].[insumo_a] ([id_insumo], [id_producto]) VALUES (46100, 58044)
INSERT [dbo].[insumo_a] ([id_insumo], [id_producto]) VALUES (46200, 59085)
INSERT [dbo].[insumo_a] ([id_insumo], [id_producto]) VALUES (46300, 60006)
INSERT [dbo].[insumo_a] ([id_insumo], [id_producto]) VALUES (46400, 61007)
INSERT [dbo].[insumo_a] ([id_insumo], [id_producto]) VALUES (46500, 70088)
INSERT [dbo].[insumo_a] ([id_insumo], [id_producto]) VALUES (46600, 61007)
INSERT [dbo].[IVA] ([id_IVA], [Tipo]) VALUES (11771, N'General_20%')
INSERT [dbo].[IVA] ([id_IVA], [Tipo]) VALUES (11772, N'Reducido_10%')
INSERT [dbo].[IVA] ([id_IVA], [Tipo]) VALUES (11773, N'Superreducido_4%')
INSERT [dbo].[listaEmpleado] ([id_sucursal], [id_empleado]) VALUES (3654219, 6987459)
INSERT [dbo].[listaEmpleado] ([id_sucursal], [id_empleado]) VALUES (9654845, 3691587)
INSERT [dbo].[listaEmpleado] ([id_sucursal], [id_empleado]) VALUES (9654845, 2489562)
INSERT [dbo].[listaEmpleado] ([id_sucursal], [id_empleado]) VALUES (3654219, 5896243)
INSERT [dbo].[listaEmpleado] ([id_sucursal], [id_empleado]) VALUES (3654219, 5245463)
INSERT [dbo].[Logs] ([id_log], [fecha_borradoFactura]) VALUES (N'4E3B27DA-7383-46A9-B4CA-AA921D590904', CAST(N'2018-10-25T11:22:06.550' AS DateTime))
INSERT [dbo].[Producto_B] ([id_producto], [nombre], [costo_compra], [precio_venta], [id_Categoria], [id_proveedor], [descripcion]) VALUES (98636, N'paleta', CAST(5 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)), 4565, 122565, N'paleta dulce')
INSERT [dbo].[Proveedor_E] ([id_proveedor], [RFC], [n_comercial], [n_oficial], [id_direccion], [id_insumo], [id_telefono]) VALUES (120045, 12004, N'Apple', N'662', 48788, 56870, 45899)
INSERT [dbo].[Proveedor_E] ([id_proveedor], [RFC], [n_comercial], [n_oficial], [id_direccion], [id_insumo], [id_telefono]) VALUES (121214, 32133, N'LG', N'663', 77841, 56800, 45300)
INSERT [dbo].[Proveedor_E] ([id_proveedor], [RFC], [n_comercial], [n_oficial], [id_direccion], [id_insumo], [id_telefono]) VALUES (122565, 85568, N'Gamesa', N'678', 56701, 45300, 65501)
INSERT [dbo].[Proveedor_E] ([id_proveedor], [RFC], [n_comercial], [n_oficial], [id_direccion], [id_insumo], [id_telefono]) VALUES (236984, 21365, N'Nescafe', N'564', 60006, 45906, 66006)
INSERT [dbo].[Proveedor_E] ([id_proveedor], [RFC], [n_comercial], [n_oficial], [id_direccion], [id_insumo], [id_telefono]) VALUES (248989, 23324, N'coca', N'657', 56800, 45300, 65400)
INSERT [dbo].[Proveedor_E] ([id_proveedor], [RFC], [n_comercial], [n_oficial], [id_direccion], [id_insumo], [id_telefono]) VALUES (249631, 23356, N'Pepsi', N'657', 56800, 45300, 65400)
INSERT [dbo].[Proveedor_E] ([id_proveedor], [RFC], [n_comercial], [n_oficial], [id_direccion], [id_insumo], [id_telefono]) VALUES (279315, 28964, N'Matel', N'145', 57003, 45603, 65703)
INSERT [dbo].[Proveedor_E] ([id_proveedor], [RFC], [n_comercial], [n_oficial], [id_direccion], [id_insumo], [id_telefono]) VALUES (282536, 85589, N'LG', N'158', 56902, 45603, 65602)
INSERT [dbo].[Proveedor_E] ([id_proveedor], [RFC], [n_comercial], [n_oficial], [id_direccion], [id_insumo], [id_telefono]) VALUES (369845, 42565, N'LALA', N'789', 58044, 54704, 95804)
INSERT [dbo].[Proveedor_E] ([id_proveedor], [RFC], [n_comercial], [n_oficial], [id_direccion], [id_insumo], [id_telefono]) VALUES (468521, 79355, N'Made', N'316', 59005, 45805, 65905)
INSERT [dbo].[Proveedor_E] ([id_proveedor], [RFC], [n_comercial], [n_oficial], [id_direccion], [id_insumo], [id_telefono]) VALUES (602287, 53021, N'Acer', N'661', 56870, 12547, 12896)
INSERT [dbo].[Proveedor_E] ([id_proveedor], [RFC], [n_comercial], [n_oficial], [id_direccion], [id_insumo], [id_telefono]) VALUES (638021, 77001, N'Sabritas', N'660', 56701, 45899, 1175)
INSERT [dbo].[Proveedor_E] ([id_proveedor], [RFC], [n_comercial], [n_oficial], [id_direccion], [id_insumo], [id_telefono]) VALUES (658955, 26525, N'Apple', N'279', 61007, 46007, 66107)
INSERT [dbo].[Proveedor_E] ([id_proveedor], [RFC], [n_comercial], [n_oficial], [id_direccion], [id_insumo], [id_telefono]) VALUES (694989, 98499, N'huawei', N'365', 66012, 46007, 66410)
INSERT [dbo].[Proveedor_E] ([id_proveedor], [RFC], [n_comercial], [n_oficial], [id_direccion], [id_insumo], [id_telefono]) VALUES (781125, 11452, N'Coca-Cola', N'658', 56701, 45401, 65501)
INSERT [dbo].[Proveedor_E] ([id_proveedor], [RFC], [n_comercial], [n_oficial], [id_direccion], [id_insumo], [id_telefono]) VALUES (785998, 45577, N'Gamesa', N'659', 86771, 45771, 67800)
INSERT [dbo].[Proveedor_E] ([id_proveedor], [RFC], [n_comercial], [n_oficial], [id_direccion], [id_insumo], [id_telefono]) VALUES (859599, 44787, N'Purina', N'665', 11289, 56088, 45033)
INSERT [dbo].[Proveedor_E] ([id_proveedor], [RFC], [n_comercial], [n_oficial], [id_direccion], [id_insumo], [id_telefono]) VALUES (986663, 69359, N'Xiaomi', N'799', 67013, 46007, 66511)
INSERT [dbo].[Proveedor_E] ([id_proveedor], [RFC], [n_comercial], [n_oficial], [id_direccion], [id_insumo], [id_telefono]) VALUES (996541, 11258, N'Motorola', N'664', 22392, 77841, 56800)
INSERT [dbo].[puesto_b] ([id_puesto], [n_puesto], [nivel]) VALUES (13658, N'Paquetero', 1)
INSERT [dbo].[puesto_b] ([id_puesto], [n_puesto], [nivel]) VALUES (36971, N'Tesorero', 3)
INSERT [dbo].[puesto_b] ([id_puesto], [n_puesto], [nivel]) VALUES (45698, N'Cajero', 2)
INSERT [dbo].[puesto_b] ([id_puesto], [n_puesto], [nivel]) VALUES (69654, N'Administrador', 2)
INSERT [dbo].[puesto_b] ([id_puesto], [n_puesto], [nivel]) VALUES (76767, N'Gerente', 3)
INSERT [dbo].[Respaldo_E] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (2489562, N'Sebas Sierra', NULL, 21, CAST(2 AS Decimal(18, 0)), CAST(60 AS Decimal(18, 0)), 64010, 66410, 1, 25000.0000, 36971)
INSERT [dbo].[Respaldo_E] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (3691587, N'Ana S Pulido', NULL, 18, CAST(2 AS Decimal(18, 0)), CAST(80 AS Decimal(18, 0)), 63009, 66309, 1, 25000.0000, 36971)
INSERT [dbo].[Respaldo_E] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (4896258, N'Erik T Garcia', NULL, 23, CAST(2 AS Decimal(18, 0)), CAST(60 AS Decimal(18, 0)), 66012, 66612, 0, 5000.0000, 13658)
INSERT [dbo].[Respaldo_E] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (5896243, N'Alberto A Gonzalez', NULL, 19, CAST(2 AS Decimal(18, 0)), CAST(85 AS Decimal(18, 0)), 65011, 66511, 1, 15000.0000, 45698)
INSERT [dbo].[Respaldo_E] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (6987459, N'Pedro A Martinez', NULL, 20, CAST(2 AS Decimal(18, 0)), CAST(90 AS Decimal(18, 0)), 62008, 66208, 0, 35000.0000, 76767)
INSERT [dbo].[Respaldo_E] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (7621562, N'Tennet Aguirre', NULL, 19, CAST(2 AS Decimal(18, 0)), CAST(65 AS Decimal(18, 0)), 72018, 67218, 1, 35000.0000, 36971)
INSERT [dbo].[Respaldo_E] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (9865188, N'Samuel K García ', NULL, 36, CAST(2 AS Decimal(18, 0)), CAST(85 AS Decimal(18, 0)), 67013, 66713, 0, 45000.0000, 76767)
INSERT [dbo].[Respaldo_Empleados] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (2489562, N'Sebas Sierra', NULL, 21, CAST(2 AS Decimal(18, 0)), CAST(60 AS Decimal(18, 0)), 64010, 66410, 1, 25000.0000, 36971)
INSERT [dbo].[Respaldo_Empleados] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (3691587, N'Ana S Pulido', NULL, 18, CAST(2 AS Decimal(18, 0)), CAST(80 AS Decimal(18, 0)), 63009, 66309, 1, 25000.0000, 36971)
INSERT [dbo].[Respaldo_Empleados] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (4896258, N'Erik T Garcia', NULL, 23, CAST(2 AS Decimal(18, 0)), CAST(60 AS Decimal(18, 0)), 66012, 66612, 0, 5000.0000, 13658)
INSERT [dbo].[Respaldo_Empleados] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (5896243, N'Alberto A Gonzalez', NULL, 19, CAST(2 AS Decimal(18, 0)), CAST(85 AS Decimal(18, 0)), 65011, 66511, 1, 15000.0000, 45698)
INSERT [dbo].[Respaldo_Empleados] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (6987459, N'Pedro A Martinez', NULL, 20, CAST(2 AS Decimal(18, 0)), CAST(90 AS Decimal(18, 0)), 62008, 66208, 0, 35000.0000, 76767)
INSERT [dbo].[Respaldo_Empleados] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (7621562, N'Tennet Aguirre', NULL, 19, CAST(2 AS Decimal(18, 0)), CAST(65 AS Decimal(18, 0)), 72018, 67218, 1, 35000.0000, 36971)
INSERT [dbo].[Respaldo_Empleados] ([id_empleado], [nombre], [foto], [edad], [estatura], [peso], [id_direccion], [id_telefono], [sexo], [salario], [id_puesto]) VALUES (9865188, N'Samuel K García ', NULL, 36, CAST(2 AS Decimal(18, 0)), CAST(85 AS Decimal(18, 0)), 67013, 66713, 0, 45000.0000, 76767)
INSERT [dbo].[Servicio_Descripcion] ([id_Servicio], [Descripcion]) VALUES (765, N'Familiia CocaCola bebidas')
INSERT [dbo].[Servicio_Descripcion] ([id_Servicio], [Descripcion]) VALUES (766, N'Galletas, Dulces,Pasteles, gamesa')
INSERT [dbo].[Servicio_Descripcion] ([id_Servicio], [Descripcion]) VALUES (767, N'Papitas Fritas, Snacks, Sabritas')
INSERT [dbo].[Servicio_Descripcion] ([id_Servicio], [Descripcion]) VALUES (768, N'Zapatos, Ropa Deportiva Adidas')
INSERT [dbo].[Servicio_Descripcion] ([id_Servicio], [Descripcion]) VALUES (769, N'Diseño ropa, hombre y mujer , niños, Hiltfinger')
INSERT [dbo].[Servicio_Descripcion] ([id_Servicio], [Descripcion]) VALUES (770, N'Conchones Spring air')
INSERT [dbo].[Servicio_Descripcion] ([id_Servicio], [Descripcion]) VALUES (771, N'Carnes, Cortes carne')
INSERT [dbo].[Servicio_Descripcion] ([id_Servicio], [Descripcion]) VALUES (772, N'Laptops electronica Hewlett')
INSERT [dbo].[Servicio_Descripcion] ([id_Servicio], [Descripcion]) VALUES (773, N'Acer Electronicos')
INSERT [dbo].[Servicio_Descripcion] ([id_Servicio], [Descripcion]) VALUES (774, N'Asus Electronicos')
INSERT [dbo].[Servicio_Descripcion] ([id_Servicio], [Descripcion]) VALUES (775, N'Productos de origen lacteo Lala')
INSERT [dbo].[Servicio_Descripcion] ([id_Servicio], [Descripcion]) VALUES (776, N'Pan,galletas, Bimbo')
INSERT [dbo].[Servicio_Descripcion] ([id_Servicio], [Descripcion]) VALUES (777, N'Sistemas, componentes ,consolas Microsoft')
INSERT [dbo].[Servicio_Descripcion] ([id_Servicio], [Descripcion]) VALUES (778, N'Consolas. Productos Domesticos electronicos')
INSERT [dbo].[Servicio_Descripcion] ([id_Servicio], [Descripcion]) VALUES (779, N'Pinceles, utilies ')
INSERT [dbo].[Servicio_Descripcion] ([id_Servicio], [Descripcion]) VALUES (2001, N'Proveedor_CocaCola')
INSERT [dbo].[Servicio_Descripcion] ([id_Servicio], [Descripcion]) VALUES (2002, N'Proveedor_ACER_Computadoras')
INSERT [dbo].[Sucursal_C] ([id_sucursal], [id_telefono], [codigo_p], [id_direccion], [id_listaE]) VALUES (3521256, 67016, 30185, 70016, 485967)
INSERT [dbo].[Sucursal_C] ([id_sucursal], [id_telefono], [codigo_p], [id_direccion], [id_listaE]) VALUES (3654219, 66814, 66486, 68014, 485964)
INSERT [dbo].[Sucursal_C] ([id_sucursal], [id_telefono], [codigo_p], [id_direccion], [id_listaE]) VALUES (9654845, 66915, 92155, 69015, 485965)
INSERT [dbo].[Sucursal_C] ([id_sucursal], [id_telefono], [codigo_p], [id_direccion], [id_listaE]) VALUES (9658624, 67117, 21465, 71017, 485966)
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (1175, N'8187479858', N'52')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (12896, N'8110120356', N'52')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (45033, N'8121003663', N'52')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (45034, N'8121003663', N'52')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (45300, N'8189795785', N'52')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (45301, N'8189795785', N'52')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (45601, N'8189005050', N'52')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (45890, N'8118266553', N'52')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (45899, N'8118994563', N'52')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (56800, N'8124541010', N'52')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (56801, N'8124541010', N'52')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (65400, N'811456589465', N'32')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (65411, N'8114542112', N'52')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (65501, N'811596324896', N'32')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (65571, N'8114565894', N'52')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (65602, N'811796558961', N'32')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (65703, N'811586932147', N'32')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (65804, N'811981658954', N'32')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (65905, N'811456321798', N'32')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (66006, N'811231896485', N'32')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (66007, N'8123004568', N'52')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (66067, N'8123004568', N'52')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (66107, N'811693188745', N'32')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (66108, N'8128125555', N'52')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (66208, N'811398749961', N'32')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (66309, N'811493168469', N'32')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (66410, N'811315964586', N'32')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (66511, N'811698715952', N'32')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (66612, N'811258963147', N'32')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (66713, N'811741258936', N'32')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (66814, N'811896218324', N'32')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (66915, N'811314923547', N'32')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (67016, N'811031968416', N'32')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (67108, N'8114565800', N'52')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (67117, N'811031968416', N'32')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (67218, N'811145267596', N'32')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (67800, N'8124879665', N'52')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (95804, N'8112003698', N'52')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (95805, N'8112003698', N'52')
INSERT [dbo].[telefono_a] ([id_telefono], [num_telefono], [zona]) VALUES (95906, N'8118971002', N'52')
INSERT [dbo].[TipoPagoFacura] ([id_tipoP], [Tipo]) VALUES (22771, N'Effectivo')
INSERT [dbo].[TipoPagoFacura] ([id_tipoP], [Tipo]) VALUES (22772, N'Tarjeta_Credito')
/****** Object:  Index [IDX_AlmacenC]    Script Date: 26/10/2018 01:36:26 p. m. ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Almacen_C]') AND name = N'IDX_AlmacenC')
CREATE NONCLUSTERED INDEX [IDX_AlmacenC1] ON [dbo].[Almacen_C]
(
	[registro] ASC,
	[Fecha] ASC,
	[id_producto] ASC,
	[Existencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Caja_E]    Script Date: 26/10/2018 01:36:26 p. m. ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Caja_E]') AND name = N'Caja_E')
CREATE NONCLUSTERED INDEX [Caja_E1] ON [dbo].[Caja_E]
(
	[FyH] ASC,
	[monto] ASC,
	[id_sucursal] ASC,
	[id_Factura] ASC,
	[id_compra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_direccion]    Script Date: 26/10/2018 01:36:26 p. m. ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[direccion_b]') AND name = N'IDX_direccion')
CREATE NONCLUSTERED INDEX [IDX_direccion1] ON [dbo].[direccion_b]
(
	[id_direccion] ASC,
	[calle] ASC,
	[numero] ASC,
	[colonia] ASC,
	[municipio] ASC,
	[estado] ASC,
	[pais] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_Empleado]    Script Date: 26/10/2018 01:36:26 p. m. ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Empleado_C]') AND name = N'IDX_Empleado')
CREATE NONCLUSTERED INDEX [IDX_Empleado1] ON [dbo].[Empleado_C]
(
	[id_empleado] ASC,
	[nombre] ASC,
	[edad] ASC,
	[estatura] ASC,
	[peso] ASC,
	[id_direccion] ASC,
	[id_telefono] ASC,
	[sexo] ASC,
	[salario] ASC,
	[id_puesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_Empleado_C]    Script Date: 26/10/2018 01:36:26 p. m. ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Empleado_C]') AND name = N'IDX_Empleado_C')
CREATE NONCLUSTERED INDEX [IDX_Empleado_C1] ON [dbo].[Empleado_C]
(
	[id_empleado] ASC,
	[nombre] ASC,
	[edad] ASC,
	[estatura] ASC,
	[peso] ASC,
	[id_direccion] ASC,
	[id_telefono] ASC,
	[sexo] ASC,
	[salario] ASC,
	[id_puesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_Producto_B]    Script Date: 26/10/2018 01:36:26 p. m. ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Producto_B]') AND name = N'IDX_Producto_B')
CREATE NONCLUSTERED INDEX [IDX_Producto_B1] ON [dbo].[Producto_B]
(
	[id_producto] ASC,
	[nombre] ASC,
	[descripcion] ASC,
	[costo_compra] ASC,
	[id_proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_Proveedor_E]    Script Date: 26/10/2018 01:36:26 p. m. ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Proveedor_E]') AND name = N'IDX_Proveedor_E')
CREATE NONCLUSTERED INDEX [IDX_Proveedor_E1] ON [dbo].[Proveedor_E]
(
	[id_proveedor] ASC,
	[RFC] ASC,
	[n_comercial] ASC,
	[n_oficial] ASC,
	[id_insumo] ASC,
	[id_direccion] ASC,
	[id_telefono] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Almacen_C_Producto_B]') AND parent_object_id = OBJECT_ID(N'[dbo].[Almacen_C]'))
ALTER TABLE [dbo].[Almacen_C]  WITH CHECK ADD  CONSTRAINT [FK_Almacen_C_Producto_B] FOREIGN KEY([id_producto])
REFERENCES [dbo].[Producto_B] ([id_producto])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Almacen_C_Producto_B]') AND parent_object_id = OBJECT_ID(N'[dbo].[Almacen_C]'))
ALTER TABLE [dbo].[Almacen_C] CHECK CONSTRAINT [FK_Almacen_C_Producto_B]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Caja_E_Factura2]') AND parent_object_id = OBJECT_ID(N'[dbo].[Caja_E]'))
ALTER TABLE [dbo].[Caja_E]  WITH CHECK ADD  CONSTRAINT [FK_Caja_E_Factura2] FOREIGN KEY([id_Factura])
REFERENCES [dbo].[Factura2] ([id_Factura])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Caja_E_Factura2]') AND parent_object_id = OBJECT_ID(N'[dbo].[Caja_E]'))
ALTER TABLE [dbo].[Caja_E] CHECK CONSTRAINT [FK_Caja_E_Factura2]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Caja_E_Sucursal_C]') AND parent_object_id = OBJECT_ID(N'[dbo].[Caja_E]'))
ALTER TABLE [dbo].[Caja_E]  WITH CHECK ADD  CONSTRAINT [FK_Caja_E_Sucursal_C] FOREIGN KEY([id_sucursal])
REFERENCES [dbo].[Sucursal_C] ([id_sucursal])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Caja_E_Sucursal_C]') AND parent_object_id = OBJECT_ID(N'[dbo].[Caja_E]'))
ALTER TABLE [dbo].[Caja_E] CHECK CONSTRAINT [FK_Caja_E_Sucursal_C]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Detalle_Factura2_Factura2]') AND parent_object_id = OBJECT_ID(N'[dbo].[Detalle_Factura2]'))
ALTER TABLE [dbo].[Detalle_Factura2]  WITH CHECK ADD  CONSTRAINT [FK_Detalle_Factura2_Factura2] FOREIGN KEY([id_Factura])
REFERENCES [dbo].[Factura2] ([id_Factura])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Detalle_Factura2_Factura2]') AND parent_object_id = OBJECT_ID(N'[dbo].[Detalle_Factura2]'))
ALTER TABLE [dbo].[Detalle_Factura2] CHECK CONSTRAINT [FK_Detalle_Factura2_Factura2]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Empleado_C_direccion_b]') AND parent_object_id = OBJECT_ID(N'[dbo].[Empleado_C]'))
ALTER TABLE [dbo].[Empleado_C]  WITH CHECK ADD  CONSTRAINT [FK_Empleado_C_direccion_b] FOREIGN KEY([id_direccion])
REFERENCES [dbo].[direccion_b] ([id_direccion])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Empleado_C_direccion_b]') AND parent_object_id = OBJECT_ID(N'[dbo].[Empleado_C]'))
ALTER TABLE [dbo].[Empleado_C] CHECK CONSTRAINT [FK_Empleado_C_direccion_b]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Empleado_C_puesto_b]') AND parent_object_id = OBJECT_ID(N'[dbo].[Empleado_C]'))
ALTER TABLE [dbo].[Empleado_C]  WITH CHECK ADD  CONSTRAINT [FK_Empleado_C_puesto_b] FOREIGN KEY([id_puesto])
REFERENCES [dbo].[puesto_b] ([id_puesto])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Empleado_C_puesto_b]') AND parent_object_id = OBJECT_ID(N'[dbo].[Empleado_C]'))
ALTER TABLE [dbo].[Empleado_C] CHECK CONSTRAINT [FK_Empleado_C_puesto_b]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Empleado_C_telefono_a]') AND parent_object_id = OBJECT_ID(N'[dbo].[Empleado_C]'))
ALTER TABLE [dbo].[Empleado_C]  WITH CHECK ADD  CONSTRAINT [FK_Empleado_C_telefono_a] FOREIGN KEY([id_telefono])
REFERENCES [dbo].[telefono_a] ([id_telefono])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Empleado_C_telefono_a]') AND parent_object_id = OBJECT_ID(N'[dbo].[Empleado_C]'))
ALTER TABLE [dbo].[Empleado_C] CHECK CONSTRAINT [FK_Empleado_C_telefono_a]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Factura2_IVA]') AND parent_object_id = OBJECT_ID(N'[dbo].[Factura2]'))
ALTER TABLE [dbo].[Factura2]  WITH CHECK ADD  CONSTRAINT [FK_Factura2_IVA] FOREIGN KEY([id_IVA])
REFERENCES [dbo].[IVA] ([id_IVA])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Factura2_IVA]') AND parent_object_id = OBJECT_ID(N'[dbo].[Factura2]'))
ALTER TABLE [dbo].[Factura2] CHECK CONSTRAINT [FK_Factura2_IVA]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Factura2_TipoPagoFacura]') AND parent_object_id = OBJECT_ID(N'[dbo].[Factura2]'))
ALTER TABLE [dbo].[Factura2]  WITH CHECK ADD  CONSTRAINT [FK_Factura2_TipoPagoFacura] FOREIGN KEY([id_tipoP])
REFERENCES [dbo].[TipoPagoFacura] ([id_tipoP])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Factura2_TipoPagoFacura]') AND parent_object_id = OBJECT_ID(N'[dbo].[Factura2]'))
ALTER TABLE [dbo].[Factura2] CHECK CONSTRAINT [FK_Factura2_TipoPagoFacura]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_listaC_C_Caja_E]') AND parent_object_id = OBJECT_ID(N'[dbo].[listaC_C]'))
ALTER TABLE [dbo].[listaC_C]  WITH CHECK ADD  CONSTRAINT [FK_listaC_C_Caja_E] FOREIGN KEY([id_compra])
REFERENCES [dbo].[Caja_E] ([id_compra])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_listaC_C_Caja_E]') AND parent_object_id = OBJECT_ID(N'[dbo].[listaC_C]'))
ALTER TABLE [dbo].[listaC_C] CHECK CONSTRAINT [FK_listaC_C_Caja_E]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_listaEmpleado_Sucursal_C]') AND parent_object_id = OBJECT_ID(N'[dbo].[listaEmpleado]'))
ALTER TABLE [dbo].[listaEmpleado]  WITH CHECK ADD  CONSTRAINT [FK_listaEmpleado_Sucursal_C] FOREIGN KEY([id_sucursal])
REFERENCES [dbo].[Sucursal_C] ([id_sucursal])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_listaEmpleado_Sucursal_C]') AND parent_object_id = OBJECT_ID(N'[dbo].[listaEmpleado]'))
ALTER TABLE [dbo].[listaEmpleado] CHECK CONSTRAINT [FK_listaEmpleado_Sucursal_C]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Producto_B_Categoria]') AND parent_object_id = OBJECT_ID(N'[dbo].[Producto_B]'))
ALTER TABLE [dbo].[Producto_B]  WITH CHECK ADD  CONSTRAINT [FK_Producto_B_Categoria] FOREIGN KEY([id_Categoria])
REFERENCES [dbo].[Categoria] ([id_Categoria])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Producto_B_Categoria]') AND parent_object_id = OBJECT_ID(N'[dbo].[Producto_B]'))
ALTER TABLE [dbo].[Producto_B] CHECK CONSTRAINT [FK_Producto_B_Categoria]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Producto_B_Proveedor_E]') AND parent_object_id = OBJECT_ID(N'[dbo].[Producto_B]'))
ALTER TABLE [dbo].[Producto_B]  WITH CHECK ADD  CONSTRAINT [FK_Producto_B_Proveedor_E] FOREIGN KEY([id_proveedor])
REFERENCES [dbo].[Proveedor_E] ([id_proveedor])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Producto_B_Proveedor_E]') AND parent_object_id = OBJECT_ID(N'[dbo].[Producto_B]'))
ALTER TABLE [dbo].[Producto_B] CHECK CONSTRAINT [FK_Producto_B_Proveedor_E]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Proveedor_E_direccion_b]') AND parent_object_id = OBJECT_ID(N'[dbo].[Proveedor_E]'))
ALTER TABLE [dbo].[Proveedor_E]  WITH CHECK ADD  CONSTRAINT [FK_Proveedor_E_direccion_b] FOREIGN KEY([id_direccion])
REFERENCES [dbo].[direccion_b] ([id_direccion])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Proveedor_E_direccion_b]') AND parent_object_id = OBJECT_ID(N'[dbo].[Proveedor_E]'))
ALTER TABLE [dbo].[Proveedor_E] CHECK CONSTRAINT [FK_Proveedor_E_direccion_b]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Proveedor_E_telefono_a]') AND parent_object_id = OBJECT_ID(N'[dbo].[Proveedor_E]'))
ALTER TABLE [dbo].[Proveedor_E]  WITH CHECK ADD  CONSTRAINT [FK_Proveedor_E_telefono_a] FOREIGN KEY([id_telefono])
REFERENCES [dbo].[telefono_a] ([id_telefono])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Proveedor_E_telefono_a]') AND parent_object_id = OBJECT_ID(N'[dbo].[Proveedor_E]'))
ALTER TABLE [dbo].[Proveedor_E] CHECK CONSTRAINT [FK_Proveedor_E_telefono_a]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Servicios1_Proveedor_E]') AND parent_object_id = OBJECT_ID(N'[dbo].[Servicios1]'))
ALTER TABLE [dbo].[Servicios1]  WITH CHECK ADD  CONSTRAINT [FK_Servicios1_Proveedor_E] FOREIGN KEY([id_proveedor])
REFERENCES [dbo].[Proveedor_E] ([id_proveedor])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Servicios1_Proveedor_E]') AND parent_object_id = OBJECT_ID(N'[dbo].[Servicios1]'))
ALTER TABLE [dbo].[Servicios1] CHECK CONSTRAINT [FK_Servicios1_Proveedor_E]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Servicios1_Servicio_Descripcion]') AND parent_object_id = OBJECT_ID(N'[dbo].[Servicios1]'))
ALTER TABLE [dbo].[Servicios1]  WITH CHECK ADD  CONSTRAINT [FK_Servicios1_Servicio_Descripcion] FOREIGN KEY([id_Servicio])
REFERENCES [dbo].[Servicio_Descripcion] ([id_Servicio])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Servicios1_Servicio_Descripcion]') AND parent_object_id = OBJECT_ID(N'[dbo].[Servicios1]'))
ALTER TABLE [dbo].[Servicios1] CHECK CONSTRAINT [FK_Servicios1_Servicio_Descripcion]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Sucursal_C_direccion_b]') AND parent_object_id = OBJECT_ID(N'[dbo].[Sucursal_C]'))
ALTER TABLE [dbo].[Sucursal_C]  WITH CHECK ADD  CONSTRAINT [FK_Sucursal_C_direccion_b] FOREIGN KEY([id_direccion])
REFERENCES [dbo].[direccion_b] ([id_direccion])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Sucursal_C_direccion_b]') AND parent_object_id = OBJECT_ID(N'[dbo].[Sucursal_C]'))
ALTER TABLE [dbo].[Sucursal_C] CHECK CONSTRAINT [FK_Sucursal_C_direccion_b]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Sucursal_C_telefono_a]') AND parent_object_id = OBJECT_ID(N'[dbo].[Sucursal_C]'))
ALTER TABLE [dbo].[Sucursal_C]  WITH CHECK ADD  CONSTRAINT [FK_Sucursal_C_telefono_a] FOREIGN KEY([id_telefono])
REFERENCES [dbo].[telefono_a] ([id_telefono])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Sucursal_C_telefono_a]') AND parent_object_id = OBJECT_ID(N'[dbo].[Sucursal_C]'))
ALTER TABLE [dbo].[Sucursal_C] CHECK CONSTRAINT [FK_Sucursal_C_telefono_a]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[C_monto]') AND parent_object_id = OBJECT_ID(N'[dbo].[Caja_E]'))
ALTER TABLE [dbo].[Caja_E]  WITH CHECK ADD  CONSTRAINT [C_monto] CHECK  (([monto]>(0)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[C_monto]') AND parent_object_id = OBJECT_ID(N'[dbo].[Caja_E]'))
ALTER TABLE [dbo].[Caja_E] CHECK CONSTRAINT [C_monto]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[C_PAGO]') AND parent_object_id = OBJECT_ID(N'[dbo].[Caja_E]'))
ALTER TABLE [dbo].[Caja_E]  WITH CHECK ADD  CONSTRAINT [C_PAGO] CHECK  (([pago]>[monto]))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[C_PAGO]') AND parent_object_id = OBJECT_ID(N'[dbo].[Caja_E]'))
ALTER TABLE [dbo].[Caja_E] CHECK CONSTRAINT [C_PAGO]
GO
/****** Object:  StoredProcedure [dbo].[CANTIDADP]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CANTIDADP]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CANTIDADP] AS' 
END
GO

/****** Object:  StoredProcedure [dbo].[Edad_MayorQue]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Edad_MayorQue]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Edad_MayorQue] AS' 
END
GO
ALTER PROCEDURE [dbo].[Edad_MayorQue](@var1 int)
AS
BEGIN
	SELECT nombre FROM Empleado_C 
	WHERE edad >= @var1
END
GO
/****** Object:  StoredProcedure [dbo].[EMPLOYEE]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EMPLOYEE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EMPLOYEE] AS' 
END
GO
ALTER procedure [dbo].[EMPLOYEE] (@valor1 int)
as
begin
	select * from Empleado_C
	Where id_empleado = @valor1
end
GO
/****** Object:  StoredProcedure [dbo].[PR_DirEmpleado1]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PR_DirEmpleado1]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[PR_DirEmpleado1] AS' 
END
GO
ALTER PROCEDURE [dbo].[PR_DirEmpleado1](@valor4 int)
AS
BEGIN
	SELECT Empleado_C.nombre, direccion_b.calle, direccion_b.numero , direccion_b.colonia, direccion_b.municipio, direccion_b.estado from Empleado_C 
	left join direccion_b on Empleado_C.id_direccion = direccion_b.id_direccion
	WHERE Empleado_C.id_empleado = @valor4
	GROUP BY Empleado_C.nombre, direccion_b.calle, direccion_b.numero , direccion_b.colonia, direccion_b.municipio, direccion_b.estado
END
GO
/****** Object:  StoredProcedure [dbo].[PR_DirProveedores]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PR_DirProveedores]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[PR_DirProveedores] AS' 
END
GO
ALTER PROCEDURE [dbo].[PR_DirProveedores](@valor5 int)
AS
BEGIN
	SELECT Proveedor_E.n_comercial, direccion_b.calle, direccion_b.numero , direccion_b.colonia, direccion_b.municipio, direccion_b.estado from Proveedor_E left join direccion_b on Proveedor_E.id_direccion = direccion_b.id_direccion
	WHERE Proveedor_E.id_direccion = @valor5
	GROUP BY Proveedor_E.n_comercial, direccion_b.calle, direccion_b.numero , direccion_b.colonia, direccion_b.municipio, direccion_b.estado
END
GO
/****** Object:  StoredProcedure [dbo].[PR_EmpleadoEnTienda]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PR_EmpleadoEnTienda]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[PR_EmpleadoEnTienda] AS' 
END
GO
ALTER PROCEDURE [dbo].[PR_EmpleadoEnTienda](@valor1 int)
AS
BEGIN
	SELECT Sucursal_C.id_sucursal, Empleado_C.nombre, listaEmpleado.id_empleado from Empleado_C, Sucursal_C left join listaEmpleado on id_empleado = listaEmpleado.id_empleado
	WHERE (Empleado_C.id_empleado = listaEmpleado.id_empleado) AND Sucursal_C.id_sucursal = listaEmpleado.id_sucursal AND Empleado_C.id_empleado=@valor1
	GROUP BY Sucursal_C.id_sucursal, Empleado_C.nombre, listaEmpleado.id_empleado
END
GO
/****** Object:  StoredProcedure [dbo].[PR_ServiciosDescripcion]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PR_ServiciosDescripcion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[PR_ServiciosDescripcion] AS' 
END
GO
ALTER PROCEDURE [dbo].[PR_ServiciosDescripcion](@valor2 int)
AS
BEGIN
	SELECT Servicios1.id_Servicio, Servicio_Descripcion.Descripcion, Servicios1.Costo from Servicios1 left join Servicio_Descripcion on Servicios1.id_Servicio = Servicio_Descripcion.id_Servicio
	WHERE Servicios1.id_Servicio=@valor2
	GROUP BY Servicios1.id_Servicio, Servicio_Descripcion.Descripcion, Servicios1.Costo
END
EXEC PR_ServiciosDescripcion 765
GO
/****** Object:  StoredProcedure [dbo].[PR_ServiciosDescripcion1]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PR_ServiciosDescripcion1]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[PR_ServiciosDescripcion1] AS' 
END
GO
ALTER PROCEDURE [dbo].[PR_ServiciosDescripcion1](@valor2 int)
AS
BEGIN
	SELECT Servicios1.id_Servicio, Servicio_Descripcion.Descripcion, Servicios1.Costo from Servicios1 left join Servicio_Descripcion on Servicios1.id_Servicio = Servicio_Descripcion.id_Servicio
	WHERE Servicios1.id_Servicio=@valor2
	GROUP BY Servicios1.id_Servicio, Servicio_Descripcion.Descripcion, Servicios1.Costo
END
GO
/****** Object:  StoredProcedure [dbo].[PR_TelEmpleado]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PR_TelEmpleado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[PR_TelEmpleado] AS' 
END
GO
ALTER PROCEDURE [dbo].[PR_TelEmpleado](@valor3 int)
AS
BEGIN
	SELECT Empleado_C.nombre, telefono_a.zona, telefono_a.num_telefono from Empleado_C left join telefono_a on Empleado_C.id_telefono = telefono_a.id_telefono
	WHERE Empleado_C.id_empleado = @valor3
	GROUP BY Empleado_C.nombre, telefono_a.zona, telefono_a.num_telefono	
END
GO
/****** Object:  StoredProcedure [dbo].[Reporte_Almacen_Procedure]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Reporte_Almacen_Procedure]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Reporte_Almacen_Procedure] AS' 
END
GO


/****** Object:  StoredProcedure [dbo].[Reporte_Almacen_Procedure1]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Reporte_Almacen_Procedure1]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Reporte_Almacen_Procedure1] AS' 
END
GO
ALTER procedure [dbo].[Reporte_Almacen_Procedure1](@valor1 int)
as 
begin
select Almacen_C.id_producto, Producto_B.nombre, Almacen_C.Existencia, Almacen_C.Fecha, 
Producto_B.costo_compra, Producto_B.precio_venta,  sum(costo_compra*.16) as iva
from Almacen_C, Categoria left join Producto_B on id_producto= Producto_B.id_producto
where Almacen_C.id_producto= Producto_B.id_producto
group by Almacen_C.id_producto, Producto_B.nombre, Almacen_C.Existencia, Almacen_C.Fecha, 
Producto_B.costo_compra, Producto_B.precio_venta
end
GO
/****** Object:  StoredProcedure [dbo].[Reporte_Empleado_Procedure]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Reporte_Empleado_Procedure]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Reporte_Empleado_Procedure] AS' 
END
GO
ALTER procedure [dbo].[Reporte_Empleado_Procedure](@valor1 int)
as 
begin
select Empleado_C.id_empleado ,Empleado_C.nombre, Empleado_C.edad, direccion_b.numero, direccion_b.calle,
	direccion_b.municipio, direccion_b.estado, telefono_a.num_telefono, Empleado_C.salario, sum(Empleado_C.salario*.16) as iva_sueldo
from Empleado_C, direccion_b left join telefono_a on id_telefono= telefono_a.id_telefono
where (Empleado_C.id_direccion=direccion_b.id_direccion) and (Empleado_C.id_telefono=telefono_a.id_telefono) and (Empleado_C.id_empleado=@valor1)
group by Empleado_C.id_empleado ,Empleado_C.nombre, Empleado_C.edad, direccion_b.numero, direccion_b.calle,
	direccion_b.municipio, direccion_b.estado, telefono_a.num_telefono, Empleado_C.salario
end
GO
/****** Object:  StoredProcedure [dbo].[Reporte_Empleado_Procedure1]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Reporte_Empleado_Procedure1]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Reporte_Empleado_Procedure1] AS' 
END
GO
ALTER procedure [dbo].[Reporte_Empleado_Procedure1](@valor1 int)
as 
begin
select Empleado_C.id_empleado ,Empleado_C.nombre, Empleado_C.edad, direccion_b.numero, direccion_b.calle,
	direccion_b.municipio, direccion_b.estado, telefono_a.num_telefono, Empleado_C.salario, sum(Empleado_C.salario*.16) as iva_sueldo
from Empleado_C, direccion_b left join telefono_a on id_telefono= telefono_a.id_telefono
where (Empleado_C.id_direccion=direccion_b.id_direccion) and (Empleado_C.id_telefono=telefono_a.id_telefono) and (Empleado_C.id_empleado=@valor1)
group by Empleado_C.id_empleado ,Empleado_C.nombre, Empleado_C.edad, direccion_b.numero, direccion_b.calle,
	direccion_b.municipio, direccion_b.estado, telefono_a.num_telefono, Empleado_C.salario
end
GO
/****** Object:  StoredProcedure [dbo].[Reporte_Puestos_Procedure]    Script Date: 26/10/2018 01:36:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Reporte_Puestos_Procedure]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Reporte_Puestos_Procedure] AS' 
END
GO
ALTER procedure [dbo].[Reporte_Puestos_Procedure](@valor1 int)
as 
begin
select Empleado_C.id_empleado, puesto_b.n_puesto, puesto_b.nivel, Empleado_C.salario, sum(Empleado_C.salario*.16) as iva_sueldo
from Empleado_C 
right join puesto_b on Empleado_C.id_puesto=puesto_b.id_puesto
where (Empleado_C.id_puesto=puesto_b.id_puesto) and (Empleado_C.id_empleado=@valor1)
group by Empleado_C.id_empleado, puesto_b.n_puesto, puesto_b.nivel, Empleado_C.salario
end
GO
/****** Object:  StoredProcedure [dbo].[Reporte_Puestos_Procedure1]    Script Date: 26/10/2018 01:36:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Reporte_Puestos_Procedure1]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Reporte_Puestos_Procedure1] AS' 
END
GO
ALTER procedure [dbo].[Reporte_Puestos_Procedure1](@valor1 int)
as 
begin
select Empleado_C.id_empleado, puesto_b.n_puesto, puesto_b.nivel, Empleado_C.salario, sum(Empleado_C.salario*.16) as iva_sueldo
from Empleado_C 
right join puesto_b on Empleado_C.id_puesto=puesto_b.id_puesto
where (Empleado_C.id_puesto=puesto_b.id_puesto) and (Empleado_C.id_empleado=@valor1)
group by Empleado_C.id_empleado, puesto_b.n_puesto, puesto_b.nivel, Empleado_C.salario
end
GO
/****** Object:  StoredProcedure [dbo].[ReporteProveedor]    Script Date: 26/10/2018 01:36:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReporteProveedor]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ReporteProveedor] AS' 
END
GO
ALTER procedure [dbo].[ReporteProveedor](@proveedor int)
as 
begin
select Proveedor_E.id_proveedor,Proveedor_E.RFC ,Proveedor_E.n_comercial,direccion_b.numero, 
direccion_b.calle, direccion_b.municipio, direccion_b.estado, telefono_a.num_telefono
from Proveedor_E, telefono_a, Almacen_C
left join direccion_b on direccion_b.id_direccion=id_direccion
where (Proveedor_E.id_direccion=direccion_b.id_direccion) and (Proveedor_E.id_telefono = telefono_a.id_telefono)
and (Proveedor_E.id_proveedor= @proveedor)
group by Proveedor_E.id_proveedor,Proveedor_E.RFC ,Proveedor_E.n_comercial,direccion_b.numero, 
direccion_b.calle, direccion_b.municipio, direccion_b.estado, telefono_a.num_telefono
end
GO
/****** Object:  StoredProcedure [dbo].[ReporteProveedor1]    Script Date: 26/10/2018 01:36:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReporteProveedor1]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ReporteProveedor1] AS' 
END
GO

ALTER procedure [dbo].[ReporteProveedor1](@proveedor int)
as 
begin
select Proveedor_E.id_proveedor,Proveedor_E.RFC ,Proveedor_E.n_comercial,direccion_b.numero, 
direccion_b.calle, direccion_b.municipio, direccion_b.estado, telefono_a.num_telefono, Producto_B.costo_compra, MAX( Producto_B.costo_compra*.16) as IVA_compra
from Proveedor_E, telefono_a, Almacen_C,Producto_B
left join direccion_b on direccion_b.id_direccion=id_direccion
where (Proveedor_E.id_direccion=direccion_b.id_direccion) and (Proveedor_E.id_telefono = telefono_a.id_telefono) and (Proveedor_E.id_proveedor=Producto_B.id_proveedor)
group by Proveedor_E.id_proveedor,Proveedor_E.RFC ,Proveedor_E.n_comercial,direccion_b.numero, 
direccion_b.calle, direccion_b.municipio, direccion_b.estado, telefono_a.num_telefono, Producto_B.costo_compra
end
GO
/****** Object:  StoredProcedure [dbo].[ReporteVentas_PorSucursal]    Script Date: 26/10/2018 01:36:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReporteVentas_PorSucursal]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ReporteVentas_PorSucursal] AS' 
END
GO
ALTER procedure [dbo].[ReporteVentas_PorSucursal](@sucursal int)
as 
begin
select Caja_E.id_compra, Caja_E.FyH, Sucursal_C.id_sucursal, Caja_E.cambio, Caja_E.monto, Caja_E.pago, sum(Caja_E.monto*.16) as iva_pago 
from Caja_E
right join Sucursal_C on Sucursal_C.id_sucursal= Caja_E.id_sucursal
where Sucursal_C.id_sucursal= @sucursal
group by Caja_E.id_compra, Caja_E.FyH, Sucursal_C.id_sucursal, Caja_E.cambio, Caja_E.monto, Caja_E.pago
end
GO
/****** Object:  StoredProcedure [dbo].[ReporteVentas_PorSucursal1]    Script Date: 26/10/2018 01:36:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReporteVentas_PorSucursal1]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ReporteVentas_PorSucursal1] AS' 
END
GO
ALTER procedure [dbo].[ReporteVentas_PorSucursal1](@sucursal int)
as 
begin
select Caja_E.id_compra, Caja_E.FyH, Sucursal_C.id_sucursal, Caja_E.cambio, Caja_E.monto, Caja_E.pago, sum(Caja_E.monto*.16) as iva_pago 
from Caja_E
right join Sucursal_C on Sucursal_C.id_sucursal= Caja_E.id_sucursal
group by Caja_E.id_compra, Caja_E.FyH, Sucursal_C.id_sucursal, Caja_E.cambio, Caja_E.monto, Caja_E.pago
end
GO
/****** Object:  StoredProcedure [dbo].[Respaldo_Tabla_Empleado]    Script Date: 26/10/2018 01:36:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Respaldo_Tabla_Empleado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Respaldo_Tabla_Empleado] AS' 
END
GO
ALTER procedure [dbo].[Respaldo_Tabla_Empleado](@valor1 int)
as 
begin

drop table Respaldo_E
select * into Respaldo_E from Empleado_C

	print ('completado con exito')
select * from Empleado_C
where id_empleado= @valor1

end
GO
/****** Object:  StoredProcedure [dbo].[SALARIO]    Script Date: 26/10/2018 01:36:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SALARIO]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SALARIO] AS' 
END
GO
ALTER procedure [dbo].[SALARIO] (@val1 int)
as
begin
	select * from REPORT_Empleado
	Where salario >= @val1
end
GO
/****** Object:  StoredProcedure [dbo].[SALARIOMH]    Script Date: 26/10/2018 01:36:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SALARIOMH]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SALARIOMH] AS' 
END
GO
ALTER procedure [dbo].[SALARIOMH] (@val1 int)
as
begin
	select * from EmpleadoPuestoH
	Where SalarioMensual >= @val1
end
GO
/****** Object:  StoredProcedure [dbo].[SALARIOMM]    Script Date: 26/10/2018 01:36:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SALARIOMM]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SALARIOMM] AS' 
END
GO
ALTER procedure [dbo].[SALARIOMM] (@val1 int)
as
begin
	select * from EmpleadoPuestoM
	Where SalarioMensual >= @val1
end
GO
/****** Object:  Trigger [dbo].[tr_update6]    Script Date: 26/10/2018 01:36:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_update6]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[tr_update6] ON [dbo].[Almacen_C] 
instead of update
as begin
	update Almacen_C set Fecha=GETDATE()
	FROM inserted where Almacen_C.registro = inserted.registro
		update Almacen_C set Existencia=inserted.Existencia
	FROM inserted where Almacen_C.registro = inserted.registro
end' 
GO
ALTER TABLE [dbo].[Almacen_C] ENABLE TRIGGER [tr_update6]
GO
/****** Object:  Trigger [dbo].[ACTUALIZACION]    Script Date: 26/10/2018 01:36:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[ACTUALIZACION]'))
EXEC dbo.sp_executesql @statement = N'Create Trigger [dbo].[ACTUALIZACION] on [dbo].[Detalle_Factura2]
after insert
as
print ''Actulizacion tabla Detalle_Factua''
' 
GO
ALTER TABLE [dbo].[Detalle_Factura2] ENABLE TRIGGER [ACTUALIZACION]
GO
/****** Object:  Trigger [dbo].[DELETE2]    Script Date: 26/10/2018 01:36:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[DELETE2]'))
EXEC dbo.sp_executesql @statement = N'Create Trigger [dbo].[DELETE2] on [dbo].[Detalle_Factura2]
after delete 
as
insert into Logs values (NEWID(),GETDATE() )
' 
GO
ALTER TABLE [dbo].[Detalle_Factura2] ENABLE TRIGGER [DELETE2]
GO
/****** Object:  Trigger [dbo].[tr_delete]    Script Date: 26/10/2018 01:36:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_delete]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tr_delete] ON [dbo].[Empleado_C] 
after delete
as begin
delete from direccion_b where direccion_b.id_direccion=id_direccion
delete from telefono_a where telefono_a.id_telefono=id_telefono
end
' 
GO
ALTER TABLE [dbo].[Empleado_C] ENABLE TRIGGER [tr_delete]
GO
/****** Object:  Trigger [dbo].[TR_EmpleadoActualizado]    Script Date: 26/10/2018 01:36:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[TR_EmpleadoActualizado]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[TR_EmpleadoActualizado]
ON [dbo].[Empleado_C] AFTER UPDATE
AS 
PRINT ''Se actualizaron los datos de un empleado''' 
GO
ALTER TABLE [dbo].[Empleado_C] ENABLE TRIGGER [TR_EmpleadoActualizado]
GO
/****** Object:  Trigger [dbo].[DELETE]    Script Date: 26/10/2018 01:36:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[DELETE]'))
EXEC dbo.sp_executesql @statement = N'Create Trigger [dbo].[DELETE] on [dbo].[Factura2]
after delete 
as
insert into Logs values (NEWID(),GETDATE() )
' 
GO
ALTER TABLE [dbo].[Factura2] ENABLE TRIGGER [DELETE]
GO
/****** Object:  Trigger [dbo].[NOUPDATE]    Script Date: 26/10/2018 01:36:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[NOUPDATE]'))
EXEC dbo.sp_executesql @statement = N'Create Trigger [dbo].[NOUPDATE] on [dbo].[Factura2]
instead of update
as
print ''MODIFICACION DENEGADA''
' 
GO
ALTER TABLE [dbo].[Factura2] ENABLE TRIGGER [NOUPDATE]
GO
/****** Object:  Trigger [dbo].[TR_EliminarProveedor]    Script Date: 26/10/2018 01:36:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[TR_EliminarProveedor]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[TR_EliminarProveedor]
ON [dbo].[Proveedor_E]
INSTEAD OF DELETE
AS BEGIN
DELETE FROM direccion_b WHERE direccion_b.id_direccion = id_direccion
DELETE FROM telefono_a WHERE telefono_a.id_telefono = id_telefono
END' 
GO
ALTER TABLE [dbo].[Proveedor_E] ENABLE TRIGGER [TR_EliminarProveedor]
GO
/****** Object:  Trigger [dbo].[TR_InsertarProveedorV]    Script Date: 26/10/2018 01:36:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[TR_InsertarProveedorV]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[TR_InsertarProveedorV]
ON [dbo].[Proveedor_E]
AFTER INSERT
AS BEGIN
	SELECT * FROM inserted
END' 
GO
ALTER TABLE [dbo].[Proveedor_E] ENABLE TRIGGER [TR_InsertarProveedorV]
GO
/****** Object:  Trigger [dbo].[tr_inserte]    Script Date: 26/10/2018 01:36:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_inserte]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[tr_inserte] ON [dbo].[Sucursal_C] 
AFTER INSERT  
as begin
update direccion_b set id_direccion=inserted.id_sucursal
	FROM inserted 
update telefono_a set id_telefono=inserted.id_telefono
	FROM inserted 
end' 
GO
ALTER TABLE [dbo].[Sucursal_C] ENABLE TRIGGER [tr_inserte]
GO
USE [master]
GO
ALTER DATABASE [Punto_venta] SET  READ_WRITE 
GO
