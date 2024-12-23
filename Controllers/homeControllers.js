const {getConnection} = require('../DB/Database')
const mssql= require('mssql')
const { createDetalleVentasTVP } = require('../Helpers/TVPHelpers');  // Importar la función para crear el TVP
const resumenVentas = async (req,res)=>{
    try {
        const pool = await getConnection();
        const result= await pool.request().query('EXEC sp_ConsumoPorUsuario_Reciente;')

res.status(200).send({ solicitud: result, code: 202 });
    } catch (error) {
        
    }
    
}
const ventasDetalladasGeneral= async (req,res)=>{
    try {
        const pool = await getConnection();
        const result= await pool.request().query('EXEC sp_ObtenerTodasLasCompras;')
        res.status(200).send({ solicitud: result, code: 202 });
    } catch (error) {
        
    }
}
const ventasDetalladasUsuario = async (req, res) => {
   // Obtener el ID del usuario desde el body
   // console.log(req.user.id)
    if (!req.user.id) {
        return res.status(400).send({ message: "El ID del usuario es requerido" });
    }

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('ID_Usuario', req.user.id)
            .execute('sp_ObtenerComprasPorUsuario');

        res.status(200).send({ solicitud: result.recordset, code: 200 });
    } catch (error) {
        console.error("Error al obtener las compras: ", error);
        res.status(500).send({ message: "Error interno del servidor", error: error.message });
    }
};



const comprasClientes = async (req, res) => {
    const { Total, Status, Fecha_Venta, DetalleVentas } = req.body;

    // Crear el TVP para los detalles de venta
    const detalleVentasTVP = createDetalleVentasTVP(DetalleVentas);

    try {
        const pool = await getConnection();
        await pool.request()
            .input('ID_Usuario', mssql.Int, req.user.id)
            .input('Total', mssql.Money, Total)
            .input('Status', mssql.VarChar, Status)
            .input('Fecha_Venta', mssql.Date, Fecha_Venta)
            .input('DetalleVentas', detalleVentasTVP)  // TVP para detalles de ventas
            .execute('sp_InsertarVenta');
        
        res.status(200).send({ message: 'Venta insertada correctamente.' });
    } catch (error) {
        console.error('Error al insertar venta:', error);
        res.status(500).send({ message: 'Error al insertar venta.' });
    }
};

module.exports = { comprasClientes };


module.exports={
    resumenVentas,
    ventasDetalladasUsuario,
    ventasDetalladasGeneral,
    comprasClientes,
}