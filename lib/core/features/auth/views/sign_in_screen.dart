import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/router/route_names.dart';
import '../../../state/base_state.dart';
import '../../../utils/app_assets.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_error_handler.dart';
import '../../../widgets/custom_loading_indicator.dart';
import '../../../widgets/custom_outlined_button.dart';
import '../cubits/sign_in_cubit.dart';
import '../widgets/custom_input_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late SignInCubit _signInCubit;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initCubits();
  }

  initCubits() {
    _signInCubit = context.read<SignInCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    emailController!.dispose();
    passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignInCubit, BaseState>(
          listener: (context, state) {
            if (state is SuccessState) {
              context.pushReplacement(RouteNames.homeBaseScreen);
            }
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
                    'Login',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  53.verticalSpace,
                  CustomInputField(
                    fieldTitle: 'Email',
                    hintText: 'Enter your email',
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      if (value.length < 3) {
                        return 'Username must be at least 3 characters long';
                      }
                      return null;
                    },
                  ),
                  25.verticalSpace,
                  CustomInputField(
                    fieldTitle: 'Password',
                    hintText: 'Enter your password',
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  69.verticalSpace,
                  BlocBuilder<SignInCubit, BaseState>(
                    builder: (context, state) {
                      print('state is $state');
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
                            _signInCubit.signIn(
                              email: emailController!.text,
                              password: passwordController!.text,
                            );
                          }
                        },
                        child: Text('Login'),
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
                        text: 'Dont\'t have an account?',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.lightGrey,
                        ),
                        children: [
                          TextSpan(
                            text: ' Register',
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(color: AppColors.white),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.pushReplacement('/');
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
