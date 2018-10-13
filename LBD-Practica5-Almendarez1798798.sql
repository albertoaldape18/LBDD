--LBD Juan Alberto Almendarez Aldape

use Punto_venta

--Selects con cambio de nombre de columnas, alias en el nombre de las tablas y usar funciones
SELECT peso, estatura, (peso * estatura) as variable from Empleado_C
SELECT salario, peso, (salario * peso) as variable from Empleado_C
SELECT id_telefono, zona, (id_telefono * 2 - zona) as variableX from telefono_a
SELECT salario,id_empleado,(id_empleado - salario) as variableY from Empleado_C
SELECT salario, edad, (salario * edad) as variableF from Empleado_C

--4 selects tipo join : Cross, inner, left, rigth
SELECT Empleado_C.id_direccion, Empleado_C.id_puesto from Empleado_C
inner join puesto_b on Empleado_C.id_puesto = puesto_b.id_puesto

SELECT Empleado_C.id_empleado, Empleado_C.id_telefono from Empleado_C
left join telefono_a on Empleado_C.id_telefono = telefono_a.id_telefono

SELECT Empleado_C.id_empleado, Empleado_C.id_puesto from Empleado_C
right join puesto_b on Empleado_C.id_puesto = puesto_b.id_puesto;

SELECT Empleado_C.id_empleado, puesto_b.id_puesto from Empleado_C
cross join puesto_b



--Selects con uso de where, cada select de diferente tabla y columna, una usando order by
SELECT * FROM Empleado_C where sexo = 0 order by id_empleado DESC
SELECT * FROM direccion_b where calle='calle4' order by numero ASC
SELECT * FROM insumo_a where id_insumo<46000 order by id_producto ASC
SELECT * FROM telefono_a where id_telefono<60000 order by num_telefono DESC
SELECT * FROM puesto_b where nivel=3 order by id_puesto ASC

--Selects con uso de funciones de agregación: 2 sin group by, 2 con group by y 1 con group by y having
SELECT MIN(salario) as SalarioMinimo, MAX(salario) as SalarioMaximo from Empleado_C
SELECT MIN(numero) as NumeroMin, MAX (numero) as NumeroMax, SUM(numero) as NumeroSum from direccion_b
SELECT salario, AVG(salario*.16) as Iva_salario, count(salario) as NumeroDeEmpleado from Empleado_C group by salario order by salario DESC
SELECT edad, AVG(estatura) as promest, count(edad) as edad from Empleado_C group by edad


--Selects con join y group by.
select Empleado_C.id_empleado, Empleado_C.id_puesto from Empleado_C
right join puesto_b on Empleado_C.id_puesto = puesto_b.id_puesto
group by Empleado_C.id_empleado, Empleado_C.id_puesto

select Empleado_C.id_empleado, Empleado_C.id_direccion from Empleado_C
right join direccion_b on Empleado_C.id_direccion = direccion_b.id_direccion
group by Empleado_C.id_empleado, Empleado_C.id_puesto