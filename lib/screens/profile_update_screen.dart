// profile_update_screen.dart
import 'package:flutter/material.dart';
import 'package:movie_app/api/api_update_profile_screen/api.manager.dart';
import 'package:movie_app/api/app-prefrences/token-storage.dart';
import 'package:movie_app/api/app-prefrences/user_storage.dart';
 
import 'package:movie_app/model/update_profile_request.dart';
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
  String selectedAvatar = AppAssets.gamer1; // المسار الافتراضي
  int selectedAvatarId = 1;

  // خريطة تربط المسار بالـ ID (عدّل/زوّد المسارات والـ IDs حسب AppAssets اللي عندك)
  final Map<String, int> avatarIdMap = {
       AppAssets.avatar1Image:1,
     AppAssets.avatar2Image:2,
     AppAssets.avatar3Image:3,
     AppAssets.avatar4Image:4,
     AppAssets.avatar5Image:5,
     AppAssets.avatar6Image:6,
     AppAssets.avatar7Image:7,
      AppAssets.avatar8Image:8,
       AppAssets.avatar9Image:9
    // اضف هنا باقي الصور لو عندك
  };

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final user = await UserStorage.getUser();
    setState(() {
      nameController.text = user["name"] ?? '';
      phoneController.text = user["phone"] ?? '';
      // لو انت مخزن مسار الافاتار في SharedPreferences تقدر تجيبه هنا
      // مثال: selectedAvatar = user["avatarPath"] ?? selectedAvatar;
      // selectedAvatarId = avatarIdMap[selectedAvatar] ?? selectedAvatarId;
    });
  }

  Future<void> _updateProfile() async {
    final token = await TokenStorage.getToken();

    final avId = avatarIdMap[selectedAvatar] ?? selectedAvatarId;

    final request = UpdateProfileRequest(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      avaterId: avId,
    );

    // Optional: show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final response = await ProfileApiManager.updateProfile(request, token: token);

    // close loading
    if (Navigator.canPop(context)) Navigator.pop(context);

    if (response["success"] == true) {
      // لو الـ API بيرجع data بشكل متوقع خزّنها
      final data = response["data"];
      if (data != null && data is Map<String, dynamic>) {
        await UserStorage.saveUser(data);
      } else {
        // وإلا احفظ الاسم والرقم محلياً (اختياري)
        await UserStorage.saveUser({
          "id": response["id"] ?? await UserStorage.getUser().then((u) => u["userId"]),
          "name": nameController.text,
          "email": (await UserStorage.getUser())["email"] ?? '',
          "phone": phoneController.text,
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully!")),
      );
    } else {
      final msg = response["message"] ?? "Update failed";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    }
  }

  Future<void> _deleteAccount() async {
    // تأكيد قبل الحذف
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete your account?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Delete")),
        ],
      ),
    );

    if (confirm != true) return;

    final token = await TokenStorage.getToken();

    // show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final response = await ProfileApiManager.deleteProfile(token: token);

    // close loading
    if (Navigator.canPop(context)) Navigator.pop(context);

    if (response["success"] == true) {
      await TokenStorage.clearToken();
      await UserStorage.clearUser();
      // اذهب لشاشة تسجيل الدخول وامسح الستاك
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } else {
      final msg = response["message"] ?? "Delete failed";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    }
  }

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
                controller: nameController,
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
                controller: phoneController,
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
              onPressed: _deleteAccount,
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
                      currentAvatar: selectedAvatar, // علشان يعلّم على الحالي
                      // مهم: هنا نفترض أن الـ CustomBottomSheet بتستدعي onAvatarSelected(path) فقط
                      onAvatarSelected: (String avatarPath) async {
                        setState(() {
                          selectedAvatar = avatarPath;
                          selectedAvatarId = avatarIdMap[avatarPath] ?? selectedAvatarId;
                        });
                        Navigator.pop(context);
                        await _updateProfile(); // بعد اختيار الافاتار نعمل تحديث مباشر
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
