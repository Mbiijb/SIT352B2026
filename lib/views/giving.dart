import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';

class Giving extends StatelessWidget {
  const Giving({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: secondarycolor,
          elevation: 0,
          actions: [
            // History Button added here
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.history, color: Colors.black),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Mission Banner
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: primarycolor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "OUR MISSION",
                              style: TextStyle(
                                color: primarycolor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Support Our Community",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "\"Each one must give as he has decided in his heart.\"",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: secondarycolor,
                        child: Icon(
                          Icons.volunteer_activism,
                          color: primarycolor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const TabBar(
                labelColor: primarycolor,
                unselectedLabelColor: Colors.grey,
                indicatorColor: primarycolor,
                tabs: [
                  Tab(text: "Tithe"),
                  Tab(text: "Offering"),
                  Tab(text: "Pledge"),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildGivingCard(
                      "Tithe",
                      "Traditional 10% monthly contribution",
                      Icons.savings_outlined,
                    ),
                    const SizedBox(height: 16),
                    _buildGivingCard(
                      "General Offering",
                      "Special gifts and spontaneous giving",
                      Icons.card_giftcard,
                    ),
                    const SizedBox(height: 16),
                    _buildGivingCard(
                      "Building Pledge",
                      "Committed support for church projects",
                      Icons.architecture,
                    ),

                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.history, color: primarycolor),
                          const SizedBox(width: 12),
                          const Text(
                            "Make this a monthly gift",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Switch(
                            value: false,
                            onChanged: (v) {},
                            activeThumbColor: primarycolor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGivingCard(String title, String sub, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: primarycolor.withOpacity(0.1),
              child: Icon(icon, color: primarycolor),
            ),
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(sub, style: const TextStyle(fontSize: 12)),
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixText: "KSh ",
              hintText: "0.00",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: primarycolor),
              ),
              fillColor: Colors.grey[50],
              filled: true,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primarycolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Give Now",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
