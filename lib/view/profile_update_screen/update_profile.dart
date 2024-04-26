import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:qarenly/common/widgets/tff_widget.dart';
import 'package:qarenly/controller/profile_controller.dart';
import 'package:qarenly/core/app_export.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              LineAwesomeIcons.angle_left,
              color: Colors.white,
            )),
        title: Text("Edit Profile",
            style: TextStyle(fontSize: 30, color: Colors.white)),
      ),
      body: SingleChildScrollView(
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
              // -- IMAGE with ICON
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
                      child: const Text("Camera")),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // _pickImage(ImageSource.gallery);
                      },
                      child: const Text("Gallery")),
                ],
              ),
              const SizedBox(height: 50),

              // -- Form Fields
              Form(
                child: Column(
                  children: [
                    TFF_widget(
                        Controller: controller.username,
                        ticon: Icons.person,
                        labelText: "Full Name"),
                    const SizedBox(height: 10),
                    TFF_widget(
                        Controller: controller.email,
                        ticon: Icons.email,
                        labelText: "email"),
                    const SizedBox(height: 10),
                    TFF_widget(
                        Controller: controller.password,
                        ticon: Icons.fingerprint,
                        labelText: "Password"),
                    const SizedBox(height: 10),
                    TFF_widget(
                        Controller: controller.confirmPassword,
                        ticon: Icons.fingerprint,
                        labelText: "Confirm Password"),
                    const SizedBox(height: 30),

                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () =>
                            Get.to(() => const UpdateProfileScreen()),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text.rich(
                          TextSpan(
                            text: "Joined",
                            style: TextStyle(fontSize: 12),
                            children: [
                              TextSpan(
                                  text: " El Tareeee5",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
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
      ),
    );
  }
}
