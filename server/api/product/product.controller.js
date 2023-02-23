const Category = require("./category.model");
const { Product } = require("./product.model");

exports.addProduct = async (req, res) => {
  try {
    const { name, description, images, quantity, price, category } = req.body;
    if (!name || !description || !images || !quantity || !price || !category)
      return res.json(400).json({ msg: "Please fill all fields!!" });
    let product = new Product({
      name,
      description,
      images,
      category,
      quantity,
      price,
    });
    product = await product.save();
    return res.status(200).json(product);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// /api/admin/update/<id>
exports.updateProduct = async (req, res) => {
  try {
    const { id } = req.params;
    const { name, description, images, quantity, price, category } = req.body;
    if (!name || !description || !images || !quantity || !price || !category)
      return res.json(400).json({ msg: "Please fill all fields!!" });
    // find and update product
    let product = await Product.findByIdAndUpdate(
      { _id: id },
      {
        $set: {
          name,
          description,
          images,
          price,
          quantity,
        },
      },
      {
        new: true,
        useFindAndModify: false,
      }
    );
    return res.status(200).json(product);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.addProductCategory = async (req, res) => {
  try {
    const { category } = req.body;
    if (!category)
      return res.json(400).json({ msg: "Please fill all fields!!" });
    let productCategory = new Category({
      category,
    });
    productCategory = await productCategory.save();
    return res.status(200).json(productCategory);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// /api/admin/updatecategory/<id>
exports.updateProductCategory = async (req, res) => {
  try {
    const { id } = req.params;
    const { category } = req.body;
    if (!category)
      return res.json(400).json({ msg: "Please fill all fields!!" });
    //finding and updating
    let productCategory = await Category.findByIdAndUpdate(
      { _id: id },
      {
        $set: {
          category,
        },
      },
      {
        new: true,
        useFindAndModify: false,
      }
    );
    return res.status(200).json(productCategory);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.getProductCategories = async (req, res) => {
  try {
    let category = await Category.find();
    return res.json(category);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.deleteProductCategory = async (req, res) => {
  try {
    const { id } = req.body;
    await Category.deleteOne({ _id: id });
    return res.status(200).json({ msg: "Product Deleted!!" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.getProducts = async (req, res) => {
  try {
    let product = await Product.find();
    return res.json(product);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.deleteProduct = async (req, res) => {
  try {
    const { id } = req.body;
    await Product.deleteOne({ _id: id });
    return res.status(200).json({ msg: "Product Deleted!!" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// /api/product/bycategory?category=<name>
exports.getProductByCategory = async (req, res) => {
  try {
    const { category } = req.query;
    let products = await Product.find({ category: category });
    return res.status(200).json(products); //pass directly
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// /api/product/search/<searchProduct>
exports.getProductBySearch = async (req, res) => {
  try {
    const { name } = req.params;
    let products = await Product.find({
      name: { $regex: name, $options: "i" }, //search pattern
    });
    return res.status(200).json(products); //pass directly
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// /api/product/review
exports.addReviewProduct = async (req, res) => {
  try {
    //here below id is product id
    const { id, userName, review, rating } = req.body;
    if (!id || !userName || !review || !rating)
      return res.status(400).json({ msg: "Please fill id,review,rating" });
    let product = await Product.findById(id);
    //removing already existed review
    for (let i = 0; i < product.reviews.length; i++) {
      if (product.reviews[i].userId == req.user_id) {
        product.reviews.splice(i, 1); //deleting review using index (1 means delete 1 object)
        break;
      }
    }
    //fetching user name
    const reviewSchema = {
      userId: req.user_id,
      userName: userName,
      rating,
      review,
    };
    product.reviews.push(reviewSchema);
    product = await product.save();
    res.status(200).json(product);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// product that got higher
//rating will get the deal of the day
exports.dealOfTheDay = async (req, res) => {
  try {
    let products = await Product.find();
    //sorting in descending order
    products.sort((a, b) => {
      let sumA = 0;
      let sumB = 0;

      for (let i = 0; i < a.reviews.length; i++) {
        sumA += a.reviews[i].rating;
      }
      for (let i = 0; i < b.reviews.length; i++) {
        sumB += b.reviews[i].rating;
      }
      return sumA < sumB ? 1 : -1;
    });
    //return only single product
    return res.status(200).json(products[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
