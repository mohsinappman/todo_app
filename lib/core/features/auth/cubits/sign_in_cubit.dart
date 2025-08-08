import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../state/base_state.dart';
import '../../../utils/cubit_exception_handler_mixin.dart';
import '../services/auth_service.dart';

class SignInCubit extends Cubit<BaseState> with CubitExceptionHandlingMixin {
  AuthService _authService;

  SignInCubit(this._authService) : super(InitialState());

  final supabase = Supabase.instance.client;

  Future<void> signIn({required String email, required String password}) async {
    emit(LoadingState());

    try {
      final response = await _authService.signIn(
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
