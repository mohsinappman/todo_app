import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/image_upload_usecase.dart';
import '../../state/base_state.dart';
import '../../utils/cubit_exception_handler_mixin.dart';

class ImageUploadCubit extends Cubit<BaseState>
    with CubitExceptionHandlingMixin {
  final ImageUploadUsecase imageUploadUsecase;

  ImageUploadCubit(this.imageUploadUsecase) : super(InitialState());

  Future<void> uploadImage(File imageFile) async {
    emit(LoadingState());

    try {
      final imageUrl = await imageUploadUsecase(
        imageFile: imageFile,
      );

      emit(SuccessState(data: imageUrl));
    } catch (error) {
      handleException(error);
    }
  }
}
