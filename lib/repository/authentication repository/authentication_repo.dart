import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qarenly/repository/authentication%20repository/exception/login_email_pass_failure.dart';
import 'package:qarenly/repository/authentication%20repository/exception/signup_email_pass_failure.dart';
import 'package:qarenly/view/homepage_screen/homepage_screen.dart';
import 'package:qarenly/view/login_page_screen/login_page_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepo extends GetxController {
  static AuthenticationRepo get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => LoginPageScreen())
        : Get.offAll(() => HomepageScreen());
  }

/*---------------------------------AUTHENTICATION------------------------------------------*/
  Future<Object?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => HomepageScreen())
          : Get.to(() => LoginPageScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      return ex.message;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      return ex.message;
    }
    return null;
  }

  Future<String?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = LogInWithEmailAndPasswordFailure.Code(e.code);
      return ex.message;
    } catch (_) {
      const ex = LogInWithEmailAndPasswordFailure();
      return ex.message;
    }
    return null;
  }

  Future<void> logout() async => await _auth.signOut();

/*----------------------------------GOOGLE-----------------------------------------*/
  Future<User?> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (error) {
      print(error);
    }
    return null;
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

/*------------------------------FACEBOOK---------------------------------------------*/
  Future<void> loginWithFacebook(BuildContext context) async {
    try {
      final LoginResult result =
          await FacebookAuth.instance.login(permissions: ['email']);
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        // Check if the user is already equal (already signed in)
        if (isUserEqual(result)) {
          // If the user is already signed in, navigate to the homepage
          Navigator.pushNamed(context, '/homepage_screen');
          return; // Exit the method to prevent further navigation
        }
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        // Check if the user is signing in for the first time
        if (userCredential.additionalUserInfo?.isNewUser ?? false) {
          // If the user is new, navigate to the profile setup screen
          print('new user');
          Navigator.pushNamed(context, '/homepage_screen');
        } else {
          //already registered, navigate to the home screen
          print('bla  user already exist');

          Navigator.pushNamed(context, '/homepage_screen');
        }
      } else {
        // Handle login failure
        print('Facebook login failed: ${result.message}');
      }
    } catch (e) {
      // Handle errors
      print('Error logging in with Facebook: $e');
    }
  }

  Future<void> signUpWithFacebook(BuildContext context) async {
    try {
      final LoginResult result =
          await FacebookAuth.instance.login(permissions: ['email']);
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.pushReplacementNamed(context,
            '/homepage_screen'); // Navigate to home screen after successful login
      } else {
        print(result.message);
      }
    } catch (e) {
      print('Error signing in with Facebook: $e');
    }
  }

  Future<void> signOutFacebook(BuildContext context) async {
    try {
      await _auth.signOut();
      await FacebookAuth.instance.logOut();
      print('User signed out successfully');
      Navigator.pushNamed(context, '/login_page_screen');
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  bool isUserEqual(facebookAuthResponse) {
    var firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      var providerData = firebaseUser.providerData;
      for (var i = 0; i < providerData.length; i++) {
        if (providerData[i].providerId == FacebookAuthProvider.PROVIDER_ID &&
            providerData[i].uid == facebookAuthResponse.userID) {
          // We don't need to re-auth the Firebase connection.
          return true;
        }
      }
    }
    return false;
  }
}
