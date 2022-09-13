import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/string_constant.dart';
import '../../theme/color.dart';
import '../../theme/text.dart';
import '../cubit/upload_file_cubit.dart';
import 'button.dart';

class UploadCardWidget extends StatelessWidget {
  const UploadCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 575,
      decoration: BoxDecoration(
        color: AppColor.bgSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 56),
      child: BlocBuilder<UploadFileCubit, UploadFileState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringConstants.appName,
                    style: AppTextStyle.h1,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    StringConstants.uploadText,
                    style: AppTextStyle.subTitle,
                  ),
                ],
              ),
              if (state.status == Status.filePicked)
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 52,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColor.primary,
                      ),
                      child: const Icon(
                        Icons.file_present,
                        color: AppColor.bgSurface,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${state.fileSize} MB',
                            style: AppTextStyle.body1,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            state.fileName!,
                            maxLines: 1,
                            style: AppTextStyle.body2,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
              AppButton(
                title: 'Pick a File',
                onTap: () {
                  context.read<UploadFileCubit>().pickFile();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
