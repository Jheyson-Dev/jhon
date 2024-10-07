const express = require('express');
const router = express.Router();
const { obtenerTipoCambioActual } = require('./controller');

router.get('/', obtenerTipoCambioActual);

module.exports = router;
