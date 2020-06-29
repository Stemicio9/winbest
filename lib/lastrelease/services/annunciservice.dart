


import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/authentication/posizione.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/model/annuncio.dart';
import 'package:win/lastrelease/model/filtro.dart';
import 'package:win/lastrelease/model/posizionelatlong.dart';

class Annunci {


  Dio dio = new Dio();

  final String secondbaseurlsecure = "secure/annunci/";

  Annunci._privateConstructor();

  static final Annunci instance = Annunci._privateConstructor();


  BehaviorSubject<Response> esploraannunci = BehaviorSubject<Response>();

  BehaviorSubject<Response> mieiannuncilavoratore = BehaviorSubject<Response>();

  BehaviorSubject<Response> annuncilatodatore = BehaviorSubject<Response>();


  Filtro filtro = new Filtro();


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

  Future annunciattivilavoratore() async {
    String urlcompleto = baseurl+secondbaseurlsecure+"attivi/lavoratore/"+VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token;
    var response = await dio.get(urlcompleto);
    mieiannuncilavoratore.sink.add(response);
    return response;
  }

  Future archivioannuncilavoratore() async {
    String urlcompleto = baseurl+secondbaseurlsecure+"archivio/lavoratore/"+VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token;
    var response = await dio.get(urlcompleto);
    mieiannuncilavoratore.sink.add(response);
    return response;
  }

  int pagenumber = 1;

  prendiannunciqueriedandpaged(page) async {

    if(page){
      pagenumber++;
    }

    // cercaannuncilatolavoratorequeried
    String pagina = "0";
    int numeroelementi = pagenumber*5;

    if(filtro.posizionepartenza == null){
      var location = await Posizione.instance.aggiornaposizone();
      PosizioneLatLong pos = new PosizioneLatLong(latitudine: location.latitude, longitudine: location.longitude);
      filtro.posizionepartenza = pos;
    }

    String urlcompleto = baseurl+secondbaseurlsecure+"cerca/paged/"+pagina+"/"+ numeroelementi.toString()+"/"+VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token;
    final response = await dio.post(urlcompleto,data: filtro.toJson());
    print(response.data);
    esploraannunci.sink.add(response);
  }



  Future candidati(String hex) async {
    String urlcompleto = baseurl+secondbaseurlsecure+"candidati/"+hex+"/"+VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token;
    var response = await dio.get(urlcompleto);
    return response;
  }

  Future toglicandidatura(String hex) async {
    String urlcompleto = baseurl+secondbaseurlsecure+"toglicandidatura/"+hex+"/"+VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token;
    var response = await dio.get(urlcompleto);
    return response;
  }

  Future annunciodaid(String hex) async {
    String urlcompleto = baseurl+secondbaseurlsecure+"daid/"+hex+"/"+VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token;
    var response = await dio.get(urlcompleto);
    return response;
  }


}