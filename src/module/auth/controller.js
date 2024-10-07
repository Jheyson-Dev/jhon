const bcrypt = require('bcrypt');
const retorno = require('../../red/return');
const usuarioController = require('../usuario/index');

async function login(req, res, next) {
    try {
        const { username, password } = req.body;
        const usuario = await usuarioController.getByField('username', username);

        if (usuario && await bcrypt.compare(password, usuario.password)) {
            const { username, rol } = usuario;
            retorno.success(req, res, { message: 'Inicio de sesión exitoso', username,rol }, 200);
        } else {
            retorno.error(req, res, 'Credenciales inválidas', 401);
        }
    } catch (err) {
        retorno.error(req, res, 'Error en el inicio de sesión', 500);
    }
}

module.exports = {
    login
};