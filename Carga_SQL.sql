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
