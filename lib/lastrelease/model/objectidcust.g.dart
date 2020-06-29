// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objectidcust.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjId _$ObjIdFromJson(Map<String, dynamic> json) {
  return ObjId(
    timestamp: json['timestamp'] as int,
    machineIdentifier: json['machineIdentifier'] as int,
    processIdentifier: json['processIdentifier'] as int,
    counter: json['counter'] as int,
  );
}

Map<String, dynamic> _$ObjIdToJson(ObjId instance) => <String, dynamic>{
      'timestamp': instance.timestamp,
      'machineIdentifier': instance.machineIdentifier,
      'processIdentifier': instance.processIdentifier,
      'counter': instance.counter,
    };
