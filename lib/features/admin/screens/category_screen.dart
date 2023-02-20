import 'package:athleticarsenal/constants/global_Variables.dart';
import 'package:athleticarsenal/constants/loader.dart';
import 'package:athleticarsenal/features/admin/screens/add_category.dart';
import 'package:athleticarsenal/features/admin/screens/update_category.dart';
import 'package:athleticarsenal/features/admin/services/admin_services.dart';
import 'package:athleticarsenal/models/product_category.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
    void navigateToCategory() {
      Navigator.pushNamed(context, AddCategory.routeName);
    }

    void deleteCategory(String? id) async {
      adminServices.deleteCategory(context, id);
    }

    void navigateToUddateCategory(ProductCategory category) {
      Navigator.pushNamed(
        context,
        UpdateCategory.routeName,
        arguments: category,
      );
    }

    return (categories == null)
        ? LoadingScreen()
        : Scaffold(
            body: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: categories!.length,
              itemBuilder: (context, index) {
                final categoryData = categories![index];
                return GestureDetector(
                  onTap: () => navigateToUddateCategory(categoryData),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              categoryData.category,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete_outline,
                                size: 25,
                              ),
                              onPressed: () {
                                deleteCategory(categoryData.id);
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: (index == categories!.length - 1)
                            ? SizedBox(
                                height: 0,
                              )
                            : Container(
                                height: 2,
                                color: Colors.grey,
                              ),
                      )
                    ],
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: 'Add a Category', //shows on long press
              onPressed: navigateToCategory,
              child: Icon(Icons.add),
              foregroundColor: GlobalVariables.backgroundColor,
              backgroundColor: GlobalVariables.primaryColor,
              splashColor: GlobalVariables.splashColor,
            ),
          );
  }
}
