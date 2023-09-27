// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BannerEntityAdapter extends TypeAdapter<BannerEntity> {
  @override
  final int typeId = 1;

  @override
  BannerEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BannerEntity(
      id: fields[0] as int?,
      imageUrl: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BannerEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BannerEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
