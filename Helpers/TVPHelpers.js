// utils/tvpHelper.js
const { mssql } = require('../DB/Database');  // Asegúrate de que 'db.js' exporte 'mssql'

// Función para crear y llenar el TVP
function createDetalleVentasTVP(DetalleVentas) {
    const detalleVentasTVP = new mssql.Table();
    detalleVentasTVP.columns.add('ID_Product', mssql.Int);     // Define el tipo de datos
    detalleVentasTVP.columns.add('Quanity', mssql.Int);
    detalleVentasTVP.columns.add('Price', mssql.Money);
    detalleVentasTVP.columns.add('Fecha_Detalle', mssql.Date);

    // Llenar el TVP con los detalles
    DetalleVentas.forEach(detalle => {
        detalleVentasTVP.rows.add(
            detalle.ID_Product,
            detalle.Quanity,
            detalle.Price,
            detalle.Fecha_Detalle
        );
    });

    return detalleVentasTVP;
}
const createCategoryTable = (categories, estado, usuario) => {
    const categoryTable = new mssql.Table();
    categoryTable.columns.add('Category Name', mssql.NVarChar(100));
    categoryTable.columns.add('ID Estado', mssql.Int);
    categoryTable.columns.add('ID Usuario', mssql.Int);

    // Agregar cada categoría al objeto de tabla
    categories.forEach((category) => {
        categoryTable.rows.add(category, estado, usuario);
    });

    return categoryTable;
};

module.exports = { createDetalleVentasTVP,createCategoryTable };
