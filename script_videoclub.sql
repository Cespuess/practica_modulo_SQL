create schema if not exists videoclub;

set schema 'videoclub';

-- CREAMOS LAS TABLAS

create table if not exists socios(
	id serial primary key,
	dni varchar(50) not null,
	nombre varchar(50) not null,
	apellidos varchar(50) not null, 
	fecha_nacimiento date not null,
	telefono varchar(20) not null,
	email varchar(50) not null
);

create table if not exists direccion(
	id_socio int primary key,
	calle varchar(50) not null,
	numero varchar(5),
	piso varchar(10),
	id_codigo_postal int not null
);

create table if not exists codigo_postal(
	id serial primary key,
	codigo varchar(10) not null
);

create table if not exists prestamos(
	id serial primary key,
	id_pelicula int not null,
	id_socio int not null,
	fecha_prestamo date not null, 
	fecha_devolucion date default null
);

create table if not exists peliculas(
	id serial primary key,
	titulo varchar(80) not null,
	id_genero int not null,
	id_director int not null,
	sinopsis text not null,
	num_copias int not null
);

create table if not exists generos(
	id serial primary key,
	nombre varchar(50) not null
);

create table if not exists directores(
	id serial primary key,
	nombre varchar(80) not null
);

-- CREAMOS LAS FK

alter table peliculas 
add constraint fk_directores_peliculas
foreign key (id_director)
references directores(id);

alter table peliculas 
add constraint fk_generos_peliculas
foreign key (id_genero)
references generos(id);

alter table prestamos 
add constraint fk_peliculas_prestamos
foreign key (id_pelicula)
references peliculas (id);

alter table prestamos 
add constraint fk_socios_prestamos
foreign key (id_socio)
references socios(id);

alter table direccion 
add constraint fk_socios_direccion
foreign key (id_socio)
references socios(id);

alter table direccion 
add constraint fk_codigo_postal_direccion
foreign key (id_codigo_postal)
references codigo_postal(id);

-- CREAMOS LOS UNIQUE INDEX

create unique index index_titulo_pelicula on peliculas (lower(titulo));

create unique index index_nombre_genero on generos (lower(nombre));

create unique index index_nombre_director on directores (lower(nombre));

create unique index index_dni_socio on socios (lower(dni));

create unique index index_codigo_codigo_postal on codigo_postal (lower(codigo));

