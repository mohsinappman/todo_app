import 'dart:io';

import 'package:todo_app/shared/domain/repositories/image_upload_repository.dart';

class ImageUploadUsecase {
  final ImageUploadRepository repository;

  ImageUploadUsecase(this.repository);

  Future<String> call({required File imageFile}) async {
    return await repository.uploadImage(imageFile: imageFile);
  }
}
