import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

Color? parseColorString({String? colorString}) {
  if (colorString == null) {
    return AppColors.greenColor;
  }
  final regex = RegExp(
    r'Color\(alpha: ([\d.]+), red: ([\d.]+), green: ([\d.]+), blue: ([\d.]+)',
  );

  final match = regex.firstMatch(colorString);

  if (match != null) {
    final alpha = (double.parse(match.group(1)!) * 255).round();
    final red = (double.parse(match.group(2)!) * 255).round();
    final green = (double.parse(match.group(3)!) * 255).round();
    final blue = (double.parse(match.group(4)!) * 255).round();

    return Color.fromARGB(alpha, red, green, blue);
  }

  return null;
}
