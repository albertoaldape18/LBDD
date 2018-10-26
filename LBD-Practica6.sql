--PRACTICA 6
--Juan Alberto Almendarez Aldape Mat: 1798798

--3 subconsultas
SELECT * FROM (select edad, count(edad) as [Cantidad] 
FROM Empleado_C
GROUP BY edad
) as e
where e.edad>20

SELECT * FROM (select nombre, salario, (.16 * salario) as [IvaDelSalario]
FROM Empleado_C )
as e
where e.salario>22000

SELECT nombre from Empleado_C 
where edad<(select MAX(edad) from Empleado_C)

--1 subconsulta with
WITH empleadosedad AS (
	Select Edad, COUNT (Edad) from Empleado_C
	group by edad)
SELECT * FROM empleadosedad


--5 vistas
CREATE VIEW EmpleadosEnTienda as (
	SELECT Sucursal_C.id_sucursal, Empleado_C.nombre, listaEmpleado.id_empleado from Empleado_C, Sucursal_C left join listaEmpleado on id_empleado = listaEmpleado.id_empleado
	WHERE (Empleado_C.id_empleado = listaEmpleado.id_empleado) AND Sucursal_C.id_sucursal = listaEmpleado.id_sucursal
	GROUP BY Sucursal_C.id_sucursal, Empleado_C.nombre, listaEmpleado.id_empleado
)

CREATE VIEW ReporteCostoTipoServicio as (
	SELECT Servicios.id_Servicio, Servicio_Descripcion.Descripcion, Servicios.Costo from Servicios left join Servicio_Descripcion on Servicios.id_Servicio = Servicio_Descripcion.id_Servicio
	GROUP BY Servicios.id_Servicio, Servicio_Descripcion.Descripcion, Servicios.Costo
)

CREATE VIEW ReporteDireccionProveedores as (
	SELECT Proveedor_E.n_comercial, direccion_b.calle, direccion_b.numero , direccion_b.colonia, direccion_b.municipio, direccion_b.estado from Proveedor_E left join direccion_b on Proveedor_E.id_direccion = direccion_b.id_direccion
	GROUP BY Proveedor_E.n_comercial, direccion_b.calle, direccion_b.numero , direccion_b.colonia, direccion_b.municipio, direccion_b.estado
)

CREATE VIEW ReporteDireccionEmpleados as (
	SELECT Empleado_C.nombre, direccion_b.calle, direccion_b.numero , direccion_b.colonia, direccion_b.municipio, direccion_b.estado from Empleado_C left join direccion_b on Empleado_C.id_direccion = direccion_b.id_direccion
	GROUP BY Empleado_C.nombre, direccion_b.calle, direccion_b.numero , direccion_b.colonia, direccion_b.municipio, direccion_b.estado
)

CREATE VIEW ReporteTelefonosEmpleados as (
	SELECT Empleado_C.nombre, telefono_a.zona, telefono_a.num_telefono from Empleado_C left join telefono_a on Empleado_C.id_telefono = telefono_a.id_telefono
	GROUP BY Empleado_C.nombre, telefono_a.zona, telefono_a.num_telefono
)


--1 consulta dinamica
DECLARE @query varchar (max)
DECLARE @tabla nvarchar(max) 
DECLARE @var varchar(max)
SET @tabla = 'Empleado_C'
SET @var = 'edad'
SET @query = 'SELECT nombre, ' + @var + ' from ' + @tabla
PRINT (@query)
EXEC (@query)
use PuntoDeVenta