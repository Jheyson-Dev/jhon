const XLSX = require('xlsx');
const myqsl = require('mysql2');
const config = require('../../config');

const dbconfig = {
    host: config.mysql.host,
    user: config.mysql.user,
    password: config.mysql.password,
    database: config.mysql.database,
}

let conexion;

function conexionMysql(){
    conexion = myqsl.createPool(dbconfig);

    conexion.on('error', err => {
        console.log('[db err]', err);
        if(err.code === 'PROTOCOL_CONNECTION_LOST'){
            conexionMysql();
        }else{
            throw err;
        }
    });

    console.log('DB conectada!!!');
}

conexionMysql();

async function insertarDatosDesdeExcel(rutaArchivo) {
    try {
        const workbook = XLSX.readFile(rutaArchivo);
        const sheetName = workbook.SheetNames[0];
        const worksheet = workbook.Sheets[sheetName];
        const datos = XLSX.utils.sheet_to_json(worksheet);

        for (const dato of datos) {
            await procesarFila(dato);
        }

        console.log('Inserción de datos desde Excel completada.');
    } catch (error) {
        console.error('Error al insertar datos desde Excel:', error);
    }
}

async function procesarFila(fila) {
    try {
        const nombreMarca = fila['marca_auto(nombre)'];
        let marcaId = await obtenerIdMarcaAuto(nombreMarca);
        if (!marcaId) {
            marcaId = await crearMarcaAuto(nombreMarca);
        }
        let tiendaId = await obtenerIdTienda(fila['tienda(razon_social)']);
        if (!tiendaId) {
            throw new Error(`La tienda '${fila['tienda(razon_social)']}' no existe en la base de datos.`);
        }
        let categoriaId = await obtenerIdCategoria(fila['categoria(nombre_producto)']);
        if (!categoriaId) {
            categoriaId = await crearCategoria(fila['categoria(nombre_producto)'], fila['categoria(campo_medicion)'], fila['categoria(tipo)']);
        }
        const stockFromExcel = fila['tienda_producto(stock)'];
        const stock = parseFloat(stockFromExcel);

        if (!isNaN(stock)) {
            let productoId = await obtenerIdProducto(fila['producto(codigo_OEM)'], fila['producto(codigo_fabricante)']);
            if (!productoId) {
                productoId = await crearProducto(fila['producto(codigo_OEM)'], fila['producto(codigo_fabricante)'], fila['producto(origen)'], fila['producto(marca_fabricante)'], fila['producto(descripcion)'], fila['producto(multiplos)'], fila['producto(medida)'], categoriaId, fila['producto(precio_compra)'], fila['producto(precio_venta)'], fila['producto(precio_minimo)']);
                await crearTiendaProducto(tiendaId, productoId, stock);
            } else {
                let tiendaProductoId = await obtenerIdTiendaProducto(tiendaId, productoId);
                if (!tiendaProductoId) {
                    await crearTiendaProducto(tiendaId, productoId, stock);
                } else {
                    const stockExistente = await obtenerStockTiendaProducto(tiendaProductoId);
                    const nuevoStock = stockExistente + stock;
                    await actualizarStockTiendaProducto(tiendaProductoId, nuevoStock);
                }
            }
            let modeloId = await obtenerIdModeloAuto(fila['modelo_auto(nombre)'], fila['modelo_auto(anio_inicio_termino)']);
            if (!modeloId) {
                modeloId = await crearModeloAuto(fila['modelo_auto(nombre)'], fila['modelo_auto(anio_inicio_termino)'], fila['modelo_auto(motor)'], marcaId);
            }
            const aplicacionExistente = await obtenerAplicacionExistente(productoId, modeloId);
            if (!aplicacionExistente) {
                await crearAplicacion(productoId, modeloId);
            }
        } else {
            // El valor de stock no es un número válido
            console.error('El valor de stock obtenido del archivo Excel no es un número válido:', stockFromExcel);
        }

        console.log('Fila procesada exitosamente.');
    } catch (error) {
        console.error('Error al procesar fila:', error);
    }
}

async function obtenerAplicacionExistente(idProducto, idModeloAuto) {
    try {
        const [rows] = await conexion.promise().query('SELECT * FROM aplicacion WHERE id_producto = ? AND id_modelo_auto = ?', [idProducto, idModeloAuto]);
        return rows.length > 0;
    } catch (error) {
        console.error('Error al obtener aplicación existente:', error);
        throw error;
    }
}

async function obtenerIdMarcaAuto(nombreMarca) {
    try {
        const [rows] = await conexion.promise().query('SELECT id_marca_auto FROM marca_auto WHERE nombre = ?', [nombreMarca]);
        if (rows.length > 0) {
            return rows[0].id_marca_auto;
        } else {
            return null;
        }
    } catch (error) {
        console.error('Error al obtener ID de la marca de auto:', error);
        throw error;
    }
}

async function crearMarcaAuto(nombreMarca) {
    try {
        const [result] = await conexion.promise().query('INSERT INTO marca_auto (nombre) VALUES (?)', [nombreMarca]);
        return result.insertId;
    } catch (error) {
        console.error('Error al crear la marca de auto:', error);
        throw error;
    }
}

async function obtenerIdModeloAuto(nombreModelo, anioInicioTermino) {
    try {
        console.log('Buscando modelo de auto con nombre:', nombreModelo, 'y año de inicio/termino:', anioInicioTermino);

        const [rows] = await conexion.promise().query('SELECT id_modelo_auto FROM modelo_auto WHERE nombre = ? AND anio_inicio_termino = ?', [nombreModelo, anioInicioTermino]);
        if (rows.length > 0) {
            return rows[0].id_modelo_auto;
        } else {
            return null;
        }
    } catch (error) {
        console.error('Error al obtener ID del modelo de auto:', error);
        throw error;
    }
}

