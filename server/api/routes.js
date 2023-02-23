const express = require("express");

const router = express.Router();

// All routers
router.use("/auth", require("./auth/auth.router"));
router.use("/admin", require("./admin/admin.router"));
router.use("/product", require("./product/products.route"));
router.use("/user", require("../api/user/user.route"));

// Greeting
router.get("/", (req, res) => {
  res.send("Let's explore the api");
});

module.exports = router;
