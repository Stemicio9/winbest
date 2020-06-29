// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posizionelatlong.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PosizioneLatLong _$PosizioneLatLongFromJson(Map<String, dynamic> json) {
  return PosizioneLatLong(
    latitudine: (json['latitudine'] as num)?.toDouble(),
    longitudine: (json['longitudine'] as num)?.toDouble(),
    via: json['via'] as String,
    titolo: json['titolo'] as String,
  );
}

Map<String, dynamic> _$PosizioneLatLongToJson(PosizioneLatLong instance) =>
    <String, dynamic>{
      'latitudine': instance.latitudine,
      'longitudine': instance.longitudine,
      'via': instance.via,
      'titolo': instance.titolo,
    };
