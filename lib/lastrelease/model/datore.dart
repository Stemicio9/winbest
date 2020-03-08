




import 'package:win/lastrelease/model/azienda.dart';


import 'package:json_annotation/json_annotation.dart';

part 'datore.g.dart';

@JsonSerializable()
class Datore {

  String email;
  String password;
  String nome;
  String cognome;
  String ruolo;
  String passwordinchiaro;
  DateTime datanascita;
  String immagineprofilo;
  String descrizione;
  String status;
  String numeroditelefono;

  List<Azienda> listaaziende = new List();


  Datore(
      {this.email, this.password, this.nome, this.cognome, this.ruolo, this.datanascita,
        this.immagineprofilo, this.listaaziende,
        this.numeroditelefono, this.passwordinchiaro, this.status, this.descrizione});

  factory Datore.fromJson(Map<String, dynamic> json) => _$DatoreFromJson(json);

  Map<String, dynamic> toJson() => _$DatoreToJson(this);

}