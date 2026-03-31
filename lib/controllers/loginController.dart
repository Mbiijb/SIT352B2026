import 'package:get/get.dart';

class LoginController extends GetxController {
  // Initialize with empty strings to avoid null errors
  var username = "".obs;
  var password = "".obs;
  var ispasswordvisible = false.obs;

  bool login(String user, String pass) {
    username.value = user;
    password.value = pass;

    // Simple hardcoded check
    if (username.value == "admin" && password.value == "12345") {
      return true;
    } else {
      return false;
    }
  }

  void togglepassword() {
    ispasswordvisible.value = !ispasswordvisible.value;
  }
}
