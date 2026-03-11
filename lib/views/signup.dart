import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: SignUpScreen()));
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondarycolor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/login.png',
                  height: 80,
                  width: 80,
                  errorBuilder: (ctx, obj, st) =>
                      Icon(Icons.person_add, size: 80, color: primarycolor),
                ),
                SizedBox(height: 10),
                Text(
                  "Create Account",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),

                // Full Name Field
                TextField(
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Email Field
                TextField(
                  decoration: InputDecoration(
                    labelText: "Email Address",
                    hintText: "example@mail.com",
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Country Dropdown
                DropdownButtonFormField<String>(
                  initialValue: selectedCountry,
                  decoration: InputDecoration(
                    labelText: "Country",
                    prefixIcon: Icon(Icons.public),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  items: countries.map((String country) {
                    return DropdownMenuItem(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => selectedCountry = value),
                ),
                SizedBox(height: 20),

                // Password Field
                TextField(
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () =>
                          setState(() => _obscureText = !_obscureText),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // Terms and Conditions Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: agreeToTerms,
                      activeColor: primarycolor,
                      onChanged: (value) =>
                          setState(() => agreeToTerms = value!),
                    ),
                    Expanded(
                      child: Text(
                        "I agree to the Terms of Service and Privacy Policy",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: agreeToTerms ? () {} : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primarycolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Divider
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text("OR"),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 20),

                // Google Sign In Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.g_mobiledata,
                      size: 30,
                    ), // You can use a custom SVG for the real Google logo
                    label: Text(
                      "Sign up with Google",
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    GestureDetector(
                      child: Text(
                        "Login",
                        style: TextStyle(color: primarycolor),
                      ),
                      onTap: () {
                        print("clicked");
                        Get.toNamed("/");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
