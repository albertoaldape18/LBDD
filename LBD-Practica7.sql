--PRACTICA 7
--Juan Alberto Almendarez Aldape 1798798

--5 procedimientos almacenados donde consulten sus reportes y filtren con parámetros

CREATE PROCEDURE [dbo].[PR_EmpleadoEnTienda](@valor1 int)
AS
BEGIN
	SELECT Sucursal_C.id_sucursal, Empleado_C.nombre, listaEmpleado.id_empleado from Empleado_C, Sucursal_C left join listaEmpleado on id_empleado = listaEmpleado.id_empleado
	WHERE (Empleado_C.id_empleado = listaEmpleado.id_empleado) AND Sucursal_C.id_sucursal = listaEmpleado.id_sucursal AND Empleado_C.id_empleado=@valor1
	GROUP BY Sucursal_C.id_sucursal, Empleado_C.nombre, listaEmpleado.id_empleado
END
EXEC PR_EmpleadoEnTienda 2489562


CREATE PROCEDURE [dbo].[PR_ServiciosDescripcion](@valor2 int)
AS
BEGIN
	SELECT Servicios.id_Servicio, Servicio_Descripcion.Descripcion, Servicios.Costo from Servicios left join Servicio_Descripcion on Servicios.id_Servicio = Servicio_Descripcion.id_Servicio
	WHERE Servicios.id_Servicio=@valor2
	GROUP BY Servicios.id_Servicio, Servicio_Descripcion.Descripcion, Servicios.Costo
END
EXEC PR_ServiciosDescripcion 765

CREATE PROCEDURE [dbo].[PR_TelEmpleado](@valor3 int)
AS
BEGIN
	SELECT Empleado_C.nombre, telefono_a.zona, telefono_a.num_telefono from Empleado_C left join telefono_a on Empleado_C.id_telefono = telefono_a.id_telefono
	WHERE Empleado_C.id_empleado = @valor3
	GROUP BY Empleado_C.nombre, telefono_a.zona, telefono_a.num_telefono	
END
EXEC PR_TelEmpleado 2489562
EXEC PR_TelEmpleado 5896243

CREATE PROCEDURE [dbo].[PR_DirEmpleado](@valor4 int)
AS
BEGIN
	SELECT Empleado_C.nombre, direccion_b.calle, direccion_b.numero , direccion_b.colonia, direccion_b.municipio, direccion_b.estado from Empleado_C left join direccion_b on Empleado_C.id_direccion = direccion_b.id_direccion
	WHERE Empleado_C.id_direccion = @valor4
	GROUP BY Empleado_C.nombre, direccion_b.calle, direccion_b.numero , direccion_b.colonia, direccion_b.municipio, direccion_b.estado
END
EXEC PR_DirEmpleado 64010
EXEC PR_DirEmpleado 63009
EXEC PR_DirEmpleado 66012

CREATE PROCEDURE [dbo].[PR_DirProveedores](@valor5 int)
AS
BEGIN
	SELECT Proveedor_E.n_comercial, direccion_b.calle, direccion_b.numero , direccion_b.colonia, direccion_b.municipio, direccion_b.estado from Proveedor_E left join direccion_b on Proveedor_E.id_direccion = direccion_b.id_direccion
	WHERE Proveedor_E.id_direccion = @valor5
	GROUP BY Proveedor_E.n_comercial, direccion_b.calle, direccion_b.numero , direccion_b.colonia, direccion_b.municipio, direccion_b.estado
END
EXEC PR_DirProveedores 58004
EXEC PR_DirProveedores 56902




-- 1 función 
CREATE FUNCTION [dbo].[NumeroAlCuadrado] (@v1 float)
RETURNS FLOAT
AS
BEGIN
	 RETURN (@v1 * @v1)
END
SELECT dbo.NumeroAlCuadrado(5) as NumeroAlCuadrado




--1 procedimiento tipo script
CREATE PROCEDURE [dbo].[Edad_MayorQue](@var1 int)
AS
BEGIN
	SELECT nombre FROM Empleado_C 
	WHERE edad >= @var1
END
EXEC Edad_MayorQue @var1 = 20