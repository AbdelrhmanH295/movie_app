import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';

class CustomBottomSheet extends StatefulWidget {
  final Function(String) onAvatarSelected;
  final String currentAvatar; // علشان نميّز المختار حاليًا

  const CustomBottomSheet({
    super.key,
    required this.onAvatarSelected,
    required this.currentAvatar,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final List<String> _avatars = [
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

  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    final idx = _avatars.indexOf(widget.currentAvatar);
    _selectedIndex = idx >= 0 ? idx : null;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width  = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.02),
      decoration: BoxDecoration(
        color: AppColors.darkGreyColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: GridView.builder(
        itemCount: _avatars.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 18,
          crossAxisSpacing: 26,
        ),
        itemBuilder: (context, index) {
          final isSelected = _selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() => _selectedIndex = index);                 // 1) خلي اللي واقف عليه يبقى مختار
              widget.onAvatarSelected(_avatars[index]);               // 2) حدّث الصورة اللي فوق فورًا
            },
            child: Container(
              // الخلفية الصفراء بتبان هنا — مش Border
              decoration: BoxDecoration(
                color: isSelected ? AppColors.yellowColor : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(4), // مسافة علشان الخلفية تبان حوالين الصورة
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  _avatars[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
