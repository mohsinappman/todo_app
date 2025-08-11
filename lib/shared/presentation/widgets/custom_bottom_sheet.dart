import 'package:flutter/material.dart';

Future<T?> showAdaptiveBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  bool isDismissible = true,
  bool enableDrag = true,
  bool useRootNavigator = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    useRootNavigator: useRootNavigator,
    backgroundColor: Theme.of(context).bottomSheetTheme.modalBackgroundColor,
    shape: Theme.of(context).bottomSheetTheme.shape,
    clipBehavior: Theme.of(context).bottomSheetTheme.clipBehavior ?? Clip.none,
    builder: (_) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: IntrinsicHeight(child: child),
        ),
      );
    },
  );
}
