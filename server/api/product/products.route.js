const express = require("express");

const productRouter = express.Router();

// Import Controllers
const { auth } = require("../auth/auth.middleware");
const {
  getProductByCategory,
  getProductBySearch,
  addReviewProduct,
  dealOfTheDay,
} = require("../product/product.controller");

//Request routes
productRouter.get("/bycategory", auth, getProductByCategory);
productRouter.get("/search/:name", auth, getProductBySearch);
productRouter.get("/deal", auth, dealOfTheDay); //return 1 product with highest rating

productRouter.post("/review", auth, addReviewProduct);

//Greeting
productRouter.get("/", (req, res) => {
  res.send("Welcome to product API");
});

module.exports = productRouter;
