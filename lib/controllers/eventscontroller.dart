import 'dart:convert';

import 'package:flutter_application_1/models/event_models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EventsController extends GetxController {
  var allEvents = <Event>[].obs;
  var filteredEvents = <Event>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    try {
      isLoading.value = true;
      var response = await http.get(
        Uri.parse("http://localhost/church_db/event.php"),
      );

      if (response.statusCode == 200) {
        var serverData = jsonDecode(response.body);
        List eventData = serverData["data"];
        var fetched = eventData
            .map(
              (e) => Event(
                name: e["name"] ?? "Untitled Event",
                date: e["date"] ?? "TBA",
                image: e["image"] ?? "",
              ),
            )
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
