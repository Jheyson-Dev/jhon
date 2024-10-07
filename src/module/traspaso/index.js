const db = require('../../db/mysql');
const controller = require('./controller');

module.exports = controller(db);