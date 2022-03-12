// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'studentclass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentListAdapter extends TypeAdapter<StudentList> {
  @override
  final int typeId = 0;

  @override
  StudentList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentList(
      name: fields[0] as String?,
      age: fields[1] as String?,
      batch: fields[2] as String?,
      domain: fields[3] as String?,
      imageUrl: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StudentList obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.batch)
      ..writeByte(3)
      ..write(obj.domain)
      ..writeByte(4)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
