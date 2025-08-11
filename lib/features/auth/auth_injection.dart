import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/features/auth/presentation/cubits/sign_up_cubit.dart';

import 'data/repositories/auth_repository_impl.dart';
import 'domain/usecases/sign_in_usecase.dart';
import 'domain/usecases/sign_up_usecase.dart';

final supabaseClient = Supabase.instance.client;
final authRepository = AuthRepositoryImpl(supabaseClient);
final signUpUseCase = SignUpUseCase(authRepository);
final signInUseCase = SignInUseCase(authRepository);

final signUpCubit = SignUpCubit(signUpUseCase);