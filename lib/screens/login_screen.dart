import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_app/custom_widgets/custom_elevated_button.dart';
import 'package:movie_app/custom_widgets/custom_text_form_field.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_routes.dart';
import 'package:movie_app/utils/app_styles.dart';
import 'package:movie_app/api/api_login_screen/api_manager.dart';
import '../../../app-prefrences/token-storage.dart';
import '../../../utils/dialog-utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController =
  TextEditingController(text: "zewaidi@gmail.com");

  TextEditingController passwordController =
  TextEditingController(text: "Zewaidi123@");

  bool obscure = true;

  final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    // var languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: height * 0.1),
                  Image.asset(AppAssets.movieLogoApp, height: height * 0.2),
                  SizedBox(height: height * 0.04),
                  CustomTextFormField(
                    controller: emailController,
                    colorBorderSide: AppColors.whiteColor,
                    prefixIcon: Image.asset(AppAssets.emailIcon),
                    hintText: 'Email',
                    hintStyle: AppStyles.regular16White,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Enter Email";
                      }
                      final emailValid = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$")
                          .hasMatch(text);
                      if (!emailValid) {
                        return "Enter valid Email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height * 0.02),
                  CustomTextFormField(
                    controller: passwordController,
                    colorBorderSide: AppColors.whiteColor,
                    prefixIcon: Image.asset(AppAssets.passwordIcon),
                    hintText: 'Password',
                    obsecureText: obscure,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                      icon: Icon(
                        obscure ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Enter Password";
                      }
                      if (text.length < 8) {
                        return "Password must be at least 8 characters";
                      }
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRoutes.forgetScreenRouteName);
                      },
                      child: Text(
                        "Forget Password?",
                        style: AppStyles.regular14Yellow,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  CustomElevatedButton(
                    onPressed: () => login(),
                    text: 'Login',
                    textStyle: AppStyles.regular20Black,
                    backgroundColor: AppColors.yellowColor,
                  ),
                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't Have Account?",
                          style: AppStyles.regular14White),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoutes.registerRouteName);
                        },
                        child: Text("Create one",
                            style: AppStyles.regular14Yellow),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          indent: width * 0.1,
                          thickness: 1,
                          color: AppColors.yellowColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          'OR',
                          style: AppStyles.regular16Yellow.copyWith(
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          endIndent: width * 0.1,
                          thickness: 1,
                          color: AppColors.yellowColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  CustomElevatedButton(
                    onPressed: () => loginWithGoogle(context),
                    text: 'Login With Google',
                    textStyle: AppStyles.regular16Black,
                    icon: true,
                    iconWidget: Container(
                      padding: EdgeInsets.only(left: width * 0.23),
                      child: Image.asset(AppAssets.googleIcon),
                    ),
                    backgroundColor: AppColors.yellowColor,
                  ),

                  SizedBox(height: height * 0.03),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(AppAssets.languageSwitchImage),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == true) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      try {
        // show loading
        DialogUtils.showLopading(
            textLoading: "Logging in...", context: context);

        final response = await ApiManager.login(email, password);

        // hide loading
        DialogUtils.hideLoading(context: context);

        if (response.message == "Success Login") {
          if (response.token != null) {
            await TokenStorage.saveToken(response.token!);
          }

          // show success msg
          DialogUtils.showMsg(
            context: context,
            title: "Success",
            msg: "Login Successful",
            posActionName: "OK",
            // posAction: () {
            //   Navigator.pushNamedAndRemoveUntil(
            //     context,
            //     AppRoutes.homeScreendRouteName,
            //         (route) => true,
            //   );
            // },
          );
        } else {
          //server error
          //show msg
          DialogUtils.showMsg(
            context: context,
            title: "Login Failed",
            msg: response.message,
            posActionName: "Ok",
          );
        }
      }
      //client error
      on SocketException {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMsg(
          context: context,
          title: "No Internet",
          msg: "Please check your internet connection and try again.",
          posActionName: "Retry",
        );
      } catch (e) {
        //hide loading
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMsg(
          context: context,
          title: "Login Failed",
          msg: e.toString().replaceFirst("Exception:", "").trim(),
          posActionName: "Ok",
        );
      }
    }
  }

  Future loginWithGoogle(BuildContext context) async {
    try {
      final account = await googleSignIn.signIn();
      if (account != null) {
        DialogUtils.showMsg(
          context: context,
          title: "Success",
          msg: "Welcome, ${account.displayName}",
          posActionName: "OK",
          //Navigate to home
          // posAction: () {
          //   Navigator.pushNamedAndRemoveUntil(
          //     context,
          //     AppRoutes.homeScreendRouteName,
          //         (route) => true,
          //   );
          // },
        );
        debugPrint("User Email: ${account.email}");
        debugPrint("User Name: ${account.displayName}");
        debugPrint("User ID: ${account.id}");
      } else {
        DialogUtils.showMsg(
          context: context,
          title: "Cancelled",
          msg: "Login with Google was Cancelled",
          posActionName: "OK",
        );
      }
    } catch (e) {
      DialogUtils.showMsg(
        context: context,
        title: "Error",
        msg: "Login Google failed: $e",
        posActionName: "OK",
      );
    }
  }

}



