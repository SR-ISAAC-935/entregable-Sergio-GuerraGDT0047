const express= require('express');
const { resumenVentas, ventasDetalladasUsuario, ventasDetalladasGeneral, comprasClientes } = require('../Controllers/homeControllers');
const { productos } = require('../Controllers/ProductControllers');
const verifySession = require('../Middleware/SessionHelper');

const Router= express.Router();

//Get methods
Router.get('/',verifySession,resumenVentas)
Router.get('/detallesGeneral',verifySession,ventasDetalladasGeneral)
Router.get('/productos',verifySession,productos)
Router.get('/misdetalles',verifySession,ventasDetalladasUsuario)

//Post methods
Router.post('/Compras',verifySession,comprasClientes)


module.exports= Router;