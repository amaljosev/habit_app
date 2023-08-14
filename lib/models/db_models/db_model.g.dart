// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SignUpModelAdapter extends TypeAdapter<SignUpModel> {
  @override
  final int typeId = 1;

  @override
  SignUpModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SignUpModel(
      id: fields[0] as String,
      mail: fields[1] as String,
      username: fields[2] as String,
      password: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SignUpModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.mail)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignUpModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
