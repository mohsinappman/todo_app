import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/extensions.dart';
import '../../../state/base_state.dart';
import '../../../utils/color_parser.dart';
import '../../../widgets/custom_loading_indicator.dart';
import '../../../themes/app_colors.dart';
import '../cubits/get_tasks_cubit.dart';
import '../models/task_model.dart';
import '../widgets/tasks_widget.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
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
        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(
                left: 24.w,
                right: 24.w,
                top: 16.h,
                bottom: 0.h,
              ),
              sliver: SliverAppBar(
                flexibleSpace: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for your task...',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            TasksWidget(),
          ],
        );
      },
    );
  }
}
