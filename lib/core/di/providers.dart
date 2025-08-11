import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/auth_injection.dart';
import '../../features/auth/presentation/cubits/sign_in_cubit.dart';
import '../../features/auth/presentation/cubits/sign_up_cubit.dart';
import '../../features/base/presentation/cubit/nav_bar_cubit.dart';
import '../../features/category/category_injection.dart';
import '../../features/category/presentation/cubits/create_category_cubit.dart';
import '../../features/category/presentation/cubits/get_categories_cubit.dart';
import '../../features/tasks/presentation/cubits/create_task_cubit.dart';
import '../../features/tasks/presentation/cubits/get_tasks_cubit.dart';
import '../../features/tasks/task_injection.dart';
import '../../shared/injections/image_upload_injection.dart';
import '../../shared/presentation/cubits/image_picker_cubit.dart';
import '../../shared/presentation/cubits/image_upload_cubit.dart';

List<BlocProvider> providers = [
  BlocProvider<SignInCubit>(create: (context) => SignInCubit(signInUseCase)),
  BlocProvider<SignUpCubit>(create: (context) => SignUpCubit(signUpUseCase)),
  BlocProvider<NavBarCubit>(create: (context) => NavBarCubit()),
  BlocProvider<CreateCategoryCubit>(
    create: (context) => CreateCategoryCubit(createCategoryUsecase),
  ),
  BlocProvider<CreateTaskCubit>(
    create: (context) =>
        CreateTaskCubit(createTaskUsecase),
  ),
  BlocProvider<GetTasksCubit>(
    create: (context) =>
        GetTasksCubit(getAllTasksUseCase),
  ),
  BlocProvider<ImagePickerCubit>(create: (context) => ImagePickerCubit()),
  BlocProvider<ImageUploadCubit>(
    create: (context) => ImageUploadCubit(
      imageUploadUsecase,
    ),
  ),
  BlocProvider<GetCategoriesCubit>(
    create: (context) =>
        GetCategoriesCubit(getAllCategoriesUseCase),
  ),
];
