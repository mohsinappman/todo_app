import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../models/category_model.dart';
import '../widgets/view_categories_widget.dart';

class ViewCategoriesDialog extends StatefulWidget {
  final ValueChanged<CategoryModel> onCategorySelected;
  const ViewCategoriesDialog({super.key,
  required this.onCategorySelected,
  });

  @override
  State<ViewCategoriesDialog> createState() => _ViewCategoriesDialogState();
}

class _ViewCategoriesDialogState extends State<ViewCategoriesDialog> {
  CategoryModel? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 556.h,
      width: 327.w,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          children: [
            Text(
              'Choose Category',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
            ),
            Divider(),
            15.verticalSpace,
            Expanded(child: ViewCategoriesWidget(
              onCategorySelected: (category) {
               selectedCategory = category;
              },
            )),
            SizedBox(
              width: 289.w,
              child: CustomElevatedButton(
                child: Text('Add Category'),
                onPressed: () {
                  if(selectedCategory != null) {
                    widget.onCategorySelected(selectedCategory!);
                  }
                  context.pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
