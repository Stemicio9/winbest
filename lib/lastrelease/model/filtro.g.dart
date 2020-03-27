// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filtro.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Filtro _$FiltroFromJson(Map<String, dynamic> json) {
  return Filtro(
    skill: json['skill'] as String,
    datainizio: json['datainizio'] == null
        ? null
        : DateTime.parse(json['datainizio'] as String),
    datafine: json['datafine'] == null
        ? null
        : DateTime.parse(json['datafine'] as String),
    paga: (json['paga'] as num)?.toDouble(),
    paghenonspecificate: json['paghenonspecificate'] as bool,
    posizionepartenza: json['posizionepartenza'] == null
        ? null
        : PosizioneLatLong.fromJson(
            json['posizionepartenza'] as Map<String, dynamic>),
    distanza: json['distanza'] as int,
  );
}

Map<String, dynamic> _$FiltroToJson(Filtro instance) => <String, dynamic>{
      'skill': instance.skill,
      'datainizio': instance.datainizio?.toIso8601String(),
      'datafine': instance.datafine?.toIso8601String(),
      'paga': instance.paga,
      'paghenonspecificate': instance.paghenonspecificate,
      'posizionepartenza': instance.posizionepartenza,
      'distanza': instance.distanza,
    };
