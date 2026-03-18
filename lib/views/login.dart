import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/controllers/logincontroller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

LoginController loginController = Get.put(LoginController());
TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bool _isObscured = true;

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
              Image.asset('assets/login.png', height: 100, width: 100),
              const SizedBox(height: 20),

              // Username Field
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Enter username",
                  hintText: "Use email or phone number",
                  prefixIcon: const Icon(Icons.person),
                  // Original borders preserved
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
                  obscureText: !loginController.ispasswordvisible.value,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Enter password",
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      child: Icon(
                        loginController.ispasswordvisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onTap: () {
                        loginController.togglepassword();
                      },
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

              // Login Button with Mouse Cursor
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  //onTap: () => Get.offAndToNamed("/homescreen"),
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
                  onTap: () {
                    bool success = loginController.login(
                      usernameController.text,
                      passwordController.text,
                    );
                    if (success) {
                      Get.offAndToNamed("/homescreen");
                    } else {
                      Get.snackbar(
                        "Login Failed",
                        "Invalid credentials",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                        icon: const Icon(Icons.error, color: Colors.white),
                        duration: const Duration(seconds: 5),
                      );
                    }
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                child: Row(
                  children: [
                    const Text("Don't have an account?"),
                    const SizedBox(width: 5),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => Get.toNamed("/signup"),
                        child: Text(
                          "Sign up",
                          style: TextStyle(color: primarycolor),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text("Forgot password?"),
                    const SizedBox(width: 5),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Reset",
                          style: TextStyle(color: primarycolor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Divider
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

              // Google Sign In Button
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
            ],
          ),
        ),
      ),
    );
  }
}
