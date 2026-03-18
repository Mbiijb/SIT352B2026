import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LoginController extends GetxController {
  var username;
  var password;
  var ispasswordvisible = false.obs;
  bool login(user, pass) {
    username = user;
    password = pass;
    if (username == "admin" && password == "12345") {
      return true;
    } else {
      return false;
    }
  }

  void togglepassword() {
    ispasswordvisible.value = !ispasswordvisible.value;
  }
}
