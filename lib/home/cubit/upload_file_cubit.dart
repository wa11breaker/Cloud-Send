import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../core/app_logger.dart';

part 'upload_file_state.dart';

class UploadFileCubit extends Cubit<UploadFileState> {
  UploadFileCubit() : super(const UploadFileState.initial());

  final storage = FirebaseStorage.instance;
  final storageRef = FirebaseStorage.instance.ref();
  final uuid = const Uuid();

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      emit(state.asFiledPicked(
        result.files.first.name,
        result.files.first.size.toDouble(),
      ));

      // if (kIsWeb) {
      //   voidUpload(
      //     data: result.files.first.bytes!,
      //     fileExtension: result.files.first.name.split('.').last,
      //   );
      // } else {
      //   voidUpload(
      //     data: await File(result.files.first.path!).readAsBytes(),
      //     fileExtension: result.files.first.name.split('.').last,
      //   );
      // }
    }
  }

  voidUpload({required Uint8List data, required String fileExtension}) async {
    final fileName = uuid.v1();
    final spaceRef = storageRef.child("files/$fileName.$fileExtension");

    spaceRef.putData(data).snapshotEvents.listen((taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress = 100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          AppLogger.e("Upload is $progress% complete.");
          emit(state.asLoading(progress.isNaN ? 0 : progress));
          break;
        case TaskState.paused:
          AppLogger.e("Upload is paused.");
          break;
        case TaskState.canceled:
          AppLogger.e("Upload was canceled");
          break;
        case TaskState.error:
          AppLogger.e('Failed');
          emit(state.asError('Failed'));
          break;
        case TaskState.success:
          getDownloadUrl(spaceRef);
          break;
      }
    });
  }

  Future<void> getDownloadUrl(Reference spaceRef) async {
    try {
      final downloadUrl = await spaceRef.getDownloadURL();
      AppLogger.s(downloadUrl);
      emit(state.asSuccess(downloadUrl));
    } catch (e) {
      AppLogger.e(e.toString());
      emit(state.asError(e.toString()));
    }
  }
}
