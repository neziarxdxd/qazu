import 'package:hive/hive.dart';
import 'package:qazu/db/models/question_answer_model.dart';

part 'quiz_model.g.dart';

@HiveType(typeId: 3)
class QuizModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  double? duration;
  @HiveField(5)
  List<QuestionAnswerModel>? questions;

  QuizModel(
      {this.id, this.title, this.description, this.duration, this.questions});
}
