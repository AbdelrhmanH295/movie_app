import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/utils/app_colors.dart';

class AppStyles {
  static TextStyle regular16Black = GoogleFonts.inter(
      fontSize: 16, color: AppColors.blackColor, fontWeight: FontWeight.w400);
  static TextStyle regular20Black = GoogleFonts.inter(
      fontSize: 20, color: AppColors.blackColor, fontWeight: FontWeight.w400);

  static TextStyle regular16White = GoogleFonts.inter(
      fontSize: 16, color: AppColors.whiteColor, fontWeight: FontWeight.w400);
  static TextStyle regular20BWhite = GoogleFonts.inter(
      fontSize: 20, color: AppColors.whiteColor, fontWeight: FontWeight.w400);

  static TextStyle regular16Yellow = GoogleFonts.inter(
      fontSize: 16, color: AppColors.yellowColor, fontWeight: FontWeight.w400);
  static TextStyle regular20BYellow = GoogleFonts.inter(
      fontSize: 20, color: AppColors.yellowColor, fontWeight: FontWeight.w400);
  static TextStyle regular16Red = GoogleFonts.roboto(
      color: AppColors.redColor, fontSize: 16, fontWeight: FontWeight.w400);
  static TextStyle black16Yellow = GoogleFonts.roboto(
      color: AppColors.yellowColor, fontSize: 14, fontWeight: FontWeight.w900);
}
