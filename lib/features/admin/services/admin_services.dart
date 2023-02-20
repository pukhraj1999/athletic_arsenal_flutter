import 'dart:convert';
import 'dart:io';
import 'package:athleticarsenal/constants/error_handling.dart';
import 'package:athleticarsenal/constants/global_Variables.dart';
import 'package:athleticarsenal/constants/utils.dart';
import 'package:athleticarsenal/models/product.dart';
import 'package:athleticarsenal/models/product_category.dart';
import 'package:athleticarsenal/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  Future<List<Product>> getProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/admin/getproducts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authToken': userProvider.user.token,
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (err) {
      ShowSnackBar(context, err.toString());
    }
    return productList;
  }

  Future<List<ProductCategory>> getProductCategories(
      BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductCategory> categoryList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/admin/getcategories'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authToken': userProvider.user.token,
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            categoryList.add(
              ProductCategory.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (err) {
      ShowSnackBar(context, err.toString());
    }
    return categoryList;
  }

  void sellProducts(
      {required BuildContext context,
      required String name,
      required String description,
      required String category,
      required double price,
      required double quantity,
      required List<File> images}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dgcjdoedp', 'j10d8ynr');
      List<String> imgUrls = [];

      //maping and sending to cloudinary
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imgUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        images: imgUrls,
        category: category,
        price: price,
        quantity: quantity,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/admin/addproduct'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authToken': userProvider.user.token,
        },
        body: product.toJson(),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          ShowSnackBar(context, "Product added Successfully!!");
          Navigator.pop(context); //moving back
        },
      );
    } catch (err) {
      ShowSnackBar(context, err.toString());
    }
  }

  void updateProducts(
      {required BuildContext context,
      required String? productId,
      required String name,
      required String description,
      required String category,
      required double price,
      required double quantity,
      required List<File> images}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dgcjdoedp', 'j10d8ynr');
      List<String> imgUrls = [];

      //maping and sending to cloudinary
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imgUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        images: imgUrls,
        category: category,
        price: price,
        quantity: quantity,
      );

      http.Response res = await http.put(
        Uri.parse('$uri/api/admin/updateproduct/${productId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authToken': userProvider.user.token,
        },
        body: product.toJson(),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          ShowSnackBar(context, "Product updated Successfully!!");
          Navigator.pop(context); //moving back
        },
      );
    } catch (err) {
      ShowSnackBar(context, err.toString());
    }
  }

  void addProductCategory({
    required BuildContext context,
    required final category,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      ProductCategory productCategory = ProductCategory(
        category: category,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/admin/addcategory'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authToken': userProvider.user.token,
        },
        body: productCategory.toJson(),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          ShowSnackBar(context, "Category added Successfully!!");
          Navigator.pop(context); //moving back
        },
      );
    } catch (err) {
      ShowSnackBar(context, err.toString());
    }
  }

  void updateProductCategory({
    required BuildContext context,
    required final categoryId,
    required final category,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      ProductCategory productCategory = ProductCategory(
        category: category,
      );

      http.Response res = await http.put(
        Uri.parse('$uri/api/admin/updatecategory/${categoryId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authToken': userProvider.user.token,
        },
        body: productCategory.toJson(),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          ShowSnackBar(context, "Category updated Successfully!!");
          Navigator.pop(context); //moving back
        },
      );
    } catch (err) {
      ShowSnackBar(context, err.toString());
    }
  }

  void deleteProduct(BuildContext context, String? product_id) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product(
      id: product_id,
      name: "",
      description: "",
      images: [],
      category: "",
      price: 0,
      quantity: 0,
    );
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/admin/deleteproduct'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authToken': userProvider.user.token,
        },
        body: product.toJson(),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          ShowSnackBar(context, "Product deleted Successfully!!");
        },
      );
    } catch (err) {
      ShowSnackBar(context, err.toString());
    }
  }

  void deleteCategory(BuildContext context, String? category_id) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    ProductCategory category = ProductCategory(
      id: category_id,
      category: "",
    );
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/admin/deletecategory'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authToken': userProvider.user.token,
        },
        body: category.toJson(),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          ShowSnackBar(context, "Category deleted Successfully!!");
        },
      );
    } catch (err) {
      ShowSnackBar(context, err.toString());
    }
  }
}
