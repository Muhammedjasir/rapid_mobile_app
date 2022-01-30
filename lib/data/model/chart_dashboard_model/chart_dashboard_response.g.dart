// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_dashboard_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChartDashboardResponseAdapter
    extends TypeAdapter<ChartDashboardResponse> {
  @override
  final int typeId = 4;

  @override
  ChartDashboardResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChartDashboardResponse(
      mtdSysId: fields[1] as int,
      mtdText: fields[2] as String?,
      mtdImage: fields[3] as String?,
      mtdQuery: fields[4] as String?,
      mtdBgColor: fields[5] as String?,
      mtdDisplayFormat: fields[6] as String?,
      mtdSeqNo: fields[7] as int,
      mtdSubtext: fields[8] as String?,
      mtduSysId: fields[9] as int?,
      mtduMtdDashId: fields[10] as int?,
      mtduMtlUserId: fields[11] as int?,
      mtduCgSysId: fields[12] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ChartDashboardResponse obj) {
    writer
      ..writeByte(12)
      ..writeByte(1)
      ..write(obj.mtdSysId)
      ..writeByte(2)
      ..write(obj.mtdText)
      ..writeByte(3)
      ..write(obj.mtdImage)
      ..writeByte(4)
      ..write(obj.mtdQuery)
      ..writeByte(5)
      ..write(obj.mtdBgColor)
      ..writeByte(6)
      ..write(obj.mtdDisplayFormat)
      ..writeByte(7)
      ..write(obj.mtdSeqNo)
      ..writeByte(8)
      ..write(obj.mtdSubtext)
      ..writeByte(9)
      ..write(obj.mtduSysId)
      ..writeByte(10)
      ..write(obj.mtduMtdDashId)
      ..writeByte(11)
      ..write(obj.mtduMtlUserId)
      ..writeByte(12)
      ..write(obj.mtduCgSysId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChartDashboardResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
