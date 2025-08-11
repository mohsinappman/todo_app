import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../router/route_names.dart';
import '../../../state/base_state.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/color_parser.dart';
import '../../../widgets/custom_loading_indicator.dart';
import '../cubits/get_categories_cubit.dart';
import '../models/category_model.dart';

class ViewCategoriesWidget extends StatefulWidget {
  final ValueChanged<CategoryModel> onCategorySelected;

  const ViewCategoriesWidget({super.key, required this.onCategorySelected});

  @override
  State<ViewCategoriesWidget> createState() => _ViewCategoriesWidgetState();
}

class _ViewCategoriesWidgetState extends State<ViewCategoriesWidget> {
  late GetCategoriesCubit _getCategoriesCubit;
  CategoryModel? selectedCategory;

  @override
  void initState() {
    super.initState();
    initCubits();
    callCubits();
  }

  initCubits() {
    _getCategoriesCubit = context.read<GetCategoriesCubit>();
  }

  callCubits() {
    _getCategoriesCubit.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCategoriesCubit, BaseState>(
      builder: (context, state) {
        if (state is SuccessState<List<CategoryModel>>) {
          List<CategoryModel> categories = state.data!;
          return SingleChildScrollView(
            child: Wrap(
              spacing: 49.w,
              runSpacing: 16.h,
              children: [
                SizedBox(
                  height: 90.h,
                  width: 64.w,
                  child: GestureDetector(
                    onTap: () {
                      context.push(RouteNames.createCategoryScreen);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 64.h,
                          width: 64.w,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors.greenColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: AppColors.darkGreenColor,
                                size: 40.sp,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'Create New',
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall!.copyWith(fontSize: 12.sp),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ...List.generate(
                  categories.length,
                  (index) => GestureDetector(
                    onTap: () {
                      widget.onCategorySelected(categories[index]);
                      setState(() {
                        selectedCategory = categories[index];
                      });
                    },
                    child: SizedBox(
                      height: 90.h,
                      width: 64.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 64.h,
                            width: 64.w,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: parseColorString(
                                  colorString: categories[index].colorHex,
                                ),
                                border: Border.all(
                                  color: selectedCategory == categories[index]
                                      ? AppColors.primaryColor
                                      : Colors.transparent,
                                  width: 6,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(child: Icon(Icons.ac_unit)),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              categories[index].name!,
                              style: Theme.of(context).textTheme.titleSmall,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is UnknownErrorState) {
          return Center(
            child: Text(
              state.error ?? '',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          );
        }
        return const Center(
          child: LoadingIndicator(color: AppColors.primaryColor),
        );
      },
    );
  }
}
