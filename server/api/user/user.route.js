const express = require("express");

const userRouter = express.Router();

// Import Controllers
const { auth } = require("../auth/auth.middleware");
const { addToCart, removeFromCart } = require("./user.controller");

//Request routes
userRouter.post("/addtocart", auth, addToCart);
userRouter.delete("/removefromcart/:id", auth, removeFromCart);

//Greeting
userRouter.get("/", (req, res) => {
  res.send("Welcome to user API");
});

module.exports = userRouter;
