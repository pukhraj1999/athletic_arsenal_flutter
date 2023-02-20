import 'package:athleticarsenal/common/widgets/custom_appbar.dart';
import 'package:athleticarsenal/common/widgets/custom_button.dart';
import 'package:athleticarsenal/common/widgets/custom_textfield.dart';
import 'package:athleticarsenal/constants/global_Variables.dart';
import 'package:athleticarsenal/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  static const String routeName = '/addcategory';

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final AdminServices adminServices = AdminServices();
  final _addCategoryKey = GlobalKey<FormState>();
  final TextEditingController _CategoryController = TextEditingController();

  void addCategory() {
    if (_addCategoryKey.currentState!.validate()) {
      adminServices.addProductCategory(
          context: context, category: _CategoryController.text);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _CategoryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(GlobalVariables.appBarHeight),
        child: CustomAppBar(
          appbarLeftTitle: "Add Category",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 20),
        child: Form(
          key: _addCategoryKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _CategoryController,
                hintText: "Product Category",
              ),
              SizedBox(height: 10),
              CustomButton(
                title: "Add Category",
                onPressed: addCategory,
              )
            ],
          ),
        ),
      ),
    );
  }
}
