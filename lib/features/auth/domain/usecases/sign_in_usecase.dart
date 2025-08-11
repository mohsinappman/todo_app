import 'package:supabase_flutter/supabase_flutter.dart';

import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<AuthResponse?> call({
    required String email,
    required String password,
  }) {
    return repository.signIn(email: email, password: password);
  }
}