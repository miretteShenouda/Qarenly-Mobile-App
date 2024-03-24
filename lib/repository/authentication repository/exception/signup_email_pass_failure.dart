class SignUpWithEmailAndPasswordFailure {
  final String message;

  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case "weak password":
        return SignUpWithEmailAndPasswordFailure(
          'The password provided is too weak.',
        );
      case "invalid email":
        return SignUpWithEmailAndPasswordFailure(
          'The email is badly formatted.',
        );
      case "email-already-in-use":
        return SignUpWithEmailAndPasswordFailure(
            'The email is already in use.');
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}
