import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qazu/button.dart';
import 'package:qazu/db/models/exam_taker_db.dart';
import 'package:qazu/db/models/exam_taker_model.dart';
import 'package:qazu/db/models/quiz_model.dart';
import 'package:qazu/db/quiz_add.dart';
import 'package:qazu/prof/add_questions.dart';

class ViewFinishedExam extends StatefulWidget {
  const ViewFinishedExam({super.key, required this.examCode});
  final String examCode;

  @override
  State<ViewFinishedExam> createState() => _ViewFinishedExamState();
}

class _ViewFinishedExamState extends State<ViewFinishedExam> {
  TextEditingController controllerQuizName = TextEditingController();
  TextEditingController controllerQuizDescription = TextEditingController();
  TextEditingController controllerQuizDuration = TextEditingController();
  TextEditingController controllerExamCode = TextEditingController();
  late Future<List<QuizModel>> listQuiz;
  late Future<List<ExamTakerModel>> listExamTaker;

  late QuizDB quizDB;
  late Box box;
  final _formKey = GlobalKey<FormState>();
  late ExamTakerDB examTakerDB;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    quizDB = QuizDB();
    // open mydb then get the box accounts
    box = Hive.box("quizzes");
    box = Hive.box("examTakers");
    listQuiz = quizDB.getQuizzes();
    examTakerDB = ExamTakerDB();
    listExamTaker = examTakerDB.getAllWhoTookTheExamByExamCode(widget.examCode);
  }

  // check if the exam code is already taken for validation text field
  bool checkExamCode(String examCode) {
    bool isExamCodeTaken = false;
    for (int i = 0; i < box.length; i++) {
      if (box.getAt(i)!.examCode == examCode) {
        isExamCodeTaken = true;
        break;
      }
    }
    return isExamCodeTaken;
  }

  bool invalidExamCode(String examCode) {
    // Only Letters and Numbers
    RegExp regExp = RegExp(r"^[a-zA-Z0-9]+$");
    return regExp.hasMatch(examCode);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of exam"),
      ),
      body: FutureBuilder(
        future: listExamTaker,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Text("No Exam Taker"),
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
                          trailing: Text(
                            "Score: ${snapshot.data![index].score == null ? "0" : snapshot.data![index].score!.toInt().toString()}",
                          ),
                          title: Text(snapshot.data![index].fullName!),
                          subtitle: Text(
                              "${snapshot.data![index].email.toString()} "),
                        ),
                      );
                    },
                  );
          } else {
            return const Center(
              child: Text("No Exam Taker"),
            );
          }
        },
      ),
    );
  }
}
