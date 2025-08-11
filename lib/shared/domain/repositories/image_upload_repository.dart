import 'dart:io';

abstract class ImageUploadRepository {
  Future<String> uploadImage({required File imageFile});
}