import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/shared/utils/validators.dart';
import 'package:todo_app/shared/presentation/widgets/custom_input_field.dart';
import '../../../../../app/themes/app_colors.dart';
import '../../../../shared/presentation/widgets/custom_error_handler.dart';
import '../../../../shared/presentation/widgets/custom_loading_indicator.dart';
import '../../../../shared/presentation/widgets/date_picker.dart';
import '../../../../shared/state/base_state.dart';
import '../../../../shared/utils/app_assets.dart';
import '../../../../shared/presentation/widgets/custom_dialog.dart';
import '../../../../shared/presentation/widgets/custom_snack_bar.dart';
import '../../../category/domain/entities/category_entity.dart';
import '../../../category/presentation/views/view_categories_dialog.dart';
import '../../data/models/task_model.dart';
import '../cubits/create_task_cubit.dart';
import '../cubits/get_tasks_cubit.dart';
import '../widgets/set_prority_dialog.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  late CreateTaskCubit _createTaskCubit;
  late GetTasksCubit _getTasksCubit;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDateTime;
  CategoryEntity? selectedCategory;
  int? selectedPriority;

  @override
  void initState() {
    super.initState();
    initCubits();
  }

  initCubits() {
    _createTaskCubit = context.read<CreateTaskCubit>();
    _getTasksCubit = context.read<GetTasksCubit>();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      List<String> missingFields = [];

      if (_selectedDateTime == null) {
        missingFields.add('Date and Time');
      }

      if (selectedCategory == null || selectedCategory!.id == null) {
        missingFields.add('Category');
      }

      if (selectedPriority == null) {
        missingFields.add('Priority');
      }

      if (missingFields.isNotEmpty) {
        String errorMessage = 'Please select: ${missingFields.join(', ')}';
        showCustomSnackBar(context, errorMessage);
        return;
      }

      _createTaskCubit.createTask(
        task: TaskModel(
          title: _titleController.text,
          description: _descriptionController.text,
          dueDateTime: _selectedDateTime!,
          categoryId: selectedCategory!.id!,
          taskPriority: selectedPriority!,
          isCompleted: false,
          fkUserId: Supabase.instance.client.auth.currentUser!.id,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateTaskCubit, BaseState>(
          listener: (context, state) {
            if (state is SuccessState) {
              _getTasksCubit.getAllTasks();
              context.pop();
            }
            errorHandler(context: context, state: state);
          },
        ),
      ],
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add Task', style: Theme.of(context).textTheme.titleLarge),
                14.verticalSpace,
                CustomInputField(
                  hintText: 'Title',
                  fieldTitle: '',
                  controller: _titleController,
                  showTitle: false,
                  validator: Validators.required,
                ),
                14.verticalSpace,
                CustomInputField(
                  hintText: 'Description',
                  fieldTitle: '',
                  controller: _descriptionController,
                  showTitle: false,
                  validator: Validators.required,
                ),
                35.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (_) => CustomDateTimePicker(
                            initialDate: _selectedDateTime,
                            onDateTimeSelected: (dateTime) async {
                              _selectedDateTime = dateTime;
                            },
                          ),
                        );
                      },
                      icon: Icon(Icons.timer),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => CustomDialog(
                            child: ViewCategoriesDialog(
                              onCategorySelected: (category) {
                                selectedCategory = category;
                              },
                            ),
                          ),
                        );
                      },
                      child: Image.asset(AppAssets.tagIcon),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => CustomDialog(
                            child: SetPriorityDialog(
                              onPrioritySelected: (priority) {
                                selectedPriority = priority;
                              },
                            ),
                          ),
                        );
                      },
                      child: Image.asset(AppAssets.flagIcon),
                    ),
                    100.horizontalSpace,
                    BlocBuilder<CreateTaskCubit, BaseState>(
                      builder: (context, state) {
                        if (state is LoadingState) {
                          return LoadingIndicator(
                            color: AppColors.primaryColor,
                          );
                        }
                        return GestureDetector(
                          onTap: _onSubmit,
                          child: Image.asset(AppAssets.sendIcon),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
