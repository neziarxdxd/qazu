import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qazu/db/models/quiz_model.dart';
import 'package:qazu/db/quiz_add.dart';
import 'package:qazu/quiz_app.dart';

class QuizListStudents extends StatefulWidget {
  const QuizListStudents({super.key});

  @override
  State<QuizListStudents> createState() => _QuizListStudentsState();
}

class _QuizListStudentsState extends State<QuizListStudents> {
  late Future<List<QuizModel>> listQuiz;

  late QuizDB quizDB;
  late Box box;

  @override
  void initState() {
    // TODO: implement initState
    quizDB = QuizDB();
    // open mydb then get the box accounts
    box = Hive.box("quizzes");

    listQuiz = quizDB.getQuizzes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz List"),
      ),
      body: FutureBuilder(
        future: listQuiz,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyWidget(
                                keyQuiz: box.keyAt(index),
                              ),
                            ),
                          ),
                          title: Text(snapshot.data![index].title!),
                          subtitle: Text('sdds ${box.keyAt(index)}'),
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
