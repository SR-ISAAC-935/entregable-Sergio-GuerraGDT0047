const { getConnection } = require('../DB/Database');
const mssql = require('mssql');

const verifySession = async (req, res, next) => {
    //console.log(req.cookies);
    const sessionId = req.cookies.session_id || (req.headers.authorization && req.headers.authorization.split(' ')[1]);

    if (!sessionId) {
        return res.status(401).json({ message: 'Sesión no proporcionada' });
    }

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('session_id', mssql.UniqueIdentifier, sessionId)
            .query(`
                SELECT 
                    u.[ID Usuario],
                    u.[User Name],
                    u.[User Age],
                    u.[User Phone],
                    u.[User Ubication],
                    u.[Passwords],
                    r.[Role Name] AS Rol, -- Obtener el nombre del rol
                    s.[State Name] AS Estado
                FROM [GDA0047Sergio_Guerra].[dbo].[Usuarios] u
                INNER JOIN [GDA0047Sergio_Guerra].[dbo].[States] s
                    ON u.[ID Estado] = s.[ID Estado]
                INNER JOIN [GDA0047Sergio_Guerra].[dbo].[Roles] r
                    ON u.[ID Rol] = r.[ID Rol]
                WHERE u.[ID Usuario] = (SELECT user_id FROM Sessions WHERE session_id = @session_id);
            `);

        if (result.recordset.length === 0) {
            return res.status(401).json({ message: 'Sesión no válida' });
        }

        const user = result.recordset[0];
        //console.log(user)
        // Verificar si el usuario está activo
        if (user.Estado === 'Inactivo') {
            return res.status(403).json({ message: 'El usuario está inactivo. No puede iniciar sesión.' });
        }

        // Asignar información del usuario al objeto req.user
        req.user = { 
            id: user['ID Usuario'],
            username: user['User Name'],
            age: user['User Age'],
            phone: user['User Phone'],
            ubication: user['User Ubication'],
            role: user.Rol, // Aquí asignamos el nombre del rol
            estado: user.Estado
        };

        next(); // Continuar al siguiente middleware o controlador
    } catch (err) {
        return res.status(500).json({ message: 'Error verificando la sesión', error: err.message });
    }
};

module.exports = verifySession;
