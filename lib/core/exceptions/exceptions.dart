// Custom Exception class for API error
class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => message;
}

// Custom Exception class for Internet error
class InternetException implements Exception {}

// Custom Exception class for timeout error
class TimeoutException implements Exception {}

// Custom Exception class for timeout error
class VersionException implements Exception {}