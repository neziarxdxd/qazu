import 'package:flutter/material.dart';
import 'package:qazu/button.dart';

class LoginAccounts extends StatefulWidget {
  const LoginAccounts({super.key});

  @override
  State<LoginAccounts> createState() => _LoginAccountsState();
}

class _LoginAccountsState extends State<LoginAccounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar with timer with number in right and back button at left no color
      // Hex color FAFAFA for background
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),

      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Email with text field and icon
                // addd image
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Image.asset(
                  'assets/images/login.jpg',
                  // make it responsive
                  width: 200,
                  height: 200,
                ),
                Center(
                  child: Text(
                    'Welcome to QuizApp',
                    style: TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(255, 47, 46, 46),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                // Password with text field and icon
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonCustom(
                  text: "Login",
                  color: Colors.blue,
                )
                // Login button
              ],
            ),
          ],
        ),
      )),
    );
  }
}
