mixin AuthExceptionHandler {
  void handleAndThrowAuthException(dynamic error) {
    final message = error.toString();

    if (message.contains('Invalid login credentials')) {
      throw AuthException('Invalid email or password.');
    } else if (message.contains('User already registered')) {
      throw AuthException('This email is already registered.');
    } else if (message.contains('Email not confirmed')) {
      throw AuthException('Please confirm your email address.');
    } else if (message.contains('Network error')) {
      throw AuthException('Please check your internet connection.');
    } else if (message.contains('invalid email')) {
      throw AuthException('Please enter a valid email address.');
    }

    throw AuthException('An unknown error occurred. Please try again.');
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';
}
