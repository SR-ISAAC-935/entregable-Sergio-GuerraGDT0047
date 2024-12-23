const { getConnection } = require('../DB/Database');
const uuid = require('uuid');
const bcrypt = require('bcrypt');
const mssql = require('mssql');

// Función para obtener usuario de la base de datos, incluyendo el nombre del estado
const getUserByUsername = async (username) => {
    const pool = await getConnection();
    const result = await pool.request()
        .input('username', mssql.VarChar, username)
        .query(`
            SELECT 
                u.[ID Usuario],
                u.[User Name],
                u.[Passwords],
                u.[ID Estado],
                s.[State Name] AS Estado
            FROM Usuarios u
            INNER JOIN States s
            ON u.[ID Estado] = s.[ID Estado]
            WHERE u.[User Name] = @username
        `);
    return result.recordset[0];  // Retorna el primer usuario o undefined si no existe
};

// Función para crear una sesión
const createSession = async (userId) => {
    const sessionId = uuid.v4();
    const expiresAt = new Date(Date.now() + 24 * 3600 * 1000);  // 24 horas de expiración
    const pool = await getConnection();
    await pool.request()
        .input('session_id', mssql.UniqueIdentifier, sessionId)
        .input('user_id', mssql.Int, userId)
        .input('expires_at', mssql.DateTime, expiresAt)
        .query('INSERT INTO Sessions (session_id, user_id, expires_at) VALUES (@session_id, @user_id, @expires_at)');
    return sessionId;  // Devuelve el sessionId para enviarlo al cliente
};

// Endpoint de inicio de sesión
const Sesion = async (req, res) => {
    const { username, Password } = req.body;

    try {
        const user = await getUserByUsername(username);  // Obtener usuario por username
        
        if (!user) {
            return res.status(401).json({ message: 'Credenciales incorrectas' });
        }

        // Comparar la contraseña ingresada con la almacenada
        const isPasswordValid = await bcrypt.compare(Password, user.Passwords);
        if (!isPasswordValid) {
            return res.status(401).json({ message: 'Credenciales incorrectas' });
        }

        // Verificar el estado del usuario
        if (user.Estado !== 'Activo') {
            return res.status(403).json({ message: 'Usuario inactivo. No puede iniciar sesión.' });
        }

        // Crear la sesión y obtener el session_id
        const sessionId = await createSession(user['ID Usuario']);

        // Enviar el session_id al cliente como una cookie segura
        res.cookie('session_id', sessionId, { httpOnly: true, secure: true });  // cookie segura
        return res.status(200).json({ message: 'Inicio de sesión exitoso' });
    } catch (err) {
        return res.status(500).json({ message: 'Error en el servidor', error: err.message });
    }
};

module.exports = { Sesion };
