import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'dart:ui';

class AuthenticationController {
  FirebaseAuth _auth = FirebaseAuth.instance;

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
