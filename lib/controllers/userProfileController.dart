import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserProfileController extends GetxController {
  // Observables for user data
  var fname = "".obs;
  var lname = "".obs;
  var email = "".obs;
  var phone = "".obs;
  var country = "".obs;
  var isLoading = false.obs;

  // Update user data in the controller
  void updateLocalUser(String f, String l, String e, String p, String c) {
    fname.value = f;
    lname.value = l;
    email.value = e;
    phone.value = p;
    country.value = c;
  }

  // Logic for Update Profile API
  Future<bool> updateProfileOnServer() async {
    isLoading.value = true;
    try {
      var url = Uri.parse(
        "http://localhost/church_db/update_profile.php?"
        "fname=${fname.value}&lname=${lname.value}&email=${email.value}&phone=${phone.value}",
      );
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['success'] == 1;
      }
    } catch (e) {
      print("Update Error: $e");
    } finally {
      isLoading.value = false;
    }
    return false;
  }
}
