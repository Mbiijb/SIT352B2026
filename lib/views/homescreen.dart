import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // remove back button
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/logo.png', // update path if needed
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          ),
        ),
        backgroundColor: primarycolor,
        centerTitle: true,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: secondarycolor,
        buttonBackgroundColor: primarycolor,
        items: const <Widget>[
          Icon(Icons.dashboard, size: 30),
          Icon(Icons.favorite, size: 30),
          Icon(Icons.add, size: 30),
          Icon(Icons.event, size: 30),
          Icon(Icons.person_outline, size: 30),
        ],
        onTap: (index) {
          //Handle button tap
        },
      ),
    );
  }
}
