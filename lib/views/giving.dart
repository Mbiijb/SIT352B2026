import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/controllers/givingController.dart';
import 'package:flutter_application_1/controllers/navigationController.dart';
import 'package:flutter_application_1/views/giving_history.dart';
import 'package:get/get.dart';

class Giving extends StatelessWidget {
  const Giving({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put automatically finds the existing instance created in login.dart
    final GivingController controller = Get.put(GivingController());
    final NavigationController nav = Get.find<NavigationController>();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: secondarycolor,
          elevation: 0,
          actions: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: IconButton(
                onPressed: () {
                  Get.to(() => const GivingHistory());
                },
                icon: const Icon(Icons.history, color: Colors.black),
              ),
            ),
          ],
        ),
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.reverse) {
              nav.setBottomBarVisibility(false); // Hide on scroll down
            } else if (notification.direction == ScrollDirection.forward) {
              nav.setBottomBarVisibility(true); // Show on scroll up
            }
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Mission Banner (Existing Design)
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
                        const Expanded(
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
                              SizedBox(height: 8),
                              Text(
                                "Support Our Community",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
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

                TabBar(
                  labelColor: primarycolor,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: primarycolor,
                  onTap: (index) {
                    // Request focus on the matching text field to auto-scroll to it
                    if (index == 0) controller.titheFocus.requestFocus();
                    if (index == 1) controller.offeringFocus.requestFocus();
                    if (index == 2) controller.pledgeFocus.requestFocus();
                  },
                  tabs: const [
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
                        controller.titheController,
                        controller.titheFocus,
                        () => controller.processGiving(
                          "Tithe",
                          controller.titheController.text,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildGivingCard(
                        "General Offering",
                        "Special gifts and spontaneous giving",
                        Icons.card_giftcard,
                        controller.offeringController,
                        controller.offeringFocus,
                        () => controller.processGiving(
                          "Offering",
                          controller.offeringController.text,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildGivingCard(
                        "Building Pledge",
                        "Committed support for church projects",
                        Icons.architecture,
                        controller.pledgeController,
                        controller.pledgeFocus,
                        () => controller.processGiving(
                          "Pledge",
                          controller.pledgeController.text,
                        ),
                      ),

                      const SizedBox(height: 20),
                      // The Interactive Switch
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? Colors.grey[900]
                              : Colors.white,
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
                            Obx(
                              () => Switch(
                                value: controller.isMonthly.value,
                                onChanged: (v) =>
                                    controller.isMonthly.value = v,
                                activeThumbColor: primarycolor,
                              ),
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
      ),
    );
  }

  Widget _buildGivingCard(
    String title,
    String sub,
    IconData icon,
    TextEditingController textController,
    FocusNode focusNode,
    VoidCallback onGive,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Colors.grey[900] : Colors.white,
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
            controller: textController,
            focusNode: focusNode,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
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
              fillColor: Get.isDarkMode ? Colors.black26 : Colors.grey[50],
              filled: true,
            ),
          ),
          const SizedBox(height: 12),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primarycolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: onGive,
                child: const Text(
                  "Give Now",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
