import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInputField extends StatelessWidget {
  final String fieldTitle;
  final TextEditingController? controller;
  final String hintText;
  final String? Function(String? value)? validator;

  const CustomInputField({
    super.key,
    required this.hintText,
    required this.fieldTitle,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(fieldTitle, style: Theme.of(context).textTheme.bodyLarge),
        8.verticalSpace,
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(hintText: hintText),
        ),
      ],
    );
  }
}
