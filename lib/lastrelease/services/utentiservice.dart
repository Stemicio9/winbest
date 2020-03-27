

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';

class Utenti {

  Dio dio = new Dio();

  final String secondbaseurlsecure = "secure/utenti/";

  BehaviorSubject<Response> lavoratori = BehaviorSubject<Response>();

  Utenti._privateConstructor();

  static final Utenti instance = Utenti._privateConstructor();


  Future querylavoratori(query) async {
    String urlcompleto = baseurl+secondbaseurlsecure+"lavoratori/"+query+"/"+VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token;
    final response = await dio.get(urlcompleto);
    lavoratori.sink.add(response);
    return response.data;
  }



}