import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool isPressed = false;
  int selected = 0;
  int questionIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<String> options = ["Planning", "Analysis", "Design", "Implementation"];
    List<String> questions = [
      "What is the first step in SDLC?",
      "Who is the father of computer?",
      "What is the full form of CPU?",
      "What is the full form of RAM?",
      "What is the full form of ROM?",
      "What is the full form of OS?",
      "What is the full form of URL?",
    ];
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
                Text("Question ${questionIndex + 1}/${questions.length}",
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
                  isPressed = !isPressed;
                  selected = i;
                  questionIndex++;
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
                      options[i],
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
