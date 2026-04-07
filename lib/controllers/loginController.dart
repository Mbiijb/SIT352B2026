import 'package:get/get.dart';

class LoginController extends GetxController {
  // Observables for the UI
  var username = "".obs;
  var password = "".obs;
  var ispasswordvisible = false.obs;

  // Observables for the logged-in user session
  var isLoggedIn = false.obs;
  var firstName = "Guest".obs;
  var lastName = "".obs;

  // Admin bypass check
  bool login(String user, String pass) {
    username.value = user;
    password.value = pass;

    if (username.value == "admin" && password.value == "12345") {
      isLoggedIn.value = true;
      firstName.value = "Admin";
      lastName.value = "User";
      return true;
    } else {
      return false;
    }
  }

  // New function to update user info after a successful PHP login
  void setUserInfo(String f, String l) {
    isLoggedIn.value = true;
    firstName.value = f;
    lastName.value = l;
  }

  void togglepassword() {
    ispasswordvisible.value = !ispasswordvisible.value;
  }
}
