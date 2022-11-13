--INSERTAR
use  juegoordenador;
delimiter $
create procedure insertarEscenario( in riesgo int, in tiempo int)
begin
insert into escenario(riesgo_escenario, tiempo_escenario)values(riesgo, tiempo);
end$


--CONSULTAR
use  juegoordenador;
delimiter $
create procedure ConsultarEscenario()
begin
select *from  escenario;
end$

-- ACTUALIZAR
use  juegoordenador;
delimiter $
create procedure ActualizarEscenario(in id int, in riesgo int, in tiempo int)
begin
update  escenario
set riesgo_escenario=riesgo, tiempo_escenario=tiempo where cod_escenario=id;
end$

--ELIMINAR
use  juegoordenador;
delimiter $
create procedure EliminarEscenario(in id int)
begin
delete from  escenario
where cod_escenario=id;
end$


PERSONAJE=======================================

#INSERTAR
use  juegoordenador;
delimiter $
create procedure insertarPersonaje( in fza int, in inteli int,in habili int,in codEsce int,in codPersDomi int)
begin
insert into personaje(fuerza_personaje, inteligencia_personaje,habilidad_personaje,cod_escenario, cod_personajeDominado)
values(  fza ,  inteli , habili,codEsce ,codPersDomi);
end$


--CONSULTAR
use  juegoordenador;
delimiter $
create procedure consultarPersonaje()
begin
select *from  personaje;
end$

#ACTUALIZAR
use  juegoordenador;
delimiter $
create procedure ActualizarPersonaje(in id int,in fza int, in inteli int,in habili int,in codEsce int,in codPersDomi int)
begin
update  personaje
set fuerza_personaje=fza, 
inteligencia_personaje=inteli,
habilidad_personaje=habili,
cod_escenario=codEsce,
cod_personajeDominado=codPersDomi
 where cod_personaje=id;
end$



#ELIMINAR
use  juegoordenador;
delimiter $
create procedure EliminarPersonaje(in id int)
begin
delete from  personaje
where cod_personaje=id;
end$
call EliminarPersonaje(10)



#PROC 3 TABLAS
DELIMITER //
create procedure Consultar_xEscenario_xhora(in idEscenario int,in hora int)
BEGIN
	SELECT 
    codigo_objeto,
	hora_cogio,
    minuto_cogio,
    segundo,
	cod_personaje,
    inteligencia_personaje ,
    habilidad_personaje,
    cod_escenario,
	tiempo_escenario,
    riesgo_escenario
    FROM personaje as per  
    join objeto as obj
    on per.cod_personaje=obj.cod_personaje_obj
    join escenario as esce
    on esce.cod_escenario=obj.cod_escenario_obj
	WHERE  obj.cod_escenario_obj = idEscenario and obj.hora_cogio > hora;
END//
DELIMITER ;
call Consultar_xEscenario_xhora(parametro,parametro2)


#FUNCIONES
USE juegoordenador
delimiter //
create function numero_personaje_xescenario(codEscenario int) returns int
begin
	declare numero int;
    select count(*) into numero from personaje where cod_escenario_per =codEscenario ;
    return numero;
end//
delimiter ;
select numero_personaje_xescenario(1);

//TRIGER AUDITORIA

CREATE TABLE `juegoordenador`.`auditoria` (
  `id` INT(11) NOT NULL,
  `accion` VARCHAR(200) NULL DEFAULT NULL,
  `fecha` DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
  PRIMARY KEY (`id`));


#Crear usuarios que consulten y ejecuten solo procedimientos almacenados


CREATE USER 'cesarmozareyes'@'localhost' identified by 'aa11';
			
			grant select on juegoordenador.auditoria to 'cesarmoza'@'localhost' ;
grant select on juegoordenador.personaje to 'cesarmoza'@'localhost' ;

GRANT EXECUTE ON PROCEDURE juegoordenador.insertarPersonaje TO 'cesarmozareyes'@'localhost';


#generando base de datos
C:\Users\cesss>mysql -u root 
C:\Users\cesss>show databases;
C:\Users\cesss>use juegoordenador;
C:\Users\cesss>mysqldump -u root -p juegoordenador > C:\Backups\copia_juegoOrdenador.sql;  
C:\Users\cesss>mysqldump -u root -p juegoordenador < C:\Backups\copia_juegoOrdenador.sql;  

use juegoordenador;
call insertarEscenario(8,10);
call consultarEscenario();
call ActualizarEscenario(2,4,4);
call insertarPersonaje(6,6,6,1,8);
call insertarPersonaje(7,7,7,1,8);