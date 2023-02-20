import "package:athleticarsenal/common/widgets/stars.dart";
import "package:athleticarsenal/models/product.dart";
import "package:flutter/material.dart";

class SearchedProduct extends StatefulWidget {
  final Product product;
  SearchedProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<SearchedProduct> createState() => _SearchedProductState();
}

class _SearchedProductState extends State<SearchedProduct> {
  double avgRating = 0;

  @override
  void initState() {
    super.initState();
    //calculating average rating
    double totalRating = 0;
    for (int i = 0; i < widget.product.reviews!.length; i++) {
      totalRating += widget.product.reviews![i].rating;
    }

    if (totalRating != 0)
      avgRating = totalRating / widget.product.reviews!.length;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                widget.product.images[0],
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
                      widget.product.name,
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
                      top: 5,
                    ),
                    child: Stars(
                      rating: avgRating,
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
                      "₹ ${widget.product.price}",
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
                      widget.product.quantity == 0
                          ? 'Out Of Stock'
                          : "In Stock",
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
      ],
    );
  }
}
