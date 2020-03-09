import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:rxdart/rxdart.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:http/http.dart' as http;
import 'package:win/lastrelease/model/azienda.dart';
import 'package:win/placesandmaps.dart';

final String secondbaseurl = "nonsecure/utenti/";
final String secondbaseurlsecure = "secure/utenti/";


class Auth {

  Dio dio = new Dio();

  var token;
  var HERE_token;



  BehaviorSubject<Response> currentauth = BehaviorSubject<Response>();

  Auth._privateConstructor();

  static final Auth instance = Auth._privateConstructor();


  Future<bool> entra(username, password) async {
    final authorizationEndpoint =
    Uri.parse(baseurl + "oauth/token");
    final identifier = "admin";
    final secret = "ciao";
    var client = await oauth2.resourceOwnerPasswordGrant(
        authorizationEndpoint, username, password,
        identifier: identifier, secret: secret);
    if (client.credentials.accessToken != null){
      token = client.credentials.accessToken;
      return true;
    }
    return false;
  }
  
  Future<bool> entraInHere()async{
    final oauthendpoint = Uri.parse("https://account.api.here.com/oauth2/token");
    final identifier = HERE_ACCESS_KEY_ID;
    final secret = HERE_ACCESS_KEY_SECRET;
    var client = await oauth2.clientCredentialsGrant(oauthendpoint, identifier, secret);
    if(client.credentials.accessToken != null){
      print("IL TOKEN E' " + client.credentials.accessToken);
      HERE_token = client.credentials.accessToken;
      return true;
    }
    print("ERRORE");
  }

  modificaprofilo(utente)async{
    print("IL JSON E'");
    print(utente.toJson());
    String urlcompleto = baseurl+secondbaseurlsecure+"modifica/"+VALORE_DI_CONTROLLO+"?access_token="+token;
    final response = await dio.post(urlcompleto,data: utente.toJson());
    currentauth.sink.add(response);
  }

  aggiornaprofilo()async{
    String urlcompleto = baseurl+secondbaseurlsecure+"profilo/"+VALORE_DI_CONTROLLO+"?access_token="+token;
    final response = await dio.get(urlcompleto);
    currentauth.sink.add(response);
  }

  Future<String> ruolo() async {
    String urlcompleto = baseurl+secondbaseurlsecure+"ruolo/"+VALORE_DI_CONTROLLO+"?access_token="+token;
    final response = await http.get(urlcompleto);
    return response.body;
  }

  Future<String> email() async {
    var response = await currentauth.first.wrapped;
    print(response.data);
    return response.data["email"];
  }

  DecorationImage immagineprofiloasdecoration(){

    return DecorationImage(
        image: NetworkImage(
            baseurl+secondbaseurlsecure+"immagineprofilo/"+VALORE_DI_CONTROLLO+"?access_token="+token),
        fit: BoxFit.cover);

  }

  Widget immagineprofilo(){
    return Image.network(
        baseurl+secondbaseurlsecure+"immagineprofilo/"+VALORE_DI_CONTROLLO+"?access_token="+token);
  }


  void logout(context){
    token = "";
    currentauth = new BehaviorSubject<Response>();
    Navigator.pushNamedAndRemoveUntil(context, "/", (a){return true;});
  }

  Future<bool> gialoggato() async {

  }

  Future<String> ruoloautenticato()async {
    var resp = await currentauth.first;
    return resp.data.data["ruolo"];
  }

  Future<String> aggiungiazienda(Azienda azienda) async {
    String urlcompleto = baseurl+secondbaseurlsecure+"aggiungiazienda/"+VALORE_DI_CONTROLLO+"?access_token="+token;
    var response = await dio.post(urlcompleto,data: azienda.toJson());
    if(response.data == "Azienda aggiunta") {
      aggiornaprofilo();
      return "OK";
    }
    return"ERRORE";
  }

  Future<String> rimuoviazienda(String azienda) async {
    String urlcompleto = baseurl+secondbaseurlsecure+"rimuoviazienda/"+VALORE_DI_CONTROLLO+"?access_token="+token;
    var response = await dio.post(urlcompleto,data: azienda);
    if(response.data == "Azienda rimossa") {
      aggiornaprofilo();
      return "OK";
    }
    return"ERRORE";
  }


  Future<String> aggiungiskill(String skill) async {
    String urlcompleto = baseurl+secondbaseurlsecure+"aggiungiskill/"+VALORE_DI_CONTROLLO+"?access_token="+token;
    var response = await dio.post(urlcompleto,data: skill);
    if(response.data == "Skill aggiunta"){
      aggiornaprofilo();
      return "OK";
    }
    return "ERRORE";
  }

  Future<String> rimuoviskill(String skill) async {
    String urlcompleto = baseurl+secondbaseurlsecure+"rimuoviskill/"+VALORE_DI_CONTROLLO+"?access_token="+token;
    var response = await dio.post(urlcompleto,data: skill);
    if(response.data == "Skill rimossa"){
      aggiornaprofilo();
      return "OK";
    }
    return "ERRORE";
  }


}