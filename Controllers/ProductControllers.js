const { formidable } = require("formidable");
const { getConnection } = require('../DB/Database')
const mssql = require('mssql');
const { createCategoryTable } = require("../Helpers/TVPHelpers");
const cloudinary = require('../Helpers/Cloudinay');

const productos = async (req, res) => {
  try {
    const pool = await getConnection();
    const result = await pool.request().query('EXEC GetProducts')
    res.status(200).send({ Solicitud: result, code: 202 });
  } catch (error) {
    res.status(500).send({ mensaje: 'Error al obtener los productos', error: error.message })
  }
}
const cocos = async (req, res) => {
  const { id } = req.params;
  const { category, productName, provider, prices, stock } = req.body;
  console.log(req.params, '\n', req.body);
}
const ActualizarProductos = async (req, res) => {
  console.log("Petición recibida");
  console.log("Params:", req.params);
  console.log("Body:", req.body);

  const { id } = req.params;
  const { category, productName, provider, prices, stock, image } = req.body;

  if (!id) {
    console.log("ID no proporcionado");
    return res.status(400).send({ mensaje: 'ID requerido', code: 400 });
  }

  try {
    const pool = await getConnection();
    console.log(pool)
    console.log("Conexión a base de datos exitosa");

    const result = await pool.request()
      .input('ID_Product', mssql.Int, id)
      .input('ID_Categoria', mssql.Int, category || null)
      .input('Product_Name', mssql.NVarChar, productName || null)
      .input('Product_Provider', mssql.NVarChar, provider || null)
      .input('product_Prices', mssql.Float, prices || null)
      .input('Product_Stock', mssql.Int, stock || null)
      .input('ID_Usuario',      mssql.Int, req.user ? req.user.id : null)
      .input('Image', mssql.NVarChar, image || null)
      .execute('UpdateProduct');

    console.log("Resultado de la ejecución:", result);

    if (result.rowsAffected[0] === 0) {
      return res.status(404).send({ mensaje: 'Producto no encontrado', code: 404 });
    }

    return res.status(200).send({ mensaje: 'Producto actualizado con éxito', code: 200 });
  } catch (error) {
    console.error("Error al actualizar producto:", error);
    return res.status(500).send({ mensaje: 'Error interno del servidor', code: 500, error: error.message });
  }
};

const Crearproductos = async (req, res) => {
  const form = formidable({ multiples: true, keepExtensions: true });

  form.parse(req, async (err, fields, files) => {
    if (err) return res.status(400).json({ error: 'Error al procesar el formulario.' });
    if (!req.user || !req.user.id) return res.status(401).json({ error: 'Usuario no autenticado.' });

    // Parseamos los productos
    let products;
    try {
      products = JSON.parse(fields.products);
    } catch {
      return res.status(400).json({ error: 'Formato inválido en los productos.' });
    }

    if (!products || !Array.isArray(products) || products.length === 0) {
      return res.status(400).json({ error: 'Debe enviar al menos un producto.' });
    }

    const validMimeTypes = ['image/jpeg', 'image/jpg', 'image/png'];
    const results = [];
    const errors = [];

    const pool = await getConnection();
    const fileKeys = Object.keys(files);
    if (!fileKeys.length) return res.status(400).json({ error: 'Por favor agrega al menos una imagen.' });

    // Procesar todos los archivos y productos
    const promises = fileKeys.map(async (key, index) => {
      const file = Array.isArray(files[key]) ? files[key][0] : files[key];
      const { category, productName, provider, prices, stock } = products[index];

      if (!file || !file.originalFilename) return errors.push({ index, error: 'Archivo no válido.' });

      // Subir la imagen a Cloudinary
      try {
        const uploadResult = await cloudinary.uploader.upload(file.filepath, {
          folder: 'products',
          public_id: `${Date.now()}_${file.originalFilename.split('.')[0]}`,
          use_filename: true,
        });

        // Insertar el producto en la base de datos
        if (!category || !productName || !provider || !prices || !stock) {
          return errors.push({ index, error: 'Faltan campos requeridos.' });
        }

        await pool.request()
          .input('category', mssql.Int, category)
          .input('productName', mssql.NVarChar, productName)
          .input('provider', mssql.NVarChar, provider)
          .input('prices', mssql.Float, prices)
          .input('stock', mssql.Int, stock)
          .input('userId', mssql.Int, req.user.id)
          .input('image', mssql.NVarChar, uploadResult.secure_url)
          .query(`
            INSERT INTO [dbo].[Products] ([ID Categoria], [Product Name], [Product Provider], [Product Prices], [Product Stock], [ID Usuario], [image])
            VALUES (@category, @productName, @provider, @prices, @stock, @userId, @image);
          `);

        results.push({ index, message: 'Imagen subida exitosamente.', imageUrl: uploadResult.secure_url });
      } catch (error) {
        errors.push({ index, error: error.message });
      }
    });

    // Esperar que todas las promesas se resuelvan
    await Promise.all(promises);

    // Devolver respuesta
    res.status(201).json({ results, errors });
  });
};


const actualizarPedido = async (req, res) => {
  try {
    const { IDSales, NewTotal, Details } = req.body;

    // Validar datos de entrada
    if (!IDSales || !NewTotal || !Array.isArray(Details) || Details.length === 0) {
      return res.status(400).json({ message: 'Datos de entrada inválidos. Asegúrese de proporcionar IDSales, NewTotal y una lista de Details.' });
    }
    // Conexión a la base de datos
    const pool = await getConnection();

    // Crear un objeto tipo tabla para los detalles con 4 columnas
    const detailsTable = new msmssqlTable();
    detailsTable.columns.add('ID Product', msmssqlInt);
    detailsTable.columns.add('Quantity', msmssqlInt);
    detailsTable.columns.add('Price', msmssqlMoney);
    detailsTable.columns.add('Fecha Detalle', msmssqlDate);  // Columna para fecha

    Details.forEach(detail => {
      detailsTable.rows.add(detail.ID_Producto, detail.Cantidad, detail.Precio_Unitario, detail.Fecha_Detalle);
    });

    const result = await pool.request()
      .input('IDSales', msmssqlInt, IDSales)
      .input('NewTotal', msmssqlMoney, NewTotal)
      .input('Details', detailsTable)  // Asegúrate de pasar el parámetro correctamente
      .execute('CompareAndUpdateSaleTotal');

    // Responder al cliente
    res.status(200).json({
      message: 'Pedido actualizado exitosamente.',
      result: result.recordset
    });
  } catch (error) {
    // Log completo del error para poder identificar el problema
    console.error('Error detallado:', error);

    // Enviar el mensaje de error al cliente
    res.status(500).json({
      message: 'Error interno del servidor.',
      error: error.message,
      stack: error.stack // Esto puede dar más detalles sobre el origen del error
    });
  }
};
module.exports = {
  productos,
  actualizarPedido,
  Crearproductos,
  ActualizarProductos,
  cocos
}
