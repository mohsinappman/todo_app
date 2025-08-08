import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_exception_mixin.dart';

abstract class AuthService {
  Future<AuthResponse?> signUp({
    required String email,
    required String password,
  });

  Future<AuthResponse?> signIn({
    required String email,
    required String password,
  });
}

class AuthServiceRepository with AuthExceptionHandler implements AuthService {
  final SupabaseClient supabase;

  AuthServiceRepository(this.supabase);

  @override
  Future<AuthResponse?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      return response;
    } catch (error) {
      handleAndThrowAuthException(error);
      return null;
    }
  }

  @override
  Future<AuthResponse?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (error) {
      handleAndThrowAuthException(error);
      return null;
    }
  }
}
