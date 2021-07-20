CREATE DATABASE project_db;

-------------------------------Entidades-------------------------

-------------------------------Cuenta_usuario-------------------------
CREATE TABLE cuenta_usuario (
	UID bigint PRIMARY KEY NOT NULL,
	correo_electronico varchar(255) NOT NULL, 
	username varchar(50) NOT NULL,
	contrasena varchar(90) NOT NULL,
	desde date NOT NULL
);
ALTER TABLE cuenta_usuario ADD CONSTRAINT cuenta_usuario_emailunique UNIQUE (correo_electronico);



-------------------------------objeto-------------------------
CREATE TABLE objeto (
	id int NOT NULL,
	c_uid bigint NOT NULL,
	cantidad int NOT NULL,
	obj_estrellas smallint NOT NULL, 
	tipo_obj varchar(50) NOT NULL,
	nombre varchar(255) NOT NULL,
	PRIMARY KEY (id,c_uid)
);
ALTER TABLE objeto ADD CONSTRAINT objeto_uid_fk FOREIGN KEY (c_uid) REFERENCES cuenta_usuario (UID);
ALTER TABLE objeto ADD CONSTRAINT objeto_cantidad_notneg CHECK (cantidad >= 0);
ALTER TABLE objeto ADD CONSTRAINT objeto_estrellas_notneg CHECK (obj_estrellas >= 0);


-------------------------------mapa-------------------------
CREATE TABLE mapa (
	nombre varchar(60) NOT NULL,
	c_uid bigint NOT NULL,
	porcentaje_cmplt double precision NOT NULL,
	nivel_mundo smallint NOT NULL,
	PRIMARY KEY (nombre, c_uid)
);
ALTER TABLE mapa ADD CONSTRAINT mapa_uid_fk FOREIGN KEY (c_uid) REFERENCES cuenta_usuario (UID);
ALTER TABLE mapa ADD CONSTRAINT mapa_porcntj_compl_range CHECK (porcentaje_cmplt BETWEEN 0 AND 100);
ALTER TABLE mapa ADD CONSTRAINT mapa_nivmund_notneg CHECK (nivel_mundo >= 0);


-------------------------------region-------------------------
CREATE TABLE region (
	nombre_r varchar(60) NOT NULL,
	nombre_m varchar(60) NOT NULL, 
	c_uid bigint NOT NULL,
	prcntj_cmplt_r double precision NOT NULL,
	cant_tp_act smallint NOT NULL,
	cant_boss_act smallint NOT NULL,
	cant_dominios_act smallint NOT NULL,
	cant_estatuas_act smallint NOT NULL,
	PRIMARY KEY (nombre_r, nombre_m, c_uid)
);
ALTER TABLE region ADD CONSTRAINT region_nombre_m_c_uid FOREIGN KEY (nombre_m, c_uid) REFERENCES mapa (nombre, c_uid);
ALTER TABLE region ADD CONSTRAINT region_prcntj_cmplt_r_range CHECK (prcntj_cmplt_r BETWEEN  0 AND 100);
ALTER TABLE region ADD CONSTRAINT region_cant_tp_notneg CHECK (cant_tp_act >= 0);
ALTER TABLE region ADD CONSTRAINT region_cant_boss_notneg CHECK (cant_boss_act >= 0);
ALTER TABLE region ADD CONSTRAINT region_cant_dominios_notneg CHECK (cant_dominios_act >= 0);
ALTER TABLE region ADD CONSTRAINT region_cant_estatuas_notneg CHECK (cant_estatuas_act >= 0);


-------------------------------recompensa_explo-------------------------
CREATE TABLE recompensa_explo (
	nombre_r varchar(60) NOT NULL,
	nombre_m varchar(60) NOT NULL,
	c_uid bigint NOT NULL,
	id int NOT NULL,
	posicion_mapa varchar(50) NOT NULL,
	tipo_accion varchar(150) NOT NULL,
	obj_id int NOT NULL,
	obj_estrellas smallint NOT NULL, 
	tipo_obj varchar(50) NOT NULL,
	nombre_obj varchar(255) NOT NULL,
	cantidad smallint NOT NULL,
	PRIMARY KEY (nombre_r, nombre_m, c_uid, id)
);
ALTER TABLE recompensa_explo ADD CONSTRAINT recompensa_explo_fks FOREIGN KEY (nombre_r, nombre_m, c_uid) REFERENCES region(nombre_r, nombre_m, c_uid);
ALTER TABLE recompensa_explo ADD CONSTRAINT recompensa_explo_obj_id_fk FOREIGN KEY (c_uid ,obj_id) REFERENCES objeto (c_uid, id);
ALTER TABLE recompensa_explo ADD CONSTRAINT recompensa_explo_cant_notneg CHECK (cantidad >= 0);


