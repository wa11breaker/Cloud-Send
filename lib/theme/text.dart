import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

/// Defines the text theme for the app.
class AppTextStyle {
  /// heading 1
  static TextStyle h1 = GoogleFonts.ptSerif(
    fontSize: 32,
    color: AppColor.textVivid,
  );

  /// sub title
  static TextStyle subTitle = GoogleFonts.roboto(
    fontSize: 16,
    color: AppColor.textDim,
    fontWeight: FontWeight.w300,
    height: 1.5,
  );

  /// body 1
  static TextStyle body1 = GoogleFonts.roboto(
    fontSize: 14,
    color: AppColor.textVivid,
    fontWeight: FontWeight.w500,
  );

  /// body 2
  static TextStyle body2 = GoogleFonts.roboto(
    fontSize: 12,
    color: AppColor.textDim,
    fontWeight: FontWeight.w300,
  );

  /// button
  static TextStyle button = GoogleFonts.roboto(
    fontSize: 16,
    color: AppColor.bgSurface,
    fontWeight: FontWeight.w500,
  );
}
