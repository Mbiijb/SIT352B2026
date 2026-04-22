import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/loginController.dart';
import 'package:flutter_application_1/models/event_models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EventsController extends GetxController {
  var allEvents = <Event>[].obs;
  var filteredEvents = <Event>[].obs;
  var registeredEvents = <Event>[].obs;
  var isLoading = true.obs;
  var isRegistering = false.obs;
  var isFetchingRegistrations = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    try {
      isLoading.value = true;

      final String baseUrl = GetPlatform.isAndroid
          ? "http://10.0.2.2/church_db"
          : "http://localhost/church_db";

      var response = await http.get(Uri.parse("$baseUrl/event.php"));

      if (response.statusCode == 200) {
        var serverData = jsonDecode(response.body);
        List eventData = serverData["data"] ?? [];
        List<Event> fetched = eventData
            .map<Event>((e) => Event.fromJson(e))
            .toList();

        allEvents.assignAll(fetched);
        filteredEvents.assignAll(fetched); // Initially show all
      }
    } catch (e) {
      print("Error fetching events: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchUserRegistrations() async {
    try {
      isFetchingRegistrations.value = true;

      // 1. Get the logged-in user's email from the LoginController
      final LoginController loginController = Get.find<LoginController>();
      String email = loginController.email.value; // Ensure this is not empty

      if (email.isEmpty) {
        print(
          "Email is empty. Skipping fetch to prevent shared empty records.",
        );
        return;
      }

      final String baseUrl = GetPlatform.isAndroid
          ? "http://10.0.2.2/church_db"
          : "http://localhost/church_db";

      // 2. Pass that email to your PHP script
      var url = Uri.parse("$baseUrl/get_user_registrations.php?email=$email");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['success'] == 1) {
          List eventData = data["data"] ?? [];
          List<Event> fetched = eventData
              .map<Event>((e) => Event.fromJson(e))
              .toList();
          registeredEvents.assignAll(fetched);
        }
      }
    } catch (e) {
      print("Error fetching user registrations: $e");
    } finally {
      isFetchingRegistrations.value = false;
    }
  }

  Future<void> registerForEvent(int eventId) async {
    isRegistering.value = true;

    try {
      final LoginController login = Get.find<LoginController>();

      if (login.email.value.isEmpty) {
        Get.snackbar(
          "Session Error",
          "Identity verification failed. Please log out and log back in.",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        return;
      }

      final String baseUrl = GetPlatform.isAndroid
          ? "http://10.0.2.2/church_db"
          : "http://localhost/church_db";

      var url = Uri.parse(
        "$baseUrl/register_event.php?email=${login.email.value}&event_id=$eventId",
      );
      var response = await http.get(url);
      var data = jsonDecode(response.body);

      if (data['success'] == 1) {
        Get.snackbar(
          "Success",
          "You have successfully registered for the event!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Notice",
          data['message'],
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Connection failed. Please try again.",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isRegistering.value = false;
    }
  }

  void searchEvents(String query) {
    if (query.isEmpty) {
      filteredEvents.assignAll(allEvents);
    } else {
      filteredEvents.assignAll(
        allEvents
            .where(
              (event) => event.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList(),
      );
    }
  }
}
