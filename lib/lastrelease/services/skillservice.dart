


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';

class Skills {

  Dio dio = new Dio();

  final String secondbaseurlsecure = "secure/skills/";

  BehaviorSubject<Response> skills = BehaviorSubject<Response>();

  Skills._privateConstructor();

  static final Skills instance = Skills._privateConstructor();


  Future aggiornaskills(String query)async{
    String urlcompleto = baseurl + secondbaseurlsecure+ "queried/" + query +"/" + VALORE_DI_CONTROLLO + "?access_token="+Auth.instance.token;
    var response = await dio.get(urlcompleto);
    skills.sink.add(response);
  }

  DecorationImage skillimageasdecoration(String skill){

    return DecorationImage(
        image: NetworkImage(
            baseurl+secondbaseurlsecure+"resource/"+skill+"/"+VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token),
        fit: BoxFit.cover);

  }

  Widget skillimage(String skill){
    return Image.network(
        baseurl+secondbaseurlsecure+"resource/"+skill+"/"+VALORE_DI_CONTROLLO+"?access_token="+Auth.instance.token);
  }



}