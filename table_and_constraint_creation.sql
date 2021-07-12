CREATE DATABASE project_db;

-------------------------------Entidades-------------------------

CREATE TABLE cuenta_usuario (
	UID bigint NOT NULL,
	cantidad_resina smallint NOT NULL,
	correo_electronico varchar(255) NOT NULL, 
	protogemas smallint NOT NULL,
	username varchar(50) NOT NULL,
	cristales_genesis bigint NOT NULL,
	contrasena varchar(90) NOT NULL,
	cantidad_mora bigint NOT NULL,
	desde date NOT NULL
);
ALTER TABLE cuenta_usuario ADD CONSTRAINT uid_pk PRIMARY KEY (UID);



CREATE TABLE objeto (
	id int NOT NULL,
	cantidad int NOT NULL,
	obj_estrellas smallint NOT NULL, 
	tipo_obj varchar(50) NOT NULL,
	nombre varchar(255) NOT NULL,
c_uid bigint PRIMARY KEY NOT NULL
);
ALTER TABLE objeto ADD CONSTRAINT id_obj_pk PRIMARY KEY (id);
ALTER TABLE objeto ADD CONSTRAINT uid_fk_1 FOREIGN KEY (c_uid) REFERENCES cuenta_usuario (UID);



CREATE TABLE mapa (
	nombre varchar(60) NOT NULL,
	c_uid bigint PRIMARY KEY NOT NULL,
	porcentaje_cmplt double precision NOT NULL,
	nivel_mundo smallint NOT NULL
);
ALTER TABLE mapa ADD CONSTRAINT nm_pk PRIMARY KEY (nombre);
ALTER TABLE mapa ADD CONSTRAINT uid_fk_2 FOREIGN KEY (c_uid) REFERENCES cuenta_usuario (UID);




CREATE TABLE region (
	nombre_r varchar(60) NOT NULL,
	nombre_m varchar(60) PRIMARY KEY NOT NULL, 
	c_uid bigint PRIMARY KEY NOT NULL,
	prcntj_cmplt_r double precision NOT NULL,
	cant_tp_act smallint NOT NULL,
	cant_boss_act smallint NOT NULL,
	cant_dominios_act smallint NOT NULL,
	cant_estatuas_act smallint NOT NULL
);
ALTER TABLE region ADD CONSTRAINT nombre_pk PRIMARY KEY (nombre_r);
ALTER TABLE region ADD CONSTRAINT nombre_m_fk FOREIGN KEY (nombre_m) REFERENCES mapa (nombre);
ALTER TABLE region  ADD CONSTRAINT uid_fk_3 FOREIGN KEY (c_uid) REFERENCES cuenta_usuario (UID);



CREATE TABLE evento_accion (
	nombre_r varchar(60) PRIMARY KEY NOT NULL,
	nombre_m varchar(60) PRIMARY KEY NOT NULL,
	c_uid bigint PRIMARY KEY NOT NULL,
	id int NOT NULL,
	posicion_mapa varchar(50) NOT NULL,
	tipo_accion varchar(150) NOT NULL,
	obj_id int NOT NULL,
	cantidad smallint NOT NULL
);
ALTER TABLE evento_accion ADD CONSTRAINT id_evac_pk PRIMARY KEY (id);
ALTER TABLE evento_accion ADD CONSTRAINT nombre_r_fk FOREIGN KEY (nombre_r) REFERENCES region (nombre_r);
ALTER TABLE evento_accion ADD CONSTRAINT nombre_m1_fk FOREIGN KEY (nombre_m) REFERENCES mapa (nombre);
ALTER TABLE evento_accion ADD CONSTRAINT uid_fk_4 FOREIGN KEY (c_uid) REFERENCES cuenta_usuario (UID);



CREATE TABLE evento_mision (
	id int NOT NULL, 
	nombre varchar(255) NOT NULL,
	desde date NOT NULL,
	hasta date NOT NULL
),
ALTER TABLE evento_mision ADD CONSTRAINT id_evmi_pk PRIMARY KEY (id);
--CHECK IF not desde > hasta


CREATE TABLE tienda (
	codigo bigint NOT NULL,
	tipo_div varchar(50) NOT NULL,
	fecha date NOT NULL,
	obj_id bigint NOT NULL, 
	cantidad smallint NOT NULL,
	cargo int NOT NULL
);
ALTER TABLE tienda ADD CONSTRAINT codigo_pk PRIMARY KEY (codigo);


CREATE TABLE gachapon (
	codigo bigint NOT NULL,
	tipo varchar(50) NOT NULL,
	obj_id bigint NOT NULL,
	fecha_hora date NOT NULL,
);
ALTER TABLE gachapon ADD CONSTRAINT gachapon_codigo_pk PRIMARY KEY (codigo);


CREATE TABLE Otorga_em (
	eventmis_id bigint PRIMARY KEY NOT NULL,
	obj_id bigint PRIMARY KEY NOT NULL,
	uid bigint PRIMARY KEY NOT NULL,
	cantidad int NOT NULL,
	fecha date
);

ALTER TABLE Otorga_em ADD CONSTRAINT otorga_eventmis_id_fk FOREIGN KEY (eventmis_id) REFERENCES evento_mision (id);

ALTER TABLE Otorga_em ADD CONSTRAINT otorga_obj_id_fk FOREIGN KEY (obj_id) REFERENCES objeto (id);

ALTER TABLE Otorga_em ADD CONSTRAINT otorga_uid_fk FOREIGN KEY (uid) REFERENCES usuario (uid);





CREATE TABLE otorga_gachapon(
	gacha_id bigint PRIMARY KEY NOT NULL,
	obj_id bigint PRIMARY KEY NOT NULL,
	uid bigint PRIMARY KEY NOT NULL,
	cantidad int NOT NULL,
	fecha date
);
ALTER TABLE otorga_gachapon ADD CONSTRAINT otor_gachapon_gacha_id_fk FOREIGN KEY (gacha_id) REFERENCES gachapon(codigo);

ALTER TABLE otorga_gachapon ADD CONSTRAINT otor_gachapon_obj_id_fk FOREIGN KEY (obj_id) REFERENCES objeto (id);

ALTER TABLE otorga_gachapon ADD CONSTRAINT otor_gachapon_uid_fk FOREIGN KEY (uid) REFERENCES usuario (uid);

