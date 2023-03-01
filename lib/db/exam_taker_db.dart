import 'package:hive_flutter/hive_flutter.dart';
import 'package:qazu/db/models/exam_taker_model.dart';

class ExamTakerDB {
  Future<void> addExamTaker(ExamTakerModel examTakerModel) async {
    final box = await Hive.openBox('examTakers');
    ExamTakerModel examTaker = ExamTakerModel(
      email: examTakerModel.email,
      studentKeyID: examTakerModel.studentKeyID,
      fullName: examTakerModel.fullName,
      quizID: examTakerModel.quizID,
      quizTitle: examTakerModel.quizTitle,
      quizDescription: examTakerModel.quizDescription,
      finishedTime: examTakerModel.finishedTime,
      score: examTakerModel.score,
      examCode: examTakerModel.examCode,
    );
    await box.add(examTaker);
  }
}
