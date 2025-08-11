import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/shared/utils/extensions.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/themes/app_colors.dart';
import '../../../../shared/presentation/widgets/custom_loading_indicator.dart';
import '../../../../shared/state/base_state.dart';
import '../../../../shared/utils/color_parser.dart';
import '../../domain/entities/task_entity.dart';
import '../cubits/get_tasks_cubit.dart';
import 'empty_task_widget.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({super.key});

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  late GetTasksCubit _getTasksCubit;

  @override
  void initState() {
    super.initState();
    _getTasksCubit = context.read<GetTasksCubit>();
    _getTasksCubit.getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTasksCubit, BaseState>(
      builder: (context, state) {
        return _buildTasksList(state);
      },
    );
  }

  Widget _buildTasksList(BaseState state) {
    if (state is LoadingState) {
      return SliverFillRemaining(
        child: Center(child: LoadingIndicator(color: AppColors.primaryColor)),
      );
    }

    if (state is SuccessState<List<TaskEntity>>) {
      final tasks = state.data ?? [];

      if (tasks.isEmpty) {
        return EmptyTaskWidget();
      }

      return SliverPadding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 0.h),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final task = tasks[index];
            return Padding(
              padding: EdgeInsets.only(top: index > 0 ? 16.h : 0.h),
              child: _buildTaskCard(task),
            );
          }, childCount: tasks.length),
        ),
      );
    }

    if (state is ErrorState) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64.sp, color: Colors.red),
              16.verticalSpace,
              Text(
                'Error loading tasks',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              8.verticalSpace,
              Text(
                state.error ?? 'Unknown error occurred',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              16.verticalSpace,
              ElevatedButton(
                onPressed: () => _getTasksCubit.getAllTasks(),
                child: Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return SliverFillRemaining(
      child: Center(
        child: Text(
          'Welcome! Start by creating your first task.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildTaskCard(TaskEntity task) {
    return SizedBox(
      height: 72.h,
      width: double.infinity,
      child: GestureDetector(
        onTap: () => context.push(RouteNames.updateTaskScreen),
        child: DecoratedBox(
          decoration: BoxDecoration(color: AppColors.blackColor),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.radio_button_off, color: AppColors.white),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(child: Text(task.title ?? '')),
                      8.verticalSpace,
                      Flexible(
                        child: Text(
                          task.dueDateTime?.toHumanReadable() ?? 'No due date',
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 29.h,
                              maxWidth: 87.w,
                            ),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: parseColorString(
                                  colorString: task.category?.colorHex,
                                ),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 10.h,
                                ),
                                child: RichText(
                                  // maxLines: 1,
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: Icon(
                                          Icons.calendar_month,
                                          size: 16.sp,
                                        ),
                                      ),
                                      WidgetSpan(child: 4.horizontalSpace),
                                      TextSpan(
                                        text:
                                            task.category?.name ??
                                            'No Category',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          12.horizontalSpace,
                          Flexible(
                            child: SizedBox(
                              width: 42.w,
                              height: 29.h,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
                                  border: Border.all(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                child: Center(
                                  child: Text(task.taskPriority.toString()),
                                ),
                              ),
                            ),
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
    );
  }
}
