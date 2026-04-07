import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/controllers/eventsController.dart';
import 'package:flutter_application_1/models/event_models.dart';
import 'package:get/get.dart';

class EventScreen extends StatelessWidget {
  EventScreen({super.key});

  final EventsController eventsController = Get.find<EventsController>();

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
                  : ListView.builder(
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
                child: Image.network(
                  "http://localhost/church_db/event_images/${event.image}",
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.event,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
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
                  child: const Text(
                    "CHURCH EVENT",
                    style: TextStyle(
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
                const Text(
                  "Join us for this special gathering as we grow together in faith and community.",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
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
                        onPressed: () {},
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
                        onPressed: () {},
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
}
