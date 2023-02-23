import "package:athleticarsenal/common/widgets/custom_button.dart";
import "package:athleticarsenal/common/widgets/custom_search_appbar.dart";
import "package:athleticarsenal/constants/global_Variables.dart";
import "package:athleticarsenal/features/cart/widget/cart_product.dart";
import "package:athleticarsenal/features/cart/widget/cart_subtotal.dart";
import "package:athleticarsenal/features/home/widgets/address.dart";
import "package:athleticarsenal/providers/user_provider.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class CartScreen extends StatefulWidget {
  static const routeName = "/cartscreen";
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(GlobalVariables.appBarHeight),
        child: CustomSearchAppBar(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            AddressBox(),
            CartSubtotal(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CustomButton(
                title: "Proceed to Buy (${user.cart.length} items)",
                onPressed: () {},
              ),
            ),
            SizedBox(height: 15),
            Container(
              color: Colors.black.withOpacity(0.08),
              height: 1,
            ),
            SizedBox(height: 5),
            Container(
              height: 550,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: user.cart.length,
                itemBuilder: (context, index) {
                  return CartProduct(index: index);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
