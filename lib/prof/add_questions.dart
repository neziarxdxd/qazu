import 'dart:math';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qazu/button.dart';
import 'package:qazu/db/models/question_answer_model.dart';
import 'package:qazu/db/models/quiz_model.dart';
import 'package:qazu/db/quiz_add.dart';

class AddQuestionPage extends StatefulWidget {
  // key id of the quiz
  final int quizId;
  final String title;
  final String description;
  final double duration;
  final String examCode;

  const AddQuestionPage(
      {Key? key,
      required this.quizId,
      required this.title,
      required this.description,
      required this.duration,
      required this.examCode})
      : super(key: key);

  @override
  State<AddQuestionPage> createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController controllerQuestion = TextEditingController();
  TextEditingController conrollerAnswer = TextEditingController();
  TextEditingController controllerOpt1 = TextEditingController();
  TextEditingController controllerOpt2 = TextEditingController();
  TextEditingController controllerOpt3 = TextEditingController();

  late Future<List<QuestionAnswerModel>> listQuiz;

  late QuizDB quizDB;
  late Box box;
  late Box boxQuestions;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    quizDB = QuizDB();
    // open mydb then get the box accounts
    box = Hive.box("quizzes");
    boxQuestions = Hive.box("questionsAndAnswers");

    listQuiz = quizDB.getQuestionByTeacher(widget.quizId);
    print("List Quiz: ${listQuiz.toString()}");
    print("ADD QUESTION Quiz ID: ${widget.quizId}");
  }

  String? validationMessage(String value) {
    if ((value == conrollerAnswer.text) && value == conrollerAnswer.text) {
      return "Answer should not be the same as the options";
    }
    if (value.isEmpty) {
      return "Field is required";
    }

    return null;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // open modal alert dialog
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Add Question"),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            // Question
                            TextFormField(
                              validator: (value) {
                                validationMessage(value!);
                              },
                              controller: controllerQuestion,
                              decoration: const InputDecoration(
                                  labelText: "Question",
                                  hintText: "Enter Question"),
                            ),
                            // Answer
                            TextFormField(
                              validator: (value) => validationMessage(value!),
                              controller: conrollerAnswer,
                              decoration: const InputDecoration(
                                  labelText: "Answer",
                                  hintText: "Enter Answer"),
                            ),
                            // Option 1
                            TextFormField(
                              validator: (value) => validationMessage(value!),
                              controller: controllerOpt1,
                              decoration: const InputDecoration(
                                  labelText: "Option 1",
                                  hintText: "Enter Option 1"),
                            ),
                            // Option 2
                            TextFormField(
                              validator: (value) => validationMessage(value!),
                              controller: controllerOpt2,
                              decoration: const InputDecoration(
                                  labelText: "Option 2",
                                  hintText: "Enter Option 2"),
                            ),
                            // Option 3
                            TextFormField(
                              validator: (value) => validationMessage(value!),
                              controller: controllerOpt3,
                              decoration: const InputDecoration(
                                  labelText: "Option 3",
                                  hintText: "Enter Option 3"),
                            ),
                            // Option 4

                            const SizedBox(
                              height: 20,
                            ),
                            ButtonCustom(
                              text: "Add Quiz",
                              onPressed: () {
                                /// get the existing questions

                                // add the new question to the existing questions
                                print(
                                    "LORD help me to this huhuh ${widget.examCode}");
                                quizDB.addQuestionToQuiz(
                                    widget.quizId,
                                    QuestionAnswerModel(
                                      question: controllerQuestion.text,
                                      answer: conrollerAnswer.text,
                                      option1: controllerOpt1.text,
                                      option2: controllerOpt2.text,
                                      option3: controllerOpt3.text,
                                      quizId: widget.quizId,
                                      examCode: widget.examCode,
                                    ));

                                // print existing questions

                                Navigator.pop(context);

                                // refresh the page
                                setState(() {
                                  // refresh the page
                                  listQuiz = quizDB
                                      .getQuestionByTeacher(widget.quizId);
                                  print(
                                      "ADD QUESTION Quiz ID XXX: ${widget.quizId}");
                                  listQuiz.then((value) {
                                    for (var item in value) {
                                      print(
                                          "QuestionEXAMCODE: ${item.examCode}");
                                    }
                                  });
                                });
                                // clear the text fields
                                controllerQuestion.clear();
                                conrollerAnswer.clear();
                                controllerOpt1.clear();
                                controllerOpt2.clear();
                                controllerOpt3.clear();
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Add Quiz"),
      ),
      body: FutureBuilder(
        future: listQuiz,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Text("Just press the + button to add a questions"),
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
                          // edit the question and answer modal
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Edit Question"),
                                  content: SingleChildScrollView(
                                    child: Form(
                                      key: _formKey,
                                      child: Column(children: [
                                        TextFormField(
                                          validator: (value) => value!.isEmpty
                                              ? "Question is required"
                                              : null,
                                          controller: controllerQuestion =
                                              TextEditingController(
                                                  text: snapshot
                                                      .data![index].question),
                                          decoration: const InputDecoration(
                                              labelText: "Question",
                                              hintText: "Enter Question"),
                                        ),
                                        // Answer
                                        TextFormField(
                                          validator: (value) => value!.isEmpty
                                              ? "Answer is required"
                                              : null,
                                          controller: conrollerAnswer =
                                              TextEditingController(
                                                  text: snapshot
                                                      .data![index].answer),
                                          decoration: const InputDecoration(
                                              labelText: "Answer",
                                              hintText: "Enter Answer"),
                                        ),
                                        // Option 1
                                        TextFormField(
                                          validator: (value) => value!.isEmpty
                                              ? "Option 1 is required"
                                              : null,
                                          controller: controllerOpt1 =
                                              TextEditingController(
                                                  text: snapshot
                                                      .data![index].option1),
                                          decoration: const InputDecoration(
                                              labelText: "Option 1",
                                              hintText: "Enter Option 1"),
                                        ),
                                        // Option 2
                                        TextFormField(
                                          validator: (value) => value!.isEmpty
                                              ? "Option 2 is required"
                                              : null,
                                          controller: controllerOpt2 =
                                              TextEditingController(
                                                  text: snapshot
                                                      .data![index].option2),
                                          decoration: const InputDecoration(
                                              labelText: "Option 2",
                                              hintText: "Enter Option 2"),
                                        ),
                                        // Option 3
                                        TextFormField(
                                          validator: (value) => value!.isEmpty
                                              ? "Option 3 is required"
                                              : null,
                                          controller: controllerOpt3 =
                                              TextEditingController(
                                                  text: snapshot
                                                      .data![index].option3),
                                          decoration: const InputDecoration(
                                              labelText: "Option 3",
                                              hintText: "Enter Option 3"),
                                        ),

                                        // Option 4

                                        const SizedBox(
                                          height: 20,
                                        ),
                                        ButtonCustom(
                                          text: "Update Quiz",
                                          onPressed: () {
                                            /// get the existing questions
                                            if (_formKey.currentState!
                                                .validate()) {
                                              quizDB.updateQuestion(
                                                  boxQuestions.keyAt(index),
                                                  QuestionAnswerModel(
                                                    question:
                                                        controllerQuestion.text,
                                                    answer:
                                                        conrollerAnswer.text,
                                                    option1:
                                                        controllerOpt1.text,
                                                    option2:
                                                        controllerOpt2.text,
                                                    option3:
                                                        controllerOpt3.text,
                                                    quizId: widget.quizId,
                                                    examCode: widget.examCode,
                                                  ));
                                              // snckbar
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Question Updated Successfully"),
                                                ),
                                              );
                                              Navigator.pop(context);
                                              // clear the text fields
                                              controllerQuestion.clear();
                                              conrollerAnswer.clear();
                                              controllerOpt1.clear();
                                              controllerOpt2.clear();
                                              controllerOpt3.clear();
                                            }
                                            // print existing questions

                                            // refresh the page
                                            setState(() {
                                              // refresh the page
                                              listQuiz =
                                                  quizDB.getQuestionByTeacher(
                                                      widget.quizId);
                                            });
                                          },
                                        )
                                      ]),
                                    ),
                                  ),
                                );
                              },
                            );
                          },

                          // add the new question to the existing questions

                          title: Text(snapshot.data![index].question!),
                          trailing: Text(
                              "ANSWER: ${snapshot.data![index].answer.toString()}"),
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
