const mongoose = require("mongoose");
const { productSchema } = require("../product/product.model");

const userSchema = mongoose.Schema({
  firstname: {
    type: String,
    trim: true,
    require: true,
  },
  lastname: {
    type: String,
    trim: true,
    require: true,
  },
  email: {
    type: String,
    trim: true,
    require: true,
  },
  password: {
    type: String,
    trim: true,
    require: true,
  },
  address: {
    type: String,
    default: "",
  },
  type: {
    type: String,
    default: "user",
  },
  //cart
  cart: [
    {
      product: productSchema,
      quantity: {
        type: Number,
        required: true,
      },
    },
  ],
});

const User = mongoose.model("User", userSchema);

module.exports = User;
