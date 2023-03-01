// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_taker_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExamTakerModelAdapter extends TypeAdapter<ExamTakerModel> {
  @override
  final int typeId = 1;

  @override
  ExamTakerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExamTakerModel()
      ..email = fields[0] as String?
      ..studentKeyID = fields[1] as String?
      ..fullName = fields[2] as String?
      ..quizID = fields[3] as String?
      ..quizTitle = fields[4] as String?
      ..quizDescription = fields[5] as String?
      ..finishedTime = fields[6] as double?
      ..score = fields[7] as double?
      ..examCode = fields[8] as String?;
  }

  @override
  void write(BinaryWriter writer, ExamTakerModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.studentKeyID)
      ..writeByte(2)
      ..write(obj.fullName)
      ..writeByte(3)
      ..write(obj.quizID)
      ..writeByte(4)
      ..write(obj.quizTitle)
      ..writeByte(5)
      ..write(obj.quizDescription)
      ..writeByte(6)
      ..write(obj.finishedTime)
      ..writeByte(7)
      ..write(obj.score)
      ..writeByte(8)
      ..write(obj.examCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExamTakerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
