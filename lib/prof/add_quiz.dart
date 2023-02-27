import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qazu/button.dart';
import 'package:qazu/db/models/quiz_model.dart';
import 'package:qazu/db/quiz_add.dart';
import 'package:qazu/prof/add_questions.dart';

class AddQuizPage extends StatefulWidget {
  const AddQuizPage({super.key});

  @override
  State<AddQuizPage> createState() => _AddQuizPageState();
}

class _AddQuizPageState extends State<AddQuizPage> {
  TextEditingController controllerQuizName = TextEditingController();
  TextEditingController controllerQuizDescription = TextEditingController();
  TextEditingController controllerQuizDuration = TextEditingController();
  late Future<List<QuizModel>> listQuiz;

  late QuizDB quizDB;
  late Box box;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    quizDB = QuizDB();
    // open mydb then get the box accounts
    box = Hive.box("quizzes");

    listQuiz = quizDB.getQuizzes();
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
                  title: const Text("Add Quiz"),
                  content: Container(
                    height: 300,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) =>
                              value!.isEmpty ? "Quiz Name is required" : null,
                          controller: controllerQuizName,
                          decoration: const InputDecoration(
                              labelText: "Quiz Name",
                              hintText: "Enter Quiz Name"),
                        ),
                        TextFormField(
                          validator: (value) => value!.isEmpty
                              ? "Quiz Description is required"
                              : null,
                          controller: controllerQuizDescription,
                          decoration: const InputDecoration(
                              labelText: "Quiz Description",
                              hintText: "Enter Quiz Description"),
                        ),
                        TextFormField(
                          // should be a number
                          validator: (value) => value!.isEmpty
                              ? "Quiz Duration is required"
                              : null,
                          keyboardType: TextInputType.number,
                          controller: controllerQuizDuration,
                          decoration: const InputDecoration(
                              labelText: "Quiz Duration in minutes",
                              hintText: "Enter Quiz Duration"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ButtonCustom(
                          text: "Add Quiz",
                          onPressed: () {
                            // add the quiz
                            // close the dialog
                            QuizModel quizModel = QuizModel(
                                id: 1,
                                title: controllerQuizName.text,
                                description: controllerQuizDescription.text,
                                duration:
                                    double.parse(controllerQuizDuration.text));
                            quizDB.createQuiz(quizModel);
                            Navigator.pop(context);
                            // refresh the page
                            setState(() {
                              // refresh the page
                              listQuiz = quizDB.getQuizzes();
                            });
                          },
                        )
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
                    child: Text("No Quiz"),
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
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddQuestionPage(
                                  quizId: box.keyAt(index),
                                  description:
                                      snapshot.data![index].description!,
                                  title: snapshot.data![index].title!,
                                  duration: snapshot.data![index].duration!),
                            ),
                          ),
                          title: Text(snapshot.data![index].title!),
                          trailing: Text(
                              "${snapshot.data![index].duration.toString()} minutes"),
                        ),
                      );
                    },
                  );
          } else {
            return const Center(
              child: Text("No Quiz"),
            );
          }
        },
      ),
    );
  }
}
