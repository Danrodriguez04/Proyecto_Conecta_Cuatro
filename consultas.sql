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





