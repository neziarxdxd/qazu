import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qazu/account_setting.dart';
import 'package:qazu/button.dart';
import 'package:qazu/db/models/exam_taker_db.dart';
import 'package:qazu/db/models/exam_taker_model.dart';
import 'package:qazu/db/models/quiz_model.dart';
import 'package:qazu/db/quiz_add.dart';
import 'package:qazu/login.dart';
import 'package:qazu/quiz_app.dart';

class QuizListStudents extends StatefulWidget {
  final String? emailTaker;
  final String? fullNameTaker;
  final int? studentKeyID;

  const QuizListStudents(
      {super.key, this.emailTaker, this.fullNameTaker, this.studentKeyID});

  @override
  State<QuizListStudents> createState() => _QuizListStudentsState();
}

class _QuizListStudentsState extends State<QuizListStudents> {
  late Future<List<ExamTakerModel>> listQuiz;

  late QuizDB quizDB;
  late Box box;
  late Box boxForExamTaker;
  late ExamTakerDB examTakerDB;
  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    box = Hive.box("quizzes");
    boxForExamTaker = Hive.box("examTakers");
    // TODO: implement initState
    quizDB = QuizDB();
    examTakerDB = ExamTakerDB();
    // open mydb then get the box accounts

    listQuiz = examTakerDB.getAllExamTaker(widget.emailTaker!.toString());
  }

  TextEditingController controllerExamCode = TextEditingController();

  // check if the exam code is already taken for validation text field
  bool checkExamCode(String examCode) {
    return examTakerDB.checkIfAccessCodeIsAdded(
        controllerExamCode.text, widget.emailTaker!);
  }

  bool checkIfQuizExists(String examCode) {
    return quizDB.checkIfAccessCodeExists(controllerExamCode.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // action button with modal for exam code then add to exam taker
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // open modal alert dialog
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Add Access Code"),
                  content: Form(
                    key: _formKey,
                    child: Container(
                      height: 300,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter access code";
                              } else if (checkExamCode(value)) {
                                return "Access code already added";
                              } else if (!checkIfQuizExists(value)) {
                                return "Access code does not exist";
                              }

                              return null;
                            },
                            controller: controllerExamCode,
                            decoration: const InputDecoration(
                                labelText: "Quiz Code",
                                hintText: "Enter Quiz Code"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    ButtonCustom(
                      text: "Enter Access Code",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print("Add Quiz");
                          examTakerDB.addExamTaker(ExamTakerModel(
                            finishedTime: 2,
                            examCode: controllerExamCode.text,
                            email: widget.emailTaker,
                            fullName: widget.fullNameTaker,
                            studentKeyID: widget.studentKeyID.toString(),
                          ));
                          examTakerDB.printAllExamTaker();
                          // close modal

                          // refresh the list
                          setState(() {
                            // get the list again by student key id
                            listQuiz = examTakerDB
                                .getAllExamTaker(widget.emailTaker!.toString());
                          });
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Container(
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Quiz App"),
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: () {
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const QuizListStudents()));
              },
              title: const Text("Quizzes"),
            ),
            ListTile(
              onTap: () {
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const QuizListStudents()));
              },
              title: const Text("Done Quizzes"),
            ),
            ListTile(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginAccounts()));
              },
              title: const Text("Logout"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Quiz List"),
      ),
      body: FutureBuilder(
        future: listQuiz,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("Line 155 ${snapshot.data!.toString()}");
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Text("Empty"),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      // make it dismissible
                      return Dismissible(
                        background: Container(
                          color: Colors.red,
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          // delete the quiz

                          setState(() {
                            // refresh the page
                          });
                        },
                        child: ListTile(
                          onTap: () {
                            print(
                                "Quiz!XD ID: ${snapshot.data![index].toString()}");
                            print('''MyWidget: ${MyWidget(
                              fullNameTaker: widget.fullNameTaker ?? '',
                              studentKeyID: widget.studentKeyID ?? 0,
                              examCode: snapshot.data![index].examCode!,
                              duration: 10,
                              emailTaker: widget.emailTaker ?? '',
                              quizDescription:
                                  snapshot.data![index].quizID ?? '',
                              quizTitle: snapshot.data![index].quizTitle ?? '',
                            )}
                              
                            ''');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyWidget(
                                  fullNameTaker: widget.fullNameTaker ?? '',
                                  studentKeyID: widget.studentKeyID ?? 0,
                                  examCode: snapshot.data![index].examCode!,
                                  duration: 10,
                                  emailTaker: widget.emailTaker ?? '',
                                  quizDescription:
                                      snapshot.data![index].quizID ?? '',
                                  quizTitle:
                                      snapshot.data![index].quizTitle ?? '',
                                ),
                              ),
                            );
                          },
                          title: Text(snapshot.data![index].fullName!),
                          // score with is done or not with icon
                          trailing: Text(widget.studentKeyID.toString()),
                          // exam code
                          subtitle: Text(
                              "ExamCode: ${snapshot.data![index].examCode.toString()}"),
                        ),
                      );
                    },
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
