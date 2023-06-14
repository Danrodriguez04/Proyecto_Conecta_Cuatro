/* 1 */

select partida.id, juego.id_usuario from partida,juego
where partida.id_torneo = 4
and partida.id = juego.id_partida;

# 2

select id_juez, torneo.id from partida, torneo 
where partida.id_torneo = torneo.id 
and torneo.nombre= "España";

/* 3 */

select id_torneo,clasificacion,id_usuario from participa order by clasificacion limit 3;

#4

select traduccion_pais.nombre from traduccion_pais,idioma 
where idioma.id =  traduccion_pais.id_idioma 
and idioma.nombre= "English";

/* 5 */

select Usuario.id, traduccion_ciudad.nombre from Usuario, Ciudad, traduccion_ciudad, idioma
where Usuario.id_ciudad = Ciudad.id
and ciudad.id = traduccion_ciudad.id_ciudad
and traduccion_ciudad.id_idioma = idioma.id
group by Usuario.id;

/* 6 */

select id_partida, count(id_partida) as total from comentario_partida
group by id_partida
having total > 2
order by total desc;

/* 7 */

select id  from partida
where not exists(select * from movimiento where id_partida = id);

/*8*/

select "Este año",usuario.id, traduccion_pais.nombre from usuario, ciudad,pais,traduccion_pais
where usuario.id_ciudad = ciudad.id
and ciudad.id_pais = pais.id
and pais.id = traduccion_pais.id_pais
and year(usuario.fecha_alta) = year(current_date())
UNION
select "Otro año", usuario.id, traduccion_pais.nombre from usuario, ciudad,pais,traduccion_pais
where usuario.id_ciudad = ciudad.id
and ciudad.id_pais = pais.id
and pais.id = traduccion_pais.id_pais
and year(usuario.fecha_alta) != year(current_date());

/*9*/
select truncate(avg(total_partida.total),1) from (
select count(id_partida) as total from comentario_partida
group by id_partida) as total_partida;

/* 10 */

select id from torneo where id_torneo_Dependiente = 1;

/* 11 */

select "Comentario Partidas" ,comentario_partida.id_usuario as Usuario,comentario_partida.id_partida as "Id partida/Movimiento",comentario_partida.comentario from comentario_partida ,usuario, ciudad,pais,traduccion_pais
where comentario_partida.id_usuario = usuario.id
and usuario.id_ciudad = ciudad.id
and ciudad.id_pais = pais.id
and traduccion_pais.id_pais = pais.id
and traduccion_pais.nombre != "Spain"
UNION
select "Comentario Movimientos" ,comentario_movimiento.id_usuario,comentario_movimiento.id_movimiento,comentario_movimiento.comentario from comentario_movimiento,usuario, ciudad,pais,traduccion_pais
where comentario_movimiento.id_usuario = usuario.id
and usuario.id_ciudad = ciudad.id
and ciudad.id_pais = pais.id
and traduccion_pais.id_pais = pais.id
and traduccion_pais.nombre != "Spain";

/* 12 */

select * from juego
order by id_partida;


select distinct id_usuario from juego as j1
where id_usuario != (select  distinct j2.id_usuario from juego as j2,usuario, ciudad,pais,traduccion_pais
					 where j1.id_partida = j2.id_partida
					 and j1.id_usuario != j2.id_usuario
					 and j2.id_usuario = usuario.id 
					 and usuario.id_ciudad = ciudad.id
					 and ciudad.id_pais = pais.id
					 and traduccion_pais.id_pais = pais.id
					 and traduccion_pais.nombre = "Spain")
;


/* Muestra usuarios de un pais en concreto.
select  usuario.id from usuario, ciudad,pais,traduccion_pais
where usuario.id_ciudad = ciudad.id
and ciudad.id_pais = pais.id
and traduccion_pais.id_pais = pais.id
and traduccion_pais.nombre = "Colombia"
*/