// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usermodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class usermodelAdapter extends TypeAdapter<usermodel> {
  @override
  final int typeId = 1;

  @override
  usermodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return usermodel(
      email: fields[0] as String,
      password: fields[1] as String,
    )..id = fields[2] as String?;
  }

  @override
  void write(BinaryWriter writer, usermodel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is usermodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
