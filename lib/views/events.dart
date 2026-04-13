import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/controllers/eventsController.dart';
import 'package:flutter_application_1/controllers/navigationController.dart';
import 'package:flutter_application_1/models/event_models.dart';
import 'package:get/get.dart';

class EventScreen extends StatelessWidget {
  EventScreen({super.key});

  final EventsController eventsController = Get.find<EventsController>();
  final NavigationController nav = Get.find<NavigationController>();

  // Dynamically set the URL base (10.0.2.2 is required for Android Emulators)
  final String baseUrl = GetPlatform.isAndroid
      ? "http://10.0.2.2/church_db"
      : "http://localhost/church_db";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 1. Search Bar Design
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) => eventsController.searchEvents(value),
              decoration: InputDecoration(
                hintText: "Find an event...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 2. Events List
          Expanded(
            child: Obx(
              () => eventsController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : eventsController.filteredEvents.isEmpty
                  ? const Center(child: Text("No events found"))
                  : NotificationListener<UserScrollNotification>(
                      onNotification: (notification) {
                        if (notification.direction == ScrollDirection.reverse) {
                          nav.setBottomBarVisibility(
                            false,
                          ); // Hide on scroll down
                        } else if (notification.direction ==
                            ScrollDirection.forward) {
                          nav.setBottomBarVisibility(true); // Show on scroll up
                        }
                        return true;
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: eventsController.filteredEvents.length,
                        itemBuilder: (context, index) {
                          return _buildEventCard(
                            eventsController.filteredEvents[index],
                            context,
                          );
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // 3. Merged Card Design (Static Design + Dynamic Data)
  Widget _buildEventCard(Event event, BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Event Image from XAMPP folder
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                child: event.image.isEmpty
                    ? Container(
                        height: 180,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.event,
                          size: 50,
                          color: Colors.grey,
                        ),
                      )
                    : Image.asset(
                        event.image.startsWith('assets/')
                            ? event.image
                            : "assets/${event.image}",
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print(
                            "Failed to load asset image: $error",
                          ); // Prints the exact issue to your console
                          return Container(
                            height: 180,
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.event,
                              size: 50,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
              ),
              // Dynamic Tag (Using a placeholder or a fallback since model doesn't have tag)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    event.tag.toUpperCase(),
                    style: const TextStyle(
                      color: primarycolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date from Model
                Text(
                  event.date,
                  style: const TextStyle(
                    color: primarycolor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                // Title (Name) from Model
                Text(
                  event.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  event.desc,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 16),
                // Buttons from Design
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primarycolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => _confirmRegistration(event),
                        child: const Text(
                          "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => _showEventDetails(context, event),
                        child: const Text("Details"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEventDetails(BuildContext context, Event event) {
    Get.bottomSheet(
      isScrollControlled: true,
      Container(
        height: Get.height * 0.8, // Covers 80% of screen
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          children: [
            // Header with Close Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      event.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            // Image and Description
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        event.image.startsWith('assets/')
                            ? event.image
                            : "assets/${event.image}",
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      event.date,
                      style: const TextStyle(
                        color: primarycolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(event.desc, style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            // Final Registration Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primarycolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Get.back(); // Closes the details panel
                    _confirmRegistration(event);
                  },
                  child: const Text(
                    "Proceed to Register",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmRegistration(Event event) {
    Get.defaultDialog(
      title: "Confirm Registration",
      titlePadding: const EdgeInsets.only(top: 20),
      contentPadding: const EdgeInsets.all(20),
      middleText: "Would you like to register for ${event.name}?",
      textConfirm: "Register",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      buttonColor: primarycolor,
      cancelTextColor: primarycolor,
      onConfirm: () {
        Get.back(); // Closes dialog
        Get.find<EventsController>().registerForEvent(event.id);
      },
    );
  }
}
