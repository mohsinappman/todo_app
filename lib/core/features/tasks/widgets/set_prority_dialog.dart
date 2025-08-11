import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../themes/app_colors.dart';
import '../../../utils/app_assets.dart';
import '../../../widgets/custom_elevated_button.dart';

class SetPriorityDialog extends StatefulWidget {
  final ValueChanged<int> onPrioritySelected;

  const SetPriorityDialog({super.key, required this.onPrioritySelected});

  @override
  State<SetPriorityDialog> createState() => _SetPriorityDialogState();
}

class _SetPriorityDialogState extends State<SetPriorityDialog> {
  int? selectedPriority;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360.h,
      width: 327.w,
      child: Column(
        children: [
          Text(
            'Task Priority',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
          ),
          Divider(),
          22.verticalSpace,
          SingleChildScrollView(
            child: Wrap(
              spacing: 16.w,
              runSpacing: 16.h,
              children: List.generate(
                9,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPriority = index;
                    });
                  },
                  child: SizedBox(
                    height: 64.h,
                    width: 64.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 64.h,
                          width: 64.w,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: selectedPriority == index
                                  ? AppColors.primaryColor
                                  : AppColors.blackColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(AppAssets.flagIcon),
                                  Text(
                                    index.toString(),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          18.verticalSpace,
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: CustomElevatedButton(
                  onPressed: () {
                    if (selectedPriority != null) {
                      widget.onPrioritySelected(selectedPriority! + 1);
                      context.pop();
                    }
                  },
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
