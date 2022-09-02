import 'package:flutter/material.dart';

import '../../core/string_constant.dart';
import '../../theme/color.dart';
import '../cubit/upload_file_cubit.dart';

class UploadingWidget extends StatelessWidget {
  const UploadingWidget({Key? key, required this.state}) : super(key: key);

  final UploadFileState state;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
      decoration: BoxDecoration(
        color: AppColor.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        ('${state.progress!.toStringAsFixed(1)}% ') + StringConstants.uploaded,
        style: const TextStyle(
          fontSize: 16,
          color: AppColor.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
