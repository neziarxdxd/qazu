// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qazu/db/models/quiz_model.dart';

import 'package:qazu/main.dart';
import 'package:qazu/prof/add_quiz.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  // test if exam code is valid using the function in add_quiz.dart
  test('Exam code is valid', () {
    QuizModel quizModel = QuizModel();
    expect(quizModel.invalidExamCode('1234'), true);
    // ABC
    expect(quizModel.invalidExamCode('ABC'), true);
    // 12345
    expect(quizModel.invalidExamCode('12345'), true);
    // 123456
    expect(quizModel.invalidExamCode('123456'), true);

    /// *(@#*@)ABC
    expect(quizModel.invalidExamCode('*(@#*@)ABC'), false);
    // ABC123
    expect(quizModel.invalidExamCode('ABC123'), true);

    /// ABC-2453
    expect(quizModel.invalidExamCode('ABC-2453'), false);
  });
}
