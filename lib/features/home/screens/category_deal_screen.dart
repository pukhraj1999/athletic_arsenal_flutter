import 'package:athleticarsenal/common/widgets/custom_appbar.dart';
import 'package:athleticarsenal/constants/global_Variables.dart';
import 'package:athleticarsenal/constants/loader.dart';
import 'package:athleticarsenal/features/home/services/home_services.dart';
import 'package:athleticarsenal/features/product_details/screens/product_details.dart';
import 'package:athleticarsenal/models/product.dart';
import 'package:flutter/material.dart';

class CategoryDealScreen extends StatefulWidget {
  static const routeName = "/categorydeal";
  final String category; //from before screen
  CategoryDealScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryDealScreen> createState() => _CategoryDealScreenState();
}

class _CategoryDealScreenState extends State<CategoryDealScreen> {
  final homeService = HomeServices();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  void fetchCategoryProducts() async {
    products = await homeService.fetchCategoryProduct(
        context: context, category: widget.category);
    setState(() {}); //entire widget tree build
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(GlobalVariables.appBarHeight),
        child: CustomAppBar(
          appbarRightTitle: widget.category,
        ),
      ),
      body: products == null
          ? LoadingScreen()
          : Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    "Keep shopping for ${widget.category}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 127,
                  child: GridView.builder(
                    padding: EdgeInsets.only(left: 15),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // childAspectRatio: 1.4,
                      // mainAxisSpacing: 10,
                    ),
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      final product = products![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ProductDetails.routeName,
                            arguments: product,
                          );
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 170,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 0.5,
                                  ),
                                ),
                                child: Container(
                                  child: Image.network(product.images[0]),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5)
                                  .copyWith(left: 15),
                              child: Text(
                                products![index].name,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }
}
