import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function() onPressed;
  final Widget child;

  const CustomElevatedButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 48.h,
        width: double.infinity,
        child: ElevatedButton(onPressed: onPressed, child: child),
      ),
    );
  }
}
