import 'package:flutter/material.dart';
import 'package:todo_app/core/state/base_state.dart';

import 'custom_snack_bar.dart';

errorHandler({required BuildContext context, required BaseState state}) {
  if (state is ErrorState) {
    showCustomSnackBar(context, state.error ?? '');
  } else if (state is UnknownErrorState) {
    showCustomSnackBar(context, state.error ?? '');
  }
}
