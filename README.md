# qazu

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


TextFormField(
                                            validator: (value) => value!.isEmpty
                                                ? "Question is required"
                                                : null,
                                            controller: controllerQuestion,
                                            decoration: const InputDecoration(
                                                labelText: "Question",
                                                hintText: "Enter Question"),
                                          ),
                                          // Answer
                                          TextFormField(
                                            validator: (value) =>
                                                value!.isEmpty ? "Answer is required" : null,
                                            controller: conrollerAnswer,
                                            decoration: const InputDecoration(
                                                labelText: "Answer",
                                                hintText: "Enter Answer"),
                                          ),
                                          // Option 1
                                          TextFormField(
                                            validator: (value) => value!.isEmpty
                                                ? "Option 1 is required"
                                                : null,
                                            controller: controllerOpt1,
                                            decoration: const InputDecoration(
                                                labelText: "Option 1",
                                                hintText: "Enter Option 1"),
                                          ),
                                          // Option 2
                                          TextFormField(
                                            validator: (value) => value!.isEmpty
                                                ? "Option 2 is required"
                                                : null,
                                            controller: controllerOpt2,
                                            decoration: const InputDecoration(
                                                labelText: "Option 2",
                                                hintText: "Enter Option 2"),
                                          ),
                                          // Option 3
                                          TextFormField(
                                            validator: (value) => value!.isEmpty
                                                ? "Option 3 is required"
                                                : null,
                                            controller: controllerOpt3,
                                            decoration: const InputDecoration(
                                                labelText: "Option 3",
                                                hintText: "Enter Option 3"),
                                          ),
                                          // Option 4

                                          const SizedBox(
                                            height: 20,
                                          ),

                                          