
/*Antes de ejecutar este script haremos un source desde la terminal del mysql 
 de estructuraToneos.sql para hacer los inserts de los torneos
	
    ejm:    source /Users/usuario/estructuraToneos.sql
*/


	/*Insert idioma*/
insert into idioma (nombre) values ("Español");
insert into idioma (nombre) values ("English");

/*Ciudades y paises*/
load data infile 'C:/citiesEng.csv'
into table paisEn
fields terminated by ","
lines terminated by "\r\n";

insert into paisEn2 (ciudad_nombre,pais_nombre) (select distinct * from paisEn);

call insertarPaisesIdiomaIngles();

call insertarCiudades();

call insertarCiudadTraduccionIngles();

call crearUsuarios();


load data infile 'C:/FotoPerfil.csv'
into table foto_perfil
fields terminated by ","
lines terminated by "\r\n";


load data infile 'C:/colores.csv' 
into table colores
fields terminated by ","
lines terminated by "\r\n";

call insertarColoresTraduccion();

call crearPartida();

call crearComentarios();

call añadirPuntuacion();

call asignarTorneosPartida();











