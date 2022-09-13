import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../theme/color.dart';
import '../cubit/upload_file_cubit.dart';
import '../widgets/upload_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadFileCubit(),
      child: Scaffold(
        backgroundColor: AppColor.bgSurface,
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
    return Expanded(
      child: Container(
        color: AppColor.bgMenu,
        child: BlocBuilder<UploadFileCubit, UploadFileState>(
          builder: (context, state) {
            return const Center(
              child: UploadCardWidget(),
            );
          },
        ),
      ),
    );
  }
}

class _LeftSideWidget extends StatefulWidget {
  const _LeftSideWidget();
  @override
  State<_LeftSideWidget> createState() => _LeftSideWidgetState();
}

class _LeftSideWidgetState extends State<_LeftSideWidget> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 1.6;
    return Container(
      width: width,
      color: AppColor.bgSurface,
    );
  }
}
