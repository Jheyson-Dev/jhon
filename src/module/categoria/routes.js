const express = require('express');
const retorno = require('../../red/return');
const controller = require('./index');
const uploadToS3 = require('../../middleware/uploadToS3');
const upload = require('../../middleware/multerConfig');

const router = express.Router();

router.get('/', getAll);
router.get('/:id', getById);
router.post('/', upload.single('file'), add);
router.put('/:id', upload.single('file'), update);
router.delete('/:id', remove);

async function getAll(req, res) {
    try {
        const items = await controller.getAll();
        retorno.success(req, res, items, 200);
    } catch (err) {
        retorno.error(req, res, err, 500);
    }
}

async function getById(req, res) {
    try {
        const items = await controller.getById(req.params.id);
        retorno.success(req, res, items, 200);
    } catch (err) {
        retorno.error(req, res, err, 500);
    }
}

async function add(req, res, next) {
    try {
        const nuevoRegistro = req.body;
        const imageUrl = await uploadToS3(req.file);
        nuevoRegistro.url_campo_medicion = imageUrl;
        const resultado = await controller.add(nuevoRegistro);
        retorno.success(req, res, 'Registro agregado exitosamente', 201);
    } catch (err) {
        next(err);
    }
}

async function update(req, res, next) {
    try {
        const id = req.params.id;
        const datosActualizados = req.body;
        if(req.file){
            const imageUrl = await uploadToS3(req.file);
            datosActualizados.url_campo_medicion = imageUrl;
        }
        const resultado = await controller.update(id, datosActualizados);
        retorno.success(req, res, 'Registro actualizado exitosamente', 200);
    } catch (err) {
        next(err);
    }
}

async function remove(req, res, next) {
    try {
        const id = req.params.id;
        const items = await controller.remove(id);
        retorno.success(req, res, 'Eliminado exitosamente', 200);
    } catch (err) {
        next(err);
    }
}

module.exports = router;