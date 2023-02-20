import 'package:athleticarsenal/constants/global_Variables.dart';
import 'package:athleticarsenal/constants/loader.dart';
import 'package:athleticarsenal/features/admin/services/admin_services.dart';
import 'package:athleticarsenal/features/home/screens/category_deal_screen.dart';
import 'package:athleticarsenal/models/product_category.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final AdminServices adminServices = AdminServices();
  List<ProductCategory>? categories;

  void fetchCategories() async {
    categories = await adminServices.getProductCategories(context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    void navigateToCategory(BuildContext context, String category) {
      Navigator.pushNamed(context, CategoryDealScreen.routeName,
          arguments: category);
    }

    return (categories == null)
        ? LoadingScreen()
        : Container(
            height: 30,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories!.length,
              itemExtent: 100,
              itemBuilder: (context, index) {
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => navigateToCategory(
                          context,
                          categories![index].category,
                        ),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: GlobalVariables.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            categories![index].category,
                            style: TextStyle(
                              color: GlobalVariables.backgroundColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
