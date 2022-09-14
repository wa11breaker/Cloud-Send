// ignore_for_file: public_member_api_docs, comment_references

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../core/app_logger.dart';

part 'upload_file_state.dart';

/// {@template UploadFileCubit}
/// Displays the content for the [PuzzlePage].
/// {@endtemplate}
class UploadFileCubit extends Cubit<UploadFileState> {
  UploadFileCubit() : super(const UploadFileState.initial());

  final storage = FirebaseStorage.instance;
  final storageRef = FirebaseStorage.instance.ref();
  final uuid = const Uuid();

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      emit(
        state.asFiledPicked(
          file: result.files.first,
          fileName: result.files.first.name,
          fileSize: result.files.first.size.toDouble(),
        ),
      );
    }
  }

  void discardSelection() {
    emit(const UploadFileState.initial());
  }

  Future<void> uploadFile() async {
    final fileName = uuid.v1();

    final data = Platform.isMacOS ? await File(state.file!.path!).readAsBytes() : state.file!.bytes!;
    final fileExtension = state.file!.name.split('.').last;

    final spaceRef = storageRef.child('files/$fileName.$fileExtension');

    spaceRef.putData(data).snapshotEvents.listen((taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress = 100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          AppLogger.e('Upload is $progress% complete.');
          emit(state.asLoading(progress.isNaN ? 0 : double.parse(progress.toStringAsFixed(1))));
          break;
        case TaskState.paused:
          AppLogger.e('Upload is paused.');
          break;
        case TaskState.canceled:
          AppLogger.e('Upload was canceled');
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
