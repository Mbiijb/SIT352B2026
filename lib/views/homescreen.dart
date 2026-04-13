import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/controllers/navigationController.dart';
import 'package:flutter_application_1/views/dashboard.dart';
import 'package:flutter_application_1/views/events.dart';
import 'package:flutter_application_1/views/giving.dart';
import 'package:flutter_application_1/views/profile.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final NavigationController navController = Get.put(NavigationController());

  final List<Widget> _pages = <Widget>[
    Dashboard(),
    Giving(),
    const Center(child: Text('Create')),
    EventScreen(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                floating: true, // Collapses as soon as you scroll down
                snap: true, // Snaps back into view as soon as you scroll up
                automaticallyImplyLeading: false,
                backgroundColor:
                    context.theme.appBarTheme.backgroundColor ?? secondarycolor,
                leading: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () =>
                        navController.changeIndex(0), // Sets to Dashboard
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/logo.png'),
                    ),
                  ),
                ),
                actions: [
                  _buildAppBarIcon(
                    icon: Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    onTap: () => Get.changeThemeMode(
                      Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                    ),
                  ),
                  _buildNotificationDropdown(),
                  _buildAppBarIcon(
                    icon: Icons.person_outline,
                    onTap: () =>
                        navController.changeIndex(4), // Sets to Profile
                  ),
                ],
              ),
            ];
          },
          body: _pages[navController.selectedIndex.value],
        ),
      ),
      bottomNavigationBar: Obx(
        () => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: navController.isBottomBarVisible.value
              ? 75
              : 0, // Collapses to 0
          child: Wrap(
            // Wrap prevents overflow errors when height is 0
            children: [
              CurvedNavigationBar(
                index: navController.selectedIndex.value,
                backgroundColor: context.theme.scaffoldBackgroundColor,
                color: primarycolor,
                buttonBackgroundColor: primarycolor,
                items: const [
                  Icon(Icons.dashboard, color: Colors.white),
                  Icon(Icons.favorite, color: Colors.white),
                  Icon(Icons.add, color: Colors.white),
                  Icon(Icons.event, color: Colors.white),
                  Icon(Icons.person, color: Colors.white),
                ],
                onTap: (index) => navController.changeIndex(index),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarIcon({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: IconButton(icon: Icon(icon), onPressed: onTap),
    );
  }

  Widget _buildNotificationDropdown() {
    return PopupMenuButton(
      icon: const Icon(Icons.notifications_none),
      itemBuilder: (context) => [
        const PopupMenuItem(child: Text("Service starts in 30 mins")),
        const PopupMenuItem(child: Text("New Event: Youth Camp")),
      ],
    );
  }
}
