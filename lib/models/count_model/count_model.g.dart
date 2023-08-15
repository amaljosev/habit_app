// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'count_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitsCountModelAdapter extends TypeAdapter<HabitsCountModel> {
  @override
  final int typeId = 3;

  @override
  HabitsCountModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitsCountModel(
      id: fields[0] as String,
      totalHabitCompleted: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HabitsCountModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.totalHabitCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitsCountModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
