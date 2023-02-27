import 'package:hive/hive.dart';
import 'package:qazu/db/models/question_answer_model.dart';
import 'package:qazu/db/models/quiz_model.dart';

class QuizDB {
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

  Future<void> addQuestionToQuiz(int key, QuizModel quiz) async {
    final box = await Hive.openBox('quizzes');
    QuizModel quizModel = QuizModel(
      id: quiz.id,
      title: quiz.title,
      description: quiz.description,
      duration: quiz.duration,
      questions: quiz.questions,
    );
    await box.put(key, quizModel);
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

  // get all questions to specific quiz
  Future<List<QuestionAnswerModel>> getQuestionsToQuiz(int key) async {
    final box = await Hive.openBox('quizzes');
    QuizModel quiz = box.get(key)!;
    List<QuestionAnswerModel> questions = quiz.questions!;
    print(questions);
    return questions;
  }
}
