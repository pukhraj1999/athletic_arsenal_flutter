import 'package:athleticarsenal/constants/global_Variables.dart';
import 'package:athleticarsenal/constants/loader.dart';
import 'package:athleticarsenal/features/admin/screens/add_products.dart';
import 'package:athleticarsenal/features/admin/screens/update_product.dart';
import 'package:athleticarsenal/features/admin/services/admin_services.dart';
import 'package:athleticarsenal/models/product.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final AdminServices adminServices = AdminServices();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    products = await adminServices.getProducts(context);
    setState(() {});
  }

  void deleteTheProduct(String? product_id) async {
    adminServices.deleteProduct(context, product_id);
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProduct.routeName);
  }

  void navigateToUddateProduct(Product product) {
    Navigator.pushNamed(context, UpdateProduct.routeName, arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? LoadingScreen()
        : Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 15).copyWith(bottom: 60),
              child: GridView.builder(
                itemCount: products!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final productData = products![index];
                  return GestureDetector(
                    onTap: () => navigateToUddateProduct(productData),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 150,
                          child: Image.network(
                            productData.images[0],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Text(
                                  productData.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              IconButton(
                                  icon: Icon(Icons.delete_outline),
                                  onPressed: () {
                                    deleteTheProduct(productData.id);
                                  })
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: 'Add a Product', //shows on long press
              onPressed: navigateToAddProduct,
              child: Icon(Icons.add),
              foregroundColor: GlobalVariables.backgroundColor,
              backgroundColor: GlobalVariables.primaryColor,
              splashColor: GlobalVariables.splashColor,
            ),
          );
  }
}
