import 'package:flutter/material.dart';

import '../theme/color.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        decoration: BoxDecoration(
          color: AppColor.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: AppColor.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
