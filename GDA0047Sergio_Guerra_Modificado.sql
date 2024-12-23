USE [master]
GO
/****** Object:  Database [GDA0047Sergio_Guerra]    Script Date: 23/12/2024 00:10:06 ******/
CREATE DATABASE [GDA0047Sergio_Guerra]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GDA0047Sergio_Guerra_Data', FILENAME = N'c:\dzsqls\GDA0047Sergio_Guerra.mdf' , SIZE = 8192KB , MAXSIZE = 30720KB , FILEGROWTH = 22528KB )
 LOG ON 
( NAME = N'GDA0047Sergio_Guerra_Logs', FILENAME = N'c:\dzsqls\GDA0047Sergio_Guerra.ldf' , SIZE = 8192KB , MAXSIZE = 30720KB , FILEGROWTH = 22528KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GDA0047Sergio_Guerra].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET ARITHABORT OFF 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET  ENABLE_BROKER 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET  MULTI_USER 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET QUERY_STORE = ON
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [GDA0047Sergio_Guerra]
GO
/****** Object:  User [isaacguerra_SQLLogin_1]    Script Date: 23/12/2024 00:10:08 ******/
CREATE USER [isaacguerra_SQLLogin_1] FOR LOGIN [isaacguerra_SQLLogin_1] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [isaacguerra_SQLLogin_1]
GO
/****** Object:  Schema [isaacguerra_SQLLogin_1]    Script Date: 23/12/2024 00:10:08 ******/
CREATE SCHEMA [isaacguerra_SQLLogin_1]
GO
/****** Object:  UserDefinedTableType [dbo].[CategoryTableType]    Script Date: 23/12/2024 00:10:08 ******/
CREATE TYPE [dbo].[CategoryTableType] AS TABLE(
	[Category Name] [nvarchar](100) NULL,
	[ID Estado] [int] NULL,
	[ID Usuario] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[DetailSaleType]    Script Date: 23/12/2024 00:10:08 ******/
CREATE TYPE [dbo].[DetailSaleType] AS TABLE(
	[ID Product] [int] NULL,
	[Quantity] [int] NULL,
	[Price] [money] NULL,
	[Fecha Detalle] [date] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[DETALLEVENTA_TYPE]    Script Date: 23/12/2024 00:10:08 ******/
CREATE TYPE [dbo].[DETALLEVENTA_TYPE] AS TABLE(
	[ID_Product] [int] NULL,
	[Quanity] [int] NULL,
	[Price] [money] NULL,
	[Fecha_Detalle] [date] NULL
)
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 23/12/2024 00:10:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[ID Categoria] [int] IDENTITY(1,1) NOT NULL,
	[Category Name] [varchar](40) NOT NULL,
	[ID Estado] [int] NOT NULL,
	[ID Usuario] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID Categoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetailSalesClient]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetailSalesClient](
	[ID Sale] [int] IDENTITY(1,1) NOT NULL,
	[ID Venta] [int] NOT NULL,
	[ID Product] [int] NOT NULL,
	[Quanity] [int] NOT NULL,
	[Price] [money] NOT NULL,
	[Fecha Detalle] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID Sale] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ID Product] [int] IDENTITY(1,1) NOT NULL,
	[ID Categoria] [int] NOT NULL,
	[Product Name] [varchar](60) NULL,
	[Product Provider] [varchar](30) NULL,
	[Product Prices] [money] NULL,
	[Product Stock] [int] NOT NULL,
	[ID Usuario] [int] NULL,
	[image] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID Product] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[ID Rol] [int] IDENTITY(1,1) NOT NULL,
	[Role Name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID Rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesCientResume]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesCientResume](
	[ID Sales] [int] IDENTITY(1,1) NOT NULL,
	[ID Usuario] [int] NOT NULL,
	[Total] [money] NOT NULL,
	[Fecha Venta] [date] NOT NULL,
	[ID Sale Status] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID Sales] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesStatus]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesStatus](
	[ID Sale Status] [int] IDENTITY(1,1) NOT NULL,
	[Status] [nvarchar](16) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID Sale Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sessions]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sessions](
	[session_id] [uniqueidentifier] NOT NULL,
	[user_id] [int] NULL,
	[created_at] [datetime] NULL,
	[expires_at] [datetime] NULL,
	[user_agent] [varchar](255) NULL,
	[ip_address] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[session_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[States]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[States](
	[ID Estado] [int] IDENTITY(1,1) NOT NULL,
	[State Name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID Estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[ID Usuario] [int] IDENTITY(1,1) NOT NULL,
	[User Name] [varchar](45) NOT NULL,
	[User Age] [date] NOT NULL,
	[User Phone] [int] NULL,
	[User Ubication] [varchar](60) NULL,
	[Passwords] [varchar](60) NULL,
	[ID Rol] [int] NOT NULL,
	[ID Estado] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sessions] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Categories]  WITH CHECK ADD  CONSTRAINT [FK_Categories_Estados] FOREIGN KEY([ID Estado])
REFERENCES [dbo].[States] ([ID Estado])
GO
ALTER TABLE [dbo].[Categories] CHECK CONSTRAINT [FK_Categories_Estados]
GO
ALTER TABLE [dbo].[DetailSalesClient]  WITH CHECK ADD  CONSTRAINT [FK_DetailSales_Products] FOREIGN KEY([ID Product])
REFERENCES [dbo].[Products] ([ID Product])
GO
ALTER TABLE [dbo].[DetailSalesClient] CHECK CONSTRAINT [FK_DetailSales_Products]
GO
ALTER TABLE [dbo].[DetailSalesClient]  WITH CHECK ADD  CONSTRAINT [FK_DetailSales_Sales] FOREIGN KEY([ID Venta])
REFERENCES [dbo].[SalesCientResume] ([ID Sales])
GO
ALTER TABLE [dbo].[DetailSalesClient] CHECK CONSTRAINT [FK_DetailSales_Sales]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([ID Categoria])
REFERENCES [dbo].[Categories] ([ID Categoria])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[SalesCientResume]  WITH CHECK ADD  CONSTRAINT [FK_DetailSales_Status_Sakes] FOREIGN KEY([ID Sale Status])
REFERENCES [dbo].[SalesStatus] ([ID Sale Status])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[SalesCientResume] CHECK CONSTRAINT [FK_DetailSales_Status_Sakes]
GO
ALTER TABLE [dbo].[SalesCientResume]  WITH CHECK ADD  CONSTRAINT [FK_Sales_Usuarios] FOREIGN KEY([ID Usuario])
REFERENCES [dbo].[Usuarios] ([ID Usuario])
GO
ALTER TABLE [dbo].[SalesCientResume] CHECK CONSTRAINT [FK_Sales_Usuarios]
GO
ALTER TABLE [dbo].[SalesCientResume]  WITH CHECK ADD  CONSTRAINT [FK_SalesCientResume_SaleStatus] FOREIGN KEY([ID Sale Status])
REFERENCES [dbo].[SalesStatus] ([ID Sale Status])
GO
ALTER TABLE [dbo].[SalesCientResume] CHECK CONSTRAINT [FK_SalesCientResume_SaleStatus]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_Usuarios_Estados] FOREIGN KEY([ID Estado])
REFERENCES [dbo].[States] ([ID Estado])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_Usuarios_Estados]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_Usuarios_Roles] FOREIGN KEY([ID Rol])
REFERENCES [dbo].[Roles] ([ID Rol])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_Usuarios_Roles]
GO
/****** Object:  StoredProcedure [dbo].[CompareAndUpdateSaleTotal]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CompareAndUpdateSaleTotal]
    @IDSales INT,
    @NewTotal MONEY,
    @Details dbo.DetailSaleType READONLY
AS
BEGIN
    BEGIN TRY
        DECLARE @CurrentTotal MONEY;

        -- Obtener el total actual de la venta
        SELECT @CurrentTotal = [Total]
        FROM [dbo].[SalesCientResume]
        WHERE [ID Sales] = @IDSales;

        -- Verificar si la venta existe
        IF @CurrentTotal IS NULL
        BEGIN
            RAISERROR('La venta especificada no existe.', 16, 1);
            RETURN;
        END

        -- Comparar los totales
        IF @NewTotal > @CurrentTotal
        BEGIN
            PRINT 'El nuevo total es mayor que el actual.';
        END
        ELSE IF @NewTotal < @CurrentTotal
        BEGIN
            PRINT 'El nuevo total es menor que el actual.';
        END
        ELSE
        BEGIN
            PRINT 'El nuevo total es igual al actual.';
        END

        -- Actualizar el total de la venta
        UPDATE [dbo].[SalesCientResume]
        SET [Total] = @NewTotal
        WHERE [ID Sales] = @IDSales;

        PRINT 'El total de la venta se actualizó correctamente.';

        -- Actualizar los detalles de la venta en la tabla DetailSalesClient
        UPDATE [dbo].[DetailSalesClient]
        SET [Quanity] = detail.Quantity,  -- Usar 'Quanity' en lugar de 'Quantity'
            [Price] = detail.Price
        FROM @Details AS detail
        WHERE [DetailSalesClient].[ID Venta] = @IDSales
            AND [DetailSalesClient].[ID Product] = detail.[ID Product];

        PRINT 'Detalles de la venta actualizados correctamente.';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[CreateSalesStatus]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateSalesStatus]
    @Status NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [GDA0047Sergio_Guerra].[dbo].[SalesStatus] ([Status])
    VALUES (@Status);

    SELECT SCOPE_IDENTITY() AS NewID; -- Devuelve el ID generado.
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteCategory]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Eliminar una categoría
CREATE PROCEDURE [dbo].[DeleteCategory]
    @IDCategoria INT,
	@IDEstado INT
AS
BEGIN
    SET NOCOUNT ON;
    update Categories set [ID Estado]= @IDEstado WHERE [ID Categoria] = @IDCategoria;
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteUsuario]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Eliminar un usuario
CREATE PROCEDURE [dbo].[DeleteUsuario]
	@IDEstado int,
    @IDUsuario INT
AS
BEGIN
    SET NOCOUNT ON;
    Update Usuarios set [ID Estado]=@IDEstado WHERE [ID Usuario] = @IDUsuario;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetCategories]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Obtener todas las categorías
CREATE PROCEDURE [dbo].[GetCategories]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM Categories;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetDetailSales]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Obtener todos los detalles de ventas
CREATE PROCEDURE [dbo].[GetDetailSales]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM DetailSalesClient;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetProducts]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProducts]
AS
BEGIN
    SELECT 
     
        c.[Category Name],    -- Mostrar el nombre de la categoría
        p.[Product Name], 
        p.[Product Prices], 
        p.[Product Stock]
    FROM 
        Products p
    LEFT JOIN 
        Categories c 
    ON 
        p.[ID Categoria] = c.[ID Categoria]; -- Relación entre productos y categorías
END;

--exec GetProducts
GO
/****** Object:  StoredProcedure [dbo].[GetSales]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Obtener todas las ventas
CREATE PROCEDURE [dbo].[GetSales]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM SalesCientResume;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetUsuarios]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUsuarios]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        u.[ID Usuario],
        u.[User Name],
        u.[User Age],
        u.[User Phone],
        u.[User Ubication],
        u.[Passwords],
        r.[Role Name] AS Rol,
        e.[State Name] AS Estado
    FROM 
        [dbo].[Usuarios] u
    LEFT JOIN 
        [dbo].[Roles] r ON u.[ID Rol] = r.[ID Rol]
    LEFT JOIN 
        [dbo].[States] e ON u.[ID Estado] = e.[ID Estado];
END;


--exec GetUsuarios
GO
/****** Object:  StoredProcedure [dbo].[InsertCategory]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCategory]
    @CategoryList CategoryTableType READONLY
AS
BEGIN
    INSERT INTO [dbo].[Categories] ([Category Name], [ID Estado], [ID Usuario])
    SELECT [Category Name], [ID Estado], [ID Usuario]
    FROM @CategoryList;
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertDetailSale]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insertar un detalle de venta
CREATE PROCEDURE [dbo].[InsertDetailSale]
    @IDVenta INT,
    @IDProduct INT,
    @Quanity INT,
    @Price MONEY,
    @FechaDetalle DATE  -- Nuevo parámetro para la fecha del detalle
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO DetailSalesClient ([ID Venta], [ID Product], [Quanity], [Price], [Fecha Detalle])
    VALUES (@IDVenta, @IDProduct, @Quanity, @Price, @FechaDetalle);
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertProduct]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertProduct]
    @ProductName NVARCHAR(100),
    @IDCategoria INT,
    @ProductProvider NVARCHAR(100),
    @ProductPrices DECIMAL(10, 2),
    @ProductStock INT,
    @IDUsuario INT
AS
BEGIN
    INSERT INTO [dbo].[Products] ([Product Name], [ID Categoria], [Product Provider], [Product Prices], [Product Stock], [ID Usuario])
    VALUES (@ProductName, @IDCategoria, @ProductProvider, @ProductPrices, @ProductStock, @IDUsuario);
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertSale]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insertar una venta
CREATE PROCEDURE [dbo].[InsertSale]
    @IDUsuario INT,
    @Total MONEY,
    @Status VARCHAR(25),
    @FechaVenta DATE  -- Nuevo parámetro para la fecha de la venta
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO SalesCientResume ([ID Usuario], [Total], [Status], [Fecha Venta])
    VALUES (@IDUsuario, @Total, @Status, @FechaVenta);
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertUsuario]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insertar un usuario
CREATE PROCEDURE [dbo].[InsertUsuario]
    @UserName VARCHAR(45),
    @UserAge DATE,
    @UserPhone INT = NULL,
    @UserUbication VARCHAR(60) = NULL,
    @Password VARCHAR(60),
    @IDRol INT,
    @IDEstado INT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Usuarios ([User Name], [User Age], [User Phone], [User Ubication], [Passwords], [ID Rol], [ID Estado])
    VALUES (@UserName, @UserAge, @UserPhone, @UserUbication, @Password, @IDRol, @IDEstado);
END;
GO
/****** Object:  StoredProcedure [dbo].[ReadSalesStatus]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ReadSalesStatus]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT [ID Sale Status], [Status]
    FROM [GDA0047Sergio_Guerra].[dbo].[SalesStatus];
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ConsumoPorUsuario_Reciente]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ConsumoPorUsuario_Reciente]
AS
BEGIN
    SET NOCOUNT ON; -- Evita mensajes adicionales de filas afectadas.

    SELECT 
        U.[User Name], 
        SUM(S.[Total]) AS Total_Consumo,
        MAX(S.[Fecha Venta]) AS Fecha_Reciente
    FROM SalesCientResume S
    INNER JOIN Usuarios U 
        ON S.[ID Usuario] = U.[ID Usuario]
    GROUP BY U.[User Name]
    ORDER BY Fecha_Reciente DESC; -- Ordena por la fecha más reciente
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertarVenta]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertarVenta]
    @ID_Usuario INT,
    @Total MONEY,
    @Status VARCHAR(25),
    @Fecha_Venta DATE,
    @DetalleVentas dbo.DETALLEVENTA_TYPE READONLY -- Parámetro de tipo tabla para los detalles de la venta
AS
BEGIN
    DECLARE @ID_Venta INT;

    -- Paso 1: Insertar el resumen de la venta en la tabla SalesCientResume
    INSERT INTO [SalesCientResume] ([ID Usuario], [Total], [Status], [Fecha Venta])
    VALUES (@ID_Usuario, @Total, @Status, @Fecha_Venta);

    -- Obtener el ID de la venta generada automáticamente
    SET @ID_Venta = SCOPE_IDENTITY();

    -- Paso 2: Insertar los detalles de la venta en la tabla DetailSalesClient
    INSERT INTO [DetailSalesClient] ([ID Venta], [ID Product], [Quanity], [Price], [Fecha Detalle])
    SELECT @ID_Venta, [ID_Product], [Quanity], [Price], [Fecha_Detalle]
    FROM @DetalleVentas; -- Usamos el parámetro de tipo tabla para insertar los detalles

    -- El procedimiento termina
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerComprasPorUsuario]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ObtenerComprasPorUsuario]
    @ID_Usuario INT  -- Parámetro para filtrar por ID del usuario
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        U.[User Name] AS Nombre_Usuario,
        S.[ID Sales] AS ID_Venta,
        S.[Fecha Venta],
        P.[Product Name] AS Nombre_Producto,
        D.[Quanity] AS Cantidad,
        D.[Price] AS Precio_Unitario,
        (D.[Quanity] * D.[Price]) AS Total_Producto
    FROM [Usuarios] U
    INNER JOIN [SalesCientResume] S 
        ON U.[ID Usuario] = S.[ID Usuario]
    INNER JOIN [DetailSalesClient] D 
        ON S.[ID Sales] = D.[ID Venta]
    INNER JOIN [Products] P 
        ON D.[ID Product] = P.[ID Product]
    WHERE U.[ID Usuario] = @ID_Usuario -- Filtra por el ID del usuario
    ORDER BY S.[Fecha Venta] DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerTodasLasCompras]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ObtenerTodasLasCompras]
AS
BEGIN
    SET NOCOUNT ON; -- Evita mensajes adicionales de "filas afectadas".

    SELECT 
        U.[User Name] AS Nombre_Usuario,
        S.[ID Sales] AS ID_Venta,
        S.[Fecha Venta],
        P.[Product Name] AS Nombre_Producto,
        D.[Quanity] AS Cantidad,
        D.[Price] AS Precio_Unitario,
        (D.[Quanity] * D.[Price]) AS Total_Producto
    FROM [Usuarios] U
    INNER JOIN [SalesCientResume] S 
        ON U.[ID Usuario] = S.[ID Usuario]
    INNER JOIN [DetailSalesClient] D 
        ON S.[ID Sales] = D.[ID Venta]
    INNER JOIN [Products] P 
        ON D.[ID Product] = P.[ID Product]
    ORDER BY U.[User Name], S.[Fecha Venta] DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateCategory]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Actualizar una categoría
CREATE PROCEDURE [dbo].[UpdateCategory]
    @IDCategoria INT,
    @CategoryName VARCHAR(40),
    @IDEstado INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Categories
    SET [Category Name] = @CategoryName,
        [ID Estado] = @IDEstado
    WHERE [ID Categoria] = @IDCategoria;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateProduct]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateProduct]
    @ID_Product INT,
    @ID_Categoria INT = NULL,
    @Product_Name NVARCHAR(255) = NULL,
    @Product_Provider NVARCHAR(255) = NULL,
    @Product_Prices DECIMAL(18, 2) = NULL,
    @Product_Stock INT = NULL,
    @ID_Usuario INT = NULL,
    @Image NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar si el producto existe
    IF NOT EXISTS (SELECT 1 FROM [GDA0047Sergio_Guerra].[dbo].[Products] WHERE [ID Product] = @ID_Product)
    BEGIN
        RAISERROR('Producto no encontrado', 16, 1);
        RETURN;
    END

    -- Actualizar el producto
    UPDATE [GDA0047Sergio_Guerra].[dbo].[Products]
    SET 
        [ID Categoria] = ISNULL(@ID_Categoria, [ID Categoria]),
        [Product Name] = ISNULL(@Product_Name, [Product Name]),
        [Product Provider] = ISNULL(@Product_Provider, [Product Provider]),
        [Product Prices] = ISNULL(@Product_Prices, [Product Prices]),
        [Product Stock] = ISNULL(@Product_Stock, [Product Stock]),
        [ID Usuario] = ISNULL(@ID_Usuario, [ID Usuario]),
        [image] = CASE 
                    WHEN @Image IS NOT NULL AND LTRIM(RTRIM(@Image)) <> '' THEN @Image 
                    ELSE [image]
                  END
    WHERE [ID Product] = @ID_Product;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateSalesStatus]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSalesStatus]
    @IDSaleStatus INT,
    @Status NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [GDA0047Sergio_Guerra].[dbo].[SalesStatus]
    SET [Status] = @Status
    WHERE [ID Sale Status] = @IDSaleStatus;

    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('No se encontró el registro con el ID proporcionado.', 16, 1);
    END;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateSaleStatus]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSaleStatus]
    @IDSales INT,        -- ID de la venta a actualizar
    @NewStatusID INT     -- Nuevo estado de la venta
AS
BEGIN
    BEGIN TRY
        -- Verificar si la venta existe
        IF NOT EXISTS (
            SELECT 1 
            FROM [dbo].[SalesCientResume] 
            WHERE [ID Sales] = @IDSales
        )
        BEGIN
            RAISERROR('La venta especificada no existe.', 16, 1);
            RETURN;
        END

        -- Actualizar el estado de la venta
        UPDATE [dbo].[SalesCientResume]
        SET [ID Sale Status] = @NewStatusID
        WHERE [ID Sales] = @IDSales;

        PRINT 'El estado de la venta se actualizó correctamente.';
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        PRINT ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateUsuario]    Script Date: 23/12/2024 00:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Actualizar un usuario
CREATE PROCEDURE [dbo].[UpdateUsuario]
    @IDUsuario INT,
    @UserName VARCHAR(45),
    @UserAge DATE,
    @UserPhone INT = NULL,
    @UserUbication VARCHAR(60) = NULL,
    @Password VARCHAR(60),
    @IDRol INT,
    @IDEstado INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Usuarios
    SET [User Name] = @UserName,
        [User Age] = @UserAge,
        [User Phone] = @UserPhone,
        [User Ubication] = @UserUbication,
        [Passwords] = @Password,
        [ID Rol] = @IDRol,
        [ID Estado] = @IDEstado
    WHERE [ID Usuario] = @IDUsuario;
END;
GO
USE [master]
GO
ALTER DATABASE [GDA0047Sergio_Guerra] SET  READ_WRITE 
GO
