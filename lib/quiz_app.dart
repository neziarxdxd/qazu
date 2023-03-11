import 'package:flutter/material.dart';
import 'package:qazu/db/models/exam_taker_model.dart';
import 'package:qazu/db/models/question_answer_model.dart';
import 'package:qazu/db/quiz_add.dart';
import 'package:qazu/done_quiz.dart';
import 'package:quiver/async.dart';

import 'db/models/exam_taker_db.dart';
// import quiver

class MyWidget extends StatefulWidget {
  // key
  final String examCode;
  final String emailTaker;
  final String fullNameTaker;
  final int studentKeyID;

  final String quizTitle;
  final String quizDescription;
  final double duration;
  final int score;
  const MyWidget(
      {super.key,
      required this.examCode,
      required this.emailTaker,
      required this.fullNameTaker,
      required this.studentKeyID,
      required this.quizTitle,
      required this.quizDescription,
      required this.duration,
      required this.score});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool isPressed = false;
  int selected = 0;
  int questionIndex = 0;
  late QuizDB quizDB;
  late List<QuestionAnswerModel> questionAnswerModel;
  late String title;
  // exam taken
  late ExamTakerDB examTakerDB;
  // score
  int score = 0;
  int wrong = 0;
  int? seconds;
  String? description;
  @override
  void initState() {
    // TODO: implement initState
    quizDB = QuizDB();
    examTakerDB = ExamTakerDB();
    questionAnswerModel = <QuestionAnswerModel>[];
    // get quiz title and description at key
    quizDB.getQuizzes().then((value) {
      setState(() {
        title = "sdlsl";
      });
    });
    quizDB.getQuestionsToQuiz(widget.examCode).then((value) {
      setState(() {
        print("value: $value");
        print("value length: ${value.length}");

        questionAnswerModel = value;
      });
    });
    quizDB.getSpecificQuiz(widget.examCode).then((value) {
      setState(() {
        title = value.title!;
        description = value.description!;
      });
    });

    // increase score if answer is correct
    // increase wrong if answer is wrong

    super.initState();

    seconds = 60;
    // startTimer();
  }

  @override
  Widget build(BuildContext context) {
    // List<String> options = ["Planning", "Analysis", "Design", "Implementation"];
    // List<String> questions = [
    //   "What is the first step in SDLC?",
    //   "Who is the father of computer?",
    //   "What is the full form of CPU?",
    //   "What is the full form of RAM?",
    //   "What is the full form of ROM?",
    //   "What is the full form of OS?",
    //   "What is the full form of URL?",
    // ];

    void checkAnswer(String answer) {
      if (answer == questionAnswerModel[questionIndex].answer) {
        score++;
      } else {
        wrong++;
      }
    }

    List questions = questionAnswerModel.map((e) => e.question).toList();
    List options = questionAnswerModel
        .map((e) => [e.option1, e.option2, e.option3, e.answer])
        .toList();
    // randomize options from the index of the question
    List randomOptions = options[questionIndex];
    randomOptions.shuffle();
    return Scaffold(
        // appbar with timer with number in right and back button at left no color
        // Hex color FAFAFA for background
        backgroundColor: const Color.fromARGB(255, 250, 250, 250),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          leading: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.grey,
            size: 20,
          ),
          title: Text(
            title,
            style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 47, 46, 46),
                fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.help,
                color: Colors.grey,
                size: 20,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(description!,
                    style: TextStyle(
                        color: Color.fromARGB(255, 179, 171, 213),
                        fontWeight: FontWeight.bold)),
                Text("Time: $seconds", style: TextStyle(color: Colors.grey)),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            // create animated slide text transition without using any package

            // question text
            Text(
              questions[questionIndex],
              style: TextStyle(
                  color: Color.fromARGB(255, 47, 46, 46),
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 50,
            ),
            for (int i = 0; i < 4; i++)
              // Rounded corner button color blue using TextButton
              TextButton(
                onPressed: () => setState(() {
                  print("dfldfld");
                  // if last question then go to done page
                  checkAnswer(options[questionIndex][i]);
                  if (questionIndex < questions.length - 1) {
                    questionIndex++;
                    // reset selected option
                    selected = 0;
                  } else {
                    examTakerDB.examTakerDone(
                      widget.examCode,
                      widget.emailTaker,
                      score.toDouble(),
                    );
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoneQuiz(
                                  emailTaker: widget.emailTaker,
                                  fullNameTaker: widget.fullNameTaker,
                                  studentKeyID: widget.studentKeyID,
                                  score: score,
                                  wrong: wrong,
                                )));

                    // go to next question
                  }
                }),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: selected == i ? Colors.blue : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      options[questionIndex][i],
                      style: TextStyle(
                          color: selected == i ? Colors.white : Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: 20,
            ),
            // submit button
          ]),
        ));
  }

  // void startTimer() {
  //   CountdownTimer(Duration(seconds: seconds!), Duration(seconds: 1))
  //       .listen((data) {})
  //     ..onData((data) {
  //       setState(() {
  //         // decrease seconds
  //         seconds = seconds! - 1;
  //       });
  //     })
  //     ..onDone(() {
  //       setState(() {
  //         seconds = 0;
  //       });
  //     });
  // }
}