async function crearModeloAuto(nombreModelo, anioInicioTermino, motor, idMarcaAuto) {
    try {
        const [result] = await conexion.promise().query('INSERT INTO modelo_auto (nombre, anio_inicio_termino, motor, id_marca_auto) VALUES (?, ?, ?, ?)', [nombreModelo, anioInicioTermino, motor, idMarcaAuto]);
        return result.insertId;
    } catch (error) {
        console.error('Error al crear el modelo de auto:', error);
        throw error;
    }
}

async function obtenerIdTienda(razonSocial) {
    try {
        const [rows] = await conexion.promise().query('SELECT id_tienda FROM tienda WHERE razon_social = ?', [razonSocial]);
        if (rows.length > 0) {
            return rows[0].id_tienda;
        } else {
            return null;
        }
    } catch (error) {
        console.error('Error al obtener ID de la tienda:', error);
        throw error;
    }
}

async function obtenerIdCategoria(nombreCategoria) {
    try {
        const [rows] = await conexion.promise().query('SELECT id_categoria FROM categoria WHERE nombre_producto = ?', [nombreCategoria]);
        if (rows.length > 0) {
            return rows[0].id_categoria;
        } else {
            return null;
        }
    } catch (error) {
        console.error('Error al obtener ID de la categoría:', error);
        throw error;
    }
}

async function crearCategoria(nombreCategoria, campoMedicion, tipo) {
    try {
        const [result] = await conexion.promise().query('INSERT INTO categoria (nombre_producto, campo_medicion, tipo) VALUES (?, ?, ?)', [nombreCategoria, campoMedicion, tipo]);
        return result.insertId;
    } catch (error) {
        console.error('Error al crear la categoría:', error);
        throw error;
    }
}

async function obtenerIdProducto(codigoOEM, codigoFabricante) {
    try {
        const [rows] = await conexion.promise().query('SELECT id_producto FROM producto WHERE codigo_OEM = ? AND codigo_fabricante = ?', [codigoOEM, codigoFabricante]);
        if (rows.length > 0) {
            return rows[0].id_producto;
        } else {
            return null;
        }
    } catch (error) {
        console.error('Error al obtener ID del producto:', error);
        throw error;
    }
}

async function crearProducto(codigoOEM, codigoFabricante, origen, marcaFabricante, descripcion, multiplos, medida, idCategoria, precioCompra, precioVenta, precioMinimo) {
    try {
        const codigoInterno = await generarCodigoInterno();
        const [result] = await conexion.promise().query('INSERT INTO producto (codigo_OEM, codigo_fabricante, origen, marca_fabricante, descripcion, multiplos, medida, id_categoria, precio_compra, precio_venta, precio_minimo, codigo_interno) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', [codigoOEM, codigoFabricante, origen, marcaFabricante, descripcion, multiplos, medida, idCategoria, precioCompra, precioVenta, precioMinimo, codigoInterno]);
        return result.insertId;
    } catch (error) {
        console.error('Error al crear el producto:', error);
        throw error;
    }
}


async function generarCodigoInterno() {
    try {
        const [result] = await conexion.promise().query('SELECT COUNT(*) AS total FROM producto');
        const ultimoNumero = result[0].total + 1;
        const year = new Date().getFullYear();
        return `DE-PA-${year}-P${pad(ultimoNumero, 4)}`;
    } catch (error) {
        console.error('Error al generar el código interno:', error);
        throw error;
    }
}

function pad(number, length) {
    return ('0000' + number).slice(-length);
}

async function obtenerIdTiendaProducto(idTienda, idProducto) {
    try {
        const [rows] = await conexion.promise().query('SELECT id_tienda_producto FROM tienda_producto WHERE id_tienda = ? AND id_producto = ?', [idTienda, idProducto]);
        if (rows.length > 0) {
            return rows[0].id_tienda_producto;
        } else {
            return null;
        }
    } catch (error) {
        console.error('Error al obtener ID de tienda_producto:', error);
        throw error;
    }
}

async function crearTiendaProducto(idTienda, idProducto, stock) {
    try {
        const [result] = await conexion.promise().query('INSERT INTO tienda_producto (id_producto, id_tienda, stock) VALUES (?, ?, ?)', [idProducto, idTienda, stock]);
        return result.insertId;
    } catch (error) {
        console.error('Error al crear tienda_producto:', error);
        throw error;
    }
}

async function obtenerStockTiendaProducto(idTiendaProducto) {
    try {
        const [rows] = await conexion.promise().query('SELECT stock FROM tienda_producto WHERE id_tienda_producto = ?', [idTiendaProducto]);
        if (rows.length > 0) {
            return rows[0].stock;
        } else {
            throw new Error(`No se encontró el stock para el ID de tienda_producto ${idTiendaProducto}`);
        }
    } catch (error) {
        console.error('Error al obtener stock de tienda_producto:', error);
        throw error;
    }
}

async function actualizarStockTiendaProducto(idTiendaProducto, stock) {
    try {
        await conexion.promise().query('UPDATE tienda_producto SET stock = ? WHERE id_tienda_producto = ?', [stock, idTiendaProducto]);
    } catch (error) {
        console.error('Error al actualizar el stock de tienda_producto:', error);
        throw error;
    }
}

async function crearAplicacion(idProducto, idModeloAuto) {
    try {
        const [result] = await conexion.promise().query('INSERT INTO aplicacion (id_producto, id_modelo_auto) VALUES (?, ?)', [idProducto, idModeloAuto]);
        return result.insertId;
    } catch (error) {
        console.error('Error al crear la aplicación:', error);
        throw error;
    }
}

module.exports = { insertarDatosDesdeExcel };
