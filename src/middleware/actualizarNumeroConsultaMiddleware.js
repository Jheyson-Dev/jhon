const { actualizarNumeroConsulta } = require('../db/mysql');

async function actualizarNumeroConsultaMiddleware(req, res, next) {
  const idProducto = req.params.id;
  try {
    await actualizarNumeroConsulta(idProducto);
    next();
  } catch (error) {
    console.error('Error al actualizar el número de consultas del producto:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
}

module.exports = actualizarNumeroConsultaMiddleware;