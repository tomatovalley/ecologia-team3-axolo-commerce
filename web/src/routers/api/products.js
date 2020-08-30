// TO-DO: get info of product from UUID
const express = require("express");
const logger = require("../../utils/logger");
const route = express.Router();
const db = require("../../database/config");

route.get("/api/products/:id", (req, res) => {
  const idProducto = req.params.id;
  if (!idProducto) {
    logger.error("ID was not supplied");
    res.status(500).json({ message: "error" });
  }
  // build SQL Sentence
  db.query(
    `SELECT * FROM products P ` + `WHERE P.pid = ${idProducto}`,
    (err, result, fields) => {
      if (err) {
        logger.error("Something happened, err: " + err);
        res.status(500).json({ message: "error" });
        return;
      }
      const data = result.map((producto) => {
        return {
          id: producto.pid,
          name: producto.title,
          details: producto.details,
          uuid: producto.uuid.toString(),
          picture: producto.picture,
        };
      });
      res.json(data);
    }
  );
});

route.get("/api/products/uuid/:uuid", (req, res) => {
  const uuidProducto = req.params.uuid;
  if (!uuidProducto) {
    logger.error("ID was not supplied");
    res.status(500).json({ message: "error" });
  }
  // build SQL Sentence
  db.query(
    `SELECT * FROM products P ` + `WHERE P.uuid = ${uuidProducto}`,
    (err, result, fields) => {
      if (err) {
        logger.error("Something happened, err: " + err);
        res.status(500).json({ message: "error" });
        return;
      }
      const data = result.map((producto) => {
        return {
          id: producto.pid,
          name: producto.title,
          details: producto.details,
          uuid: producto.uuid.toString(),
          picture: producto.picture,
        };
      });
      res.json(data);
    }
  );
});

route.get("/api/products/", (req, res) => {
  // build SQL Sentence
  db.query(`SELECT * FROM products`, (err, result, fields) => {
    if (err) {
      logger.error("Something happened, err: " + err);
      res.status(500).json({ message: "error" });
      return;
    }
    const data = result.map((producto) => {
      return {
        id: producto.pid,
        name: producto.title,
        details: producto.details,
        uuid: producto.uuid.toString(),
        picture: producto.picture,
      };
    });
    res.json(data);
  });
});

module.exports = route;
