import 'package:hive_flutter/hive_flutter.dart';
import 'package:qazu/db/models/quiz_model.dart';

import 'exam_taker_model.dart';

class ExamTakerDB {
  // add exam taker
  Future<void> addExamTaker(ExamTakerModel examTakerModel) async {
    var box = Hive.box('examTakers');
    await box.add(examTakerModel);
  }

  // get Quiz by StudentID and access the exam code
  Future<List<ExamTakerModel>> getAllQuizExamByID(int studentID) async {
    // get all the exam taker by student ID
    var box = Hive.box('examTakers');
    List<ExamTakerModel> examTakerDB = [];
    for (int i = 0; i < box.length; i++) {
      if (box.getAt(i)!.studentKeyID == studentID) {
        examTakerDB.add(box.getAt(i)!);
      }
    }

    // print all the exam taker without the student ID
    for (int i = 0; i < box.length; i++) {
      print("Quiz ${box.get(i).quizID}: ${box.get(i).examCode}");
    }

    print("Exam Taker DB: $examTakerDB");

    return examTakerDB;
  }

  void printAllExamTaker() async {
    var box = Hive.box('examTakers');
    for (int i = 0; i < box.length; i++) {
      print("Quiz ${box.get(i).quizID}: ${box.get(i).examCode}");
    }
  }

  // get all exam taker
  Future<List<ExamTakerModel>> getAllExamTaker(String studentEmail) async {
    var box = Hive.box('examTakers');
    List<ExamTakerModel> examTakerDB = [];
    for (int i = 0; i < box.length; i++) {
      if (box.getAt(i)!.email == studentEmail) {
        examTakerDB.add(box.getAt(i)!);
      }
    }
    return examTakerDB;
  }

  // check if access code is already added by the exam taker using email
  bool checkIfAccessCodeIsAdded(String accessCode, String email) {
    // box is ExamTakerModel
    var box = Hive.box('examTakers');
    bool isAdded = false;
    for (int i = 0; i < box.length; i++) {
      if (box.getAt(i)!.email == email &&
          box.getAt(i)!.examCode == accessCode) {
        isAdded = true;
      }
    }
    return isAdded;
  }
}
