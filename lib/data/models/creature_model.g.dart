// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreatureModelAdapter extends TypeAdapter<CreatureModel> {
  @override
  final int typeId = 0;

  @override
  CreatureModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreatureModel(
      id: fields[0] as String,
      name: fields[1] as String,
      typeIndex: fields[2] as int,
      isUnlocked: fields[3] as bool,
      unlockCost: fields[4] as int,
      spritePath: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CreatureModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.typeIndex)
      ..writeByte(3)
      ..write(obj.isUnlocked)
      ..writeByte(4)
      ..write(obj.unlockCost)
      ..writeByte(5)
      ..write(obj.spritePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreatureModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
