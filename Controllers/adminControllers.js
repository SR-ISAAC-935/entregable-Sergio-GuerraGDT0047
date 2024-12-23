const { getConnection } = require('../DB/Database')
const bcypt = require('bcrypt')
const mssql = require('mssql')


const CrearUsuarios = async (req, res) => {
    const { nombre, edadUsuario, telefonoUsuario, ubicacionUsuario, Password, Rol } = req.body;

    // Validar que los campos requeridos estén presentes
    if (!nombre || !edadUsuario || !telefonoUsuario || !ubicacionUsuario || !Password || !Rol) {
        // console.log(req.body)
        return res.status(400).send({ Respuesta: 'Datos incompletos', code: 400 });
    }

    // Calcular la edad
    const fechaNacimiento = new Date(edadUsuario);
    const hoy = new Date();
    const edad = hoy.getFullYear() - fechaNacimiento.getFullYear() -
        (hoy < new Date(hoy.getFullYear(), fechaNacimiento.getMonth(), fechaNacimiento.getDate()) ? 1 : 0);

    // Validar edad
    if (edad < 18) {
        return res.status(401).send({ Respuesta: 'Usuario menor de edad', code: 401 });
    }

    const hash = bcypt.hashSync(Password, 10)
    // Respuesta de éxito

    try {
        const pool = await getConnection();
        await pool.request()
            .input('UserName', mssql.VarChar, nombre)
            .input('UserAge', mssql.Date, edadUsuario)
            .input('UserPhone', mssql.Int, telefonoUsuario)
            .input('UserUbication', mssql.VarChar, ubicacionUsuario)
            .input('Password', mssql.VarChar, hash)
            .input('IDRol', mssql.Int, Rol)
            .input('IDEstado', mssql.Int, 1)
            .execute('InsertUsuario')
        res.status(200).send({ message: 'Usuario registrado Exitosamente' });
    } catch (error) {
        res.status(500).send({ message: 'Error al registrar el usuario', error });
    }
}
const actualizarUsuarios = async (req, res) => {
    const { idUsuario, nombre, edadUsuario, telefonoUsuario, ubicacionUsuario, Password, Rol } = req.body;

    try {
        const hash = bcypt.hashSync(Password, 10)
        const pool = await getConnection();
        await pool.request()
            .input('IDUsuario', mssql.Int, idUsuario)
            .input('UserName', mssql.VarChar, nombre)
            .input('UserAge', mssql.Date, edadUsuario)
            .input('UserPhone', mssql.Int, telefonoUsuario)
            .input('UserUbication', mssql.VarChar, ubicacionUsuario)
            .input('Password', mssql.VarChar, hash)
            .input('IDRol', mssql.Int, Rol)
            .input('IDEstado', mssql.Int, 1)
            .execute('UpdateUsuario')
        res.status(200).send({ message: 'Usuario actualizado Exitosamente' });
    } catch (error) {
        res.status(500).send({ message: 'Error al registrar el usuario', error });
    }
}
const eliminarUsuarios = async (req, res) => {

    const { id } = req.params; // Cambiado a 'id' para coincidir con la ruta
    const { idEstado } = req.body;
    console.log(req.body, '\n', req.params)
    if (!id || !idEstado) {
        return res.status(400).send({ message: 'IDUsuario o IDEstado no proporcionado' });
    }

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('IDEstado', mssql.Int, idEstado)
            .input('IDUsuario', mssql.Int, id)
            .execute('DeleteUsuario');

        if (result.rowsAffected[0] === 0) {
            return res.status(404).send({ message: 'Usuario no encontrado o sin cambios realizados' });
        }

        res.status(200).send({ message: 'Usuario actualizado exitosamente' });
    } catch (error) {
        res.status(500).send({ message: 'Error al actualizar el estado del usuario', error: error.message });
    }
};

const obtenerUsuarios = async (req, res) => {
    console.log(`ID del usuario autenticado: ${req.user.id} ${req.user.role}`); // Aquí accedes al ID del usuario

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('user_id', mssql.Int, req.user.id) // Usamos req.user.id como parámetro
            .query('EXEC GetUsuarios'); // Ejemplo de consulta con SP filtrado por ID

        res.status(200).send({ solicitud: result.recordset, code: 200 });
    } catch (error) {
        res.status(500).send({ message: 'Error al obtener los usuarios', error });
    }
};

module.exports = {
    CrearUsuarios,
    actualizarUsuarios,
    eliminarUsuarios,
    obtenerUsuarios,

}