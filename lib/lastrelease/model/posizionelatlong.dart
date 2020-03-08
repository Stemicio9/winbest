

import 'package:json_annotation/json_annotation.dart';

part 'posizionelatlong.g.dart';

@JsonSerializable()
class PosizioneLatLong {

  double latitudine;
  double longitudine;
  String via;
  String titolo;


  PosizioneLatLong({this.latitudine,this.longitudine,this.via,this.titolo});


  factory PosizioneLatLong.fromJson(Map<String, dynamic> json) => _$PosizioneLatLongFromJson(json);

  Map<String, dynamic> toJson() => _$PosizioneLatLongToJson(this);

}