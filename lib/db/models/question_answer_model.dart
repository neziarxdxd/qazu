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
}
