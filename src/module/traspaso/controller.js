const tabla = 'traspaso';

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
            const nuevoTraspaso = body;
            const id_producto = nuevoTraspaso.id_producto;
            const cantidad = nuevoTraspaso.cantidad;
            const usuario = nuevoTraspaso.usuario;
            const id_tienda_origen = nuevoTraspaso.id_tienda_origen;
            const id_tienda_destino = nuevoTraspaso.id_tienda_destino;
    
            const relacionOrigen = await db.obtenerPorProductoYTienda(id_producto, id_tienda_origen);
            if (!relacionOrigen || relacionOrigen.length === 0) {
                throw new Error("No existe una relación entre el producto y la tienda de origen.");
            }

            const stockOrigen = relacionOrigen[0].stock;
            if (parseInt(cantidad) > parseInt(stockOrigen)) {
                throw new Error("No hay suficiente stock en la tienda de origen para realizar el traspaso.");
            }
            const nuevoStockOrigen = parseInt(stockOrigen) - parseInt(cantidad);
            await db.actualizarStockTiendaProducto(relacionOrigen[0].id_tienda_producto, nuevoStockOrigen);
            const relacionDestino = await db.obtenerPorProductoYTienda(id_producto, id_tienda_destino);
            if (!relacionDestino || relacionDestino.length === 0) {
                await db.crearRelacionTiendaProducto(id_producto, id_tienda_destino, cantidad);
            } else {
                const stockDestino = relacionDestino[0].stock;
                const nuevoStockDestino = parseInt(stockDestino) + parseInt(cantidad);
                await db.actualizarStockTiendaProducto(relacionDestino[0].id_tienda_producto, nuevoStockDestino);
            }
            await db.agregar(tabla, body);
    
            return "Traspaso realizado correctamente.";
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