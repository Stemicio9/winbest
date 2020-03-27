


import 'package:json_annotation/json_annotation.dart';
import 'package:win/lastrelease/model/posizionelatlong.dart';


import 'azienda.dart';

part 'filtro.g.dart';

@JsonSerializable()
class Filtro {

  String skill;
  DateTime datainizio;
  DateTime datafine;
  double paga;
  bool paghenonspecificate;
  PosizioneLatLong posizionepartenza;
  int distanza;


  Filtro({this.skill,this.datainizio,this.datafine,this.paga,this.paghenonspecificate,this.posizionepartenza,this.distanza});

  Map<String, dynamic> toJson() => _$FiltroToJson(this);

  factory Filtro.fromJson(Map<String, dynamic> json) => _$FiltroFromJson(json);

}
