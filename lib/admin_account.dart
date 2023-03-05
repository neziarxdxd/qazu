import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qazu/button.dart';
import 'package:qazu/db/account_model.dart';
import 'package:qazu/db/list_accounts.dart';
import 'package:qazu/db/models/user_model.dart';
import 'package:qazu/listaccountpage.dart';
import 'package:random_password_generator/random_password_generator.dart';

class AdminAccountPage extends StatefulWidget {
  const AdminAccountPage({super.key});

  @override
  State<AdminAccountPage> createState() => _AdminAccountPageState();
}

class _AdminAccountPageState extends State<AdminAccountPage> {
  @override
  String? dropdownValue;
  late Accounts accountSettings;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final password = RandomPasswordGenerator();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    accountSettings = Accounts();
  }

  Widget build(BuildContext context) {
    TextEditingController controllerFirstName = TextEditingController();
    TextEditingController controllerLastName = TextEditingController();
    TextEditingController controllerEmail = TextEditingController();
    TextEditingController controllerPassword = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Admin Account",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton(
                      items: [
                        DropdownMenuItem(
                          child: Text("Student"),
                          value: "student",
                        ),
                        DropdownMenuItem(
                          child: Text("Teacher"),
                          value: "teacher",
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          dropdownValue = value;
                        });
                      },
                      hint: Text("Select Account Type"),
                      value: dropdownValue ?? "student",
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? "Enter First Name" : null,
                    controller: controllerFirstName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'First Name',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? "Enter Last Name" : null,
                    controller: controllerLastName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Last Name',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    // if no @cca.edu.ph it is invalid
                    validator: (value) {
                      if (value!.contains('@ccc.edu.ph')) {
                        return null;
                      } else {
                        return 'Please enter a valid email';
                      }
                    },
                    controller: controllerEmail =
                        TextEditingController(text: "@ccc.edu.ph"),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Email',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    // password should be 16 characters and above, should contain letters, numbers, special characters and uppercase
                    validator: (value) {
                      if (value!.length >= 12 &&
                          value.contains(RegExp(r'[A-Z]')) &&
                          value.contains(RegExp(r'[a-z]')) &&
                          value.contains(RegExp(r'[0-9]')) &&
                          value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                        return null;
                      } else {
                        return 'Password should be 16 characters and above';
                      }
                    },

                    // generate random password
                    controller: controllerPassword = TextEditingController(
                      // text: password.randomPassword(
                      //     letters: true,
                      //     passwordLength: 13,
                      //     numbers: true,
                      //     uppercase: true,
                      //     specialChar: true)),
                      text: "Password123456!",
                    ),

                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Password',
                    ),
                  ),
                ),
                // Picker
                SizedBox(
                  height: 20,
                ),
                // DropdownButton with two options Student and Teacher

                SizedBox(
                  height: 20,
                ),
                ButtonCustom(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("HIii I'm working");
                      // Add account to database
                      UserModel account = UserModel(
                        firstName: controllerFirstName.text,
                        lastName: controllerLastName.text,
                        email: controllerEmail.text,
                        password: controllerPassword.text,
                        type: dropdownValue ?? "student",
                        // generate random id length 32
                        id: 0,
                      );
                      accountSettings.createAccount(account);
                      // Clear text fields
                      controllerFirstName.clear();
                      controllerLastName.clear();
                      controllerEmail.clear();
                      controllerPassword.clear();
                      accountSettings.getAccounts();
                      // snackbar to show that account has been added
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Account has been added'),
                        ),
                      );
                      // print all accounts
                      // accountSettings.getAccounts();
                    }
                  },
                  text: "Add Account",
                  color: Colors.blue,
                ),
                SizedBox(
                  height: 20,
                ),
                // button directs to list of accounts
                ButtonCustom(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListAccounts()),
                    );
                  },
                  text: "List Accounts",
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
