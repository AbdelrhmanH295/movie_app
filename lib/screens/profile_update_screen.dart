import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';
import 'package:movie_app/custom_widgets/custom_bottom_sheet.dart';
import 'package:movie_app/custom_widgets/custom_elevated_button.dart';
import 'package:movie_app/custom_widgets/custom_text_form_field.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({super.key});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  String selectedAvatar = AppAssets.gamer1; // الافتراضي

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.yellowColor),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text('Pick Avatar', style: AppStyles.regular16Yellow),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // الصورة فوق — بدون أي إطار أصفر
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  selectedAvatar,
                  height: 110,
                  width: 110,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: height * 0.04),

            // الاسم
            Container(
              decoration: BoxDecoration(
                color: AppColors.darkGreyColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: CustomTextFormField(
                prefixIcon: Image.asset(AppAssets.usernameIconUpdateProfile),
                hintText: 'John Safwat',
                hintStyle: AppStyles.regular20White,
                colorBorderSide: AppColors.darkGreyColor,
              ),
            ),
            SizedBox(height: height * 0.02),

            // التليفون
            Container(
              decoration: BoxDecoration(
                color: AppColors.darkGreyColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: CustomTextFormField(
                prefixIcon: Image.asset(AppAssets.phoneIcon),
                hintText: '01200000000000',
                hintStyle: AppStyles.regular20White,
                colorBorderSide: AppColors.darkGreyColor,
              ),
            ),
            SizedBox(height: height * 0.03),

            InkWell(
              onTap: () {
                // TODO: go to reset password screen
              },
              child: Text('Reset Password', style: AppStyles.regular20White),
            ),
            const Spacer(),

            CustomElevatedButton(
              onPressed: () {},
              backgroundColor: AppColors.redColor,
              text: 'Delete Account',
              textStyle: AppStyles.regular20White,
            ),
            SizedBox(height: height * 0.02),

            // افتح الـBottomSheet
            CustomElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.black,
                  context: context,
                  builder: (context) {
                    return CustomBottomSheet(
                      currentAvatar: selectedAvatar,                 // علشان يعلّم على الحالي
                      onAvatarSelected: (String avatarPath) {
                        setState(() => selectedAvatar = avatarPath); // حدّث الصورة فوق فورًا
                        // مفيش إطار فوق؛ الهايلايت بس جوه الـBottomSheet
                      },
                    );
                  },
                );
              },
              text: 'Update Data',
              textStyle: AppStyles.regular20Black,
            ),
          ],
        ),
      ),
    );
  }
}
