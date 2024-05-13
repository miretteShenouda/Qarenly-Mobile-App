import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:qarenly/common/widgets/tff_widget.dart';
import 'package:qarenly/controller/profile_controller.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/model/user_model.dart';
// import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';

class UpdateProfileScreen extends StatefulWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  final profileController = Get.put(ProfileController());
  var futureUserData;

  @override
  void initState() {
    super.initState();
    futureUserData = profileController.fetchUserData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back,
            )),
        title: Text("Edit Profile",
            style: TextStyle(fontSize: 30, color: Colors.white)),
      ),
      body: FutureBuilder<UserModel?>(
          future: futureUserData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While waiting for the future to resolve
              return Center(child: CircularProgressIndicator()); // Display a loading indicator();
            } else if (snapshot.hasError) {
              // If an error occurred
              return Text('Error: ${snapshot.error}');
            } else {
              // When the future completes successfully
              return SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment(0.5, 0),
                          end: Alignment(0.5, 1),
                          colors: [
                        theme.colorScheme.onPrimary,
                        appTheme.teal100Ec,
                        theme.colorScheme.primary.withOpacity(0.93)
                      ])),
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        // backgroundImage: _imageFile != null
                        // ? FileImage(_imageFile!)
                        // : const AssetImage(
                        //     'assets/default.png',
                        //   ) as ImageProvider<Object>?),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                // _pickImage(ImageSource.camera);
                              },
                              child: const Text(
                                "Camera",
                                style: TextStyle(color: Colors.black),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                // _pickImage(ImageSource.gallery);
                              },
                              child: const Text("Gallery",
                                  style: TextStyle(color: Colors.black))),
                        ],
                      ),
                      const SizedBox(height: 50),

                      // -- Form Fields
                      Form(
                        key: profileController.formKey,
                        child: Column(
                          children: [
                            TFF_widget(
                                Controller: profileController.username,
                                ticon: Icons.person,
                                hintText: "Full Name"),
                            const SizedBox(height: 10),
                            TFF_widget(
                                Controller: profileController.email,
                                ticon: Icons.email,
                                hintText: "email"),
                            const SizedBox(height: 10),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password.';
                                } else if (value.length < 8) {
                                  return 'Password must be at least 8 characters long.';
                                }
                                return null;
                              },
                              obscureText: profileController.passwordIsObsecure,
                              controller: profileController.password,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  hintText: "Password",
                                  contentPadding: EdgeInsets.fromLTRB(
                                      30.h, 10.v, 26.h, 10.v),
                                  prefixIcon: Icon(Icons.lock,
                                      color: Colors.orange.withOpacity(0.7)),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          profileController.passwordIsObsecure =
                                              !profileController
                                                  .passwordIsObsecure;
                                        });
                                      },
                                      icon: profileController.passwordIsObsecure
                                          ? Icon(Icons.remove_red_eye)
                                          : Icon(
                                              Icons.remove_red_eye_outlined))),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your confirmation password.';
                                } else if (value.length < 8) {
                                  return 'Password must be at least 8 characters long.';
                                }

                                if (value != profileController.password.text) {
                                  return 'Passwords do not match.';
                                }
                                return null;
                              },
                              obscureText:
                                  profileController.passwordConfirmIsObsecure,
                              controller: profileController.confirmPassword,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  hintText: "Confirmation Password",
                                  contentPadding: EdgeInsets.fromLTRB(
                                      30.h, 10.v, 26.h, 10.v),
                                  prefixIcon: Icon(Icons.lock,
                                      color: Colors.orange.withOpacity(0.7)),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          profileController
                                                  .passwordConfirmIsObsecure =
                                              !profileController
                                                  .passwordConfirmIsObsecure;
                                        });
                                      },
                                      icon: profileController
                                              .passwordConfirmIsObsecure
                                          ? Icon(Icons.remove_red_eye)
                                          : Icon(
                                              Icons.remove_red_eye_outlined))),
                            ),
                            const SizedBox(height: 30),

                            // -- Form Submit Button
                            SizedBox(
                              width: double.infinity,
                              height: 30,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (profileController.formKey.currentState!.validate())
                                  {
                                      profileController.updateProfile();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Profile Updated'),
                                        )
                                      );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    side: BorderSide.none,
                                    shape: const StadiumBorder()),
                                child: const Text("Edit Profile",
                                    style: TextStyle(color: Colors.black)),
                              ),
                            ),
                            const SizedBox(height: 30),

                            // -- Created Date and Delete Button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    await profileController.deleteUser();
                                    Navigator.pushReplacementNamed(
                                        context, AppRoutes.loginPageScreen);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.redAccent.withOpacity(0.1),
                                      elevation: 0,
                                      foregroundColor: Colors.red,
                                      shape: const StadiumBorder(),
                                      side: BorderSide.none),
                                  child: const Text("Delete"),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
