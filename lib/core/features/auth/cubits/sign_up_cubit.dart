import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../state/base_state.dart';
import '../../../utils/cubit_exception_handler_mixin.dart';
import '../services/auth_service.dart';

class SignUpCubit extends Cubit<BaseState> with CubitExceptionHandlingMixin {
  AuthService _authService;

  SignUpCubit(this._authService) : super(InitialState());

  final supabase = Supabase.instance.client;

  Future<void> signUp({required String email, required String password}) async {
    emit(LoadingState());

    try {
      final response = await _authService.signUp(
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
