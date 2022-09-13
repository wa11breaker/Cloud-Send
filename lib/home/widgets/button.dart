import 'package:file_share/theme/text.dart';
import 'package:flutter/material.dart';

import '../../theme/color.dart';

enum ButtonType { normal, uploading }

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.buttonType = ButtonType.normal,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 72,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColor.primary,
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyle.button,
          ),
        ),
      ),
    );
  }
}
