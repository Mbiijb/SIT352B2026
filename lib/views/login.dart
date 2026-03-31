import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/controllers/loginController.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// Initialize controllers
final LoginController logincontroller = Get.put(LoginController());
final TextEditingController phoneController =
    TextEditingController(); // Changed for clarity
final TextEditingController passwordController = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // async function to handle the login network request
  Future<void> loginUser() async {
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();

    // 1. Validation
    if (phone.isEmpty) {
      Get.snackbar(
        "Login Failed",
        "Phone number cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    if (password.isEmpty) {
      Get.snackbar(
        "Login Failed",
        "Password cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    // 2. Perform Login Request [cite: 175, 240]
    try {
      // Note: 10.0.2.2 is the alias for localhost on Android Emulators [cite: 133, 175]
      final response = await http.get(
        Uri.parse(
          "http://10.0.2.2/church_db/login.php?phone=$phone&password=$password",
        ),
      );

      if (response.statusCode == 200) {
        final serverData = jsonDecode(response.body);

        // Check success based on your PHP 'success' or 'code' key [cite: 182, 258]
        if (serverData["success"] == 1 || serverData["code"] == 1) {
          // Success navigation
          Get.offAndToNamed("/homescreen");
        } else {
          // Failure message from server [cite: 267]
          Get.snackbar(
            "Login Failed",
            serverData["message"] ?? "Invalid credentials",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Server Error: ${response.statusCode}",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Connection error: $e",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondarycolor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Image.asset(
                'assets/login.png',
                height: 100,
                width: 100,
                errorBuilder: (ctx, obj, st) =>
                    const Icon(Icons.church, size: 100, color: primarycolor),
              ),
              const SizedBox(height: 20),

              // Phone Field (Replaces Username for DB compatibility)
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Enter phone number",
                  hintText: "e.g. 0712345678",
                  prefixIcon: const Icon(Icons.phone),
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

              // Password Field with Visibility Toggle
              Obx(
                () => TextField(
                  obscureText: !logincontroller.ispasswordvisible.value,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Enter password",
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      onTap: () => logincontroller.togglepassword(),
                      child: Icon(
                        logincontroller.ispasswordvisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primarycolor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Login Button with Mouse Pointer
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: loginUser, // Calls the async function created above
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primarycolor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
                child: Row(
                  children: [
                    const Text("Don't have an account?"),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () => Get.toNamed("/signup"),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: primarycolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text("Forgot password?"),
                    const SizedBox(width: 5),
                    const Text(
                      "Reset",
                      style: TextStyle(
                        color: primarycolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("OR"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 30),

              // Google Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.g_mobiledata, size: 30),
                  label: const Text("Sign in with Google"),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
