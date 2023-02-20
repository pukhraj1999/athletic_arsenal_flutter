const express = require("express");

const authRouter = express.Router();

// Import Controllers
const { tokenIsValid, signup, signin, getUser } = require("./auth.controller");
const { auth } = require("./auth.middleware");

// Router Requests
authRouter.post("/signup", signup);
authRouter.post("/signin", signin);
authRouter.post("/tokenisvalid", tokenIsValid);

authRouter.get("/getuser", auth, getUser);

// Greeting
authRouter.get("/", (req, res) => {
  res.send("Welcome to authentication API");
});

module.exports = authRouter;
