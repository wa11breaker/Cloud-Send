// ignore_for_file: public_member_api_docs, avoid_field_initializers_in_const_classes

import 'package:flutter/material.dart';

import '../../theme/color.dart';
import '../../theme/text.dart';

enum ButtonType { normal, uploading }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.onTap,
    this.buttonType = ButtonType.normal,
    this.progress = 0,
  });

  final String title;
  final VoidCallback onTap;
  final ButtonType buttonType;
  final double progress;

  final double buttonHeight = 56;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, builder) {
        return InkWell(
          onTap: onTap,
          child: Container(
            height: buttonHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColor.primary,
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Center(
                    child: AnimatedContainer(
                      height: buttonHeight,
                      width: builder.maxWidth * (progress / 100),
                      duration: const Duration(milliseconds: 100),
                      color: AppColor.green,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    title,
                    style: AppTextStyle.button,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
