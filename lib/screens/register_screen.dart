import 'package:flutter/material.dart';
import 'package:movie_app/api/api_register_screen/api_manager.dart';
import 'package:movie_app/custom_widgets/custom_elevated_button.dart';
import 'package:movie_app/custom_widgets/custom_text_form_field.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';
import '../../model/register_request.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  // 🔥 صور الأفاتار
  final List<String> avatarImages = [
    AppAssets.avatar1Image,
     AppAssets.avatar2Image,
     AppAssets.avatar3Image,
     AppAssets.avatar4Image,
     AppAssets.avatar5Image,
     AppAssets.avatar6Image,
     AppAssets.avatar7Image,
      AppAssets.avatar8Image,
       AppAssets.avatar9Image,
  ];

  int selectedAvatarIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.4, initialPage: 0);
     selectedAvatarIndex = 0;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final request = RegisterRequest(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        confirmPassword: _confirmPasswordController.text.trim(),
        phone: _phoneController.text.trim(),
         avaterId: selectedAvatarIndex,
      );

      final result = await ApiManager.registerUser(request);
      print(result);

      if (result['status'] == 'success' || result['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? 'Registration successful!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? result['error'] ?? 'Registration failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.yellowColor),
          backgroundColor: AppColors.transparentColor,
          title: Text('Register', style: AppStyles.regular16Yellow),
          centerTitle: true,toolbarHeight: 40,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: height * 0.02),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                 

                  // 🔥 Carousel الأفاتار
                  SizedBox(
                    height: 140,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: avatarImages.length,
                      onPageChanged: (index) {
                        setState(() {
                          selectedAvatarIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        double scale = selectedAvatarIndex == index ? 1.2 : 0.9;

                        return TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 300),
                          tween: Tween<double>(begin: scale, end: scale),
                          builder: (context, value, child) {
                            return Transform.scale(
                              scale: value,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedAvatarIndex = index;
                                  });
                                },
                                child:CircleAvatar(
  backgroundColor: Colors.transparent,
  child: ClipOval(
    child: Image.asset(
      avatarImages[index],
      fit: BoxFit.cover,  // أو contain لو عايز الصورة كلها
      width: 110,
      height: 110,
    ),
  ),
)

                              ),
                            );
                          },
                        );
                      },
                    ),
                  ), const SizedBox(height: 10),
                     Text('Avatar', textAlign: TextAlign.center, style: AppStyles.regular16White),
                 
                  const SizedBox(height: 10),

                  _buildField(
                    controller: _nameController,
                    hint: 'Name',
                    icon: AppAssets.usernameIconRegister,
                    validator: (v) => v == null || v.isEmpty ? 'Enter your name' : null,
                  ),
                  SizedBox(height: height * 0.02),

                  _buildField(
                    controller: _emailController,
                    hint: 'Email',
                    icon: AppAssets.emailIcon,
                    validator: (v) => v == null || !v.contains('@') ? 'Enter valid email' : null,
                  ),
                  SizedBox(height: height * 0.02),

                  _buildField(
                    controller: _passwordController,
                    hint: 'Password',
                    icon: AppAssets.passwordIcon,
                    isPassword: true,
                    showPassword: _showPassword,
                    togglePassword: () => setState(() => _showPassword = !_showPassword),
                    validator: (v) => v != null && v.length >= 6 ? null : 'Min 6 characters',
                  ),
                  SizedBox(height: height * 0.02),

                  _buildField(
                    controller: _confirmPasswordController,
                    hint: 'Confirm Password',
                    icon: AppAssets.passwordIcon,
                    isPassword: true,
                    showPassword: _showConfirmPassword,
                    togglePassword: () => setState(() => _showConfirmPassword = !_showConfirmPassword),
                    validator: (v) => v == _passwordController.text ? null : 'Passwords do not match',
                  ),
                  SizedBox(height: height * 0.02),

                  _buildField(
                    controller: _phoneController,
                    hint: 'Phone Number',
                    icon: AppAssets.phoneIcon,
                    validator: (v) => v != null && v.length >= 10 ? null : 'Enter valid phone',
                  ),
                  SizedBox(height: height * 0.02),

                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomElevatedButton(
                          onPressed: _onRegister,
                          text: 'Create Account',
                          backgroundColor: AppColors.yellowColor,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required String icon,
    required String? Function(String?) validator,
    bool isPassword = false,
    bool showPassword = false,
    VoidCallback? togglePassword,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkGreyColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: CustomTextFormField(
        controller: controller,
        colorBorderSide: AppColors.darkGreyColor,
        hintText: hint,
        hintStyle: AppStyles.regular16White,
        prefixIcon: Image.asset(icon),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  showPassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white70,
                ),
                onPressed: togglePassword,
              )
            : null,
        obscureText: isPassword && !showPassword,
        validator: validator,
      ),
    );
  }
}
