




import 'package:win/lastrelease/model/skill.dart';


import 'package:json_annotation/json_annotation.dart';

part 'lavoratore.g.dart';

@JsonSerializable()
class Lavoratore {

  String email;
  String password;
  String nome;
  String cognome;
  String ruolo;
  String numerotelefono;
  String passwordinchiaro;
  DateTime datanascita;
  String immagineprofilo;
  String descrizione;
  String status;
  String numeroditelefono;

  List<Skill> listaskill = new List();


  Lavoratore({this.email,this.password,this.nome,this.cognome,this.ruolo,this.datanascita,
    this.immagineprofilo, this.listaskill,
    this.numerotelefono, this.passwordinchiaro, this.status, this.descrizione});

  factory Lavoratore.fromJson(Map<String, dynamic> json) => _$LavoratoreFromJson(json);

  Map<String, dynamic> toJson() => _$LavoratoreToJson(this);


}