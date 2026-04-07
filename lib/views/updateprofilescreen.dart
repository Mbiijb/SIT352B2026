import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/controllers/loginController.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Updateprofilescreen extends StatefulWidget {
  const Updateprofilescreen({super.key});

  @override
  State<Updateprofilescreen> createState() => _UpdateprofilescreenState();
}

class _UpdateprofilescreenState extends State<Updateprofilescreen> {
  final LoginController loginController = Get.find<LoginController>();

  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill the fields with existing data from the controller
    fnameController.text = loginController.firstName.value;
    lnameController.text = loginController.lastName.value;
    phoneController.text = loginController.username.value;
  }

  Future<void> updateProfile() async {
    setState(() => isLoading = true);
    try {
      // We use the current phone number as the identifier to find the user in the database
      String currentPhone = loginController.username.value;

      var url = Uri.parse(
        "http://localhost/church_db/update_profile.php?"
        "current_phone=$currentPhone&"
        "fname=${fnameController.text.trim()}&"
        "lname=${lnameController.text.trim()}&"
        "email=${emailController.text.trim()}&"
        "phone=${phoneController.text.trim()}&"
        "password=${passwordController.text.trim()}",
      );

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['success'] == 1) {
          // Update the local GetX controller so the app immediately reflects the changes
          loginController.setUserInfo(
            fnameController.text.trim(),
            lnameController.text.trim(),
          );
          loginController.username.value = phoneController.text
              .trim(); // Update saved phone

          Get.snackbar(
            "Success",
            "Profile updated successfully!",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.back(); // Go back to the profile screen
        } else {
          Get.snackbar(
            "Error",
            data['message'] ?? "Failed to update profile",
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Connection error: $e",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondarycolor,
      appBar: AppBar(
        backgroundColor: secondarycolor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 22,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Image Section
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/profile.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: primarycolor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Icon(
                          LineAwesomeIcons.alternate_pencil,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // Form Section with Matching Styles
              Form(
                child: Column(
                  children: [
                    // First Name Field
                    TextFormField(
                      controller: fnameController,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                        prefixIcon: const Icon(Icons.person_outline),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primarycolor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Last Name Field
                    TextFormField(
                      controller: lnameController,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                        prefixIcon: const Icon(Icons.person_outline),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primarycolor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Email Field
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                        prefixIcon: const Icon(Icons.email_outlined),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primarycolor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Phone Field
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone No.',
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                        prefixIcon: const Icon(Icons.phone_outlined),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primarycolor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Password Field
                    TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                        prefixIcon: const Icon(Icons.lock_outline),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primarycolor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Save Button (Styled like the Login/Sign Up buttons)
                    MouseRegion(
                      cursor: isLoading
                          ? SystemMouseCursors.basic
                          : SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: isLoading ? null : updateProfile,
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isLoading ? Colors.grey : primarycolor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  "Save Changes",
                                  style: TextStyle(
                                    color: secondarycolor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Footer Actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text.rich(
                          TextSpan(
                            text: 'Joined on ',
                            style: TextStyle(fontSize: 12),
                            children: [
                              TextSpan(
                                text: 'January 1, 2026',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.redAccent,
                            ),
                            child: const Text(
                              'Delete Account',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
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
