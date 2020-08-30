const express = require("express");
const logger = require("../../utils/logger");
const route = express.Router();
const db = require("../../database/config");

route.get("/api/acopios/:id", (req, res) => {
  const idAcopio = req.params.id;
  if (!idAcopio) {
    logger.error("ID was not supplied");
    res.status(500).json({ message: "error" });
  }
  // build SQL Sentence
  db.query(
    `SELECT M.id, M.title, C.category, M.phone, M.picture, M.lat, M.lng FROM manufacturers ` +
      `M LEFT JOIN manufacturing_categories C ON C.id = M.id_category WHERE M.id = ${idAcopio}`,
    (err, result, fields) => {
      if (err) {
        logger.error("Something happened, err: " + err);
        res.status(500).json({ message: "error" });
        return;
      }
      const data = result.map((manu) => {
        return {
          id: manu.id,
          name: manu.title,
          category: manu.category,
          phone: manu.phone,
          picture: manu.picture,
          lat: manu.lat,
          lng: manu.lng,
        };
      });
      res.json(data);
    }
  );
});

route.get("/api/acopios", (req, res) => {
  // build SQL Sentence
  db.query(
    `SELECT M.id, M.title, C.category, M.phone, M.picture, M.lat, M.lng FROM manufacturers M ` +
      `LEFT JOIN manufacturing_categories C ON C.id = M.id_category`,
    (err, result, fields) => {
      if (err) {
        logger.error("Something happened, err: " + err);
        res.status(500).json({ message: "error" });
        return;
      }
      const data = result.map((manu) => {
        return {
          id: manu.id,
          cateogory: manu.category,
          name: manu.title,
          phone: manu.phone,
          picture: manu.picture,
          lat: manu.lat,
          lng: manu.lng,
        };
      });
      res.json(data);
    }
  );
});

module.exports = route;
