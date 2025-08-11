import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../themes/app_colors.dart';
import '../../../utils/app_assets.dart';

class UpdateTaskScreen extends StatefulWidget {
  const UpdateTaskScreen({super.key});

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.close),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.repeat))],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.radio_button_off),
                ),
                21.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Do Math Homework',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      15.verticalSpace,
                      Text(
                        'Dp chapter 2 to 5 for next week',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              ],
            ),
            _taskTile(
              taskIcon: Icon(Icons.timer),
              taskRowName: 'Task Time:',
              child: Text('Today At 16:45'),
            ),
            _taskTile(
              taskIcon: Image.asset(AppAssets.tagIcon),
              taskRowName: 'Task Category:',
              child: Text('Today At 16:45'),
            ),
            _taskTile(
              taskIcon: Image.asset(AppAssets.flagIcon),
              taskRowName: 'Task Priority:',
              child: Text('Today At 16:45'),
            ),
            29.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.delete, color: AppColors.errorColor),
                11.horizontalSpace,
                Text(
                  'Delete Task',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.errorColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _taskTile({
    required Widget taskIcon,
    required String taskRowName,
    required Widget child,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 34.h),
      child: SizedBox(
        height: 37.h,
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  taskIcon,
                  8.horizontalSpace,
                  Text(
                    taskRowName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            SizedBox(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.blackColor,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
