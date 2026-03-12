/* 
------------------------------------------------------------------------------
------------------------------------------------------------------------------
Script para crear una nueva base de datos llamada 'DataWarehouse', después de comprobar que efectivamente existe y de eliminarla para volverla a crear si es el caso.
Creación de esquemas bronze, silver y gold.

ESTE SCRIPT BORRARÁ LA BASE DE DATOS 'DATAWAREHOUSE' POR COMPLETO SI ESTA EXISTE, HACER COPIA DE SEGURIDAD ANTES DE EJECUTARLO
------------------------------------------------------------------------------
------------------------------------------------------------------------------
*/

USE master;
GO

--Drop DataWarehouse y volverlo a crear
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO

--Crear el DataWarehouse
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

--Crear esquemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
