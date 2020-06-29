




import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';

class Notifiche {

  Dio dio = new Dio();


  final String secondbaseurlsecure = "secure/notifiche/";


  Notifiche._privateConstructor();

  static final Notifiche instance = Notifiche._privateConstructor();


  BehaviorSubject<Response> notifiche = BehaviorSubject<Response>();

  prendinotifiche()async{
    var response = await dio.get(baseurl+ secondbaseurlsecure  + "notificheutente"+ VALORE_DI_CONTROLLO +"?access_token=" + Auth.instance.token);
    notifiche.sink.add(response);
  }

  notificaletta(hex)async {
    String dainviare = hex;
    var response = await dio.post(baseurl+ secondbaseurlsecure + "notifiche/v2/notificaletta"+ VALORE_DI_CONTROLLO +"?access_token=" + Auth.instance.token, data: dainviare);
  }




}