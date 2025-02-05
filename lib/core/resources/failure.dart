abstract class Failure {
  final String message;

  Failure(this.message);
}

// Server Failure (e.g., API errors)
class ServerFailure extends Failure {
  ServerFailure(super.message);
}

// Network Failure (e.g., no internet connection)
class NetworkFailure extends Failure {
  NetworkFailure() : super("No internet connection. Please try again.");
}

// Validation Failure (e.g., incorrect user input)
class ValidationFailure extends Failure {
  ValidationFailure(super.message);
}

// Unknown Failure (e.g., unexpected errors)
class UnknownFailure extends Failure {
  UnknownFailure(super.message);
}
