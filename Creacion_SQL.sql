
/*Tablas ciudad | pais*/
create table paisEn(
	ciudad_nombre varchar(100),
    pais_nombre varchar(100)

);

create table paisEn2(
	ciudad_nombre varchar(100),
    pais_nombre varchar(100)

);

/*Insert pais*/

delimiter $$
create procedure insertarPaisesIdiomaIngles(
)
begin
	declare pais varchar(45);
    declare finished int(1) default 0;
    declare contador int(11) default 0;
    declare cursor_paises cursor for select distinct pais_nombre from paisEn2; 
	declare continue handler for not found set finished = 1;
    
    open cursor_paises;
    crearPais : loop 
				fetch cursor_paises into pais;
				if	finished = 1
                then
					leave crearPais;
                end if;
                
                insert into pais() values();
                set contador = contador + 1;
                
                insert into Traduccion_Pais() values(2,contador,pais);
                
                end loop;

    close cursor_paises;
end $$
delimiter ;


/*Ciudad*/

delimiter $$

create procedure insertarCiudades (
)
begin
	declare finished int(1) default 0;
    declare pais varchar(100);
    declare ciudad varchar(100);
    
	declare cursor_ciudad cursor for select * from paisEn2;
	declare continue handler for not found set finished = 1;

	open cursor_ciudad;
    crearCiudad : loop 
				  fetch cursor_ciudad into ciudad,pais;
				  if	finished = 1
				  then
					leave crearCiudad;
				  end if;
					
                  insert into ciudad (id_pais) select id_pais from traduccion_pais
											   where traduccion_pais.nombre = pais; 
					
				  end loop;
    
    close cursor_ciudad;

end$$

delimiter ;

delimiter $$

create procedure insertarCiudadTraduccionIngles(
)
begin
	declare ciudad varchar(45);
    declare finished int(1) default 0;
    declare contador int(11) default 0;
    declare cursor_ciudades cursor for select ciudad_nombre from paisEn2; 
	declare continue handler for not found set finished = 1;
    
    open cursor_ciudades;
    crearCiudades : loop 
				fetch cursor_ciudades into ciudad;
				if	finished = 1
                then
					leave crearCiudades;
                end if;
                
                set contador = contador + 1;
                
                insert into Traduccion_Ciudad() values(2,contador,ciudad);
                
                end loop;

    close cursor_ciudades;
end $$
delimiter ;

alter table usuario
modify column id int;

alter table usuario add nombre_usuario varchar(50) not null;
    
delimiter $$
create procedure crearUsuarios(
)
begin
	declare contador int(11) default 1;
    declare ciudadId int(11) default 0;
    declare nombreUsuario varchar(50);
    
    
	while(contador <= 10)
    do
		set nombreUsuario = concat("user",contador);
        
        select id into ciudadId from ciudad order by rand() limit 1;
        
		insert into usuario (id,nombre,apellido1,fecha_nacimiento,codigo_postal,id_ciudad,nombre_Usuario) values(contador,"x","x",current_date(),"07500",ciudadId,nombreUsuario);
        set contador = contador + 1;
    end while;
    
end $$

delimiter ;

call crearUsuarios();

load data infile 'C:/FotoPerfil.csv'
into table foto_perfil
fields terminated by ","
lines terminated by "\r\n";

/*Insertar colores*/

create table colores(
	colorEspañol varchar(30),
    colorIngles varchar(30)
);

load data infile 'C:/colores.csv' 
into table colores
fields terminated by ","
lines terminated by "\r\n";

delimiter $$
create procedure insertarColoresTraduccion(
)
begin
	declare coloresIngles varchar(30);
    declare coloresEspanol varchar(30);
    
    declare finished int(1) default 0;
    declare contador int(11) default 0;
    declare cursor_colores cursor for select colorEspañol,colorIngles from colores; 
	declare continue handler for not found set finished = 1;
    
    open cursor_colores;
    crearColores : loop 
				   fetch cursor_colores into coloresEspanol,coloresIngles;
					if	finished = 1
					then
						leave crearColores;
					end if;
                
					set contador = contador + 1;
					insert into color() values();
                
					insert into Traduccion_color() values(2,contador,coloresIngles);
					insert into Traduccion_color() values(1,contador,coloresEspanol);
                
					end loop;

    close cursor_colores;
end $$
delimiter ;

call insertarColoresTraduccion();

/* Insertar partida */

delimiter $$
create procedure crearPartida()
begin

	declare fecha datetime;
    declare contador int(1) default 0; 
    declare juez int(1);
    while (contador < 5)
    do
		select id into juez from usuario order by rand() limit 1;
		set fecha = date_add(current_time(), interval (contador * -1) day);
        
        insert into partida(fecha_inicio,id_torneo,id_juez) values(fecha,1,juez);
        
        set contador = contador + 1;
    end while;
    
end $$
delimiter ;

call crearPartida();


/* Asignar jugadores y movimientos a partida */

delimiter $$
create trigger insertJuegaMovimiento
	after insert 
    on partida
    for each row
