import 'package:flutter/material.dart';
import 'package:qazu/admin_account.dart';
import 'package:qazu/button.dart';
import 'package:qazu/db/list_accounts.dart';
import 'package:qazu/db/models/user_model.dart';
import 'package:qazu/list_of_quiz.dart';
import 'package:qazu/listaccountpage.dart';
import 'package:qazu/prof/add_quiz.dart';
import 'package:qazu/quiz_app.dart';

class LoginAccounts extends StatefulWidget {
  const LoginAccounts({super.key});

  @override
  State<LoginAccounts> createState() => _LoginAccountsState();
}

class _LoginAccountsState extends State<LoginAccounts> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  late Accounts accountSettings;
  late UserModel user;
  late List<UserModel> listUsers;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    accountSettings = Accounts();
    accountSettings.getAccounts().then((value) {
      listUsers = value;
    });
    // auto refresh

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // auto refresh
    accountSettings.getAccounts().then((value) {
      listUsers = value;
    });
    return Scaffold(
      // appbar with timer with number in right and back button at left no color
      // Hex color FAFAFA for background
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),

      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
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
                    child: TextFormField(
                      controller: controllerEmail,
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
                      obscureText: true,
                      controller: controllerPassword,
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
                    onPressed: () {
                      String email = controllerEmail.text;
                      String password = controllerPassword.text;
                      print("Submitted");
                      print(email);
                      print("Password: $password");

                      bool isUserExist = listUsers.any((element) =>
                          element.email == controllerEmail.text &&
                          element.password == controllerPassword.text);

                      print("isUserExist: $isUserExist");
                      int index = listUsers.indexWhere((element) =>
                          element.email == controllerEmail.text &&
                          element.password == controllerPassword.text);
                      print("index: $index");
                      String getRole =
                          index == -1 ? "" : listUsers[index].type!;
                      print("getRole: $getRole");

                      if (isUserExist) {
                        String firstName = listUsers[index].firstName!;
                        String lastName = listUsers[index].lastName!;
                        String fullName = firstName + " " + lastName;
                        print("fullName: $fullName");
                        int studentIDKey = listUsers[index].id!;
                        print("id: $studentIDKey");
                        String emailTaker = listUsers[index].email!;
                        print("email: $email");

                        if (getRole.toLowerCase() == 'teacher') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddQuizPage(
                                teacherEmail: email,
                              ),
                            ),
                          );
                        } else if (getRole == 'student') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizListStudents(
                                studentKeyID: studentIDKey,
                                fullNameTaker: fullName,
                                emailTaker: emailTaker,
                              ),
                            ),
                          );
                        }
                        //}
                      } else {
                        if (email == 'admin' && password == 'admin') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AdminAccountPage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Invalid email or password'),
                            ),
                          );
                        }
                      }
                    },
                    text: "Login",
                    color: Colors.blue,
                  )
                  // Login button
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
