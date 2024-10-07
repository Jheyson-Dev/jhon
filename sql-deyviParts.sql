CREATE DATABASE db_deybiparts CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
use db_deybiparts;

CREATE TABLE categoria (
                id_categoria INT AUTO_INCREMENT NOT NULL,
                nombre_producto VARCHAR(254) NOT NULL,
                campo_medicion VARCHAR(254) NOT NULL,
                url_campo_medicion VARCHAR(255) NULL,
                tipo VARCHAR(100) NULL,
                PRIMARY KEY (id_categoria)
);

CREATE TABLE marca_auto (
                id_marca_auto INT AUTO_INCREMENT NOT NULL,
                nombre VARCHAR(254) NOT NULL,
                img_url VARCHAR(500) NULL,
                PRIMARY KEY (id_marca_auto)
);


CREATE TABLE modelo_auto (
                id_modelo_auto INT AUTO_INCREMENT NOT NULL,
                nombre VARCHAR(254) NOT NULL,
                anio_inicio_termino VARCHAR(60) NOT NULL,
                motor VARCHAR(150) NULL,
                img_url VARCHAR(500) NULL,
                id_marca_auto INT NOT NULL,
                PRIMARY KEY (id_modelo_auto)
);


CREATE TABLE producto (
                id_producto INT AUTO_INCREMENT NOT NULL,
                codigo_OEM VARCHAR(100) NOT NULL,
                codigo_interno VARCHAR(100) NULL,
                codigo_fabricante VARCHAR(100) NOT NULL,
                origen VARCHAR(500) NULL,
                marca_fabricante VARCHAR(500) NULL,
                descripcion VARCHAR(500) NOT NULL,
                multiplos VARCHAR(200) NULL,
                consultas int DEFAULT 0,
                medida VARCHAR(254) NULL,
                id_categoria INT NOT NULL,
                precio_compra DOUBLE PRECISION NULL,
                precio_venta DOUBLE PRECISION NOT NULL,
                precio_minimo DOUBLE PRECISION NULL,
                PRIMARY KEY (id_producto)
);


CREATE TABLE img_producto (
                id_img_producto INT AUTO_INCREMENT NOT NULL,
                id_producto INT NOT NULL,
                img_url VARCHAR(500) NULL,
                PRIMARY KEY (id_img_producto)
);

CREATE TABLE oferta (
                id_oferta INT AUTO_INCREMENT NOT NULL,
                id_producto INT NOT NULL,
                descripcion VARCHAR(500) NOT NULL,
                priorizacion CHAR(2) DEFAULT 'no' CHECK (priorizacion IN ('no', 'si')),
                descuento DOUBLE PRECISION NOT NULL,
                PRIMARY KEY (id_oferta)
);

CREATE TABLE reemplazo (
                id_reemplazo INT AUTO_INCREMENT NOT NULL,
                id_producto INT NOT NULL,
                producto_reemplazo INT NOT NULL,
                variacion DOUBLE PRECISION NOT NULL,
                notas VARCHAR(400) NOT NULL,
                PRIMARY KEY (id_reemplazo)
);

CREATE TABLE aplicacion (
                id_aplicacion INT AUTO_INCREMENT NOT NULL,
                id_producto INT NOT NULL,
                id_modelo_auto INT NOT NULL,
                PRIMARY KEY (id_aplicacion)
);


CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT NOT NULL,
    username VARCHAR(254) NOT NULL,
    password VARCHAR(254) NOT NULL,
    rol VARCHAR(30) NOT NULL CHECK (rol IN ('administrador', 'trabajador', 'admin')),
    PRIMARY KEY (id_usuario)
);

CREATE TABLE tienda (
    id_tienda INT AUTO_INCREMENT NOT NULL,
    ruc VARCHAR(100) NOT NULL,
    razon_social VARCHAR(150) NOT NULL,
    direccion VARCHAR(150) NOT NULL,
    encargado VARCHAR(150) NOT NULL,
    celular VARCHAR(15) NOT NULL,
    PRIMARY KEY (id_tienda)
);


CREATE TABLE tienda_usuario (
    id_tienda_usuario INT AUTO_INCREMENT NOT NULL,
    id_usuario INT NOT NULL,
    id_tienda INT NOT NULL,
    PRIMARY KEY (id_tienda_usuario)
);

CREATE TABLE tienda_producto (
    id_tienda_producto INT AUTO_INCREMENT NOT NULL,
    id_producto INT NOT NULL,
    id_tienda INT NOT NULL,
    stock INT DEFAULT 0 NULL,
    PRIMARY KEY (id_tienda_producto)
);

-- Tablas unitarias (solo registros)

