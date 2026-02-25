import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text(
            "Login Screen",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/login.png', height: 100, width: 100),
            Text(
              "Login Screen",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            ),
            //SizedBox(height: 20),
            Text("Enter username"),
            TextField(),
            //SizedBox(height: 30),
            Text("Enter password"),
            TextField(),
            SizedBox(height: 30),
            MaterialButton(
              onPressed: () {},
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              color: Colors.cyan,
            ),
          ],
        ),
      ),
    ),
  );
}
