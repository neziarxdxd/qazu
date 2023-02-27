import 'package:hive/hive.dart';

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
}
