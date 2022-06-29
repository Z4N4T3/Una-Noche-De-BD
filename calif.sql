create table usuario(
  
  id int PRIMARY KEY identity(1,1),
  nombre_susario varchar (100) not null unique,
  contrasenia varchar (100) not null,
  
  fecha_rea DATETIME not null default GETDATE(),
  
  )
  
-- roles

CREATE table roles(
  
  id int PRIMARY key identity (1,1),
  nombre_rol varchar(100) not null unique,
  
  )

CREATE table rolesUsuario(
  
  id int PRIMARY key identity (1,1),
  id_rol int not null,
  id_usuario int not null,
  
  FOREIGN key (id_rol) references roles(id),
  FOREIGN key (id_usuario) references usuario(id),
  )

CREATE table permisos(
  
  id int PRIMARY key identity (1,1),
  nombre_permiso varchar(100) not null unique,
  
  
  
  
  )
  
CREATE table rolesPermisos(
  
  id int PRIMARY key identity (1,1),
  id_rol int not null,
  id_permiso int not null,
  
  FOREIGN key (id_rol) references roles(id),
  FOREIGN key (id_permiso) references permisos(id),
  )





-- empleado, sexo, datos personales, cargo, telefono

create table sexo(
  id int PRIMARY key identity (1,1),
  
  sexo bit not null,
  )



CREATE table DatosPersonales(
  id int PRIMARY key identity (1,1),
  
  Nombre varchar (100) not null,
  Apellido varchar (100) not null,
  idSexo int not null,
  
  FOREIGN key (idSexo) references sexo(id)

  )
  
create table telefono(
  id int PRIMARY key identity (1,1),
  
  numeroTelefono varchar(8) not null,
  idDatos int not null,

  FOREIGN key (idDatos) references DatosPersonales(id)
  
  
  )


create table cargo(
  id int PRIMARY key identity (1,1),
  nombreCargo varchar(100) not null,
  
  )
CREATE table empleado(
  id int PRIMARY key identity (1,1),
  idCargo int not null,
  idUsuario int not null,
  idDatos int not null,
  
  fecha_contrata DATETIME not null,
  
  
  FOREIGN key (idCargo) references cargo(id),
  FOREIGN key (idUsuario) references usuario(id),
  FOREIGN key (idDatos) references DatosPersonales(id)
  
  
  
  )