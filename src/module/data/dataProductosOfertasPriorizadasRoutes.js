const express = require('express');
const router = express.Router();
const db = require('../../db/mysql'); 
const retorno = require('../../red/return');

router.get('/', async (req, res) => {
    try {
        const items = await db.obtenerProductosConPriorizacionSI();
        retorno.success(req, res, items, 200);
    } catch(err){
        console.log(err)
        retorno.error(req, res, err, 500);
    }
});

module.exports = router;