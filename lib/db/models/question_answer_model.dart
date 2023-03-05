import 'package:hive/hive.dart';

part 'question_answer_model.g.dart';

@HiveType(typeId: 4)
class QuestionAnswerModel {
  // question, answer, 4 options

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? question;
  @HiveField(2)
  String? answer;
  @HiveField(3)
  String? option1;
  @HiveField(4)
  String? option2;
  @HiveField(5)
  String? option3;
  @HiveField(6)
  String? option4;
  @HiveField(7)
  int? quizId;
  @HiveField(8)
  int? points;
  @HiveField(9)
  String? examCode;

  QuestionAnswerModel(
      {this.id,
      this.question,
      this.answer,
      this.option1,
      this.option2,
      this.option3,
      this.option4,
      this.quizId,
      this.points,
      this.examCode});

  // to String
  @override
  String toString() {
    return 'TEST!!!: /QuestionAnswerModel{id: $id, question: $question, answer: $answer, option1: $option1, option2: $option2, option3: $option3, option4: $option4, quizId: $quizId, points: $points, examCode: $examCode}';
  }
}
