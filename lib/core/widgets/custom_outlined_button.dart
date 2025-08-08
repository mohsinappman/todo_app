import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOutlinedButton extends StatelessWidget {
  final Function() onPressed;
  final Widget child;

  const CustomOutlinedButton({
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
        child: OutlinedButton(onPressed: onPressed, child: child),
      ),
    );
  }
}
