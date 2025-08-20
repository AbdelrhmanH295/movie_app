import 'package:flutter/material.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/utils/app_routes.dart';
import 'package:provider/provider.dart';
import '../../../../providers/app-language-provider.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
import '../../custom_widgets/custom_elevated_button.dart';
import '../../custom_widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .04),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image(
                  image: AssetImage(AppAssets.movieLogoApp),
                  height: height * .20,
                ),
                SizedBox(
                  height: height * .02,
                ),
                Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextFormField(
                          hintText: AppLocalizations.of(context)!.email,
                          prefixIcon:
                              Image(image: AssetImage(AppAssets.emailIcon)),
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return AppLocalizations.of(context)!.enter_email;
                            }
                            final bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(emailController.text);
                            if (!emailValid) {
                              return AppLocalizations.of(context)!.valid_email;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        CustomTextFormField(
                          hintText: AppLocalizations.of(context)!.password,
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return AppLocalizations.of(context)!
                                  .enter_password;
                            }
                            if (text.length < 6) {
                              return AppLocalizations.of(context)!
                                  .valid_password;
                            }
                            return null;
                          },
                          prefixIcon:
                              Image(image: AssetImage(AppAssets.passwordIcon)),
                          suffixIcon: IconButton(
                              onPressed: () {
                                obscure = !obscure;
                                setState(() {});
                              },
                              icon: Icon(
                                obscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.whiteColor,
                              )),
                          obscureText: obscure,
                          obscuringCharacter: "*",
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .forgetPasswordQuestion,
                                  style: AppStyles.regular16Yellow.copyWith(
                                    fontSize: 14,
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        CustomElevatedButton(
                            onPressed: () {
                              login();
                            },
                            text: AppLocalizations.of(context)!.login),
                        SizedBox(
                          height: height * .02,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppLocalizations.of(context)!.no_account,
                                  style: AppStyles.regular16White),
                              TextButton(
                                  onPressed: () {
                                    //todo : Navigate to Register Screen
                                    //Navigator.pushNamedAndRemoveUntil(context, AppRoutes.registerRouteName, (route) => true,);
                                  },
                                  child: Text(
                                      AppLocalizations.of(context)!.create_one,
                                      style: AppStyles.regular16Yellow))
                            ]),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Divider(
                              indent: width * .05,
                              endIndent: width * .04,
                              thickness: 2,
                              color: AppColors.yellowColor,
                            )),
                            Text(
                              AppLocalizations.of(context)!.or,
                              style: AppStyles.regular16Yellow,
                            ),
                            Expanded(
                                child: Divider(
                                    thickness: 2,
                                    indent: width * .04,
                                    endIndent: width * .06,
                                    color: AppColors.yellowColor))
                          ],
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        CustomElevatedButton(
                            onPressed: () {},
                            text: AppLocalizations.of(context)!.loginWithGoogle,
                            textStyle: AppStyles.regular16Black,
                            icon: true,
                            iconName: AppAssets.googleIcon),
                        SizedBox(
                          height: height * .04,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                    width: 1.5, color: AppColors.yellowColor)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    languageProvider.changeLanguage('en');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color:
                                            languageProvider.appLanguage == 'en'
                                                ? AppColors.yellowColor
                                                : Colors.transparent,
                                        width: 3,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: Image(
                                        image: AssetImage(AppAssets.usFlag),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * .03,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    languageProvider.changeLanguage('ar');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color:
                                            languageProvider.appLanguage == 'ar'
                                                ? AppColors.yellowColor
                                                : Colors.transparent,
                                        width: 3,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: Image(
                                        image: AssetImage(AppAssets.egyptFlag),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState?.validate() == true) {
      //todo: login
    }
  }
}
