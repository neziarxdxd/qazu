import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:qazu/list_of_quiz.dart';

class DoneQuiz extends StatefulWidget {
  final String emailTaker;
  final String fullNameTaker;
  final int studentKeyID;

  int? score;
  int? wrong;
  DoneQuiz(
      {super.key,
      this.score,
      this.wrong,
      required this.emailTaker,
      required this.fullNameTaker,
      required this.studentKeyID});

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
          const Image(image: AssetImage("assets/images/done.png"), height: 150),
          const Text("CONGRATULATIONS \nfor finishing the quiz!"),
          SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () {
                  // go to home
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuizListStudents(
                                emailTaker: widget.emailTaker,
                                studentKeyID: widget.studentKeyID,
                                fullNameTaker: widget.fullNameTaker,
                              )));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Go to Home"),
                    SizedBox(width: 10),
                    Icon(Icons.home),
                  ],
                )),
          )
        ],
      ),
    ));
  }
}
