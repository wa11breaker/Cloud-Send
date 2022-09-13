// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'upload_file_cubit.dart';

enum Status {
  uninitialized,
  filePicked,
  loading,
  success,
  failed,
}

class UploadFileState {
  const UploadFileState._({
    this.status = Status.uninitialized,
    this.progress = 0.0,
    this.url,
    this.fileName,
    this.error,
    this.fileSize = 0.0,
    this.file,
  });

  UploadFileState copyWith({
    Status? status,
    double? progress,
    String? url,
    String? fileName,
    String? error,
    double? fileSize,
    PlatformFile? file,
  }) {
    return UploadFileState._(
      status: status ?? this.status,
      progress: progress ?? this.progress,
      url: url ?? this.url,
      fileName: fileName ?? this.fileName,
      error: error ?? this.error,
      fileSize: fileSize ?? this.fileSize,
      file: file ?? this.file,
    );
  }

  const UploadFileState.initial() : this._();

  UploadFileState asFiledPicked({required PlatformFile file, required String fileName, required double fileSize}) {
    return copyWith(status: Status.filePicked, fileName: fileName, fileSize: fileSize, file: file);
  }

  UploadFileState asSuccess(String url) {
    return copyWith(status: Status.success, url: url);
  }

  UploadFileState asLoading(double progress) {
    return copyWith(status: Status.loading, progress: progress);
  }

  UploadFileState asError(String error) {
    return copyWith(status: Status.failed, error: error);
  }

  final Status status;
  final double? progress;
  final String? url;
  final String? fileName;
  final String? error;
  final double? fileSize;
  final PlatformFile? file;
}
