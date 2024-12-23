const express= require('express');
const { CrearUsuarios, actualizarUsuarios, eliminarUsuarios, obtenerUsuarios } = require('../Controllers/adminControllers');
const verifySession = require('../Middleware/SessionHelper');
const {  actualizarPedido, Crearproductos, ActualizarProductos,  } = require('../Controllers/ProductControllers');
const verifyRole = require('../Middleware/RoleHelper');
const { crearCategorias, ActualizarCategorias, eliminarCategorias, cocos } = require('../Controllers/categoryController');
const { CrearStates, modificarStates } = require('../Controllers/StatesControllers');


const router= express.Router();

router.get('/Usuarios',verifySession,verifyRole,obtenerUsuarios)
router.put('/ModificarUsuarios',verifySession,verifyRole,actualizarUsuarios)
router.put('/modificarOperadores',verifySession,verifyRole,actualizarUsuarios)
router.put('/EliminarOperadores/:id',verifySession,verifyRole,eliminarUsuarios)
router.put('/EliminarUsuarios/:id', verifySession, verifyRole, eliminarUsuarios);
router.post('/CrearUsuarios',verifySession,verifyRole,CrearUsuarios);
router.post('/CrearCategorias',verifySession,verifyRole,crearCategorias)
router.put('/ModificarCategorias/:id',verifySession,verifyRole,ActualizarCategorias)
router.put('/ModificarPedido',verifySession,verifyRole,actualizarPedido)
router.post('/CrearProducto',verifySession,verifyRole,Crearproductos)
//router.put('/ModificarProducto/:id',verifySession,verifyRole,Crearproductos)
router.put('/EliminarCategoria/:id',verifySession,verifyRole,eliminarCategorias)
router.post('/CrearEstados',verifySession,verifyRole,CrearStates)
router.put('/ModificarEstados/:id',verifySession,verifyRole,modificarStates)
router.put('/ModificarProducto/:id',verifySession,verifyRole,ActualizarProductos)

module.exports= router;