// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScoreModelAdapter extends TypeAdapter<ScoreModel> {
  @override
  final int typeId = 1;

  @override
  ScoreModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScoreModel(
      highScore: fields[0] as int,
      totalCoins: fields[1] as int,
      totalGems: fields[2] as int,
      lastPlayed: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ScoreModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.highScore)
      ..writeByte(1)
      ..write(obj.totalCoins)
      ..writeByte(2)
      ..write(obj.totalGems)
      ..writeByte(3)
      ..write(obj.lastPlayed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScoreModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
