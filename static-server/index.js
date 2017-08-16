const express = require("express");
const logger = require("morgan");
const app = express();
const cors = require('cors')

const PORT = process.env.PORT || 1337;
const NAME = process.env.NAME || '<app-name>';

app.use(cors());
app.use(logger("combined"));
app.use("/", express.static("/dist/"));

app.listen(PORT, err => {
  if (err) {
    return console.error(err)
  }
	console.log(`${NAME} server listening on internal port ${PORT}`);
});
