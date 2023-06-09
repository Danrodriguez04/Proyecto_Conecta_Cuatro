Create database Conecta_cuatro;
use Conecta_cuatro;

select * from Pais;
create table Pais(
id int (11) auto_increment primary key 
);

show tables;

create table Ciudad (
id int (11) auto_increment primary key,
id_pais int (11) not null,
CONSTRAINT fk_ciudad_pais FOREIGN KEY (id_pais)
    REFERENCES Pais(id)
);

create table Idioma (
id int auto_increment primary key,
nombre varchar (45) not null
);

create table Color (
id int auto_increment primary key
);


create table Traduccion_Ciudad (
id_idioma int ,
id_ciudad int ,
nombre varchar (45) not null,
primary key (id_idioma,id_ciudad),
constraint fk_traduccionCiudad_idioma foreign key (id_idioma) references Idioma(id),
constraint fk_traduccionCiudad_ciudad foreign key (id_ciudad) references Ciudad(id)
);

create table Traduccion_Color (
id_idioma int,
id_color int,
nombre varchar (45) not null,
primary key (id_idioma,id_color),
constraint fk_traduccionColor_idioma foreign key (id_idioma) references Idioma(id),
constraint fk_traduccionColor_color foreign key (id_color) references Color(id)
);

create table Traduccion_Pais (
id_idioma int,
id_pais int,
nombre varchar (45) not null,
primary key (id_idioma,id_pais),
constraint fk_traduccionPais_idioma foreign key (id_idioma) references Idioma(id),
constraint fk_traduccionPais_pais foreign key (id_pais) references Pais(id)
);


create table Usuario (
id int primary key auto_increment,
nombre varchar (45) not null,
apellido1 varchar (45) not null,
apellido2 varchar (45) null,
telefono varchar (18),
correo varchar (100),
fecha_nacimiento date not null,
fecha_alta date,
contraseña varchar (40),
codigo_Postal int not null,
id_ciudad int not null,
constraint fk_Usuario_ciudad foreign key (id_ciudad) references Ciudad(id)
);


create table Foto_Perfil (
id int auto_increment primary key,
ruta varchar (300) not null,
orden_fotos int,
id_usuario int not null,
constraint UC_UserOrden unique (id_usuario,orden_fotos),
constraint fk_FotoPerfil_usuario foreign key (id_usuario) references Usuario(id)
); 
drop table foto_perfil;
describe Foto_Perfil;
show create table foto_perfil;

create table Torneo (
id int auto_increment primary key,
nombre varchar (60) not null,
id_torneo_dependiente int null,
constraint fk_Torneo_torneodependiente foreign key (id_torneo_dependiente) references Torneo(id)
);

create table Participa (
id_usuario int,
id_torneo int,
clasificacion int,
primary key (id_usuario,id_torneo,clasificacion),
constraint fk_Participa_usuario foreign key (id_usuario) references Usuario(id),
constraint fk_Participa_torneo foreign key (id_torneo) references Torneo(id)
);

create table Partida (
id int auto_increment primary key,
fecha_inicio datetime not null,
fecha_final datetime null,
id_torneo int,
id_juez int not null,
puntuacion int null,
constraint chk_partida check (fecha_final > fecha_inicio),
constraint fk_Partida_torneo foreign key (id_torneo) references Torneo(id),
constraint fk_Partida_usuario foreign key (id_juez) references Usuario(id)
);
describe Partida;


create table Comentario_Partida (
fecha datetime,
id_usuario int,
id_partida int not null,
comentario varchar (250) not null,
primary key(fecha,id_usuario),
constraint fk_Comentariopartida_usuario foreign key (id_usuario) references Usuario(id),
constraint fk_Comentariopartida_partida foreign key (id_partida) references Partida(id)
);

create table Juego (
id_usuario int,
id_partida int,
id_color int not null,
puntuacion int,
gana boolean default false,  # si es 0 es falso, cualquier otro numero true
inicia boolean not null,
primary key (id_usuario,id_partida),
constraint fk_Juego_usuario foreign key (id_usuario) references Usuario(id),
constraint fk_Juego_partida foreign key (id_partida) references Partida(id),
constraint fk_Juego_color foreign key (id_color) references Color(id)
);
describe Juego;
show create table Juego;


create table Movimiento (
id int auto_increment primary key,
posicion_x int (2) not null, 
posicion_y int (2) not null, 
fecha datetime not null,
id_usuario int not null,
id_partida int not null,
constraint fk_Movimiento_usuario foreign key (id_usuario) references Usuario(id),
constraint fk_Movimiento_partida foreign key (id_partida) references Partida(id)
);

create table Comentario_Movimiento (
fecha datetime,
id_usuario int,
id_movimiento int not null,
comentario varchar (250) not null,
primary key(fecha,id_usuario),
constraint fk_Comentariomovimiento_usuario foreign key (id_usuario) references Usuario(id),
constraint fk_Comentariomovimiento_movimiento foreign key (id_movimiento) references Movimiento(id)
);

