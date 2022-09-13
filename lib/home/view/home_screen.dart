import 'package:file_share/home/widgets/upload_failed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../../core/string_constant.dart';
import '../../theme/color.dart';
import '../../widget/button.dart';
import '../cubit/upload_file_cubit.dart';
import '../widgets/upload_success.dart';
import '../widgets/uploading_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadFileCubit(),
      child: Scaffold(
        body: Row(
          children: const [
            _LeftSideWidget(),
            _RightSideWidget(),
          ],
        ),
      ),
    );
  }
}

class _RightSideWidget extends StatefulWidget {
  const _RightSideWidget();

  @override
  State<_RightSideWidget> createState() => _RightSideWidgetState();
}

class _RightSideWidgetState extends State<_RightSideWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadFileCubit, UploadFileState>(
      builder: (context, state) {
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
                  if (state.status == Status.success)
                    UploadSuccessWidget(state: state)
                  else if (state.status == Status.failed)
                    UploadFailedWidget(state: state)
                  else if (state.status == Status.loading)
                    UploadingWidget(state: state)
                  else
                    AppButton(
                      title: StringConstants.uploadFile,
                      onTap: () {
                        context.read<UploadFileCubit>().pickFile();
                      },
                    )
                ],
              ),
            );
          }),
        );
      },
    );
  }
}

class _LeftSideWidget extends StatefulWidget {
  const _LeftSideWidget();
  @override
  State<_LeftSideWidget> createState() => _LeftSideWidgetState();
}

class _LeftSideWidgetState extends State<_LeftSideWidget> {
  SMIInput? _pressInput;

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    _pressInput = controller.inputs.first;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: AppColor.primary,
        child: BlocBuilder<UploadFileCubit, UploadFileState>(
          builder: (context, state) {
            if (state.status == Status.loading) {
              _pressInput?.value = state.progress!;
            }
            return RiveAnimation.asset(
              'assets/rive/tree.riv',
              onInit: _onRiveInit,
            );
          },
        ),
      ),
    );
  }
}
