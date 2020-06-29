// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lavoratore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lavoratore _$LavoratoreFromJson(Map<String, dynamic> json) {
  return Lavoratore(
    email: json['email'] as String,
    password: json['password'] as String,
    nome: json['nome'] as String,
    cognome: json['cognome'] as String,
    ruolo: json['ruolo'] as String,
    datanascita: json['datanascita'] == null
        ? null
        : DateTime.parse(json['datanascita'] as String),
    immagineprofilo: json['immagineprofilo'] as String,
    listaskill: (json['listaskill'] as List)
        ?.map(
            (e) => e == null ? null : Skill.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    numeroditelefono: json['numeroditelefono'] as String,
    passwordinchiaro: json['passwordinchiaro'] as String,
    status: json['status'] as String,
    descrizione: json['descrizione'] as String,
  );
}

Map<String, dynamic> _$LavoratoreToJson(Lavoratore instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'nome': instance.nome,
      'cognome': instance.cognome,
      'ruolo': instance.ruolo,
      'passwordinchiaro': instance.passwordinchiaro,
      'datanascita': instance.datanascita?.toIso8601String(),
      'immagineprofilo': instance.immagineprofilo,
      'descrizione': instance.descrizione,
      'status': instance.status,
      'numeroditelefono': instance.numeroditelefono,
      'listaskill': instance.listaskill,
    };
