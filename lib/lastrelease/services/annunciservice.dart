


import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/model/annuncio.dart';

class Annunci {


  Dio dio = new Dio();

  final String secondbaseurlsecure = "secure/annunci/";

  Annunci._privateConstructor();

  static final Annunci instance = Annunci._privateConstructor();


  BehaviorSubject<Response> esploraannunci = BehaviorSubject<Response>();

  BehaviorSubject<Response> mieiannunciattivilavoratore = BehaviorSubject<Response>();

  BehaviorSubject<Response> annuncilatodatore = BehaviorSubject<Response>();


  Future annunciattividatore() async {
    String urlcompleto = baseurl+secondbaseurlsecure+"attivi/datore/"+VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token;
    var response = await dio.get(urlcompleto);
    annuncilatodatore.sink.add(response);
    return response;
  }

  Future archivioannuncidatore() async {
    String urlcompleto = baseurl+secondbaseurlsecure+"archivio/datore/"+VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token;
    var response = await dio.get(urlcompleto);
    annuncilatodatore.sink.add(response);
    return response;
  }



  Future pubblicaannuncio(Annuncio annuncio) async {
    String urlcompleto = baseurl+secondbaseurlsecure+"pubblica/"+VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token;
    var response = await dio.post(urlcompleto, data: annuncio);
    return response;
  }


}