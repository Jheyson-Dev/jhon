const bcrypt = require('bcrypt');
const tabla = 'usuario';
const { conexion } = require('../../db/mysql');

module.exports = function (dbInjected) {

    let db = dbInjected;

    if(!db){
        db = require('../../db/mysql')
    }

    async function hashPassword(password) {
        const saltRounds = 10;
        return await bcrypt.hash(password, saltRounds);
    }

    async function comparePassword(plainPassword, hashedPassword) {
        return await bcrypt.compare(plainPassword, hashedPassword);
    }

    function getAll() {
        return db.obtenerTodos(tabla);
    }
    function getById(id) {
        return db.obtenerPorId(tabla, id);
    }
    async function add(body) {
        body.password = await hashPassword(body.password);
        return db.agregar(tabla, body);
    }
    async function update(id, newData) {
        if (newData.password) {
            newData.password = await hashPassword(newData.password);
        }
        return db.actualizar(tabla, id, newData);
    }
    function remove(id) {
        return db.eliminar(tabla, id);
    }
    function getByField(field, value) {
        return new Promise((resolve, reject) => {
            const query = `SELECT * FROM ${tabla} WHERE ${field} = ?`;
            conexion.query(query, [value], (error, result) => {
                if (error) {
                    console.error('Error en la consulta MySQL:', error);
                    return reject(error);
                }
                if (result.length === 0) return resolve(null);
                resolve(result[0]);
            });
        });
    }

    return{
        getAll,
        getById,
        add,
        update,
        remove,
        getByField
    }
    
}