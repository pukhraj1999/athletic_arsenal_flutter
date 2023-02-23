import "package:athleticarsenal/common/widgets/custom_button.dart";
import "package:athleticarsenal/common/widgets/custom_search_appbar.dart";
import "package:athleticarsenal/common/widgets/custom_textfield.dart";
import "package:athleticarsenal/common/widgets/stars.dart";
import "package:athleticarsenal/constants/global_Variables.dart";
import "package:athleticarsenal/features/cart/services/cart_services.dart";
import "package:athleticarsenal/features/product_details/services/product_detail_services.dart";
import "package:athleticarsenal/models/product.dart";
import "package:athleticarsenal/providers/user_provider.dart";
import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import "package:provider/provider.dart";

class ProductDetails extends StatefulWidget {
  static const String routeName = "/productdetail";
  final Product product;
  ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final productDetailServices = ProductDetailServices();
  final cartServices = CartServices();
  final _reviewFormKey = GlobalKey<FormState>(); //key for form
  final TextEditingController _reviewController = TextEditingController();
  double myRating = 3;
  double avgRating = 0;

  void addReview(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    productDetailServices.reviewProduct(
      context: context,
      userName: user.firstname + " " + user.lastname,
      product: widget.product,
      rating: myRating,
      review: _reviewController.text,
    );
  }

  @override
  void initState() {
    super.initState();
    //calculating average rating
    double totalRating = 0;
    for (int i = 0; i < widget.product.reviews!.length; i++) {
      totalRating += widget.product.reviews![i].rating;
      //updating my rating
      if (widget.product.reviews![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.reviews![i].rating;
      }
    }

    if (totalRating != 0)
      avgRating = totalRating / widget.product.reviews!.length;
  }

  @override
  void dispose() {
    super.dispose();
    _reviewController.dispose();
  }

  void addToCart() {
    cartServices.addToCart(context: context, product: widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(GlobalVariables.appBarHeight),
        child: CustomSearchAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.id!,
                  ),
                  Stars(
                    rating: avgRating,
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              child: Text(
                widget.product.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CarouselSlider(
              items: widget.product.images.map(
                (i) {
                  return Builder(
                    builder: (BuildContext context) => Image.network(
                      i,
                      fit: BoxFit.contain,
                      height: 200,
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: 300,
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                  text: "Deal Price: ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: "₹ ${widget.product.price}",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                widget.product.description,
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: CustomButton(
                title: "Buy Now",
                onPressed: () {},
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(10),
              child: CustomButton(
                title: "Add to Cart",
                onPressed: addToCart,
                color: Color.fromRGBO(254, 216, 19, 1),
              ),
            ),
            SizedBox(height: 10),
            Container(
              color: Colors.black12,
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Rate the Product",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            RatingBar.builder(
              initialRating: myRating, //from variable
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: GlobalVariables.secondaryColor,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  myRating = rating;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text(
                "Review",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            //Form Working
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _reviewFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _reviewController,
                      hintText: "Review",
                      maxLines: 7,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: CustomButton(
                        title: "Review",
                        onPressed: () {
                          if (_reviewFormKey.currentState!.validate()) {
                            addReview(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.black12,
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text(
                "See Reviews",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: widget.product.reviews!.length >= 1 ? 200 : 0,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.product.reviews!.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product.reviews![index].userName,
                            style: TextStyle(
                              color: GlobalVariables.primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Stars(rating: widget.product.reviews![index].rating),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        widget.product.reviews![index].review,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
