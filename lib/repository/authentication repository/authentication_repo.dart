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
      currentUser = user;
      this.userData = UserModel(
        id: currentUser!.uid,
        username: "Guest",
        password: "",
        email: "",
        savedItems: [],
        notificationToken: null,
      );

      Get.offAll(() => LoginPageScreen());
    } else if (user != null) {
      currentUser = user;
      // If user is not null, fetch user data from Firestore

      userData = await fetchUserData();
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
      return user;
    } catch (e) {}
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
      userData = UserModel(
        id: currentUser!.uid,
        username: "Guest",
        password: "",
        email: "",
        savedItems: [],
        notificationToken: null,
      );
      return true;
    } catch (e) {}
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

        // if user exist in firestore
        var userDoc = await FirebaseFirestore.instance
            .collection("Users")
            .where("id", isEqualTo: userCredential.user!.uid)
            .get();
        if (userCredential.user != null && !userDoc.docs.isEmpty) {
          this.currentUser = userCredential.user;
          this.userData = await fetchUserData();
          return userCredential.user;
        }

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

        await FirebaseAuth.instance.signInWithCredential(credential);

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        currentUser = userCredential.user;

        // Check if the user is already equal (already signed in)
        if (isUserEqual(result)) {
          // If the user is already signed in, navigate to the homepage
          userData = await fetchUserData();
          Navigator.pushNamed(context, AppRoutes.homepageScreen);
          return; // Exit the method to prevent further navigation
        }

        // Check if the user is signing in for the first time
        if (userCredential.additionalUserInfo?.isNewUser == true) {
          // If the user is new, navigate to the profile setup screen
          UserModel userData = UserModel(
            id: userCredential.user!.uid,
            username: userCredential.user!.displayName!,
            email: userCredential.user!.email!,
            password: '',
            savedItems: [],
          );
          this.userData = userData;
          InsertUser(userData);
          Navigator.pushNamed(context, AppRoutes.homepageScreen);
        } else {
          //already registered, navigate to the home screen
          userData = await fetchUserData();
          Navigator.pushNamed(context, AppRoutes.homepageScreen);
        }
      } else {
        // Handle login failure
      }
    } catch (e) {
      // Handle errors
    }
  }

  Future<void> signUpWithFacebook(BuildContext context) async {
    try {
      final LoginResult result =
          await FacebookAuth.instance.login(permissions: ['email']);
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);

        final userCreds =
            await FirebaseAuth.instance.signInWithCredential(credential);

        currentUser = userCreds.user;

        final userInstance = await FirebaseFirestore.instance
            .collection('Users')
            .where('id', isEqualTo: currentUser!.uid)
            .get();

        if (!userInstance.docs.isEmpty) {
          userData = await fetchUserData();
        } else {
          UserModel userData = UserModel(
            id: currentUser!.uid,
            username: currentUser!.displayName!,
            email: currentUser!.email!,
            password: '',
            savedItems: [],
          );
          this.userData = userData;
          InsertUser(userData);
        }

        Navigator.pushNamed(
            context,
            AppRoutes
                .homepageScreen); // Navigate to home screen after successful login
      } else {}
    } catch (e) {}
  }

  Future<void> signOutFacebook(BuildContext context) async {
    try {
      await _auth.signOut();
      await FacebookAuth.instance.logOut();
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

        if (data.containsKey('notifications') &&
            data['notifications'] != null) {
          notifications = data['notifications'].cast<Map<String, dynamic>>();
        }

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
      } else {
        // User data does not exist in Firestore
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
    } catch (e) {}
  }
}
