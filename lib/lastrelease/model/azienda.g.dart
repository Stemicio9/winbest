// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'azienda.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Azienda _$AziendaFromJson(Map<String, dynamic> json) {
  return Azienda(
    nomeazienda: json['nomeazienda'] as String,
    nomelocation: json['nomelocation'] as String,
    posizionelatlong: json['posizionelatlong'] == null
        ? null
        : PosizioneLatLong.fromJson(
            json['posizionelatlong'] as Map<String, dynamic>),
    categoria: json['categoria'] as String,
  );
}

Map<String, dynamic> _$AziendaToJson(Azienda instance) => <String, dynamic>{
      'nomeazienda': instance.nomeazienda,
      'nomelocation': instance.nomelocation,
      'posizionelatlong': instance.posizionelatlong,
      'categoria': instance.categoria,
    };
