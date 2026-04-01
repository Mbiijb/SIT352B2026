import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/controllers/loginController.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// Initialize controllers
final LoginController logincontroller = Get.put(LoginController());
final TextEditingController usernameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Logic to handle login using the PHP API structure
  Future<void> loginUser() async {
    String phone = usernameController.text.trim();
    String password = passwordController.text.trim();

    // 1. Check LoginController first (for admin/12345 bypass)
    bool isHardcodedAdmin = logincontroller.login(phone, password);
    if (isHardcodedAdmin) {
      Get.offAndToNamed("/homescreen");
      return;
    }

    // 2. Validation for empty fields
    if (phone.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Login Failed",
        "Fields cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    // 3. Database Authentication using GET
    try {
      // Data is appended to the URL as query parameters
      final String url =
          "http://localhost/church_db/login.php?phone=$phone&password=$password";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final serverData = jsonDecode(response.body);

        // Your PHP returns 'code' => 1 for success
        if (serverData["code"] == 1) {
          // Success: Navigate to Home
          Get.snackbar(
            "Success",
            "Welcome back!",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offAndToNamed("/homescreen");
        } else {
          // Failure: Show the 'message' from PHP
          Get.snackbar(
            "Login Failed",
            serverData["message"] ?? "Invalid credentials",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar("Error", "Server Error: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Check your connection or XAMPP status");
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
              // Church Logo
              Image.asset(
                'assets/login.png',
                height: 100,
                width: 100,
                errorBuilder: (ctx, err, st) =>
                    const Icon(Icons.church, size: 100, color: primarycolor),
              ),
              const SizedBox(height: 20),

              // Phone Number Field
              TextField(
                controller: usernameController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  hintText: "Enter registered phone",
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

              // Password Field
              Obx(
                () => TextField(
                  obscureText: !logincontroller.ispasswordvisible.value,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => logincontroller.togglepassword(),
                        child: Icon(
                          logincontroller.ispasswordvisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
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

              // Login Button
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: loginUser,
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

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () => Get.toNamed("/signup"),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        color: primarycolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
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

              const SizedBox(height: 20),
              // Google Mock Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.g_mobiledata, size: 30),
                  label: const Text("Sign in with Google"),
                  style: OutlinedButton.styleFrom(
                    enabledMouseCursor: SystemMouseCursors.click,
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
