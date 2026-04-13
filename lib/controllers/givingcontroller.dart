import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/userProfileController.dart'; // Import your profile controller
import 'package:flutter_application_1/models/giving_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GivingController extends GetxController {
  // Amount Controllers
  final titheController = TextEditingController();
  final offeringController = TextEditingController();
  final pledgeController = TextEditingController();

  // Focus Nodes to navigate to respective input fields
  final titheFocus = FocusNode();
  final offeringFocus = FocusNode();
  final pledgeFocus = FocusNode();

  // Switch state
  var isMonthly = false.obs;
  var isLoading = false.obs;
  var history = <GivingRecord>[].obs;
  var totalContributed = 0.0.obs;
  var ytdContributed = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchGivingHistory();
  }

  Future<void> fetchGivingHistory() async {
    try {
      isLoading.value = true;
      final UserProfileController user = Get.find();

      final String baseUrl = GetPlatform.isAndroid
          ? "http://10.0.2.2/church_db"
          : "http://localhost/church_db";
      var url = Uri.parse("$baseUrl/get_giving.php?email=${user.email.value}");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['data'] != null) {
          List records = data['data'];
          var list = records.map((e) => GivingRecord.fromJson(e)).toList();
          history.assignAll(list);

          // Calculate Totals
          totalContributed.value = list.fold(
            0,
            (sum, item) => sum + item.amount,
          );
          // Simplified YTD logic for current year
          String currentYear = DateTime.now().year.toString();
          ytdContributed.value = list
              .where((item) => item.date.contains(currentYear))
              .fold(0, (sum, item) => sum + item.amount);
        }
      }
    } catch (e) {
      print("Error fetching history: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Function to process giving
  Future<void> processGiving(String category, String amount) async {
    if (amount.isEmpty || double.tryParse(amount) == 0) {
      Get.snackbar(
        "Error",
        "Please enter a valid amount for $category",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    try {
      // Get user email from UserProfileController
      final UserProfileController userProv = Get.find();

      final String baseUrl = GetPlatform.isAndroid
          ? "http://10.0.2.2/church_db"
          : "http://localhost/church_db";
      var url = Uri.parse(
        "$baseUrl/giving.php?"
        "email=${userProv.email.value}&"
        "amount=$amount&"
        "category=$category&"
        "monthly=${isMonthly.value ? 1 : 0}",
      );

      var response = await http.get(url);
      var data = jsonDecode(response.body);

      if (data['success'] == 1) {
        Get.snackbar(
          "God Bless You!",
          "Your $category has been received.",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Clear inputs
        titheController.clear();
        offeringController.clear();
        pledgeController.clear();

        // Refresh history after new contribution
        fetchGivingHistory();
      }
    } catch (e) {
      Get.snackbar("Error", "Check your connection and try again.");
    } finally {
      isLoading.value = false;
    }
  }

  // Always properly dispose FocusNodes and Controllers to prevent memory leaks
  @override
  void onClose() {
    titheController.dispose();
    offeringController.dispose();
    pledgeController.dispose();
    titheFocus.dispose();
    offeringFocus.dispose();
    pledgeFocus.dispose();
    super.onClose();
  }
}
