/* 1 */

select * from partida;
select * from participa;

select partida.id, juego.id_usuario from partida,juego
where partida.id_torneo = 4
and partida.id = juego.id_partida;

describe partida;
/* 2 */
/*Hecho por daniel*/

/* 3 */
select id_torneo,clasificacion,id_usuario from participa order by clasificacion limit 3;

/* 4 */
/*Hecho por daniel*/

/* 5 */
select Usuario.id, traduccion_ciudad.nombre from Usuario, Ciudad, traduccion_ciudad, idioma
where Usuario.id_ciudad = Ciudad.id
and ciudad.id = traduccion_ciudad.id_ciudad
and traduccion_ciudad.id_idioma = idioma.id
group by Usuario.id;

/* 6 */


