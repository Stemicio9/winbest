

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe_payment/flutter_stripe_payment.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';

class Abbonamenti{

  final String secondbaseurl = "nonsecure/abbonamenti/";
  final String secondbaseurlsecure = "secure/abbonamenti/";



  String publishablekey = "pk_test_X0K4rUERss19mC5oPdjzg3El00Ck3eitJt";
  String merchant_id = "acct_1G35GYEE94YiEfmb";


  Dio dio = new Dio();

  BehaviorSubject<Response> pacchetti = BehaviorSubject<Response>();

  BehaviorSubject<Response> abbonamento = BehaviorSubject<Response>();

  BehaviorSubject<Response> metodidipagamento = BehaviorSubject<Response>();

  FlutterStripePayment flutterStripePayment = FlutterStripePayment();


  Abbonamenti._privateConstructor(){
    flutterStripePayment.setStripeSettings(
        publishablekey,
    );
  }

  static final Abbonamenti instance = Abbonamenti._privateConstructor();


  Future aggiornapacchetti()async {
    String urlcompleto = baseurl+secondbaseurlsecure+"prodottiabbonamenti/"+VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token;
    final response = await dio.get(urlcompleto);
    pacchetti.sink.add(response);
    return response.data;
  }

  Future aggiornaabbonamento() async {
    String urlcompleto = baseurl+secondbaseurlsecure+"abbonamento/"+VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token;
    final response = await dio.get(urlcompleto);
    abbonamento.sink.add(response);
    return response.data;
  }


  DecorationImage prodottoabbonamentoasdecoration(String prodotto){

    return DecorationImage(
        image: NetworkImage(
            baseurl+secondbaseurlsecure+"prodottoabbonamento/image/"+prodotto+"/"+VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token),
        fit: BoxFit.cover);

  }

  Widget prodottoabbonamento(String prodotto){
    return Image.network(
        baseurl+secondbaseurlsecure+"prodottoabbonamento/image/"+prodotto+"/"+VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token);
  }



  // PAGAMENTI CON STRIPE


  Future<String> creaintentodipagamento(String nomeprodotto) async {
    String urlbase = baseurl+secondbaseurlsecure+ "creaintentodipagamento/" + VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token;
    var response = await dio.post(urlbase, data: nomeprodotto);
    return response.data;
  }


  Future prendimetodidipagamento()async {
    String urlbase = baseurl+secondbaseurlsecure+ "metodidipagamento/" + VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token;
    var response = await dio.get(urlbase);
    metodidipagamento.sink.add(response);
    return response.data;
  }

  Future salvametododipagamento(String paymentmethod) async {
    String urlbase = baseurl+secondbaseurlsecure+ "metodidipagamento/save/" + VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token;
    var response = await dio.post(urlbase,data: paymentmethod);
    prendimetodidipagamento();
    return response.data;
  }

  Future rimuovimetododipagamento(paymentid) async {
    String urlbase = baseurl+secondbaseurlsecure+ "metodidipagamento/remove/" + VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token;
    var response = await dio.post(urlbase,data: paymentid);
    prendimetodidipagamento();
    return response.data;
  }

  Future<bool> confermapagamento(prodotto) async {
    String urlbase = baseurl+secondbaseurlsecure+ "confermapagamento/" + VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token;
    var response = await dio.post(urlbase,data: prodotto);
    if(response.statusCode == 200){
      abbonamento.sink.add(response);
      return true;
    }
    return false;
  }

}