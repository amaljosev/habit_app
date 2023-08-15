// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StartModelAdapter extends TypeAdapter<StartModel> {
  @override
  final int typeId = 2;

  @override
  StartModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StartModel(
      id: fields[0] as String,
      habit: fields[1] as String,
      days: fields[2] as String,
      wheelName: fields[3] as String,
      wheelCount: fields[4] as String,
      todayHours: fields[5] as String,
      today: fields[6] as String,
      streak: fields[7] as String,
      week: (fields[8] as List).cast<dynamic>(),
      doitAt: fields[9] as String,
      date: fields[10] as DateTime,
      dateLastDone: fields[11] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, StartModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.habit)
      ..writeByte(2)
      ..write(obj.days)
      ..writeByte(3)
      ..write(obj.wheelName)
      ..writeByte(4)
      ..write(obj.wheelCount)
      ..writeByte(5)
      ..write(obj.todayHours)
      ..writeByte(6)
      ..write(obj.today)
      ..writeByte(7)
      ..write(obj.streak)
      ..writeByte(8)
      ..write(obj.week)
      ..writeByte(9)
      ..write(obj.doitAt)
      ..writeByte(10)
      ..write(obj.date)
      ..writeByte(11)
      ..write(obj.dateLastDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StartModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
