const express = require("express");

const route = express.Router();
const db = require("../../database/config");

route.get("/api/tracking/:uuid", (req, res) => {
  const uuid = req.params.uuid;

  // get ID from UUID
  let id = 0;
  const sqlSelectId = `SELECT pid FROM products WHERE uuid=${uuid}`;
  db.query(sqlSelectId, (err, result, fields) => {
    if (err) {
      logger.error("Something happened, err: " + err);
      res.status(500).json({ message: "error" });
      return;
    }

    id = result[0].pid;
    // get padres

    const sqlPadres = (idProducto) => {
      return `
  with recursive cte(id, id_product, id_parent, observation) as (
    select     id,
               id_product,
               id_parent,
               observation
    from       traceability
    where      id_product = ${idProducto}
    union all
    select     p.id,
               p.id_product,
               p.id_parent,
               p.observation
    from       traceability p
    inner join cte
            on p.id_product = cte.id_parent
  )
  SELECT * FROM cte INNER JOIN products P on id_product = P.pid;`;
    };

    db.query(sqlPadres(id), (err, results, fields) => {
      if (err) {
        logger.error("Something happened, err: " + err);
        res.status(500).json({ message: "error" });
        return;
      }
      const data = results
        .map((producto) => {
          return {
            observation: producto.observation,
            title: producto.title,
            details: producto.details,
            uuid: producto.uuid.toString(),
            picture: producto.picture,
          };
        })
        .slice(1);
      res.json(data);
    });
  });
});

module.exports = route;
