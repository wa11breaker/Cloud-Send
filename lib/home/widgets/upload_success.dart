import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../core/string_constant.dart';
import '../../theme/color.dart';
import '../cubit/upload_file_cubit.dart';

class UploadSuccessWidget extends StatelessWidget {
  const UploadSuccessWidget({Key? key, required this.state}) : super(key: key);

  final UploadFileState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        QrImage(
          padding: EdgeInsets.zero,
          data: state.url!,
          version: QrVersions.auto,
          size: 200.0,
        ),
        const SizedBox(height: 8),
        SelectableText(
          state.url.toString(),
          style: const TextStyle(
            fontSize: 12,
            color: AppColor.green,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 16),
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            context.read<UploadFileCubit>().pickFile();
          },
          child: Ink(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              StringConstants.uploadNew,
              style: TextStyle(
                fontSize: 16,
                color: AppColor.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
