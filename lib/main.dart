import 'package:flutter/material.dart';
import 'package:movie_app/screens/forget_password.dart';
import 'package:movie_app/screens/login_screen.dart';
import 'package:movie_app/screens/profile_update_screen.dart';
import 'package:movie_app/screens/register_screen.dart';
import 'package:movie_app/utils/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.loginRouteName ,
      routes: {
        AppRoutes.loginRouteName: (context) => LoginScreen(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
        AppRoutes.forgetScreenRouteName: (context) => ForgetPassword(),
        AppRoutes.updateProfileRouteName: (context) => ProfileUpdateScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: LoginScreen(),
    );
  }
}
