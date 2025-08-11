import 'package:flutter/material.dart';

Future<TimeOfDay?> showAppTimePicker({
  required BuildContext context,
  TimeOfDay? initialTime,
  String? helpText,
}) {
  return showTimePicker(
    context: context,
    initialTime: initialTime ?? TimeOfDay.now(),
    helpText: helpText ?? 'Select Time',
  );
}
