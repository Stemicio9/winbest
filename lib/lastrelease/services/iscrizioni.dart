import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/model/datore.dart';
import 'package:win/lastrelease/model/lavoratore.dart';

final String secondbaseurl = "nonsecure/utenti/";
final String secondbaseurlsecure = "secure/utenti";



Future<Lavoratore> iscrviticomelavoratore(Lavoratore lavoratore) async {
  String urlcompleto = baseurl + secondbaseurl + "iscrizione/lavoratore/" + VALORE_DI_CONTROLLO;
  final response = await http.post(urlcompleto,body: jsonEncode(lavoratore.toJson()), headers: headers);
  if(response.statusCode == 200) {
    Lavoratore result = Lavoratore.fromJson(jsonDecode(response.body));
    return result;
  }
  return null;
}

Future<Datore> iscriviticomedatore(Datore datore)async{
  String urlcompleto = baseurl + secondbaseurl + "iscrizione/datore/" + VALORE_DI_CONTROLLO;
  final response = await http.post(urlcompleto,body: jsonEncode(datore.toJson()), headers: headers);
  if(response.statusCode == 200) {
    Datore result = Datore.fromJson(jsonDecode(response.body));
    return result;
  }
  return null;
}

Future<String> passworddimenticata(email) async {
  String urlcompleto = baseurl + secondbaseurl + "passworddimenticata/" + VALORE_DI_CONTROLLO;
  final response = await http.post(urlcompleto,body: email, headers: headers);
  if(response.statusCode == 200){
    return response.body;
  }
  print(response.body);
}
