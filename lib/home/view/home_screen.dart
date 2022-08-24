import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rive/rive.dart';

import '../../core/string_constant.dart';
import '../../theme/color.dart';
import '../cubit/upload_file_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SMIInput? _pressInput;

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    _pressInput = controller.inputs.first;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadFileCubit(),
      child: Scaffold(
        body: Row(
          children: [
            _LeftSideWidget(
              onRiveInit: _onRiveInit,
            ),
            BlocBuilder<UploadFileCubit, UploadFileState>(
              builder: (context, state) {
                if (state.status == Status.loading) {
                  _pressInput!.value = state.progress!;
                }
                return Expanded(
                  child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
                    final width = constraints.maxWidth / 10;
                    return Padding(
                      padding: EdgeInsets.all(width),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            StringConstants.appName,
                            style: TextStyle(
                              fontSize: 34,
                              color: AppColor.primary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            StringConstants.uploadText,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColor.primary.withOpacity(0.8),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(height: 32),
                          if (state.status == Status.success) ...[
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
                          ] else if (state.status == Status.loading)
                            Ink(
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
                            )
                          else
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
                                  StringConstants.uploadFile,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LeftSideWidget extends StatelessWidget {
  const _LeftSideWidget({Key? key, this.onRiveInit}) : super(key: key);
  final void Function(Artboard)? onRiveInit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: AppColor.primary,
        child: RiveAnimation.asset(
          'assets/rive/tree.riv',
          onInit: onRiveInit,
        ),
      ),
    );
  }
}
