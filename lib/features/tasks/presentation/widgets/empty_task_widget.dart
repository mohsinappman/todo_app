import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/utils/app_assets.dart';

class EmptyTaskWidget extends StatelessWidget {
  const EmptyTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.emptyDoodle, height: 227.h, width: 227.w),
            16.verticalSpace,
            Text(
              'What do you want to do today?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            8.verticalSpace,
            Text(
              'Tap + to add your task',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
