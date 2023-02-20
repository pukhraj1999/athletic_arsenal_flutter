import 'package:athleticarsenal/features/admin/screens/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:athleticarsenal/features/auth/screens/auth_screen.dart';
import 'package:athleticarsenal/features/auth/services/auth_service.dart';
import 'package:athleticarsenal/providers/user_provider.dart';
import 'package:athleticarsenal/common/widgets/bottom_bar.dart';
import 'package:athleticarsenal/routes.dart';
import 'constants/global_Variables.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //for getting the user data
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    //storing user data by checking token
    authService.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    Widget showScreen() {
      var user = Provider.of<UserProvider>(context).user;
      if (user.token.isNotEmpty) {
        switch (user.type) {
          case 'admin':
            return AdminScreen();
          case 'user':
            return BottomBar();
        }
      }
      return AuthScreen();
    }

    return MaterialApp(
      title: "Athletic Arsenal",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      // Helps to generate dynamic routes
      onGenerateRoute: (routeSettings) => generateRoute(routeSettings),
      home: showScreen(),
    );
  }
}
