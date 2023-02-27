import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:qazu/button.dart';

class AddQuizPage extends StatefulWidget {
  const AddQuizPage({super.key});

  @override
  State<AddQuizPage> createState() => _AddQuizPageState();
}

class _AddQuizPageState extends State<AddQuizPage> {
  TextEditingController controllerQuizName = TextEditingController();
  TextEditingController controllerQuizDescription = TextEditingController();
  TextEditingController controllerQuizDuration = TextEditingController();
  @override
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
                            onPressed: () {},
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
        body: ListView(
          children: [
            Container(
              child: Text("Tedxdt"),
            )
          ],
        ));
  }
}
