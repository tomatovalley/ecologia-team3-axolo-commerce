const winston = require("winston");
const colorizer = winston.format.colorize();

const logger = winston.createLogger({
  level: "info",
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.simple(),
    winston.format.printf((msg) =>
      colorizer.colorize(
        msg.level,
        `${msg.timestamp} - ${msg.level}: ${msg.message}`
      )
    )
  ),
  transports: [
    new winston.transports.Console({
      prettyPrint: true,
      colorize: true,
      timestamp: true,
    }),
  ],
});

module.exports = logger;