CREATE TABLE ingreso (
                id_ingreso INT AUTO_INCREMENT NOT NULL,
                id_producto INT NOT NULL,
                codigo_interno VARCHAR(100) NULL,
                id_tienda INT NOT NULL,
                razon_social VARCHAR(150) NULL,
                cantidad INT NOT NULL,
                fecha_hora VARCHAR(100) NULL,
                PRIMARY KEY (id_ingreso)
);


CREATE TABLE auto (
                id_auto INT AUTO_INCREMENT NOT NULL,
                placa VARCHAR(20) NOT NULL,
                serie_vin VARCHAR(150) NULL,
                img_url VARCHAR(500) NULL,
                PRIMARY KEY (id_auto)
);
CREATE TABLE reduccion_inventario (
                id_reduccion_inventario INT AUTO_INCREMENT NOT NULL,
                id_producto INT NOT NULL,
                codigo_interno VARCHAR(100) NULL,
                id_tienda INT NOT NULL,
                razon_social VARCHAR(150) NULL,
                cantidad INT NULL,
                usuario VARCHAR(50) NULL,
                fecha_hora DATETIME NULL,
                PRIMARY KEY (id_reduccion_inventario)
);
CREATE TABLE compra (
                id_compra INT AUTO_INCREMENT NOT NULL,
                numero_factura VARCHAR(20) NULL,
                proveedor VARCHAR(20) NULL,
                fecha_inicio_vencimiento VARCHAR(60) NULL,
                estado CHAR(1) DEFAULT 1 CHECK (estado IN (1, 0)),
                img_url VARCHAR(500) NULL,
                PRIMARY KEY (id_compra)
);
CREATE TABLE pedido (
                id_pedido INT AUTO_INCREMENT NOT NULL,
                descripcion VARCHAR(400) NULL,
                medidas VARCHAR(100) NULL,
                cantidad INT NULL,
                img_url VARCHAR(500) NULL,
                PRIMARY KEY (id_pedido)
);
CREATE TABLE traspaso (
                id_traspaso INT AUTO_INCREMENT NOT NULL,
                id_producto VARCHAR(20) NULL,
                codigo_interno VARCHAR(100) NULL,
                cantidad INT NULL,
                usuario VARCHAR(50) NULL,
                fecha_hora VARCHAR(100) NULL,
                id_tienda_origen VARCHAR(100) NULL,
                razon_social_origen VARCHAR(150) NULL,
                id_tienda_destino VARCHAR(100) NULL,
                razon_social_destino VARCHAR(150) NULL,
                PRIMARY KEY (id_traspaso)
);


-- FKs
ALTER TABLE producto ADD CONSTRAINT categoria_produco_fk
FOREIGN KEY (id_categoria)
REFERENCES categoria (id_categoria)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE modelo_auto ADD CONSTRAINT marca_auto_modelo_auto_fk
FOREIGN KEY (id_marca_auto)
REFERENCES marca_auto (id_marca_auto)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE aplicacion ADD CONSTRAINT modelo_auto_aplicacion_fk
FOREIGN KEY (id_modelo_auto)
REFERENCES modelo_auto (id_modelo_auto)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE aplicacion ADD CONSTRAINT producto_aplicacion_fk
FOREIGN KEY (id_producto)
REFERENCES producto (id_producto)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE reemplazo ADD CONSTRAINT producto_reemplazo_fk
FOREIGN KEY (id_producto)
REFERENCES producto (id_producto)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE reemplazo ADD CONSTRAINT producto_reemplazo_fk1
FOREIGN KEY (producto_reemplazo)
REFERENCES producto (id_producto)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE img_producto ADD CONSTRAINT producto_img_producto_fk
FOREIGN KEY (id_producto)
REFERENCES producto (id_producto)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE oferta ADD CONSTRAINT producto_oferta_fk
FOREIGN KEY (id_producto)
REFERENCES producto (id_producto)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE tienda_usuario ADD CONSTRAINT usuario_tienda_usuario_fk
FOREIGN KEY (id_usuario)
REFERENCES usuario (id_usuario)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE tienda_usuario ADD CONSTRAINT tienda_tienda_usuario_fk
FOREIGN KEY (id_tienda)
REFERENCES tienda (id_tienda)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE tienda_producto ADD CONSTRAINT producto_tienda_producto_fk
FOREIGN KEY (id_producto)
REFERENCES producto (id_producto)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE tienda_producto ADD CONSTRAINT tienda_tienda_producto_fk
FOREIGN KEY (id_tienda)
REFERENCES tienda (id_tienda)
ON DELETE CASCADE
ON UPDATE CASCADE;