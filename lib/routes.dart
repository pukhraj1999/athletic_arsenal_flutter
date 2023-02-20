import 'package:athleticarsenal/features/admin/screens/add_category.dart';
import 'package:athleticarsenal/features/admin/screens/add_products.dart';
import 'package:athleticarsenal/features/admin/screens/admin_screen.dart';
import 'package:athleticarsenal/features/admin/screens/update_category.dart';
import 'package:athleticarsenal/features/admin/screens/update_product.dart';
import 'package:athleticarsenal/features/home/screens/category_deal_screen.dart';
import 'package:athleticarsenal/features/product_details/screens/product_details.dart';
import 'package:athleticarsenal/features/search/screens/search_screen.dart';
import 'package:athleticarsenal/models/product.dart';
import 'package:athleticarsenal/models/product_category.dart';
import 'package:flutter/material.dart';
import 'package:athleticarsenal/constants/global_Variables.dart';
import 'package:athleticarsenal/features/auth/screens/auth_screen.dart';
import 'package:athleticarsenal/features/home/screens/home_screen.dart';
import 'package:athleticarsenal/common/widgets/bottom_bar.dart';

// Regestring routes
Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => HomeScreen(),
      );
    case CategoryDealScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealScreen(
          category: category,
        ),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BottomBar(),
      );
    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AdminScreen(),
      );
    case AddProduct.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddProduct(),
      );
    case UpdateProduct.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => UpdateProduct(product: product),
      );
    case AddCategory.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddCategory(),
      );
    case UpdateCategory.routeName:
      var category = routeSettings.arguments as ProductCategory;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => UpdateCategory(category: category),
      );
    case ProductDetails.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetails(
          product: product,
        ),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(searchQuery: searchQuery),
      );
    // default for unvalid route
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => Scaffold(
          body: Center(
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: GlobalVariables.primaryColor),
              child: Text(
                "Screen does not exist",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      );
  }
}
