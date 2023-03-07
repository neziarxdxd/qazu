import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:qazu/list_of_quiz.dart';

class DoneQuiz extends StatefulWidget {
  int? score;
  int? wrong;
  DoneQuiz({super.key, this.score, this.wrong});

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
          // Image
          Image(image: AssetImage("assets/images/done.png"), height: 150),
          Text("Done"),
          Text("Go to Home\n Score: ${widget.score}\n Wrong: ${widget.wrong}")
        ],
      ),
    ));
  }
}
