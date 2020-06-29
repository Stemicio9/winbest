// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prodottoabbonamento.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProdottoAbbonamento _$ProdottoAbbonamentoFromJson(Map<String, dynamic> json) {
  return ProdottoAbbonamento(
    nome: json['nome'] as String,
    prezzo: (json['prezzo'] as num)?.toDouble(),
    numeroannunci: json['numeroannunci'] as int,
    numerogiorni: json['numerogiorni'] as int,
  );
}

Map<String, dynamic> _$ProdottoAbbonamentoToJson(
        ProdottoAbbonamento instance) =>
    <String, dynamic>{
      'nome': instance.nome,
      'prezzo': instance.prezzo,
      'numeroannunci': instance.numeroannunci,
      'numerogiorni': instance.numerogiorni,
    };
