CREATE DATABASE project_db;

-------------------------------Entidades-------------------------

-------------------------------Cuenta_usuario-------------------------
CREATE TABLE cuenta_usuario (
	UID bigint PRIMARY KEY NOT NULL,
	cantidad_resina smallint NOT NULL,
	correo_electronico varchar(255) NOT NULL, 
	protogemas int NOT NULL,
	username varchar(50) NOT NULL,
	cristales_genesis int NOT NULL,
	contrasena varchar(90) NOT NULL,
	cantidad_mora bigint NOT NULL,
	desde date NOT NULL
);
ALTER TABLE cuenta_usuario ADD CONSTRAINT cuenta_usuario_emailunique UNIQUE (correo_electronico);
ALTER TABLE cuenta_usuario ADD CONSTRAINT cuenta_cantidad_resina_notneg CHECK (cantidad_resina >= 0); 
ALTER TABLE cuenta_usuario ADD CONSTRAINT cuenta_protogemas_notneg CHECK (protogemas >= 0); 
ALTER TABLE cuenta_usuario ADD CONSTRAINT cuenta_cantidad_mora_notneg CHECK (cantidad_mora >= 0);
ALTER TABLE cuenta_usuario ADD CONSTRAINT cuenta_cristales_genesis_notneg CHECK (cristales_genesis >= 0); 


-------------------------------objeto-------------------------
CREATE TABLE objeto (
	id int PRIMARY KEY NOT NULL,
	c_uid bigint PRIMARY KEY NOT NULL
	cantidad int NOT NULL,
	obj_estrellas smallint NOT NULL, 
	tipo_obj varchar(50) NOT NULL,
	nombre varchar(255) NOT NULL,
);
ALTER TABLE objeto ADD CONSTRAINT objeto_uid_fk FOREIGN KEY (c_uid) REFERENCES cuenta_usuario (UID);
ALTER TABLE objeto ADD CONSTRAINT objeto_cantidad_notneg CHECK (cantidad >= 0);


-------------------------------mapa-------------------------
CREATE TABLE mapa (
	nombre varchar(60) PRIMARY KEY NOT NULL,
	c_uid bigint PRIMARY KEY NOT NULL,
	porcentaje_cmplt double precision NOT NULL,
	nivel_mundo smallint NOT NULL
);
ALTER TABLE mapa ADD CONSTRAINT mapa_uid_fk FOREIGN KEY (c_uid) REFERENCES cuenta_usuario (UID);


-------------------------------region-------------------------
CREATE TABLE region (
	nombre_r varchar(60) PRIMARY KEY NOT NULL,
	nombre_m varchar(60) PRIMARY KEY NOT NULL, 
	c_uid bigint PRIMARY KEY NOT NULL,
	prcntj_cmplt_r double precision NOT NULL,
	cant_tp_act smallint NOT NULL,
	cant_boss_act smallint NOT NULL,
	cant_dominios_act smallint NOT NULL,
	cant_estatuas_act smallint NOT NULL
);
ALTER TABLE region ADD CONSTRAINT region_nombre_m_fk FOREIGN KEY (nombre_m) REFERENCES mapa (nombre);
ALTER TABLE region  ADD CONSTRAINT region_uid_fk FOREIGN KEY (c_uid) REFERENCES cuenta_usuario (UID);


-------------------------------evento_accion-------------------------
CREATE TABLE evento_accion (
	nombre_r varchar(60) PRIMARY KEY NOT NULL,
	nombre_m varchar(60) PRIMARY KEY NOT NULL,
	c_uid bigint PRIMARY KEY NOT NULL,
	id int PRIMARY KEY NOT NULL,
	posicion_mapa varchar(50) NOT NULL,
	tipo_accion varchar(150) NOT NULL,
	obj_id int NOT NULL,
	cantidad smallint NOT NULL
);
ALTER TABLE evento_accion ADD CONSTRAINT evento_accion_nombre_r_fk FOREIGN KEY (nombre_r) REFERENCES region (nombre_r);
ALTER TABLE evento_accion ADD CONSTRAINT evento_accion_nombre_m_fk FOREIGN KEY (nombre_m) REFERENCES mapa (nombre);
ALTER TABLE evento_accion ADD CONSTRAINT evento_accion_uid_fk FOREIGN KEY (c_uid) REFERENCES cuenta_usuario (UID);


-------------------------------evento_mision-------------------------
CREATE TABLE evento_mision (
	id int PRIMARY KEY NOT NULL, 
	nombre varchar(255) NOT NULL,
	desde date NOT NULL,
	hasta date NOT NULL
),

ALTER TABLE evento_mision ADD CONSTRAINT eventmis_fecha_check CHECK (desde <= hasta);


-------------------------------tienda-------------------------
CREATE TABLE tienda (
	codigo bigint PRIMARY KEY NOT NULL,
	c_uid bigint NOT NULL,
	tipo_div varchar(50) NOT NULL,
	fecha date NOT NULL,
	obj_id bigint NOT NULL, 
	cantidad smallint NOT NULL,
	cargo int NOT NULL
);
ALTER TABLE tienda ADD CONSTRAINT tienda_c_uid_fk FOREIGN KEY (c_uid) REFERENCES cuenta_usuario (UID);


-------------------------------gachapon-------------------------
CREATE TABLE gachapon (
	codigo bigint PRIMARY KEY NOT NULL,
	tipo varchar(50) NOT NULL,
	obj_id bigint NOT NULL,
	fecha_hora date NOT NULL,
);


-------------------------------Otorga_em-------------------------
CREATE TABLE Otorga_em (
	eventmis_id int PRIMARY KEY NOT NULL,
	obj_id int PRIMARY KEY NOT NULL,
	uid bigint PRIMARY KEY NOT NULL,
	cantidad int NOT NULL,
	fecha date
);

ALTER TABLE Otorga_em ADD CONSTRAINT otorga_eventmis_id_fk FOREIGN KEY (eventmis_id) REFERENCES evento_mision (id);
ALTER TABLE Otorga_em ADD CONSTRAINT otorga_obj_id_fk FOREIGN KEY (obj_id) REFERENCES objeto (id);
ALTER TABLE Otorga_em ADD CONSTRAINT otorga_uid_fk FOREIGN KEY (uid) REFERENCES usuario (uid);


-------------------------------otorga_gachapon-------------------------
CREATE TABLE otorga_gachapon(
	gacha_id bigint PRIMARY KEY NOT NULL,
	obj_id int PRIMARY KEY NOT NULL,
	uid bigint PRIMARY KEY NOT NULL,
	cantidad int NOT NULL,
	fecha date
);
ALTER TABLE otorga_gachapon ADD CONSTRAINT otor_gachapon_gacha_id_fk FOREIGN KEY (gacha_id) REFERENCES gachapon(codigo);
ALTER TABLE otorga_gachapon ADD CONSTRAINT otor_gachapon_obj_id_fk FOREIGN KEY (obj_id) REFERENCES objeto (id);
ALTER TABLE otorga_gachapon ADD CONSTRAINT otor_gachapon_uid_fk FOREIGN KEY (uid) REFERENCES usuario (uid);

