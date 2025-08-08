import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/auth/services/auth_exception_mixin.dart';
import '../state/base_state.dart';

mixin CubitExceptionHandlingMixin<S> on Cubit<S> {
  void handleException(Object e) {
    if (e is AuthException) {
      emit(ErrorState(error: e.message) as S);
    } else {
      emit(UnknownErrorState(error: e.toString()) as S);
    }
  }
}
