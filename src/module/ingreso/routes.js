const express = require('express');
const retorno = require('../../red/return');
const controller = require('./index');


const router = express.Router();

router.get('/', getAll);
router.get('/:id', getById);
router.post('/', add);

async function getAll(req, res){
    try{
        const items = await controller.getAll();
        retorno.success(req, res, items, 200);
    }catch(err){
        retorno.error(req, res, err, 500);
    }
};

async function getById(req, res){
    try{
        const items = await controller.getById(req.params.id);
        retorno.success(req, res, items, 200);
    }catch(err){
        retorno.error(req, res, err, 500);
    }
    
};

async function add(req, res, next) {
    try {
        const nuevoRegistro = req.body;
        const resultado = await controller.add(nuevoRegistro);
        retorno.success(req, res, 'Registro agregado exitosamente', 201);
    } catch (err) {
        next(err);
    }
}

module.exports = router;