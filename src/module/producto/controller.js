const tabla = 'producto';

module.exports = function (dbInjected) {

    let db = dbInjected;

    if(!db){
        db = require('../../db/mysql')
    }

    function getAll() {
        return db.obtenerProductosConDatosCompletos();
    }
    function getById(id) {
        return db.obtenerProductosConDatosCompletosPorId(id);
    }
    async function add(producto) {
        try {
            const resultado = await db.agregarProducto(producto);
            return resultado;
        } catch (error) {
            throw error;
        }
    }
    function update(id, newData) {
        return db.actualizarProducto(id, newData);
    }
    function remove(id) {
        return db.eliminar(tabla, id);
    }

    return{
        getAll,
        getById,
        add,
        update,
        remove, 
    }
    
}