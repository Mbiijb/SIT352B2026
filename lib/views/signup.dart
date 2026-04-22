import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/controllers/loginController.dart';
import 'package:flutter_application_1/controllers/userProfileController.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // 1. Controllers for capturing data
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();

  String? selectedCountry = 'United States';
  bool agreeToTerms = false;
  bool _obscureText = true;

  final List<String> countries = [
    'United States',
    'Kenya',
    'United Kingdom',
    'Canada',
    'India',
  ];

  // Function to perform the Sign Up via API
  Future<void> signUpUser() async {
    // Validation: Ensure all fields are filled
    if (firstname.text.isEmpty ||
        lastname.text.isEmpty ||
        phone.text.isEmpty ||
        email.text.isEmpty ||
        password.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill in all fields",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    if (password.text.length < 6) {
      Get.snackbar(
        "Error",
        "Password must be at least 6 characters",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    if (!agreeToTerms) {
      Get.snackbar(
        "Error",
        "You must agree to the terms",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      // Fix: dynamically set the URL base (10.0.2.2 is required for Android Emulators)
      final String baseUrl = GetPlatform.isAndroid
          ? "http://10.0.2.2/church_db"
          : "http://localhost/church_db";

      // Construct the URL with fname and lname as separate parameters
      var url = Uri.parse(
        "$baseUrl/signup.php?"
        "fname=${firstname.text.trim()}&" // Matches PHP $_GET['fname']
        "lname=${lastname.text.trim()}&" // Matches PHP $_GET['lname']
        "phone=${phone.text.trim()}&"
        "email=${email.text.trim()}&"
        "country=$selectedCountry&"
        "password=${password.text.trim()}",
      );

      print("Requesting: $url"); // Debug to see the split names

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var serverData = jsonDecode(response.body);
        if (serverData['success'] == 1) {
          Get.snackbar(
            "Success",
            "Account created successfully",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          // Manually "log in" the user by populating the necessary controllers
          // This ensures the app knows who the user is when they land on the home screen
          final LoginController loginController = Get.put(
            LoginController(),
            permanent: true,
          );
          final UserProfileController userController = Get.put(
            UserProfileController(),
            permanent: true,
          );

          loginController.setUserInfo(
            firstname.text.trim(),
            lastname.text.trim(),
          );
          loginController.email.value = email.text.trim(); // Save the email!
          userController.email.value = email.text.trim(); // Save for events
          Get.offAllNamed("/homescreen"); // Navigate to the home screen
        } else {
          Get.snackbar(
            "Error",
            "Registration failed: ${serverData['message'] ?? 'Unknown error'}",
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Server returned status: ${response.statusCode}",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Connection Error: $e",
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
              const SizedBox(height: 20),
              Image.asset(
                'assets/login.png',
                height: 100,
                width: 100,
                errorBuilder: (ctx, obj, st) => const Icon(
                  Icons.person_add,
                  size: 100,
                  color: primarycolor,
                ),
              ),
              const SizedBox(height: 20),

              // First Name Field
              TextField(
                controller: firstname,
                decoration: InputDecoration(
                  labelText: "First Name",
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
              TextField(
                controller: lastname,
                decoration: InputDecoration(
                  labelText: "Last Name",
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

              // Phone Number Field
              TextField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Phone Number",
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
              const SizedBox(height: 20),

              // Email Field
              TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email Address",
                  hintText: "example@mail.com",
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

              // Country Dropdown
              DropdownButtonFormField<String>(
                initialValue: selectedCountry,
                items: countries
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) => setState(() => selectedCountry = value),
                decoration: InputDecoration(
                  labelText: "Country",
                  prefixIcon: const Icon(Icons.public),
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
              TextField(
                controller: password,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () =>
                          setState(() => _obscureText = !_obscureText),
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
              const SizedBox(height: 10),

              // Checkbox
              Row(
                children: [
                  Checkbox(
                    value: agreeToTerms,
                    activeColor: primarycolor,
                    onChanged: (value) => setState(() => agreeToTerms = value!),
                  ),
                  const Expanded(
                    child: Text(
                      "I agree to the Terms of Service and Privacy Policy",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Sign Up Button Container
              MouseRegion(
                cursor: agreeToTerms
                    ? SystemMouseCursors.click
                    : SystemMouseCursors.basic,
                child: GestureDetector(
                  onTap: signUpUser,
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: agreeToTerms ? primarycolor : Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
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

              // Google Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.g_mobiledata, size: 30),
                  label: const Text(
                    "Sign up with Google",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  style: OutlinedButton.styleFrom(
                    enabledMouseCursor: SystemMouseCursors.click,
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  const SizedBox(width: 5),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => Get.toNamed("/login"),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: primarycolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
