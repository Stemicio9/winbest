// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annuncio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Annuncio _$AnnuncioFromJson(Map<String, dynamic> json) {
  return Annuncio(
    paga: (json['paga'] as num)?.toDouble(),
    dataora: json['dataora'] == null
        ? null
        : DateTime.parse(json['dataora'] as String),
    skill: json['skill'] as String,
    datapubblicazione: json['datapubblicazione'] == null
        ? null
        : DateTime.parse(json['datapubblicazione'] as String),
    noteaggiuntive: json['noteaggiuntive'] as String,
    pubblicante: json['pubblicante'] as String,
    candidati: (json['candidati'] as List)?.map((e) => e as String)?.toList(),
    scelto: json['scelto'] as String,
    azienda: json['azienda'] == null
        ? null
        : Azienda.fromJson(json['azienda'] as Map<String, dynamic>),
    id: json['id'] == null
        ? null
        : ObjId.fromJson(json['id'] as Map<String, dynamic>),
    distanza: json['distanza'] as String,
  );
}

Map<String, dynamic> _$AnnuncioToJson(Annuncio instance) => <String, dynamic>{
      'id': instance.id,
      'paga': instance.paga,
      'dataora': instance.dataora?.toIso8601String(),
      'skill': instance.skill,
      'datapubblicazione': instance.datapubblicazione?.toIso8601String(),
      'noteaggiuntive': instance.noteaggiuntive,
      'pubblicante': instance.pubblicante,
      'candidati': instance.candidati,
      'scelto': instance.scelto,
      'azienda': instance.azienda,
      'distanza': instance.distanza,
    };
