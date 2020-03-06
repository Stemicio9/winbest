


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:rxdart/rxdart.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:http/http.dart' as http;

final String secondbaseurl = "nonsecure/utenti/";
final String secondbaseurlsecure = "secure/utenti/";


class Auth {

  Dio dio = new Dio();

  var token;
  final BehaviorSubject<Response> currentauth = BehaviorSubject<Response>();

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


}