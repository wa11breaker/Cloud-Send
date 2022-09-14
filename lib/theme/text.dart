import 'package:file_share/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle h1 = GoogleFonts.ptSerif(
    fontSize: 32,
    color: AppColor.textVivid,
  );
  static TextStyle subTitle = GoogleFonts.roboto(
    fontSize: 16,
    color: AppColor.textDim,
    fontWeight: FontWeight.w300,
    height: 1.5,
  );
  static TextStyle body1 = GoogleFonts.roboto(
    fontSize: 14,
    color: AppColor.textVivid,
    fontWeight: FontWeight.w500,
  );
  static TextStyle body2 = GoogleFonts.roboto(
    fontSize: 12,
    color: AppColor.textDim,
    fontWeight: FontWeight.w300,
  );
  static TextStyle button = GoogleFonts.roboto(
    fontSize: 16,
    color: AppColor.bgSurface,
    fontWeight: FontWeight.w500,
  );
}
