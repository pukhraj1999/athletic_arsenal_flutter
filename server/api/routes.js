const express = require("express");

const router = express.Router();

// All routers
router.use("/user", require("./auth/auth.router"));
router.use("/admin", require("./admin/admin.router"));
router.use("/product", require("./product/products.route"));

// Greeting
router.get("/", (req, res) => {
  res.send("Let's explore the api");
});

module.exports = router;
