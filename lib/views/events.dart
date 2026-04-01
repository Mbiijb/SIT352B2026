import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

var myEvents = [];
bool loaded = false;

class Event extends StatefulWidget {
  const Event({super.key});

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  @override
  void initState() {
    super.initState();
    fetchevents();
  }

  void fetchevents() async {
    var response = await http.get(
      Uri.parse('http://localhost/church_db/event.php'),
    );
    if (response.statusCode == 200) {
      var serverData = jsonDecode(response.body);
      var eventData = serverData["data"];
      for (var event in eventData) {
        myEvents.add(
          Event(
            name: event["name"],
            date: event["date"],
            image: event["image"],
          ),
        );
      }
      setState(() => loaded = true);
    } else {
      GetSnackBar(
        title: "Error",
        message: "Failed to load events",
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 3),
      ).show();
      print("Failed to load events");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: myEvents.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Image.network(
              "http://localhost/church_db/event_images/}",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.event, size: 100, color: Colors.grey),
            ),
            Column(
              children: [
                Text(myEvents[index].name),
                Text(myEvents[index].date),
              ],
            ),
          ],
        );
      },:Center(child: Text("No events found")
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/configs/colors.dart';

// class Event extends StatelessWidget {
//   const Event({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: "Find an event...",
//                 prefixIcon: const Icon(Icons.search),
//                 filled: true,
//                 fillColor: Colors.grey[100],
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               children: [
//                 _buildEventCard(
//                   "Community Drive",
//                   "Oct 15, 2024 • 9:00 AM",
//                   "Join our local outreach to help provide essentials for families in need.",
//                   "OUTREACH",
//                   'assets/drive.jpg',
//                 ),
//                 _buildEventCard(
//                   "Youth Summer Camp",
//                   "Jun 12 - 16, 2025",
//                   "A high-energy week of fun, friendship, and growing in faith.",
//                   "YOUTH",
//                   'assets/camp.jpg',
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEventCard(
//     String title,
//     String date,
//     String desc,
//     String tag,
//     String img,
//   ) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 20),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//       elevation: 2,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(24),
//                 ),
//                 child: Container(
//                   height: 180,
//                   width: double.infinity,
//                   color: Colors.grey[300],
//                 ), // Replace with Image.asset
//               ),
//               Positioned(
//                 top: 12,
//                 right: 12,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     tag,
//                     style: TextStyle(
//                       color: primarycolor,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 10,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   date,
//                   style: TextStyle(
//                     color: primarycolor,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   desc,
//                   style: const TextStyle(color: Colors.grey, fontSize: 13),
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: primarycolor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         onPressed: () {},
//                         child: const Text(
//                           "Register",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: OutlinedButton(
//                         style: OutlinedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         onPressed: () {},
//                         child: const Text("Details"),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
