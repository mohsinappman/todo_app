import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/validators.dart';

class ValidatedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? maxLength;
  final bool readOnly;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final TextCapitalization textCapitalization;
  final EdgeInsetsGeometry? contentPadding;

  const ValidatedTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.maxLength,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      maxLength: maxLength,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}

/// A custom text field specifically for forms with title and validation
class FormTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final bool required;

  const FormTextField({
    Key? key,
    required this.title,
    required this.controller,
    required this.hintText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.required = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: Theme.of(context).textTheme.titleMedium,
            children: required
                ? [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ]
                : null,
          ),
        ),
        8.verticalSpace,
        ValidatedTextField(
          controller: controller,
          hintText: hintText,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscureText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          maxLines: maxLines,
        ),
      ],
    );
  }
}

/// Quick access text fields with common validators
class QuickTextField {
  static Widget email({
    required TextEditingController controller,
    String hintText = 'Enter your email',
    String? labelText,
  }) {
    return ValidatedTextField(
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      keyboardType: TextInputType.emailAddress,
      validator: Validators.email,
      prefixIcon: const Icon(Icons.email_outlined),
    );
  }

  static Widget password({
    required TextEditingController controller,
    String hintText = 'Enter your password',
    String? labelText,
    bool isStrict = false,
  }) {
    return ValidatedTextField(
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      obscureText: true,
      validator: isStrict 
          ? Validators.password
          : Validators.simplePassword,
      prefixIcon: const Icon(Icons.lock_outline),
    );
  }

  static Widget confirmPassword({
    required TextEditingController controller,
    required TextEditingController originalPasswordController,
    String hintText = 'Confirm your password',
    String? labelText,
  }) {
    return ValidatedTextField(
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      obscureText: true,
      validator: (value) => Validators.confirmPassword(value, originalPasswordController.text),
      prefixIcon: const Icon(Icons.lock_outline),
    );
  }

  static Widget name({
    required TextEditingController controller,
    String hintText = 'Enter your name',
    String? labelText,
  }) {
    return ValidatedTextField(
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      textCapitalization: TextCapitalization.words,
      validator: Validators.name,
      prefixIcon: const Icon(Icons.person_outline),
    );
  }

  static Widget taskTitle({
    required TextEditingController controller,
    String hintText = 'Enter task title',
    String? labelText,
  }) {
    return ValidatedTextField(
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      textCapitalization: TextCapitalization.sentences,
      validator: Validators.taskTitle,
    );
  }

  static Widget taskDescription({
    required TextEditingController controller,
    String hintText = 'Enter task description (optional)',
    String? labelText,
    int maxLines = 3,
  }) {
    return ValidatedTextField(
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      maxLines: maxLines,
      textCapitalization: TextCapitalization.sentences,
      validator: Validators.taskDescription,
    );
  }

  static Widget categoryName({
    required TextEditingController controller,
    String hintText = 'Enter category name',
    String? labelText,
  }) {
    return ValidatedTextField(
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      textCapitalization: TextCapitalization.words,
      validator: Validators.categoryName,
      prefixIcon: const Icon(Icons.category_outlined),
    );
  }

  static Widget phoneNumber({
    required TextEditingController controller,
    String hintText = 'Enter phone number',
    String? labelText,
  }) {
    return ValidatedTextField(
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      keyboardType: TextInputType.phone,
      validator: Validators.phoneNumber,
      prefixIcon: const Icon(Icons.phone_outlined),
    );
  }

  static Widget url({
    required TextEditingController controller,
    String hintText = 'Enter URL',
    String? labelText,
  }) {
    return ValidatedTextField(
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      keyboardType: TextInputType.url,
      validator: (value) => value.validateUrl,
      prefixIcon: const Icon(Icons.link_outlined),
    );
  }
}

// Extension for validator shortcuts
extension ValidatorShortcuts on String? {
  String? confirmPassword(String? originalPassword) {
    return Validators.confirmPassword(this, originalPassword);
  }
}
