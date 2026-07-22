// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_progress_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuizProgressModelAdapter extends TypeAdapter<QuizProgressModel> {
  @override
  final typeId = 0;

  @override
  QuizProgressModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizProgressModel(
      currentQuestionNum: (fields[0] as num).toInt(),
      selectedAnswers: (fields[1] as Map).cast<int, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, QuizProgressModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.currentQuestionNum)
      ..writeByte(1)
      ..write(obj.selectedAnswers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizProgressModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
