import 'package:athleticarsenal/common/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:athleticarsenal/common/widgets/custom_button.dart';
import 'package:athleticarsenal/common/widgets/custom_textfield.dart';
import 'package:athleticarsenal/constants/global_Variables.dart';
import 'package:athleticarsenal/features/auth/services/auth_service.dart';

// _ means private variable

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth";

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //default value
  Auth _auth = Auth.signup; //for radio group
  final _signupFormKey = GlobalKey<FormState>(); //key for form
  final _signinFormKey = GlobalKey<FormState>(); //key for form
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  //backend connectivity
  final AuthService authService = AuthService();

// prevent from memory leaks
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
  }

  void signup() {
    //fetching text from formTextFields and sending to backend
    authService.signup(
        context: context,
        firstname: _firstNameController.text,
        lastname: _lastNameController.text,
        email: _emailController.text,
        password: _passwordController.text);
  }

  void signin() {
    //fetching text from formTextFields and sending to backend
    authService.signin(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(GlobalVariables.appBarHeight),
        child: CustomAppBar(),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                tileColor: _auth == Auth.signup
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundColor,
                title: Text(
                  "Create Account",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.primaryColor,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!; //can't be null
                    });
                  },
                ),
              ),
              if (_auth == Auth.signup)
                Container(
                  padding: EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signupFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _firstNameController,
                          hintText: "First Name",
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          controller: _lastNameController,
                          hintText: "Last Name",
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          controller: _emailController,
                          hintText: "Email",
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: "Password",
                          isPassword: true,
                        ),
                        SizedBox(height: 10),
                        CustomButton(
                          title: "Sign up",
                          onPressed: () {
                            if (_signupFormKey.currentState!.validate()) {
                              signup();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor: _auth == Auth.signin
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundColor,
                title: Text(
                  "Signin",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.primaryColor,
                  value: Auth.signin,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signin)
                Container(
                  padding: EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signinFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          hintText: "Email",
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: "Password",
                          isPassword: true,
                        ),
                        SizedBox(height: 10),
                        CustomButton(
                          title: "Sign in",
                          onPressed: () {
                            if (_signinFormKey.currentState!.validate()) {
                              signin();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
