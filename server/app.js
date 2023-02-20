const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
require("dotenv").config();

const app = express();

// Connect DataBase
mongoose.set("strictQuery", true);
mongoose.connect(
  process.env.DB,
  {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  },
  (err) => {
    if (err) console.log(err);
    else console.log("Successfully Connected!");
  }
);

//middlewares
app.use(cors());
app.use(express.json());
app.use("/api", require("./api/routes"));

// Greeting
app.get("/", (req, res) => {
  res.send("Welcome to AthleticArsenal API");
});

//0.0.0.0 -> means it can be accessed from anywhere
const port = process.env.PORT || 5000;
app.listen(port, "0.0.0.0", () => {
  console.log(`Server running at port: http://localhost:${port}`);
});
