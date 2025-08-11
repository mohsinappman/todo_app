import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/state/base_state.dart';
import '../cubits/get_tasks_cubit.dart';
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
