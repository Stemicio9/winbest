import 'package:json_annotation/json_annotation.dart';

part 'prodottoabbonamento.g.dart';

@JsonSerializable()
class ProdottoAbbonamento {


  String nome;
  double prezzo;
  int numeroannunci;
  int numerogiorni;

  ProdottoAbbonamento({this.nome,this.prezzo,this.numeroannunci,this.numerogiorni});

  factory ProdottoAbbonamento.fromJson(Map<String, dynamic> json) => _$ProdottoAbbonamentoFromJson(json);

  Map<String, dynamic> toJson() => _$ProdottoAbbonamentoToJson(this);

}