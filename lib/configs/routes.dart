import 'package:flutter_application_1/views/homescreen.dart';
import 'package:flutter_application_1/views/login.dart';
import 'package:flutter_application_1/views/signup.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

var routes = [
  GetPage(name: "/login", page: () => LoginScreen()),
  GetPage(name: "/signup", page: () => SignUpScreen()),
  GetPage(name: "/homescreen", page: () => HomeScreen()),
];
