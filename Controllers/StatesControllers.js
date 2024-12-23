const {getConnection}= require('../DB/Database')
const mssql = require('mssql')


const CrearStates= async(req,res)=>{
    const{Status}= req.body
    console.log(req.body)
    if(!Status)
        {
            res.status(400).send({mensaje:'faltan parametros', error:'400'})
        }
        try {
            const pool= await getConnection();
            const result= await pool.request()
            .input('Status',mssql.NVarChar,Status)
            .execute('CreateSalesStatus')
            if( result.rowsAffected[0] === 0)
                {
                    res.status(404).send({mensaje:'No se encontro el Estado ',error:404})
                }

            res.status(200).send({mensaje:'Exito al crear el estado', error:'200'})
        } catch (error) {
            res.status(500).send({solicitud:'Error interno en el servidor', code: 500, error: error.message})
        }
}


const modificarStates= async(req,res)=>{
    const {id}=req.params
    const{Status}=req.body

    console.log(req.params,'\n',req.body)
    if(!id || !Status)
    {
        res.status(400).send({mensaje:'faltan parametros', error:'400'})
    }
    try {
        const pool= await getConnection();
        const result= await pool.request()
        .input('IDSaleStatus',mssql.Int,id)
        .input('Status',mssql.NVarChar,Status)
        .execute('UpdateSalesStatus')
        if( result.rowsAffected[0] === 0)
        {
            res.status(404).send({mensaje:'No se encontro el Estado ',error:404})
        }
        res.status(200).send({mensaje:'Exito al modificar el estado', error:'200'})
    } catch (error) {
        res.status(500).send({solicitud:'Error interno en el servidor', code: 500, error: error.message})
    }
}

module.exports={
    CrearStates,
    modificarStates
}