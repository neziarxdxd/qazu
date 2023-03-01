import 'package:hive/hive.dart';
import 'package:qazu/db/models/question_answer_model.dart';
import 'package:qazu/db/models/quiz_model.dart';

class QuizDB {
  //// ====================== Quiz ======================
  // create CRUD operations
  /// create Quiz with ID, Title, Description, Duration
  Future<void> createQuiz(QuizModel quiz) async {
    final box = await Hive.openBox('quizzes');
    // create a new quiz
    QuizModel quizModel = QuizModel(
      id: quiz.id,
      title: quiz.title,
      description: quiz.description,
      duration: quiz.duration,
    );
    // add the quiz to the box
    await box.add(quizModel);
  }

  // get all quizzes
  Future<List<QuizModel>> getQuizzes() async {
    final box = await Hive.openBox('quizzes');
    // let all the quizzes be a list of QuizModel objects
    List<QuizModel> quizzes = [];
    // loop through the box and add each quiz to the list
    for (int i = 0; i < box.length; i++) {
      quizzes.add(box.getAt(i)!);
    }
    // print all quizzes
    for (int i = 0; i < quizzes.length; i++) {
      print("Quiz ${i + 1}: ${quizzes[i].description}");
    }

    // print keys
    for (int i = 0; i < box.length; i++) {
      print(" ${box.keyAt(i)}");
    }

    return quizzes;
  }

//// ====================== Questions and Answers ======================

  Future<void> addQuestionToQuiz(
      int key, QuestionAnswerModel questionAnswerModel) async {
    final box = await Hive.openBox('questionsAndAnswers');
    // create a new question
    QuestionAnswerModel question = QuestionAnswerModel(
      id: questionAnswerModel.id,
      question: questionAnswerModel.question,
      answer: questionAnswerModel.answer,
      option1: questionAnswerModel.option1,
      option2: questionAnswerModel.option2,
      option3: questionAnswerModel.option3,
      option4: questionAnswerModel.option4,
      quizId: questionAnswerModel.quizId,
      points: questionAnswerModel.points,
    );
    print("Added question: ${question.toString()}");
    // add the question to the box
    await box.add(question);
  }

  // get all questions to specific quiz
  Future<List<QuestionAnswerModel>> getQuestionsToQuiz(int quizID) async {
    final box = await Hive.openBox('questionsAndAnswers');

    // let all the questions be a list of QuestionAnswerModel objects and filter by quizId
    List<QuestionAnswerModel> questions = [];
    // loop through the box and add each question to the list
    for (int i = 0; i < box.length; i++) {
      QuestionAnswerModel questionModel = box.getAt(i)!;
      if (questionModel.quizId == quizID) {
        questions.add(box.getAt(i)!);
      }
    }
    // print all questions

    for (int i = 0; i < questions.length; i++) {
      print("Question ${i + 1}: ${questions[i].question}");
    }
    // return questions
    return questions;
  }

  Future<QuestionAnswerModel> getSpecificQuestion(int key) async {
    final box = await Hive.openBox('questionsAndAnswers');
    QuestionAnswerModel question = box.getAt(key)!;
    print("SPECIFIC Question: ${question.toString()}");
    return question;
  }

  Future<void> deleteQuestion(int key) async {
    final box = await Hive.openBox('questionsAndAnswers');
    await box.deleteAt(key);
  }

  Future<void> updateQuestion(int key, QuestionAnswerModel question) async {
    final box = await Hive.openBox('questionsAndAnswers');
    QuestionAnswerModel questionModel = QuestionAnswerModel(
      id: question.id,
      question: question.question,
      answer: question.answer,
      option1: question.option1,
      option2: question.option2,
      option3: question.option3,
      option4: question.option4,
      quizId: question.quizId,
      points: question.points,
    );
    print("Line 112: Key: $key");
    print("Line 113: Updated question: ${questionModel.toString()}");
    await box.put(key, questionModel);
  }
}
