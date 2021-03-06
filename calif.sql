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

-- docente y materias

create TABLE docente(
  id int PRIMARY key identity(1,1),
  
  idEmpleado int not null,
  usuarioReg int not null, -- lave foranea de la tabla usuario

  FOREIGN key (idEmpleado) references empleado(id),
  FOREIGN key (usuarioReg) references usuario(id),
  
  )
  
  
create table materia(
  id int PRIMARY key identity(1,1),
  
  NombreMateria varchar(100) not null unique,
  
  fecha_registro DATETIME not null default GETDATE(),

  usuarioReg int not null, -- lave foranea de la tabla usuario
  
  FOREIGN key (usuarioReg) references usuario(id)
  
  )
 
 create table docenteMateria(
   
   id int PRIMARY key identity(1,1),
   
   idDocente int not null,
   idMateria int not null,
   
   FOREIGN key (idDocente) references docente(id),
   
   FOREIGN key (idMateria) references materia(id)
   
   
   )
-- estudiante grado matricula


create table grado(
  id int PRIMARY key identity(1,1),
  NumGrado int not null,

  )
  
create table gradoMateria(
  id int PRIMARY key identity(1,1),
  
  idGrado int not null,
  idMateria int not null,
  
  
  FOREIGN key (idGrado) references grado(id),
  FOREIGN key (idMateria) references materia(id),
  
  
  
  )
  
  
create TABLE estudiante (
  id int PRIMARY key identity(1,1),
  
  carnet varchar(8) not null unique,
  
  idDatos int not null,
  usuarioreg int not null,
  idGrado int not null,
  
  fecha_registro DATETIME not null DEFAULT GETDATE(),
  FOREIGN key (idDatos) references DatosPersonales(id),
  FOREIGN key (idGrado) references grado(id),
  FOREIGN key (usuarioreg) references usuario(id),
  
  
  )
  
  
create table matricula(
  id int PRIMARY key identity(1,1),
  
  carnet varchar(8) not null unique,
  
  idMateria int not null,
  idEstudiante int not null,
  
  FOREIGN key (idMateria) references materia(id),
  FOREIGN key (idEstudiante) references estudiante(id),
  
  
  
  )
  
  -- calificaciones


  create table calif(
  id int PRIMARY key identity(1,1),
  
  PrimerParcial decimal(4,2) not null check (PrimerParcial >=0 AND PrimerParcial <=50),
  SegundoParcial decimal(4,2) not null check (SegundoParcial >=0 AND SegundoParcial <=50),
  
  totalCalif AS PrimerParcial + SegundoParcial, --define el campo calculado del total de la calificacione
  
  iddocente int not null,
  idestudiante int not null,
  idMateria int not null,
  
  
  FOREIGN key (idMateria) references materia(id),
  FOREIGN key (iddocente) references docente(id),
  FOREIGN key (idestudiante) references estudiante(id),
   
  
  
  
  )


-- agregar los constraints 

 Alter table telefono
  	add CONSTRAINT ck_telefono CHECK (numeroTelefono LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
  
  alter TABLE estudiante
  	add CONSTRAINT ck_carnet CHECK (carnet LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')

  /*
  	tabla telefono al Numtelefono 
    tablar estudiante al carnet
  
  
  */
  
  
  -- rellenar roles y permisos

-- admin

INSERT INTO roles (nombre_rol) VALUES (
  'Administrador'
); 

-- Secretario Academico

INSERT INTO roles (nombre_rol) VALUES (
  'Secretario academico'
); 

-- docente

INSERT INTO roles (nombre_rol) VALUES (
  'Docente'
); 

-- Estudiante

INSERT INTO roles (nombre_rol) VALUES (
  'Estudiante'
); 


-- PERMISOS


INSERT INTO permisos (nombre_permiso) VALUES (
  'Crear-Usuario'
); 


INSERT INTO permisos (nombre_permiso) VALUES (
  'editar-Usuario'
); 

INSERT INTO permisos (nombre_permiso) VALUES (
  'Ver-calificaciones'
); 
INSERT INTO permisos (nombre_permiso) VALUES (
  'Registrar-docente'
); 
INSERT INTO permisos (nombre_permiso) VALUES (
  'Registrar-estudiante'
); 
INSERT INTO permisos (nombre_permiso) VALUES (
  'Registrar-Materias'
); 


INSERT INTO permisos (nombre_permiso) VALUES (
  'Registrar-calificaciones'
); 

INSERT INTO permisos (nombre_permiso) VALUES (
  'Asignar-Materias-Docente'
); 
INSERT INTO permisos (nombre_permiso) VALUES (
  'Asignar-Materias-Estudiante'
); 




-- roles y permisos por defecto solicitados en el problema




-- para el admin
INSERT INTO rolesPermisos (id_rol,id_permiso) VALUES (
  '1',
  '1'
); 




INSERT INTO rolesPermisos (id_rol,id_permiso) VALUES (
  '1',
  '2'
); 


INSERT INTO rolesPermisos (id_rol,id_permiso) VALUES (
  '1',
  '3'
); 


-- para el secretario 

INSERT INTO rolesPermisos (id_rol,id_permiso) VALUES (
  '2',
  '4'
); 

INSERT INTO rolesPermisos (id_rol,id_permiso) VALUES (
  '2',
  '5'
); 



INSERT INTO rolesPermisos (id_rol,id_permiso) VALUES (
  '2',
  '6'
); 



INSERT INTO rolesPermisos (id_rol,id_permiso) VALUES (
  '2',
  '8'
); 


INSERT INTO rolesPermisos (id_rol,id_permiso) VALUES (
  '2',
  '9'
); 



INSERT INTO rolesPermisos (id_rol,id_permiso) VALUES (
  '2',
  '3'
); 




INSERT INTO rolesPermisos (id_rol,id_permiso) VALUES (
  '2',
  '1'
); 



INSERT INTO rolesPermisos (id_rol,id_permiso) VALUES (
  '2',
  '2'
); 



-- docente



INSERT INTO rolesPermisos (id_rol,id_permiso) VALUES (
  '3',
  '7'
); 



INSERT INTO rolesPermisos (id_rol,id_permiso) VALUES (
  '3',
  '3'
); 


-- estudiante 

INSERT INTO rolesPermisos (id_rol,id_permiso) VALUES (
  '4',
  '3'
); 





  /*
  	Admin 
    	- crea ususarios 
        - editar usuario 
        -ver reporte calificaciones
    Secretario academico
    	-Registra Docentes 
        - registra estudiantes 
        - Refistra Materias 
        - Asigna docentes y estudiantes a materias 
        - Ve reportes de calificaciones 
        - Crea usuario y edita 
    
    Docente
    	- Registra Calificaciones
        - Puede ver calificaciones 
        
    Estudiante 
  		- - Puede ver calificaciones 
  
  
  */