// import 'package:flutter/material.dart';
// import 'package:movie_app/custom_widgets/custom_elevated_button.dart';
// import 'package:movie_app/custom_widgets/custom_text_form_field.dart';
// import 'package:movie_app/utils/app_assets.dart';
// import 'package:movie_app/utils/app_colors.dart';
// import 'package:movie_app/utils/app_routes.dart';
// import 'package:movie_app/utils/app_styles.dart';
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: AppColors.blackColor,
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: width * 0.04),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(
//               height: height * 0.1,
//             ),
//             Container(
//               height: height * 0.2,
//               width: width * 0.02,
//               child: Image.asset(
//                 AppAssets.movieLogoApp,
//               ),
//             ),
//             SizedBox(
//               height: height * 0.04,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   color: AppColors.darkGreyColor,
//                   borderRadius: BorderRadius.circular(15)),
//               child: CustomTextFormField(
//                 prefixIcon: Image.asset(AppAssets.emailIcon),
//                 hintText: 'Email',
//                 hintStyle: AppStyles.regular16White,
//                 colorBorderSide: AppColors.transparentColor,
//               ),
//             ),
//             SizedBox(
//               height: height * 0.02,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   color: AppColors.darkGreyColor,
//                   borderRadius: BorderRadius.circular(15)),
//               child: CustomTextFormField(
//                 prefixIcon: Image.asset(AppAssets.passwordIcon),
//                 hintText: 'Password',
//                 suffixIcon: Image.asset(AppAssets.eyeHiddenIcon),
//                 hintStyle: AppStyles.regular16White,
//                 colorBorderSide: AppColors.transparentColor,
//               ),
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                   onPressed: () {
//                     // todo : navigate to forget password screen.
//                     Navigator.of(context)
//                         .pushNamed(AppRoutes.forgetScreenRouteName);
//                   },
//                   child: Text(
//                     'Forrget Password ?',
//                     textAlign: TextAlign.end,
//                     style: AppStyles.regular14Yellow
//                         .copyWith(fontFamily: 'Roboto'),
//                   )),
//             ),
//             SizedBox(
//               height: height * 0.02,
//             ),
//             CustomElevatedButton(
//               onPressed: () {
//                 Navigator.of(context)
//                     .pushNamed(AppRoutes.updateProfileRouteName);
//               },
//               text: 'Login',
//               textStyle:
//                   AppStyles.regular20Black.copyWith(fontFamily: 'Roboto'),
//               backgroundColor: AppColors.yellowColor,
//             ),
//             SizedBox(
//               height: height * 0.02,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Dont Have Account ?',
//                   style:
//                       AppStyles.regular14White.copyWith(fontFamily: 'Roboto'),
//                 ),
//                 TextButton(
//                     onPressed: () {
//                       // todo : navigate to register screen
//                       Navigator.of(context)
//                           .pushNamed(AppRoutes.registerRouteName);
//                     },
//                     child: Text(
//                       'Create one',
//                       style: AppStyles.regular14Yellow
//                           .copyWith(fontFamily: 'Roboto'),
//                     )),
//                 SizedBox(
//                   height: height * 0.02,
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: Divider(
//                     indent: width * 0.1,
//                     thickness: 1,
//                     color: AppColors.yellowColor,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                   child: Text(
//                     'OR',
//                     style: AppStyles.regular16Yellow
//                         .copyWith(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Expanded(
//                   child: Divider(
//                     endIndent: width * 0.1,
//                     thickness: 1,
//                     color: AppColors.yellowColor,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: height * 0.02,
//             ),
//             CustomElevatedButton(
//               onPressed: () {},
//               text: 'Login With Googel',
//               textStyle:
//                   AppStyles.regular16Black.copyWith(fontFamily: 'Roboto'),
//               icon: true,
//               iconWidget: Container(
//                   padding: EdgeInsets.only(left: width * 0.23),
//                   child: Image.asset(AppAssets.googleIcon)),
//               backgroundColor: AppColors.yellowColor,
//             ),
//             SizedBox(
//               height: height * 0.03,
//             ),
//             Align(
//                 alignment: Alignment.topCenter,
//                 child: Image.asset(AppAssets.languageSwitchImage))
//           ],
//         ),
//       ),
//     );
//   }
// }
