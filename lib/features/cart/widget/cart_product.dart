import 'package:athleticarsenal/features/cart/services/cart_services.dart';
import 'package:athleticarsenal/models/product.dart';
import 'package:athleticarsenal/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  CartProduct({Key? key, required this.index}) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final cartServices = CartServices();

  void increaseQuantity(Product product) {
    cartServices.addToCart(context: context, product: product);
  }

  void decreaseQuantity(Product product) {
    cartServices.removeFromCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    final quantity = productCart['quantity'];
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.fitWidth,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(
                      "Eligible For Free Shipping",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: EdgeInsets.only(
                      left: 10,
                      top: 5,
                    ),
                    child: Text(
                      "₹ ${product.price}",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(
                      product.quantity == 0 ? 'Out Of Stock' : "In Stock",
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.all(10),
            width: 108,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () => decreaseQuantity(product),
                  child: Container(
                    color: Colors.grey,
                    width: 35,
                    height: 32,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.remove,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black12,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Container(
                    width: 35,
                    height: 32,
                    alignment: Alignment.center,
                    child: Text(
                      quantity.toString(),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => increaseQuantity(product),
                  child: Container(
                    color: Colors.grey,
                    width: 35,
                    height: 32,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.add,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          height: 1,
          color: Colors.grey,
        )
      ],
    );
  }
}
