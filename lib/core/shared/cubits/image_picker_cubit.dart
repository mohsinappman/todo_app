import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../state/base_state.dart';

class ImagePickerCubit extends Cubit<BaseState> {
  final ImagePicker _picker = ImagePicker();

  ImagePickerCubit() : super(InitialState());

  Future<void> pickImage({required ImageSource source}) async {
    emit(LoadingState());
    try {
      final pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        emit(SuccessState(data: File(pickedFile.path)));
      }
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  void clearImage() => emit(InitialState());
}
