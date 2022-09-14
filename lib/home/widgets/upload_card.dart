import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../core/string_constant.dart';
import '../../theme/color.dart';
import '../../theme/text.dart';
import '../cubit/upload_file_cubit.dart';
import 'button.dart';

class UploadCardWidget extends StatelessWidget {
  const UploadCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String buttonTitle(UploadFileState state) {
      if (state.status == Status.success) {
        return 'Uploaded';
      } else if (state.status == Status.loading) {
        return '${state.progress}% Uploaded';
      } else if (state.status == Status.filePicked) {
        return 'Upload';
      } else {
        return 'Pick a File';
      }
    }

    void onButtonTap(UploadFileState state) {
      if (state.status == Status.loading) {
        return;
      }

      if (state.status == Status.filePicked) {
        context.read<UploadFileCubit>().voidUpload();
        return;
      }

      context.read<UploadFileCubit>().pickFile();
    }

    return Container(
      width: 380,
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
              if (state.status != Status.uninitialized && state.status != Status.success) const _PickedFileWidget(),
              if (state.status == Status.success) const _UploadedFileWidget(),
              AppButton(
                title: buttonTitle(state),
                progress: state.progress ?? 0,
                onTap: () => onButtonTap(state),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PickedFileWidget extends StatelessWidget {
  const _PickedFileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadFileCubit, UploadFileState>(builder: (context, state) {
      return Row(
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
            onPressed: () {
              context.read<UploadFileCubit>().discardSelection();
            },
            icon: const Icon(Icons.close),
          )
        ],
      );
    });
  }
}

class _UploadedFileWidget extends StatefulWidget {
  const _UploadedFileWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_UploadedFileWidget> createState() => _UploadedFileWidgetState();
}

class _UploadedFileWidgetState extends State<_UploadedFileWidget> {
  bool copied = false;

  Future<void> copyToClipBoard(String url) async {
    await Clipboard.setData(ClipboardData(text: url));
    copied = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    copied = false;
    return BlocBuilder<UploadFileCubit, UploadFileState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QrImage(
                data: state.url ?? '',
                version: QrVersions.auto,
                size: 100.0,
                backgroundColor: AppColor.primary,
                padding: const EdgeInsets.all(4),
                gapless: false),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.fileName!,
                    style: AppTextStyle.body1,
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () => copyToClipBoard(state.url!),
                    child: Row(
                      children: [
                        Icon(
                          copied ? Icons.check : Icons.copy,
                          color: copied ? AppColor.green : AppColor.textDim,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          copied ? 'Copied' : 'Click to copy the url',
                          style: AppTextStyle.body2.copyWith(
                            color: copied ? AppColor.green : AppColor.textDim,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
