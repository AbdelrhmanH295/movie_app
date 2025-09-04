import 'package:flutter/material.dart';
import 'package:movie_app/custom_widgets/custom_elevated_button.dart';
import 'package:movie_app/custom_widgets/custom_text_form_field.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_routes.dart';
import 'package:movie_app/utils/app_styles.dart';
import 'package:movie_app/api/api_login_screen/api_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final response = await ApiManager.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ ${response.message}")),
      );

      // Navigate to Home or any screen if token exists
      if (response.token != null) {
        // Navigator.of(context).pushReplacementNamed(AppRoutes.homeRouteName);
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: height * 0.1),
                Container(
                  height: height * 0.2,
                  width: width * 0.02,
                  child: Image.asset(AppAssets.movieLogoApp),
                ),
                SizedBox(height: height * 0.04),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.darkGreyColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: CustomTextFormField(
                    controller: emailController,
                    prefixIcon: Image.asset(AppAssets.emailIcon),
                    hintText: 'Email',
                    hintStyle: AppStyles.regular16White,
                    colorBorderSide: AppColors.transparentColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: height * 0.02),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.darkGreyColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: CustomTextFormField(
                    controller: passwordController,
                    prefixIcon: Image.asset(AppAssets.passwordIcon),
                    hintText: 'Password',
                    suffixIcon: Image.asset(AppAssets.eyeHiddenIcon),
                    hintStyle: AppStyles.regular16White,
                    colorBorderSide: AppColors.transparentColor,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.forgetScreenRouteName);
                    },
                    child: Text(
                      'Forget Password ?',
                      textAlign: TextAlign.end,
                      style: AppStyles.regular14Yellow
                          .copyWith(fontFamily: 'Roboto'),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.updateProfileRouteName);
                        },
                        text: 'Login',
                        textStyle: AppStyles.regular20Black
                            .copyWith(fontFamily: 'Roboto'),
                        backgroundColor: AppColors.yellowColor,
                      ),
                SizedBox(height: height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t Have Account ?',
                      style: AppStyles.regular14White
                          .copyWith(fontFamily: 'Roboto'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.registerRouteName);
                      },
                      child: Text(
                        'Create one',
                        style: AppStyles.regular14Yellow
                            .copyWith(fontFamily: 'Roboto'),
                      ),
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
                        style: AppStyles.regular16Yellow
                            .copyWith(fontWeight: FontWeight.bold),
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
                  onPressed: () {},
                  text: 'Login With Google',
                  textStyle:
                      AppStyles.regular16Black.copyWith(fontFamily: 'Roboto'),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
