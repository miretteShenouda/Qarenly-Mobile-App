import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/model/user_model.dart';
import 'package:qarenly/repository/authentication%20repository/exception/login_email_pass_failure.dart';
import 'package:qarenly/view/homepage_screen/homepage_screen.dart';
import 'package:qarenly/view/login_page_screen/login_page_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class AuthenticationRepo extends GetxController {
  static AuthenticationRepo get instance => Get.find();
  final _auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;
  User? currentUser;
  UserModel? userData;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(
        _auth.authStateChanges()); // Listen to authentication state changes
    ever(firebaseUser, _handleUserAuthentication);
    ever(firebaseUser, _setInitialScreen);

    ///firebaseUser.bindStream(_auth.userChanges());
  }

  _handleUserAuthentication(User? user) async {
    if (user != null && user.isAnonymous) {
      print("gowa el anonymous");
      currentUser = user;
      print(currentUser!.displayName);
      print(currentUser!.uid);
      userData = UserModel(
        id: currentUser!.uid,
        username: "Guest",
        password: "",
        email: "",
        savedItems: [],
        notificationToken: null,
      );
      print(" User Data User Name : ${userData!.username}");
      print(" User Data id : ${userData!.id}");
      Get.offAll(() => LoginPageScreen());
    } else if (user != null) {
      print("gowa el handleuser");
      currentUser = user;
      print(currentUser!.isAnonymous);
      print(user.uid);
      print(currentUser!.displayName);
      // If user is not null, fetch user data from Firestore
      // /  _fetchUserData(user.uid);
      print("Fetching User Data ==========");
      userData = await fetchUserData();
      print("After Fetching the user Data");
    } else {
      // If user is null, navigate to login page
      Get.offAll(() => LoginPageScreen());
    }
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => LoginPageScreen())
        // : Get.offAll(() => LoginPageScreen());
        : Get.offAll(() => HomepageScreen(user));
  }

/*---------------------------------AUTHENTICATION------------------------------------------*/
  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      firebaseUser.value != null
          ? Get.offAll(() => HomepageScreen(user!))
          : Get.to(() => LoginPageScreen());
      // User? user = userCredential.user;
      return user;
    } catch (e) {
      print('Error registering user: $e');
    }
    return null;
  }

  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      currentUser = userCredential.user;
      return true;
    } on FirebaseAuthException catch (e) {
      final ex = LogInWithEmailAndPasswordFailure.Code(e.code);
    } catch (_) {
      const ex = LogInWithEmailAndPasswordFailure();
    }
    return false;
  }

  Future<void> logout() async => await _auth.signOut();

  Future<bool> enterAsGuest() async {
    try {
      final UserCredential userCredential = await _auth.signInAnonymously();
      currentUser = userCredential.user;
      print(currentUser!.uid);
      userData = UserModel(
        id: currentUser!.uid,
        username: "Guest",
        password: "",
        email: "",
        savedItems: [],
        notificationToken: null,
      );
      print(" User Data User Name : ${userData!.username}");
      print("User signed in anonymously: ${currentUser!.uid}");
      return true;
    } catch (e) {
      print("Error signing in anonymously: ${e}");
    }
    return false;
  }

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

        UserModel userData = UserModel(
          id: userCredential.user!.uid,
          username: userCredential.user!.displayName!,
          email: userCredential.user!.email!,
          password: '',
          savedItems: [],
        );

        await InsertUser(userData);
        currentUser = userCredential.user;
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
          Navigator.pushNamed(context, AppRoutes.homepageScreen);
          return; // Exit the method to prevent further navigation
        }
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        // Check if the user is signing in for the first time
        if (userCredential.additionalUserInfo?.isNewUser ?? false) {
          // If the user is new, navigate to the profile setup screen
          print('new user');
          Navigator.pushNamed(context, AppRoutes.homepageScreen);
        } else {
          //already registered, navigate to the home screen
          print('bla  user already exist');
          Navigator.pushNamed(context, AppRoutes.homepageScreen);
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
        // final UserCredential userCredential =
        //     await _auth.signInWithCredential(credential);

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
      // Navigator.pushNamed(context, '/login_page_screen');
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

/*----------------------------------USER_DATA-----------------------------------------*/
  Future<void> InsertUser(UserModel userModel) async {
    await FirebaseFirestore.instance.collection('Users').doc(userModel.id).set({
      'id': userModel.id,
      'username': userModel.username,
      'email': userModel.email,
      'password': userModel.password,
      'savedItems': userModel.savedItems,
      'notificationToken': userModel.notificationToken,
      'notifications': userModel.notifications,
    });
  }

  Future<void> UpdateUser(UserModel user) async {
    final userDocRef =
        FirebaseFirestore.instance.collection('Users').doc(currentUser!.uid);
    await userDocRef.update(user.toMap());

    userData = user;
  }

  Future<void> deleteUser() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(this.currentUser!.uid)
        .delete();
  }

  // Fetch user data from Firestore based on uid
  Future<UserModel?> fetchUserData() async {
    String uid = currentUser!.uid;
    print("uid : $uid");
    try {
      final userData =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();

      if (userData.exists) {
        // User data exists in Firestore
        // Extract user properties and do something with them
        var data = userData.data();

        final username = data!['username'];
        final email = data['email'];
        final password = data['password'];
        final savedItems = data['savedItems'];

        String? notificationToken = null;
        List<Map<String, dynamic>>? notifications = null;

        if (data.containsKey('notificationToken')) {
          notificationToken = data['notificationToken'];
        }

        if (data.containsKey('notifications')) {
          notifications = data['notifications'].cast<Map<String, dynamic>>();
        }

        print("notificationToken : $notificationToken");

        final List<DocumentReference> updatedSavedItems =
            savedItems!.cast<DocumentReference>();

        UserModel user = UserModel(
          id: uid,
          username: username,
          email: email,
          password: password,
          savedItems: updatedSavedItems,
          notificationToken: notificationToken,
          notifications: notifications,
        );
        return user;

        // You can use the fetched user data as needed
      } else {
        // User data does not exist in Firestore
        // Handle the case where user data is missing
      }
    } catch (e) {
      // Error handling
      print('Error fetching user data: $e');
    }
    return null;
  }

  Future<void> updateUserPassword(String newPassword) async {
    try {
      await currentUser!.updatePassword(newPassword);
    } catch (e) {
      print(e);
    }
  }

/*----------------------------------MOBILE_VERIFICATION-----------------------------------------*/
  Future<void> sendOTP(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-retrieval of SMS code completed
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failure
          if (e.code == 'invalid-phone-number') {
            Get.snackbar('Error', 'The provided phone number is not valid');
          } else {
            Get.snackbar('Error', 'Please try again');
          }
        },
        codeSent: (verificationId, int? resendToken) {
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId.value = verificationId;
        },
      );
      // OTP sent successfully
    } catch (e) {
      // Error handling
    }
  }

  Future<void> verifyOTP(String otp, String verificationId) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      var result = await _auth.signInWithCredential(credential);
    } catch (e) {
      // OTP verification failed
    }
  }
}
