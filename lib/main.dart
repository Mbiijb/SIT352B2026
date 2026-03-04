import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: secondarycolor,
        // appBar: AppBar(
        //   backgroundColor: primarycolor,
        //   title: Text(
        //     "Login Screen",
        //     style: TextStyle(color: Colors.white, fontSize: 20),
        //   ),
        //   centerTitle: true,
        // ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/login.png', height: 100, width: 100),
                // Text(
                //   "Login Screen",
                //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                // ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Enter username",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primarycolor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Use email or phone number",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Enter password",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primarycolor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.visibility),
                  ),
                ),
                SizedBox(height: 30),
                // MaterialButton(
                //   onPressed: () {},
                //   color: primarycolor,
                //   child: Text(
                //     "Login",
                //     style: TextStyle(color: Colors.white, fontSize: 20),
                //   ),
                // ),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primarycolor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                  child: Row(
                    children: [
                      Text("Don't have an account?"),
                      SizedBox(width: 5),
                      Text("Sign up", style: TextStyle(color: primarycolor)),
                      Spacer(),
                      Text("Forgot password?"),
                      SizedBox(width: 5),
                      Text("Reset", style: TextStyle(color: primarycolor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