-------------------------------evento_mision-------------------------
CREATE TABLE evento_mision (
	id int NOT NULL, 
	nombre varchar(255) NOT NULL,
	desde date NOT NULL,
	hasta date NOT NULL,
	PRIMARY KEY (id)
);

ALTER TABLE evento_mision ADD CONSTRAINT eventmis_fecha_check CHECK (desde <= hasta);


-------------------------------compra-------------------------
CREATE TABLE compra (
	codigo bigint NOT NULL,
	c_uid bigint NOT NULL,
	tipo_div varchar(50) NOT NULL,
	fecha date NOT NULL,
	obj_id bigint NOT NULL,
	obj_estrellas smallint NOT NULL, 
	tipo_obj varchar(50) NOT NULL,
	nombre_obj varchar(255) NOT NULL,	
	cantidad smallint NOT NULL,
	cargo int NOT NULL,
	PRIMARY KEY (codigo)
);
ALTER TABLE compra ADD CONSTRAINT compra_fks FOREIGN KEY (c_uid,obj_id) REFERENCES objeto (c_uid, id);
ALTER TABLE compra ADD CONSTRAINT compra_tipo_div_rest CHECK (tipo_div = 'USD' OR  tipo_div = 'protogema' OR tipo_div = 'mora' OR tipo_div = 'cristal_genesis');
ALTER TABLE compra ADD CONSTRAINT compra_cantidad_notneg CHECK (cantidad >= 0);
ALTER TABLE compra ADD CONSTRAINT compra_cargo_notneg CHECK (cargo >= 0);


-------------------------------gachapon-------------------------
CREATE TABLE gachapon (
	codigo bigint NOT NULL,
	tipo varchar(50) NOT NULL,
	obj_id bigint NOT NULL,
	PRIMARY KEY (codigo)
);

COPY genshin_db.compra FROM 'C:\Users\Dom\Desktop\utec\4 ciclo\Base de datos 1\Proyecto_BaseDe_Datos\DATA\compra.tsv' DELIMITER E',';

-------------------------------Otorga_em-------------------------
CREATE TABLE otorga_evento_mision (
	eventmis_id int NOT NULL,
	obj_id int NOT NULL,
	c_uid bigint NOT NULL,
	obj_estrellas smallint NOT NULL, 
	tipo_obj varchar(50) NOT NULL,
	nombre_obj varchar(255) NOT NULL,
	cantidad int NOT NULL,
	fecha timestamp,
	PRIMARY KEY (eventmis_id, obj_id, c_uid)
);

ALTER TABLE otorga_evento_mision ADD CONSTRAINT otorga_eventmis_id_fk FOREIGN KEY (eventmis_id) REFERENCES evento_mision (id);
ALTER TABLE otorga_evento_mision ADD CONSTRAINT otorga_eventmis_obj_uid_fk FOREIGN KEY (obj_id, c_uid) REFERENCES objeto (id, c_uid);
ALTER TABLE otorga_evento_mision ADD CONSTRAINT otorga_cantidad_notneg CHECK (cantidad >= 0);

-------------------------------otorga_gachapon-------------------------
CREATE TABLE otorga_gachapon(
	gacha_id bigint NOT NULL,
	obj_id int NOT NULL,
	c_uid bigint NOT NULL,
	obj_estrellas smallint NOT NULL, 
	tipo_obj varchar(50) NOT NULL,
	nombre_obj varchar(255) NOT NULL,
	cantidad int NOT NULL,
	fecha timestamp,
	PRIMARY KEY (gacha_id, obj_id, c_uid)
);
ALTER TABLE otorga_gachapon ADD CONSTRAINT otor_gachapon_gacha_id_fk FOREIGN KEY (gacha_id) REFERENCES gachapon(codigo);
ALTER TABLE otorga_gachapon ADD CONSTRAINT otor_gachapon_obj_uid_fk FOREIGN KEY (obj_id, c_uid) REFERENCES objeto (id, c_uid);
ALTER TABLE otorga_gachapon ADD CONSTRAINT otor_gachapon_cantidad_notneg CHECK (cantidad >= 0);

-------------------------------FUNCTIONS AND TRIGGERS-------------------------

