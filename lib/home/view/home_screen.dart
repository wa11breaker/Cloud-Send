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

class _RightSideWidget extends StatelessWidget {
  const _RightSideWidget();

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

class _LeftSideWidget extends StatelessWidget {
  const _LeftSideWidget();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 1.6;
    return Container(
      width: width,
      decoration: const BoxDecoration(
        color: AppColor.bgSurface,
        image: DecorationImage(
          image: AssetImage('assets/images/pattern.png'),
          fit: BoxFit.cover,
          opacity: 0.25,
        ),
      ),
    );
  }
}
