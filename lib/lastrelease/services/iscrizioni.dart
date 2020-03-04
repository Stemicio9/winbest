import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/model/lavoratore.dart';

final String secondbaseurl = "nonsecure/utenti/";
final String secondbaseurlsecure = "secure/utenti";



Future<Lavoratore> iscrviticomelavoratore(Lavoratore lavoratore,Function onerror) async {
  String urlcompleto = baseurl + secondbaseurl + "iscrizione/lavoratore/" + VALORE_DI_CONTROLLO;
  final response = await http.post(urlcompleto,body: jsonEncode(lavoratore.toJson()), headers: headers);
  if(response.statusCode == 200) {
    Lavoratore result = Lavoratore.fromJson(jsonDecode(response.body));
    return result;
  }
  print("STATUS CODE");
  print(response.statusCode);
  if(response.statusCode == 500){
     onerror();
  }
  print("BODY");
  print(response.body);
  print("HEADERS");
  print(response.headers);
  return null;
}