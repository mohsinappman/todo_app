import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/features/auth/cubits/sign_in_cubit.dart';
import '../core/features/auth/cubits/sign_up_cubit.dart';
import '../core/features/auth/services/auth_service.dart';
import '../core/features/base/cubit/nav_bar_cubit.dart';
import '../core/features/category/cubits/create_category_cubit.dart';
import '../core/features/category/cubits/get_categories_cubit.dart';
import '../core/features/category/services/category_service.dart';
import '../core/features/tasks/cubits/create_task_cubit.dart';
import '../core/features/tasks/cubits/get_tasks_cubit.dart';
import '../core/features/tasks/services/task_service.dart';
import '../core/shared/cubits/image_picker_cubit.dart';
import '../core/shared/cubits/image_upload_cubit.dart';
import '../core/shared/services/image_upload_service.dart';

List<BlocProvider> providers = [
  BlocProvider<SignInCubit>(
    create: (context) =>
        SignInCubit(AuthServiceRepository(Supabase.instance.client)),
  ),
  BlocProvider<SignUpCubit>(
    create: (context) =>
        SignUpCubit(AuthServiceRepository(Supabase.instance.client)),
  ),
  BlocProvider<NavBarCubit>(create: (context) => NavBarCubit()),
  BlocProvider<CreateCategoryCubit>(
    create: (context) => CreateCategoryCubit(
      CategoryServiceRepository(Supabase.instance.client),
    ),
  ),
  BlocProvider<CreateTaskCubit>(
    create: (context) =>
        CreateTaskCubit(TaskServiceRepository(Supabase.instance.client)),
  ),
  BlocProvider<GetTasksCubit>(
    create: (context) =>
        GetTasksCubit(TaskServiceRepository(Supabase.instance.client)),
  ),
  BlocProvider<ImagePickerCubit>(create: (context) => ImagePickerCubit()),
  BlocProvider<ImageUploadCubit>(
    create: (context) => ImageUploadCubit(
      ImageUploadServiceRepository(Supabase.instance.client),
    ),
  ),
  BlocProvider<GetCategoriesCubit>(
    create: (context) =>
        GetCategoriesCubit(CategoryServiceRepository(Supabase.instance.client)),
  ),
];
