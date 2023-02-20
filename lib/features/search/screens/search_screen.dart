import 'package:athleticarsenal/common/widgets/custom_search_appbar.dart';
import 'package:athleticarsenal/constants/global_Variables.dart';
import 'package:athleticarsenal/constants/loader.dart';
import 'package:athleticarsenal/features/home/widgets/address.dart';
import 'package:athleticarsenal/features/product_details/screens/product_details.dart';
import 'package:athleticarsenal/features/search/services/search_services.dart';
import 'package:athleticarsenal/features/search/widget/searched_product.dart';
import 'package:athleticarsenal/models/product.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/searchscreen";
  final String searchQuery;
  SearchScreen({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchService = SearchServices();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    fetchSearchedProduct();
  }

  void fetchSearchedProduct() async {
    products = await searchService.fetchSearchedProduct(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(GlobalVariables.appBarHeight),
        child: CustomSearchAppBar(),
      ),
      body: products == null
          ? LoadingScreen()
          : Column(
              children: [
                AddressBox(),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ProductDetails.routeName,
                            arguments: products![index],
                          );
                        },
                        child: SearchedProduct(
                          product: products![index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
