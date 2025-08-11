import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:todo_app/features/auth/domain/usecases/sign_up_usecase.dart';

import '../../../../shared/state/base_state.dart';
import '../../../../shared/utils/cubit_exception_handler_mixin.dart';

class SignUpCubit extends Cubit<BaseState> with CubitExceptionHandlingMixin {
  final SignUpUseCase signUpUseCase;

  SignUpCubit(this.signUpUseCase) : super(InitialState());

  final supabase = Supabase.instance.client;

  Future<void> signUp({required String email, required String password}) async {
    emit(LoadingState());

    try {
      final response = await signUpUseCase(
        email: email,
        password: password,
      );

      if (response != null) {
        emit(SuccessState(data: response));
      }
    } catch (error) {
      handleException(error);
    }
  }
}
