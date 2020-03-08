
import 'package:json_annotation/json_annotation.dart';
import 'package:win/lastrelease/model/posizionelatlong.dart';

part 'azienda.g.dart';

@JsonSerializable()
class Azienda {

  String nomeazienda;
  String nomelocation;
  PosizioneLatLong posizionelatlong;
  String categoria;

  Azienda({this.nomeazienda,this.nomelocation,this.posizionelatlong,this.categoria});

  factory Azienda.fromJson(Map<String, dynamic> json) => _$AziendaFromJson(json);

  Map<String, dynamic> toJson() => _$AziendaToJson(this);

}