

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';

final String secondbaseurl = "nonsecure/generali/";
final String secondbaseurlsecure = "secure/generali/";


class ComeFunzionaService {


  Dio dio = new Dio();

  ComeFunzionaService._privateConstructor();

  static final ComeFunzionaService instance = ComeFunzionaService._privateConstructor();


  BehaviorSubject<Response> comefunziona = BehaviorSubject<Response>();


  Future aggiornacomefunziona()async{
    String urlcompleto = baseurl+secondbaseurlsecure+"comefunziona/"+VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token;
    var response = await dio.get(urlcompleto);
    comefunziona.sink.add(response);
  }

  Future<bool> aggiungicomefunziona(String titolo,String source) async {
    var body = {
      "titolo":titolo,
      "source":source
    };
    String urlcompleto = baseurl+secondbaseurlsecure+"comefunziona/aggiungi/"+VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token;
    var response = await dio.post(urlcompleto,data: body);
    if(response.data == "Video aggiunto") return true;
    return false;
  }

  Future<bool> rimuovicomefunziona(String titolo) async {
    String urlcompleto = baseurl+secondbaseurlsecure+"comefunziona/rimuovi/"+VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token;
    var response = await dio.post(urlcompleto,data: titolo);
    if(response.data == "Video rimosso") return true;
    return false;
  }

}