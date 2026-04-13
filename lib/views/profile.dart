import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/controllers/loginController.dart';
import 'package:flutter_application_1/controllers/navigationController.dart';
import 'package:flutter_application_1/views/login.dart';
import 'package:flutter_application_1/views/updateprofilescreen.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final LoginController loginController = Get.isRegistered<LoginController>()
      ? Get.find<LoginController>()
      : Get.put(LoginController());
  final NavigationController nav = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        if (notification.direction == ScrollDirection.reverse) {
          nav.setBottomBarVisibility(false); // Hide on scroll down
        } else if (notification.direction == ScrollDirection.forward) {
          nav.setBottomBarVisibility(true); // Show on scroll up
        }
        return true;
      },
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Image Section
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/profile.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: primarycolor,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // FIX: Wrap with Obx and ensure value is read correctly
              Obx(() {
                // Combine fname and lname for the UI
                String displayFullName =
                    "${loginController.firstName.value} ${loginController.lastName.value}";
                return Text(
                  displayFullName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.church, size: 16, color: primarycolor),
                  const SizedBox(width: 5),
                  const Text(
                    "Community Church",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const Text(
                "Faithful Member since January 2026",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 25),

              //Giving Preferences Section
              _buildSectionHeader(
                Icons.volunteer_activism,
                "Giving Preferences",
              ),
              const SizedBox(height: 10),
              _buildCardWrapper([
                ProfileMenuWidget(
                  title: "Preferred Payment",
                  subtitle: "Visa ending in •••• 4242",
                  icon: Icons.credit_card,
                  onPress: () {},
                ),
                const Divider(height: 1),
                ProfileMenuWidget(
                  title: "Recurring Gifts",
                  subtitle: "2 active recurring donations",
                  icon: Icons.sync,
                  onPress: () {},
                ),
              ]),

              const SizedBox(height: 25),

              //Account Settings Section
              _buildSectionHeader(Icons.person_outline, "Account Settings"),
              const SizedBox(height: 10),
              _buildCardWrapper([
                ProfileMenuWidget(
                  title: "Edit Profile",
                  icon: Icons.person_outline,
                  onPress: () => Get.to(() => const Updateprofilescreen()),
                ),
                const Divider(height: 1),
                ProfileMenuWidget(
                  title: "Notification Settings",
                  icon: Icons.notifications_none,
                  onPress: () {},
                ),
                const Divider(height: 1),
                ProfileMenuWidget(
                  title: "Information",
                  icon: Icons.info_outline,
                  onPress: () {},
                ),
                const Divider(height: 1),
                ProfileMenuWidget(
                  title: "Help & Support",
                  icon: Icons.help_outline,
                  onPress: () {},
                ),
              ]),

              const SizedBox(height: 30),

              // Sign Out Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () => Get.offAll(() => LoginScreen()),
                  icon: const Icon(Icons.logout),
                  label: const Text(
                    "Sign Out",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primarycolor,
                    side: BorderSide(color: primarycolor.withOpacity(0.5)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to build headers with icons
  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: primarycolor, size: 20),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Helper to wrap list tiles in a card-like container
  Widget _buildCardWrapper(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.subtitle,
    this.endIcon = true,
    this.textcolor,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textcolor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      leading: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: primarycolor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: primarycolor),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600, color: textcolor),
      ),
      subtitle: subtitle != null
          ? Text(subtitle!, style: const TextStyle(fontSize: 12))
          : null,
      trailing: endIcon
          ? const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14)
          : null,
    );
  }
}
