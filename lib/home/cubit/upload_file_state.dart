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
  });

  UploadFileState copyWith({
    Status? status,
    double? progress,
    String? url,
    String? fileName,
    String? error,
  }) {
    return UploadFileState._(
      status: status ?? this.status,
      progress: progress,
      fileName: fileName ?? this.fileName,
      error: error ?? this.error,
      url: url,
    );
  }

  const UploadFileState.initial() : this._();

  UploadFileState asFiledPicked(String fileName) {
    return copyWith(status: Status.filePicked, fileName: fileName);
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
}
