const express= require('express');
const { Sesion } = require('../Controllers/authControllers');


const router= express.Router();

router.get('/', (req, res)=>{
    res.send('hola mundo auth')
})
router.post('/login',Sesion)
module.exports= router;



