import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:qazu/list_of_quiz.dart';

class DoneQuiz extends StatefulWidget {
  const DoneQuiz({super.key});

  @override
  State<DoneQuiz> createState() => _DoneQuizState();
}

class _DoneQuizState extends State<DoneQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        // done then with button of go to home
        children: [
          Text("Done"),
          TextButton(
              onPressed: () {
                // go to home
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuizListStudents()));
              },
              child: Text("Go to Home"))
        ],
      ),
    ));
  }
}
