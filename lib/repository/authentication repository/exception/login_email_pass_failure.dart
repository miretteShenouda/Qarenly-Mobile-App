// class LogInWithEmailAndPasswordFailure extends Exception {
//   final String message;
//   const LogInWithEmailAndPasswordFailure([
//     this.message = 'An unknown exception occurred.',
//   ]);
//   factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
//     switch (code) {
//       case 'user-not-found':
//         return LogInWithEmailAndPasswordFailure(
//           'No user found for that email.',
//         );
//       case 'wrong-password':
//         return LogInWithEmailAndPasswordFailure(
//           'Wrong password provided for that user.',
//         );
//       default:
//         return LogInWithEmailAndPasswordFailure();
//     }
//   }
//   @override
//   String toString() => message;