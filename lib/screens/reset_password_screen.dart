import 'package:flutter/material.dart';
import 'package:movie_app/custom_widgets/custom_elevated_button.dart';
import 'package:movie_app/custom_widgets/custom_text_form_field.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.yellowColor),
        centerTitle: true,
        backgroundColor: AppColors.transparentColor,
        title: Text(
          'Reset Password',
          style: AppStyles.regular16Yellow,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                AppAssets.gamer1,
                alignment: Alignment.center,
              ),
            ),
            SizedBox(height: height * 0.04),

            // old password
            Container(
              decoration: BoxDecoration(
                  color: AppColors.darkGreyColor,
                  borderRadius: BorderRadius.circular(16)),
              child: CustomTextFormField(
                prefixIcon: Icon(Icons.lock, color: AppColors.yellowColor),
                hintText: 'Old password',
                hintStyle: AppStyles.regular20White,
                colorBorderSide: AppColors.darkGreyColor,
                obsecureText: true,
              ),
            ),
            SizedBox(height: height * 0.02),
            // new password
            Container(
              decoration: BoxDecoration(
                  color: AppColors.darkGreyColor,
                  borderRadius: BorderRadius.circular(16)),
              child: CustomTextFormField(
                prefixIcon:
                    Icon(Icons.lock_reset, color: AppColors.yellowColor),
                hintText: 'New Password',
                hintStyle: AppStyles.regular20White,
                colorBorderSide: AppColors.darkGreyColor,
                obsecureText: true,
              ),
            ),
            SizedBox(height: height * 0.02),

            // confirm new password
            Container(
              decoration: BoxDecoration(
                  color: AppColors.darkGreyColor,
                  borderRadius: BorderRadius.circular(16)),
              child: CustomTextFormField(
                prefixIcon:
                    Icon(Icons.check_circle, color: AppColors.yellowColor),
                hintText: 'Confirm new password',
                hintStyle: AppStyles.regular20White,
                colorBorderSide: AppColors.darkGreyColor,
                obsecureText: true,
              ),
            ),
            Spacer(),
            CustomElevatedButton(
              onPressed: () {
                // todo : implement reset logic
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Password reset successfully!")),
                );
              },
              backgroundColor: AppColors.yellowColor,
              text: 'Confirm Reset',
              textStyle: AppStyles.regular20Black,
            ),
          ],
        ),
      ),
    );
  }
}
