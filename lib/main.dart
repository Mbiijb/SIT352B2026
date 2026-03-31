import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
// import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/configs/routes.dart';
import 'package:flutter_application_1/views/login.dart';
// import 'package:flutter_application_1/views/login.dart'; // Remove this if login is handled in routes
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialRoute: "/",
      getPages: routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF545aea),
        scaffoldBackgroundColor: secondarycolor,
        appBarTheme: const AppBarTheme(
          backgroundColor: secondarycolor,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF545aea),
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          foregroundColor: secondarycolor,
          elevation: 0,
        ),
      ),
      themeMode: ThemeMode.system,
      home: LoginScreen(),
    ),
  );
}
