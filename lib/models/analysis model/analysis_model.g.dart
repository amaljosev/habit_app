// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnalysisModelAdapter extends TypeAdapter<AnalysisModel> {
  @override
  final int typeId = 5;

  @override
  AnalysisModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnalysisModel(
      id: fields[0] as int,
      monday: fields[1] as double,
      tuesday: fields[2] as double,
      wednesday: fields[3] as double,
      thursday: fields[4] as double,
      friday: fields[5] as double,
      saturday: fields[6] as double,
      sunday: fields[7] as double,
    );
  }

  @override
  void write(BinaryWriter writer, AnalysisModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.monday)
      ..writeByte(2)
      ..write(obj.tuesday)
      ..writeByte(3)
      ..write(obj.wednesday)
      ..writeByte(4)
      ..write(obj.thursday)
      ..writeByte(5)
      ..write(obj.friday)
      ..writeByte(6)
      ..write(obj.saturday)
      ..writeByte(7)
      ..write(obj.sunday);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnalysisModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
