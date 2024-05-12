import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qarenly/common/theme/theme_helper.dart';

// class ResetPasswordScreen extends StatefulWidget {
//   final String email;

//   const ResetPasswordScreen({Key? key, required this.email}) : super(key: key);

//   @override
//   _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
// }

// class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController =
//       TextEditingController();

//   bool _isLoading = false;
//   String _errorMessage = '';

//   void _resetPassword() async {
//     if (_passwordController.text != _confirmPasswordController.text) {
//       setState(() {
//         _errorMessage = 'Passwords do not match';
//       });
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//       _errorMessage = ''; // Clear previous error message
//     });

//     try {
//       await FirebaseAuth.instance.confirmPasswordReset(
//         code: widget.email,
//         newPassword: _passwordController.text,
//       );

//       // Password reset successful, navigate to login screen or home screen
//       // Example:
//       // Navigator.of(context).pushReplacementNamed('/login');
//     } on FirebaseAuthException catch (error) {
//       String errorMessage = '';

//       if (error.code == 'invalid-action-code') {
//         errorMessage =
//             'The password reset link is invalid, expired, or has already been used.';
//       } else {
//         errorMessage = 'An unexpected error occurred. Please try again later.';
//       }

//       setState(() {
//         _errorMessage = errorMessage;
//       });
//     } catch (error) {
//       setState(() {
//         _errorMessage = 'An unexpected error occurred. Please try again later.';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Reset Password'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Enter your new password:',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: InputDecoration(
//                 hintText: 'New Password',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               controller: _confirmPasswordController,
//               obscureText: true,
//               decoration: InputDecoration(
//                 hintText: 'Confirm Password',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _isLoading ? null : _resetPassword,
//               child: _isLoading
//                   ? CircularProgressIndicator()
//                   : Text('Reset Password'),
//             ),
//             if (_errorMessage.isNotEmpty)
//               Text(
//                 _errorMessage,
//                 style: TextStyle(color: Colors.red),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class MailScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.5, 0),
            end: Alignment(0.5, 1),
            colors: [
              theme.colorScheme.onPrimary,
              appTheme.teal100Ec,
              theme.colorScheme.primary.withOpacity(0.93),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30 * 4),
                Text("Forgot Password", style: theme.textTheme.displayMedium),
                SizedBox(height: 5),
                Text(
                  "Please enter your email to reset your password",
                  style: TextStyle(
                    color: Colors.orange[200],
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            label: Text("Email"),
                            hintText: "Email",
                            prefixIcon: Icon(Icons.mail_outline_rounded),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final email = _emailController.text;
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: email);
                            Get.snackbar(
                              "Reset Link Sent",
                              "A password reset link has been sent to $email",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            // Get.to(ResetPasswordScreen(
                            //     email: email)); // Pass email as named parameter
                          },
                          child: const Text(
                            "Reset your password",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