begin
    
	declare primerBucle boolean;
	declare contador int(11) default 0;
	
    declare pos_x int(2);
    declare pos_y int(2);
    
    
    declare jugador1 int(11);
    declare jugador2 int (11);
    declare color1 int(11);
    declare color2 int(11);
    
    set primerBucle = true;
    
    while(primerBucle)
    do 
		select id into jugador1 from usuario order by rand() limit 1;
		select id into jugador2 from usuario order by rand() limit 1;
        select id into color1 from color order by rand() limit 1;
        select id into color2 from color order by rand() limit 1;
        
		if (jugador1 != new.id_juez and jugador2 != new.id_juez and jugador1 != jugador2 and color1 != color2)
        then
				insert into juego(id_usuario,id_partida,id_color,inicia) values(jugador1,new.id,color1,0);
				insert into juego(id_usuario,id_partida,id_color,inicia) values(jugador2,new.id,color2,1);
                set primerBucle = false;
				
                while(contador < 10)
				do
					select round( (rand() * (14-7)) + 1 ) into pos_y;
					select round( (rand() * (12-6)) + 1 ) into pos_x;
					
                    insert into movimiento(posicion_x,posicion_y,fecha,id_usuario,id_partida) values (pos_x, pos_y, current_time(),jugador1,new.id);
                    
                    select round( (rand() * (14-7)) + 7 ) into pos_y;
					select round( (rand() * (12-6)) + 6 ) into pos_x;
                    
                    insert into movimiento(posicion_x,posicion_y,fecha,id_usuario,id_partida) values (pos_x, pos_y, current_time(),jugador2,new.id);
                    
                    set contador = contador + 1;
				end while;
                
		end if;
    end while;
end$$    

delimiter ;

/*10 comentarios*/
delimiter $$

create procedure crearComentarios()
begin
	
    declare contador int(11) default 0;
    declare seleccion int(11) default 0;
    declare fecha datetime;
    
    declare comentPart int(11) default 0;

    declare usuario int(11) default 0;
    
    while(contador < 10)
	do
		select round( (rand() * (2-1)) + 1 ) into seleccion;
		select id into usuario from usuario order by rand() limit 1;
        
        set fecha = date_add(current_timestamp(), interval (contador * -1) day);
        
        if(seleccion = 1)
        then
			select id into comentPart from movimiento order by rand() limit 1;
			insert into comentario_movimiento(fecha,id_usuario,id_movimiento,comentario) values (fecha,usuario,comentPart,"xxx");
            
        elseif (seleccion = 2)
        then
			select id into comentPart from partida order by rand() limit 1;
			insert into comentario_partida(fecha,id_usuario,id_partida,comentario) values(fecha,usuario,comentPart,"xxx");
			
        end if;
        
        set contador = contador + 1;
    end while;


end $$

delimiter ;

call crearComentarios();



/*Añadir puntuacion partida y jugador*/


delimiter $$
create procedure añadirPuntuacion()
begin
	declare idPartida int(11) default 0;
	declare idJuego int(11) default 0;
    
    declare finished int(1) default 0;
    
	declare cursor_partida cursor for select id from partida;  
    
	declare cursor_jug cursor for select id_usuario,id_partida from juego;  
    
    declare continue handler for not found set finished = 1;
    
    open cursor_partida ;
    open cursor_jug; 
    
    crearPuntuPar: loop
				   fetch cursor_partida into idPartida;
				   if finished = 1
                   then
						leave crearPuntuPar;
                   end if;
                   
				   update partida
                   set puntuacion = (select round( (rand() * (100-0)) + 0 )) 
                   where id = idPartida;
				   
				   end loop;
                   
	set finished = 0;
	crearPuntuJug: loop
				   fetch cursor_jug into idJuego,idPartida;
				   if finished = 1
                   then
						leave crearPuntuJug;
                   end if;
                   
				   update juego
                   set puntuacion = (select round( (rand() * (100-0)) + 0 )) 
                   where id_usuario = idJuego
                   and id_Partida = idPartida;
				   
				   end loop;
	close cursor_partida ;               
	close cursor_jug;
end $$

delimiter ;

call añadirPuntuacion();

/**/

delimiter $$
create procedure asignarTorneosPartida()
begin
	declare primerTorneo int;
     
	select id into primerTorneo from torneo limit 1;
    
    update partida 
    set id_torneo=primerTorneo 
    where year(fecha_inicio) = year(now());

end $$

delimiter ;

call asignarTorneosPartida();


/*Triggers sobre torneo*/

delimiter $$
create trigger asignarUsuariosTorneo
	after insert 
    on juego
    for each row
begin
	declare IdTorneo int (11);
    declare clasi int(11);
    
    select partida.id_torneo into idTorneo from partida where new.id_partida = partida.id;
	select clasificacion into clasi from participa order by clasificacion desc limit 1; 

    if (clasi is null)
	then
		set clasi = 1;
    else
		set clasi = clasi + 1;
    end if;

	if (idTorneo is not null)
    then
		insert into participa(id_usuario,id_torneo,clasificacion)values(new.id_usuario,idTorneo,clasi);
    end if;
end$$    

delimiter ;

/**/

delimiter $$
create trigger asignarUsuariosTorneoUpdate
	before update
	on partida
    for each row
begin
    declare idUsuario int(11);
    declare clasi int(11);
	declare finished int(1) default 0;
    
	declare cursor_Usuarios cursor for select id_usuario from juego , partida where partida.id = new.id and juego.id_partida = partida.id; 
    
    declare continue handler for not found set finished = 1;
    
    if(old.id_torneo is null)
    then
		open cursor_Usuarios;
        
        c: loop
			fetch cursor_Usuarios into idUsuario;
            
            if finished = 1
            then
				leave c;
            end if;
            
			set clasi = (select clasificacion from participa where id_torneo = new.id_torneo order by clasificacion desc limit 1) ;
            
            if ( clasi is null )
            then
				set clasi = 1;
            else
				set clasi = clasi +1;
            end if;
            
            insert into participa (id_usuario,id_torneo,clasificacion) values (idUsuario,new.id_torneo, clasi  ) ;
            
			end loop;
        close cursor_Usuarios;
    end if;

end $$    

delimiter ;
