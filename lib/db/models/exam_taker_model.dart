import 'package:hive/hive.dart';

part 'exam_taker_model.g.dart';

@HiveType(typeId: 1)
class ExamTakerModel {
  @HiveField(0)
  String? email;
  @HiveField(1)
  String? studentKeyID;
  @HiveField(2)
  String? fullName;
  @HiveField(3)
  String? quizID;
  @HiveField(4)
  String? quizTitle;
  @HiveField(5)
  String? quizDescription;
  @HiveField(6)
  double? finishedTime;
  @HiveField(7)
  double? score;
  @HiveField(8)
  String? examCode;
  @HiveField(9)
  String? isDone;
  ExamTakerModel({
    this.email,
    this.studentKeyID,
    this.fullName,
    this.quizID,
    this.quizTitle,
    this.quizDescription,
    this.finishedTime,
    this.score,
    this.examCode,
    this.isDone,
  });

  @override
  String toString() {
    return 'ExamTakerModel{email: $email, studentKeyID: $studentKeyID, fullName: $fullName, quizID: $quizID, quizTitle: $quizTitle, quizDescription: $quizDescription, finishedTime: $finishedTime, score: $score, examCode: $examCode , isDone: $isDone}';
  }
}
