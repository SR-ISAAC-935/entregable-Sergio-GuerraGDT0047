const mssql= require('mssql')
const sql = require('mssql')


const sqlConfig={
    user:"isaacguerra_SQLLogin_1",
    password:"cavzeijqk9",
    database:"GDA0047Sergio_Guerra",
    server:"GDA0047Sergio_Guerra.mssql.somee.com",
    options:{
        encrypt:true,
        trustServerCertificate:true,
    }
}

let sqlPool;
async function getConnection(){
    try {
        return await mssql.connect(sqlConfig);
    } catch (error) {
        console.log(error);
    }
}

async function connectSQlServer()
{
    if(!sqlPool)
    {
        try {
            sqlPool= await new sql.ConnectionPool(sqlConfig).connect();
            console.log('conexion exitosa');
            return sqlPool
        } catch (error) {
            console.log('error al conectar', error)
            throw  error;
        }
    }
    return sqlPool;
}

connectSQlServer();
module.exports ={
    mssql, getConnection,

}