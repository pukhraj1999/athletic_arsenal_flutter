const { Product } = require("../product/product.model");
const User = require("../user/user.model");

exports.addToCart = async (req, res) => {
  try {
    const { id } = req.body;
    const product = await Product.findById(id);
    let user = await User.findById(req.user_id);

    if (user.cart.length == 0) {
      user.cart.push({ product, quantity: 1 });
    } else {
      let isProductFound = false;

      for (let i = 0; i < user.cart.length; i++) {
        //product already exist in cart (comparing object)
        if (user.cart[i].product._id.equals(product._id)) {
          isProductFound = true;
        }
      }

      //Found product and increment it
      if (isProductFound) {
        let foundProduct = user.cart.find((cartItem) =>
          cartItem.product._id.equals(product._id)
        );
        foundProduct.quantity += 1; //increasing it's quantity
      } else {
        user.cart.push({ product, quantity: 1 });
      }
    }

    user = await user.save();
    res.status(200).json(user);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.removeFromCart = async (req, res) => {
  try {
    const { id } = req.params;
    const product = await Product.findById(id);
    let user = await User.findById(req.user_id);

    for (let i = 0; i < user.cart.length; i++) {
      //product already exist in cart (comparing object)
      if (user.cart[i].product._id.equals(product._id)) {
        //deleting the whole product
        if (user.cart[i].quantity == 1) {
          user.cart.splice(i, 1);
        } else {
          user.cart[i].quantity -= 1;
        }
      }
    }

    user = await user.save();
    res.status(200).json(user);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
