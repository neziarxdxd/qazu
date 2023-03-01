// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_answer_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionAnswerModelAdapter extends TypeAdapter<QuestionAnswerModel> {
  @override
  final int typeId = 4;

  @override
  QuestionAnswerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionAnswerModel(
      id: fields[0] as int?,
      question: fields[1] as String?,
      answer: fields[2] as String?,
      option1: fields[3] as String?,
      option2: fields[4] as String?,
      option3: fields[5] as String?,
      option4: fields[6] as String?,
    )
      ..quizId = fields[7] as int?
      ..points = fields[8] as int?;
  }

  @override
  void write(BinaryWriter writer, QuestionAnswerModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.question)
      ..writeByte(2)
      ..write(obj.answer)
      ..writeByte(3)
      ..write(obj.option1)
      ..writeByte(4)
      ..write(obj.option2)
      ..writeByte(5)
      ..write(obj.option3)
      ..writeByte(6)
      ..write(obj.option4)
      ..writeByte(7)
      ..write(obj.quizId)
      ..writeByte(8)
      ..write(obj.points);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionAnswerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
