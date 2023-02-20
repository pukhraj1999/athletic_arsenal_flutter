const express = require("express");

const adminRouter = express.Router();

// Import Controllers
const { isAdmin } = require("./admin.middleware");
const {
  addProduct,
  getProducts,
  deleteProduct,
  addProductCategory,
  getProductCategories,
  deleteProductCategory,
  updateProduct,
  updateProductCategory,
} = require("../product/product.controller");

//Request routes
adminRouter.post("/addproduct", isAdmin, addProduct);
adminRouter.get("/getproducts", getProducts);
adminRouter.delete("/deleteproduct", isAdmin, deleteProduct);

adminRouter.post("/addcategory", isAdmin, addProductCategory);
adminRouter.get("/getcategories", getProductCategories);
adminRouter.delete("/deletecategory", isAdmin, deleteProductCategory);

adminRouter.put("/updateproduct/:id", isAdmin, updateProduct);
adminRouter.put("/updatecategory/:id", isAdmin, updateProductCategory);

//Greeting
adminRouter.get("/", (req, res) => {
  res.send("Welcome to admin API");
});

module.exports = adminRouter;
