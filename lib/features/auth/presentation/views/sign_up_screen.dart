import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/features/auth/presentation/cubits/sign_in_cubit.dart';
import '../../../../app/router/route_names.dart';
import '../../../../app/themes/app_colors.dart';
import '../../../../shared/presentation/widgets/custom_elevated_button.dart';
import '../../../../shared/presentation/widgets/custom_error_handler.dart';
import '../../../../shared/presentation/widgets/custom_loading_indicator.dart';
import '../../../../shared/state/base_state.dart';
import '../../../../shared/utils/app_assets.dart';
import '../../../../shared/presentation/widgets/custom_outlined_button.dart';
import '../cubits/sign_up_cubit.dart';
import '../../../../shared/utils/validators.dart';
import '../../../../shared/presentation/widgets/custom_input_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late SignUpCubit _signUpCubit;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initCubits();
  }

  initCubits() {
    _signUpCubit = context.read<SignUpCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    emailController!.dispose();
    passwordController!.dispose();
    confirmPasswordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignInCubit, BaseState>(
          listener: (context, state) {
            errorHandler(context: context, state: state);
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Register',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  23.verticalSpace,
                  CustomInputField(
                    fieldTitle: 'Email',
                    hintText: 'Enter your email',
                    controller: emailController,
                    validator: Validators.email,
                    showTitle: true,
                  ),
                  25.verticalSpace,
                  CustomInputField(
                    fieldTitle: 'Password',
                    hintText: 'Enter your password',
                    controller: passwordController,
                    validator: Validators.password,
                    showTitle: true,
                  ),
                  25.verticalSpace,
                  CustomInputField(
                    fieldTitle: 'Confirm Password',
                    hintText: 'Confirm your password',
                    controller: confirmPasswordController,
                    validator: (value) => Validators.confirmPassword(value, passwordController?.text),
                    showTitle: true,
                  ),
                  40.verticalSpace,
                  BlocBuilder<SignUpCubit, BaseState>(
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return CustomElevatedButton(
                          onPressed: () {},
                          child: Center(
                            child: LoadingIndicator(color: AppColors.white),
                          ),
                        );
                      }
                      return CustomElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _signUpCubit.signUp(
                              email: emailController!.text,
                              password: passwordController!.text,
                            );
                          }
                        },
                        child: Text('Register'),
                      );
                    },
                  ),
                  18.verticalSpace,
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      4.horizontalSpace,
                      Text('or'),
                      4.horizontalSpace,
                      Expanded(child: Divider()),
                    ],
                  ),
                  24.verticalSpace,
                  CustomOutlinedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppAssets.googleIcon,
                          height: 20.h,
                          width: 20.w,
                        ),
                        10.horizontalSpace,
                        Text('Register with Google'),
                      ],
                    ),
                  ),
                  17.verticalSpace,
                  CustomOutlinedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppAssets.appleIcon,
                          height: 24.h,
                          width: 24.w,
                        ),
                        10.horizontalSpace,
                        Text('Register with Apple'),
                      ],
                    ),
                  ),
                  46.verticalSpace,
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account?',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.lightGrey,
                        ),
                        children: [
                          TextSpan(
                            text: ' Login',
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(color: AppColors.white),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.pushReplacement(
                                  RouteNames.signInScreen,
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
