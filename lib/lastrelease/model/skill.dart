import 'package:json_annotation/json_annotation.dart';

part 'skill.g.dart';

@JsonSerializable()
class Skill {

  String nomeskill;
  String urlimmagine;

  Skill({this.nomeskill, this.urlimmagine});

  factory Skill.fromJson(Map<String,dynamic> json) => _$SkillFromJson(json);

  Map<String,dynamic> toJson() => _$SkillToJson(this);

}