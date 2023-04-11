------------------------------------------------------------------------ Consultas Multitable-----------------------------------------------------------------------------------

-- 1.Muestra el nombre y apellidos del peleador con más combates. Solamente se debe mostrar sus datos.
select p.nombre, p.apellidos, count(c.codigo) as combates
from combate c
inner join peleador p
on p.dni=c.peleador_dni
group by c.peleador_dni
order by combates desc
limit 1;

-- 2.Devuelve el número de peleadores que tiene cada gimnasio. Se debe mostrar los que tengan al menos 3 peleadores. 
select g.nombre, count(p.dni) as peleadores
from peleador p
inner join gimnasio g
on g.codigo=p.gimnasio_codigo
group by g.nombre
having peleadores>=3;

-- 3.Muestra el nombre del gimnasio y las veces que ha tenido lugar una competición en ella.
select g.nombre, count(c.gimnasio_codigo) as veces
from gimnasio g
inner join competicion c
on g.codigo =c.gimnasio_codigo
group by g.nombre;

-- 4.Muestra el nombre de la competición que tuvo lugar en el mes de agosto, el número de combates que tuvieron lugar, y el número de peleadores que participaron.
select c.nombre, count(c2.codigo) as combates, count(p.dni) as peleadores
from competicion c
inner join combate c2
on c2.competicion_codigo=c.codigo
inner join peleador p
on c2.peleador_dni=p.dni
where monthname(c.fecha)='august'
group by c.nombre;

-- 5.Muestra el nombre y apellidos de la persona que entrena al peleador con mayor número de victorias.
select e.nombre, e.apellidos, max(p.victorias) as victorias
from peleador p
inner join entrenador e
on e.dni=p.entrenador_dni
group by e.dni
order by victorias desc
limit 1;


------------------------------------------------------------------------ Vistas-----------------------------------------------------------------------------------

-- 1.Vista 1
create view vista1 as
	select c.nombre, count(c2.codigo) as combates, count(p.dni) as peleadores
	from competicion c
	inner join combate c2
	on c2.competicion_codigo=c.codigo
	inner join peleador p
	on c2.peleador_dni=p.dni
	where monthname(c.fecha)='august'
	group by c.nombre;
select * from vista1;

-- 1.Vista 2
create view vista2 as
	select e.nombre, e.apellidos, max(p.victorias) as victorias
	from peleador p
	inner join entrenador e
	on e.dni=p.entrenador_dni
	group by e.dni
	order by victorias desc
	limit 1;
select * from vista2;


------------------------------------------------------------------------ Funciones-----------------------------------------------------------------------------------

-- 1. Función que recibe el dni, y devuelve el número de victorias.
delimiter &&
create function funcion1(dni varchar(9)) returns int deterministic
begin
	declare victorias int;
	
	set victorias =(
		select p.victorias
		from peleador p
		where p.dni=dni);
	return victorias;
end &&
delimiter ;
select funcion1("155804876");

-- 2. Función que recibe el dni, y devuelve el número de victorias.
delimiter &&
create function funcion2(codigo_competicion varchar(3)) returns varchar(50) deterministic
begin
	declare nom_gimnasio varchar(50);
	
	set nom_gimnasio =(
		select g.nombre
		from gimnasio g
		inner join competicion c
		on c.gimnasio_codigo=g.codigo
		where c.codigo=codigo_competicion);
	return nom_gimnasio;
end &&
delimiter ;
select funcion2("104");


------------------------------------------------------------------------ Procedimientos-----------------------------------------------------------------------------------

-- 1.Procedimiento que recibe el dni del peleador, y devuelve el nombre y apellidos.
delimiter &&
create procedure procedimiento1(in dni varchar(9), out nombre varchar(50), out apellidos varchar(50))
begin
	set nombre =(
		select p.nombre
		from peleador p
		where p.dni=dni);
	
	set apellidos =(
		select p.apellidos
		from peleador p
		where p.dni=dni);
end &&
delimiter ;
call procedimiento1("102526473", @nombre, @apellidos);
select @nombre, @apellidos;

-- 2.Procedimiento que recibe el dni del peleador, y devuelve si es un peleador con experiencia (más de 20 victorias) o un peleador novato (menos de 5 victorias).
delimiter &&
create procedure procedimiento2(in dni varchar(9), out respuesta varchar(50))
begin
	
	declare victorias int;
	
	set victorias =(
		select funcion1(dni)
	);
	if (victorias > 20) then
		set respuesta=(
			select concat(p.nombre, ' ', p.apellidos, ' es un peleador con experiencia.')
			from peleador p
			where p.dni=dni);
	elseif (victorias < 5) then
		set respuesta=(
			select concat(p.nombre, ' ', p.apellidos, ' es un peleador novato.')
			from peleador p
			where p.dni=dni);
	end if;
end&&
delimiter ;
call procedimiento2("102526473", @respuesta);
select @respuesta;

-- 3.Procedimiento que muestra los 10 peleadores con más victorias, y los 10 con más derrotas.
delimiter &&
create procedure procedimiento3()
begin
  	declare done int default false;
  	declare nombre varchar(50);
  	declare apellidos varchar(50);
 	declare victorias int;
 	declare derrotas int;
 	declare salida varchar(10000) default '-----------Más Victorias-----------\n';
  	
  	declare cur1 cursor for 
		select p.nombre, p.apellidos, p.victorias 
		from peleador p
		order by p.victorias desc
		limit 10;
  	
	declare cur2 cursor for 
		select p.nombre, p.apellidos, p.derrotas 
		from peleador p
		order by p.derrotas desc 
		limit 10;
  	
	declare continue handler for not found set done = true;

  	open cur1;
  	while (not done) do
  		fetch cur1 into nombre, apellidos, victorias;
  		if (not done) then
  			set salida = concat('El peleador ', nombre, ' ', apellidos, ' tiene ', victorias, ' victorias.');
  		end if;
  	end while;
  	close cur1;
  	
  	set salida = concat(salida, '\n-----------Más Derrotas-----------');
  	set done = false;
  
  	open cur2;
  	while (not done) do
  		fetch cur2 into nombre, apellidos, derrotas;
  		if (not done) then
  			set salida = concat('El peleador ', nombre, ' ', apellidos, ' tiene ', derrotas, ' derrotas.');
  		end if;
  	end while;
  	close cur2;
  
  	select salida;
end &&

call procedimiento3();

------------------------------------------------------------------------ Triggers-----------------------------------------------------------------------------------

-- 1. Trigger que al detectar que el aforo es de menos de 100, lo redondea a 100.
delimiter &&
create trigger trigger1
before insert on gimnasio for each row
begin
	if new.aforo<100 then
	set new.aforo = 100;
	end if;
end &&
DELIMITER ;

-- 2.Trigger que si detecta una fecha que no existe, establece 2023-04-01.
delimiter &&
create trigger trigger2
before insert on competicion for each row
begin
	if new.fecha > '2023-04-01' then
set new.fecha = '2023-04-01';
end if;
end &&
delimiter ;