-------------------------------INSERTAR OBJETOS CUANDO OCURRE UN EVENTO-------------------------------------
CREATE OR REPLACE FUNCTION update_object_after_event()
RETURNS TRIGGER AS $$
	BEGIN
		IF(TG_OP = 'INSERT') THEN
			UPDATE objeto 
			SET cantidad = cantidad + NEW.cantidad 
			WHERE objeto.id = NEW.obj_id
			AND objeto.c_uid = NEW.c_uid;
			IF NOT FOUND THEN
				INSERT INTO objeto VALUES(
					NEW.obj_id, 
					NEW.c_uid, 
					NEW.cantidad, 
					NEW.obj_estrellas,
					NEW.tipo_obj,
					NEW.nombre_obj);
			END IF;
			RETURN NEW;
		END IF;
	END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_obj_trigger
BEFORE INSERT OR UPDATE ON recompensa_explo
	FOR EACH ROW EXECUTE PROCEDURE update_object_after_event();
	
CREATE TRIGGER update_obj_trigger
BEFORE INSERT OR UPDATE ON otorga_evento_mision
	FOR EACH ROW EXECUTE PROCEDURE update_object_after_event();
	
CREATE TRIGGER update_obj_trigger
BEFORE INSERT OR UPDATE ON otorga_gachapon
	FOR EACH ROW EXECUTE PROCEDURE update_object_after_event();
	
CREATE TRIGGER update_obj_trigger
BEFORE INSERT OR UPDATE ON compra
	FOR EACH ROW EXECUTE PROCEDURE update_object_after_event();
	
--------------------------------CUANDO SE CREA UN USUARIO GENERAR OBJETOS BASICOS Y MAPA-----------------------

CREATE OR REPLACE FUNCTION generate_basic_objects()
RETURNS TRIGGER AS $$
	BEGIN
		IF(TG_OP = 'INSERT')THEN
			INSERT INTO objeto VALUES(
				0,
				NEW.uid,
				0,
				1,
				'divisa',
				'mora');
			INSERT INTO objeto VALUES(
				1,
				NEW.uid,
				0,
				5,
				'divisa',
				'protogemas');
			INSERT INTO objeto VALUES(
				2,
				NEW.uid,
				0,
				5,
				'divisa',
				'cristales_genesis');
		END IF;
		RETURN NEW;
	END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER generate_basics
AFTER INSERT ON cuenta_usuario
	FOR EACH ROW EXECUTE PROCEDURE generate_basic_objects();
	

CREATE OR REPLACE FUNCTION generate_map()
RETURNS TRIGGER AS $$
	BEGIN
		IF(TG_OP = 'INSERT')THEN
			INSERT INTO mapa VALUES(
				'Teyvat',
				NEW.uid,
				0,
				0);
		END IF;
		RETURN NEW;
	END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER generate_map_before_insert_user
AFTER INSERT ON cuenta_usuario
	FOR EACH ROW EXECUTE PROCEDURE generate_map();
	
---------------------------------------TRANSACCIONES(POR HACER)-----------------------------------------------























----------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION add_object (
	n_id int,
	n_c_uid bigint,
	n_cantidad int,
	n_obj_estrellas smallint, 
	n_tipo_obj varchar,
	n_nombre varchar
	)
RETURNS void AS $$
BEGIN
	IF NOT EXISTS(
		SELECT *
		FROM objeto O
		WHERE O.c_uid = n_c_uid
		AND O.id = n_id)
	THEN
		INSERT INTO objeto VALUES (n_id, n_c_uid, n_cantidad, n_obj_estrellas, n_tipo_obj, n_nombre);
	END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_cant_object (
	n_id int,
	n_c_uid bigint,
	n_cantidad int
	)
RETURNS void AS $$
BEGIN
	IF EXISTS(
		SELECT *
		FROM objeto O
		WHERE O.c_uid = n_c_uid
		AND O.id = n_id)
	THEN
		UPDATE objeto 
		SET cantidad = cantidad + n_cantidad
		WHERE objeto.c_uid = n_c_uid 
		AND objeto.id = n_id;
	END IF;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION sub_cant_object (
	n_id int,
	n_c_uid bigint,
	n_cantidad int
	)
RETURNS void AS $$
BEGIN
	IF EXISTS(
		SELECT *
		FROM objeto O
		WHERE O.c_uid = n_c_uid
		AND O.id = n_id)
	THEN
		UPDATE objeto 
		SET cantidad = cantidad - n_cantidad 
		WHERE objeto.c_uid = n_c_uid 
		AND objeto.id = n_id;
	END IF;
END;
$$ LANGUAGE plpgsql;





	
	