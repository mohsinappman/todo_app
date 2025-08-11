import 'package:supabase_flutter/supabase_flutter.dart';

import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<AuthResponse?> call({
    required String email,
    required String password,
  }) {
    return repository.signUp(email: email, password: password);
  }
}