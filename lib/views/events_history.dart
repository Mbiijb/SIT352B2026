import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/controllers/eventsController.dart';
import 'package:get/get.dart';

class EventsHistory extends StatefulWidget {
  const EventsHistory({super.key});

  @override
  State<EventsHistory> createState() => _EventsHistoryState();
}

class _EventsHistoryState extends State<EventsHistory> {
  final EventsController eController = Get.find<EventsController>();

  @override
  void initState() {
    super.initState();
    // Fetch the latest registrations as soon as the page opens
    eController.fetchUserRegistrations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Registered Events",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Obx(
        () => eController.isFetchingRegistrations.value
            ? const Center(child: CircularProgressIndicator())
            : eController.registeredEvents.isEmpty
            ? const Center(
                child: Text(
                  "You haven't registered for any events yet.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: eController.registeredEvents.length,
                itemBuilder: (context, index) {
                  final event = eController.registeredEvents[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: primarycolor.withOpacity(0.1),
                        child: const Icon(
                          Icons.event_available,
                          color: primarycolor,
                        ),
                      ),
                      title: Text(
                        event.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        event.date,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
