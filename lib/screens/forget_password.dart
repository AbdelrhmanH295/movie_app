import 'package:flutter/material.dart';
import 'package:movie_app/custom_widgets/custom_bottom_sheet.dart';
import 'package:movie_app/custom_widgets/custom_elevated_button.dart';
import 'package:movie_app/custom_widgets/custom_text_form_field.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.transparentColor,
        leading: Icon(
          Icons.arrow_back,
          color: AppColors.yellowColor,
        ),
        title: Text(
          'Forget Password',
          style: AppStyles.regular16Yellow,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.center,
                // color: AppColors.redColor,
                child: Image.asset(
                  AppAssets.forgotPasswordImage,
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(height: height * 0.04),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.darkGreyColor,
                    borderRadius: BorderRadius.circular(16)),
                child: CustomTextFormField(
                  prefixIcon: Image.asset(AppAssets.emailIcon),
                  hintText: 'Email',
                  hintStyle: AppStyles.regular20White,
                  colorBorderSide: AppColors.darkGreyColor,
                ),
              ),
              SizedBox(height: height * 0.02),
              CustomElevatedButton(
                onPressed: () {},
                backgroundColor: AppColors.yellowColor,
                text: 'Verify Email',
                textStyle: AppStyles.regular20Black,
              ),
              SizedBox(height: height * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
