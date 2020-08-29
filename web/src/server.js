const express = require("express");
const session = require("express-session");
const cookieParser = require("cookie-parser");
const bodyParser = require("body-parser");
const winston = require("winston"); // Logger
const path = require("path");
const logger = require("./utils/logger");

/**
 * Create app object & assign express object.
 */
const app = express();

/**
 * Set view engine & point a view folder.
 */
app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));
/**
 * Register cookie
 */
app.use(cookieParser());
/**
 * Register session with secret key
 */
app.use(session({ secret: "kak", resave: true, saveUninitialized: true }));
/**
 * Add & register body parser
 */
app.use(bodyParser.json()); // support json encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies
/**
 * Set site title.
 */
app.locals.siteTitle = "🌱 Axolo";
/**
 * set public folder is static to use any where.
 * Public folder contents js, css, images
 */
app.use(express.static("public"));
/**
 * Add routes.
 */
app.use(require("./routers/pages"));
/**
 * Cache
 */
/*app.use(function (req, res, next) {
  res.header('Cache-Control', 'private, no-cache, no-store, must-revalidate');
  // -1 setting up request as expired and re-requesting before display again.
  res.header('Expires', '-1');
  res.header('Pragma', 'no-cache');
  next();
});*/
/**
 * Create server.
 */
const port = process.env.PORT || 3000;
app.listen(port, function () {
  logger.info(`Running server on port ${port}`);
});
