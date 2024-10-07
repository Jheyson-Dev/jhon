const tabla = 'ingreso';

module.exports = function (dbInjected) {

    let db = dbInjected;

    if(!db){
        db = require('../../db/mysql')
    }

    function getAll() {
        return db.obtenerTodos(tabla);
    }
    function getById(id) {
        return db.obtenerPorId(tabla, id);
    }
    async function add(body) {
        try {
            const nuevoRegistro = body;
            const id_producto = nuevoRegistro.id_producto;
            const id_tienda = nuevoRegistro.id_tienda;
            const cantidad = nuevoRegistro.cantidad;
            const relacionExistente = await db.obtenerPorProductoYTienda(id_producto, id_tienda);
    
            if (relacionExistente && relacionExistente.length > 0) {
                const stockActual = relacionExistente[0].stock;
                const nuevoStock = parseInt(stockActual) + parseInt(cantidad);
                await db.actualizarStockTiendaProducto(relacionExistente[0].id_tienda_producto, nuevoStock);
                await db.agregar(tabla, nuevoRegistro);
                return "Registro actualizado exitosamente";
            } else {
                await db.crearRelacionTiendaProducto(id_producto, id_tienda, cantidad);
                await db.agregar(tabla, nuevoRegistro);
                return "Relacion creada y stock actualizado";
            }
        } catch (error) {
            throw error;
        }
    }

    return{
        getAll,
        getById,
        add
    }
    
}