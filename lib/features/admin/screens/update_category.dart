import 'package:athleticarsenal/common/widgets/custom_appbar.dart';
import 'package:athleticarsenal/common/widgets/custom_button.dart';
import 'package:athleticarsenal/common/widgets/custom_textfield.dart';
import 'package:athleticarsenal/constants/global_Variables.dart';
import 'package:athleticarsenal/features/admin/services/admin_services.dart';
import 'package:athleticarsenal/models/product_category.dart';
import 'package:flutter/material.dart';

class UpdateCategory extends StatefulWidget {
  static const String routeName = '/updatecategory';
  final ProductCategory category;
  UpdateCategory({Key? key, required this.category}) : super(key: key);

  @override
  State<UpdateCategory> createState() => _UpdateCategoryState();
}

class _UpdateCategoryState extends State<UpdateCategory> {
  final AdminServices adminServices = AdminServices();
  final _updateCategoryKey = GlobalKey<FormState>();
  final TextEditingController _CategoryController = TextEditingController();

  void updateCategory() {
    if (_updateCategoryKey.currentState!.validate()) {
      adminServices.updateProductCategory(
        context: context,
        categoryId: widget.category.id,
        category: _CategoryController.text,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _CategoryController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _CategoryController.text = widget.category.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(GlobalVariables.appBarHeight),
        child: CustomAppBar(
          appbarLeftTitle: "Update Category",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 20),
        child: Form(
          key: _updateCategoryKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _CategoryController,
                hintText: "Product Category",
              ),
              SizedBox(height: 10),
              CustomButton(
                title: "Update Category",
                onPressed: updateCategory,
              )
            ],
          ),
        ),
      ),
    );
  }
}
