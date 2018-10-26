--PRACTICA 8
--Juan Alberto Almendarez Aldape 1798798

--3 trigger, insert, delete y update
--al menos un instead y un after

CREATE TRIGGER [dbo].[TR_InsertarProveedorV]
ON Proveedor_E
AFTER INSERT
AS BEGIN
	SELECT * FROM inserted
END
go


CREATE TRIGGER [dbo].[TR_EliminarProveedor]
ON Proveedor_E
INSTEAD OF DELETE
AS BEGIN
DELETE FROM direccion_b WHERE direccion_b.id_direccion = id_direccion
DELETE FROM telefono_a WHERE telefono_a.id_telefono = id_telefono
END
go

CREATE TRIGGER [dbo].[TR_EmpleadoActualizado]
ON Empleado_C AFTER UPDATE
AS 
PRINT 'Se actualizaron los datos de un empleado'
go