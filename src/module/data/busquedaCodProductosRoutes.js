const express = require('express');
const router = express.Router();
const db = require('../../db/mysql');

router.get('/', async (req, res) => {
    try {
        const query = req.query.busqueda;
        if (query) {
            const searchData = await db.buscarProductosPorCodigo(query);
            return res.status(200).json(searchData);
        } else {
            return res.status(400).json({ error: true, message: 'Término de búsqueda no proporcionado' });
        }
    } catch (error) {
        console.error('Error en la ruta /api/buscar_productos:', error);
        return res.status(500).json({ error: true, message: 'Error interno' });
    }
});

module.exports = router;

module.exports = router;