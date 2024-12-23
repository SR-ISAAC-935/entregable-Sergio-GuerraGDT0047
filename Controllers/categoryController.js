const {getConnection}= require('../DB/Database')
const mssql= require('mssql')

const categorias= async (req,res)=>{
    try {
      const pool= await getConnection();
      const result= await pool.request().query('EXEC getCategories')
      res.status(200).send({Solicitud: result, code: 202});
    } catch (error) {
      res.status(500).send({mensaje: 'Error al obtener las categorias', error: error.message}) 
    }
    }
const crearCategorias = async (req,res)=>{
    console.log(req.user)
    const allowedRoles = ['Operador', 'Administrador'];
    if (!allowedRoles.includes(req.user.role)) {
        res.status(401).send({ mensaje: "No estás autorizado a entrar aquí" });
    } else {
        const { CategoryName } = req.body;
        console.log(req.body, '\n', 'Rol:', req.user.id);
  
        try {
          const pool = await getConnection();
      
          // Crear el objeto tipo tabla con la función
          const categoryTable = createCategoryTable(CategoryName, 1, req.user.id);
          console.log(categoryTable)
          // Llamar al procedimiento almacenado
          await pool.request()
              .input('CategoryList', categoryTable)
              .execute('InsertCategory');
      
          res.status(200).send({ mensaje: "Categorías insertadas correctamente" });
      } catch (err) {
          res.status(500).send({ mensaje: "Error al insertar categorías", error: err.message });
      }
    }
  }
  const ActualizarCategorias = async (req, res) => {
    const { id} = req.params;  // El IDCategory viene en la URL
    const { CategoryName, IDEstado } = req.body;  // CategoryName y IDEstado en el cuerpo de la solicitud

    // Validar si los parámetros necesarios están presentes
    if (!id || !CategoryName || !IDEstado) {
        return res.status(400).send({ solicitud: 'Faltan parámetros', code: 400 });
    }

    // Convertir IDEstado a número (si es necesario)
    const IDEstadoNum = Number(IDEstado);
    if (isNaN(IDEstadoNum)) {
        return res.status(400).send({ solicitud: 'IDEstado debe ser un número válido', code: 400 });
    }

    console.log('Parámetros:', req.params, '\nCuerpo:', req.body);

    try {
        const pool = await getConnection();
        const result = await pool.request()
            .input('IDCategoria', mssql.Int, id)  // Cambiar 'IDCategoria' si tu SP usa otro nombre
            .input('CategoryName', mssql.NVarChar, CategoryName)
            .input('IDEstado', mssql.Int, IDEstadoNum)  // Convertido a número
            .execute('UpdateCategory');

        // Verificar si se encontró y actualizó la categoría
        if (result.rowsAffected[0] === 0) {
            return res.status(404).send({ solicitud: 'No se encontró la categoría', code: 404 });
        }

        return res.status(200).send({ solicitud: 'Actualizado con éxito', code: 200 });
    } catch (error) {
        console.error('Error al actualizar categoría:', error.message);
        return res.status(500).send({ solicitud: 'Error interno del servidor', code: 500, error: error.message });
    }
};
const eliminarCategorias= async (req,res)=>{
    const {id}= req.params;
    const {IDEstado}=req.body
    console.log(req.params,'\n',req.body)
    try {
        if(!id || !IDEstado)
            {
                return res.status(400).send({ solicitud: 'Faltan parámetros', code: 400 });
            }
            const pool= await getConnection();
            const result= await pool.request()
            .input('IDCategoria',mssql.Int,id)
            .input('IDEstado',mssql.Int,IDEstado)
            .execute('DeleteCategory')
            if(result.rowsAffected[0]===0)
            {
                res.status(404).send({solicitud:'No se encontró la categoría',code:404})
            }
            return res.status(200).send({solicitud:'exito al eliminar la categoria',code:200})
    } catch (error) {
        res.status(500).send({mensaje:`error al eliminar la categoria ${error}`})
    }
}
const cocos = async (req, res) => {
    const { id } = req.params;
    const { category, productName, provider, prices, stock } = req.body;
    console.log(req.params, '\n', req.body);
  }
  module.exports={
    crearCategorias,
    ActualizarCategorias,
    eliminarCategorias,
    categorias,
    cocos,
  }