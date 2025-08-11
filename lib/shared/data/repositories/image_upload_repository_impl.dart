

import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repositories/image_upload_repository.dart';

class ImageUploadRepositoryImpl implements ImageUploadRepository {
  final SupabaseClient supabase;

  ImageUploadRepositoryImpl(this.supabase);

  @override
  Future<String> uploadImage({required File imageFile}) async {
    try {
      final fileName =
          'category_images/${DateTime.now().millisecondsSinceEpoch}_${imageFile.path.split('/').last}';

      final storageResponse = await supabase.storage
          .from('images')
          .upload(fileName, imageFile);

      if (storageResponse.isEmpty) {
        throw Exception('Image upload failed');
      }

      final publicUrl = supabase.storage.from('images').getPublicUrl(fileName);

      return publicUrl;
    } catch (e) {
      print('Image upload error: $e');
      throw Exception('Image upload error: $e');
    }
  }
}