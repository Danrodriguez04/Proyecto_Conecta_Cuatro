


use Conecta_cuatro;


select * from partida;
select * from torneo;

# 2

select id_juez, torneo.id from partida, torneo 
where partida.id_torneo = torneo.id 
and torneo.nombre= "España";


#4

select traduccion_pais.nombre from traduccion_pais,idioma 
where idioma.id =  traduccion_pais.id_idioma 
and idioma.nombre= "English";



