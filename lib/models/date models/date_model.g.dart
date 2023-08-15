// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DateModelAdapter extends TypeAdapter<DateModel> {
  @override
  final int typeId = 4;

  @override
  DateModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DateModel(
      id: fields[0] as String,
      date: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DateModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
