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
    this.progress = 0,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final ButtonType buttonType;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, builder) {
      return InkWell(
        onTap: onTap,
        child: Container(
          height: 72,
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
                    height: 72,
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
    });
  }
}
