import 'package:flutter/material.dart';
import 'package:qazu/db/models/question_answer_model.dart';
import 'package:qazu/db/quiz_add.dart';
import 'package:qazu/done_quiz.dart';

class MyWidget extends StatefulWidget {
  // key
  final int keyQuiz;
  const MyWidget({super.key, required this.keyQuiz});

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
  // score
  int score = 0;
  int wrong = 0;
  @override
  void initState() {
    // TODO: implement initState
    quizDB = QuizDB();
    questionAnswerModel = <QuestionAnswerModel>[];
    // get quiz title and description at key
    quizDB.getQuizzes().then((value) {
      setState(() {
        title = value[widget.keyQuiz].title!;
      });
    });
    quizDB.getQuestionsToQuiz(widget.keyQuiz).then((value) {
      setState(() {
        print("value: $value");
        print("value length: ${value.length}");
        print("value: ${value[0].question}");
        questionAnswerModel = value;
      });
    });

    // increase score if answer is correct
    // increase wrong if answer is wrong

    super.initState();
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
    randomOptions = randomOptions..shuffle();
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
            'Software Engineering ',
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
                Text("sdsd",
                    style: TextStyle(
                        color: Color.fromARGB(255, 179, 171, 213),
                        fontWeight: FontWeight.bold)),
                Text("50:00", style: TextStyle(color: Colors.grey)),
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
                    // if selected option is correct then increase score

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoneQuiz(
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
}
