
/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`final_magni` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `final_magni`;

DROP TABLE IF EXISTS `rubro`;
CREATE TABLE `rubro` (
  `idRubro` int(11) NOT NULL AUTO_INCREMENT,
  `idRubroPadre` int(11) DEFAULT NULL,
  `codigo` varchar(20) DEFAULT NULL,
  `denominacion` varchar(100) NOT NULL,
  PRIMARY KEY (`idRubro`),
  CONSTRAINT `rubro_rubro_padre` FOREIGN KEY (`idRubroPadre`) REFERENCES `rubro` (`idRubro`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `articulo`;
CREATE TABLE `articulo` (
  `idArticulo` int(11) NOT NULL AUTO_INCREMENT,
  `idRubro` int(11) NOT NULL,
  `denominacion` varchar(100) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `precioCompra` double NOT NULL,
  `precioVenta` double NOT NULL,
  `iva` double DEFAULT NULL,
  PRIMARY KEY (`idArticulo`),
  KEY `fk_articulo_rubro_idx` (`idRubro`),
  CONSTRAINT `fk_articulo_rubro` FOREIGN KEY (`idRubro`) REFERENCES `rubro` (`idRubro`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `domicilio`;
CREATE TABLE `domicilio` (
  `idDomicilio` int(11) NOT NULL AUTO_INCREMENT,
  `calle` varchar(100) DEFAULT NULL,
  `numero` int DEFAULT NULL,
  `localidad` varchar(100) DEFAULT NULL,
  `latitud` double DEFAULT NULL,
  `longitud` double DEFAULT NULL,
  PRIMARY KEY (`idDomicilio`)
);

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente` (
  `idCliente` int(11) NOT NULL AUTO_INCREMENT,
  `idDomicilio` int(11) NOT NULL,
  `razonSocial` varchar(100) NOT NULL,
  `cuit` varchar(20) DEFAULT NULL,
  `saldo` double DEFAULT NULL,
  PRIMARY KEY (`idCliente`),
  KEY `fk_cliente_domicilio_idx` (`idDomicilio`),
  CONSTRAINT `fk_cliente_domicilio` FOREIGN KEY (`idDomicilio`) REFERENCES `domicilio` (`idDomicilio`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `pedidoVenta`;
CREATE TABLE `pedidoVenta` (
  `idPedidoVenta` int(11) NOT NULL AUTO_INCREMENT,
  `fechaEntrega` date DEFAULT NULL,
  `gastosEnvio` double DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `entregado` bit(1) DEFAULT b'0',
  `fechaPedido` date DEFAULT NULL,
  `nroPedido` int(11) DEFAULT NULL,
  `subTotal` double DEFAULT NULL,
  `montoTotal` double DEFAULT NULL,
  `idCliente` int(11) NOT NULL,
  `idDomicilio` int(11) NOT NULL,
  PRIMARY KEY (`idPedidoVenta`),
  KEY `fk_pedidoVenta_Cliente_idx` (`idCliente`),
  KEY `fk_pedidoVenta_Domicilio_idx` (`idDomicilio`),
  CONSTRAINT `fk_pedidoVenta_Cliente` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidoVenta_Domicilio` FOREIGN KEY (`idDomicilio`) REFERENCES `domicilio` (`idDomicilio`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

DROP TABLE IF EXISTS `pedidoVentaDetalle`;
CREATE TABLE `pedidoVentaDetalle` (
  `idPedidoVentaDetalle` int(11) NOT NULL AUTO_INCREMENT,
  `cantidad` int(10) NOT NULL,
  `subTotal` double DEFAULT NULL,
  `porcentajeDescuento` double DEFAULT NULL,
  `idPedidoVenta` int(11) NOT NULL,
  `idArticulo` int(11) NOT NULL,
  PRIMARY KEY (`idPedidoVentaDetalle`),
  KEY `fk_pedidoVentaDetalle_PedidoVenta_idx` (`idPedidoVenta`),
  KEY `fk_pedidoVentaDetalle_Articulo_idx` (`idArticulo`),
  CONSTRAINT `fk_pedidoVentaDetalle_Articulo` FOREIGN KEY (`idArticulo`) REFERENCES `articulo` (`idArticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidoVentaDetalle_PedidoVenta` FOREIGN KEY (`idPedidoVenta`) REFERENCES `pedidoVenta` (`idPedidoVenta`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`idUsuario`)
);


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;