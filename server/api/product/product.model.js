const mongoose = require("mongoose");
const reviewSchema = require("./review.model");

const productSchema = mongoose.Schema({
  name: {
    type: String,
    trim: true,
    required: true,
  },
  description: {
    type: String,
    trim: true,
    required: true,
  },
  images: [
    {
      type: String,
      required: true,
    },
  ],
  category: {
    type: String,
    trim: true,
    required: true,
  },
  quantity: {
    type: Number,
    required: true,
  },
  price: {
    type: Number,
    required: true,
  },
  //reviews
  reviews: [reviewSchema], //review structure from another file
});

const Product = mongoose.model("Product", productSchema);
module.exports = { Product, productSchema };
