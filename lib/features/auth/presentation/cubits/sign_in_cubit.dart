import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/state/base_state.dart';
import '../../../../shared/utils/cubit_exception_handler_mixin.dart';
import '../../domain/usecases/sign_in_usecase.dart';

class SignInCubit extends Cubit<BaseState> with CubitExceptionHandlingMixin {
  final SignInUseCase signInUseCase;

  SignInCubit(this.signInUseCase) : super(InitialState());

  Future<void> signIn({required String email, required String password}) async {
    emit(LoadingState());

    try {
      final response = await signInUseCase(
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
