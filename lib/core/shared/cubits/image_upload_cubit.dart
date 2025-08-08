import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../state/base_state.dart';
import '../../utils/cubit_exception_handler_mixin.dart';
import '../services/image_upload_service.dart';

class ImageUploadCubit extends Cubit<BaseState>
    with CubitExceptionHandlingMixin {
  final ImageUploadService _imageUploadService;

  ImageUploadCubit(this._imageUploadService) : super(InitialState());

  final supabase = Supabase.instance.client;

  Future<void> uploadImage(File imageFile) async {
    emit(LoadingState());

    try {
      final imageUrl = await _imageUploadService.uploadImage(
        imageFile: imageFile,
      );

      emit(SuccessState(data: imageUrl));
    } catch (error) {
      handleException(error);
    }
  }
}
