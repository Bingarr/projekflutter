// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoleHiveAdapter extends TypeAdapter<RoleHive> {
  @override
  final int typeId = 0;

  @override
  RoleHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoleHive()..role = fields[0] as RoleUserCurrent?;
  }

  @override
  void write(BinaryWriter writer, RoleHive obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.role);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoleHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
