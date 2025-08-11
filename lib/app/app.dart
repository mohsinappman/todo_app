import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'themes/app_theme.dart';
import '../core/di/providers.dart';
import 'router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp.router(
            title: 'Todo app',
            theme: customTheme,
            routerConfig:
            AppRouter.router, // Use the GoRouter from app_router.dart
          );
        },
      ),
    );
  }
}