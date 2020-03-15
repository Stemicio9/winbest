
import 'package:json_annotation/json_annotation.dart';
import 'package:win/lastrelease/model/azienda.dart';
import 'package:win/lastrelease/model/objectidcust.dart';

part 'annuncio.g.dart';

@JsonSerializable()
class Annuncio {

  ObjId id;
  double paga;
  DateTime dataora;
  String skill;
  DateTime datapubblicazione;
  String noteaggiuntive;
  String pubblicante;
  List<String> candidati;
  String scelto;
  Azienda azienda;
  String distanza;



  Annuncio({this.paga,this.dataora,this.skill,
    this.datapubblicazione,this.noteaggiuntive,this.pubblicante,
    this.candidati,this.scelto,this.azienda,this.id,this.distanza});


  factory Annuncio.fromJson(Map<String, dynamic> json) => _$AnnuncioFromJson(json);

  Map<String, dynamic> toJson() => _$AnnuncioToJson(this);

}