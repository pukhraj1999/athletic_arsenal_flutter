import 'dart:io';

import 'package:athleticarsenal/common/widgets/custom_appbar.dart';
import 'package:athleticarsenal/common/widgets/custom_button.dart';
import 'package:athleticarsenal/common/widgets/custom_textfield.dart';
import 'package:athleticarsenal/constants/global_Variables.dart';
import 'package:athleticarsenal/constants/loader.dart';
import 'package:athleticarsenal/constants/utils.dart';
import 'package:athleticarsenal/features/admin/services/admin_services.dart';
import 'package:athleticarsenal/models/product.dart';
import 'package:athleticarsenal/models/product_category.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class UpdateProduct extends StatefulWidget {
  static const String routeName = '/updateproduct';
  final Product product;

  UpdateProduct({Key? key, required this.product}) : super(key: key);

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final TextEditingController _NameController = TextEditingController();
  final TextEditingController _DescriptionController = TextEditingController();
  final TextEditingController _PriceController = TextEditingController();
  final TextEditingController _QuantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();

  String category = "H";
  List<ProductCategory>? categories;
  List<File> images = [];
  final _updateProductKey = GlobalKey<FormState>();

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void fetchCategories() async {
    categories = await adminServices.getProductCategories(context);
    setState(() {
      //updating category
      category = categories!.length >= 1 ? widget.product.category : "None";
    });
  }

  void updateProduct() {
    if (_updateProductKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.updateProducts(
        context: context,
        productId: widget.product.id, //product fetching
        name: _NameController.text,
        description: _DescriptionController.text,
        category: category,
        price: double.parse(_PriceController.text),
        quantity: double.parse(_QuantityController.text),
        images: images,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
    _NameController.text = widget.product.name;
    _DescriptionController.text = widget.product.description;
    _PriceController.text = widget.product.price.toString();
    _QuantityController.text = widget.product.quantity.toString();
  }

  @override
  void dispose() {
    super.dispose();
    _NameController.dispose();
    _DescriptionController.dispose();
    _PriceController.dispose();
    _QuantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (categories == null || categories!.length < 1)
        ? LoadingScreen()
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(GlobalVariables.appBarHeight),
              child: CustomAppBar(
                appbarLeftTitle: "Update Products",
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _updateProductKey,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      images.isNotEmpty
                          ? CarouselSlider(
                              items: images.map(
                                (url) {
                                  return Builder(
                                    builder: (BuildContext context) =>
                                        Image.file(
                                      url,
                                      fit: BoxFit.cover,
                                      height: 200,
                                    ),
                                  );
                                },
                              ).toList(), //mapped url to image network and converted into list
                              options: CarouselOptions(
                                viewportFraction: 1,
                                height: 200,
                              ),
                            )
                          : GestureDetector(
                              onTap: selectImages,
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                radius: Radius.circular(10),
                                dashPattern: [10, 4],
                                strokeCap: StrokeCap.round,
                                child: Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.folder_open,
                                        size: 35,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Select Product Images',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(height: 30),
                      CustomTextField(
                        controller: _NameController,
                        hintText: "Product Name",
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        controller: _DescriptionController,
                        hintText: "Description",
                        maxLines: 7,
                      ),
                      SizedBox(height: 10),
                      //drop down
                      SizedBox(
                        width: double.infinity,
                        child: DropdownButton(
                          value: category,
                          icon: Icon(Icons.keyboard_arrow_down),
                          items: categories!.map((item) {
                            return DropdownMenuItem(
                              value: item.category,
                              child: Text(item.category),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              category = value!;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        controller: _PriceController,
                        hintText: "Price",
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        controller: _QuantityController,
                        hintText: "Quantity",
                      ),
                      SizedBox(height: 10),
                      CustomButton(
                        title: "Sell",
                        onPressed: updateProduct,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
