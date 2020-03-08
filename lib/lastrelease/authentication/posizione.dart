

import 'package:dio/dio.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';

class Posizione {

  final String HERE_API_KEY = "w6MVmAYVirk8L84ruXe9WqNqAVX-YKGrGlk0Bi6iaNY";

  Dio dio = new Dio();

  BehaviorSubject<LocationData> posizione = BehaviorSubject<LocationData>();

  BehaviorSubject<dynamic> locations = BehaviorSubject<dynamic>();

  Posizione._privateConstructor();

  static final Posizione instance = Posizione._privateConstructor();



  Future<LocationData> aggiornaposizone()async{
    LocationData currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception catch (e) {
      currentLocation = null;
    }
    posizione.sink.add(currentLocation);
    return currentLocation;
  }




  cercasuHERE(String query) async {
    LocationData posizionecorrente = await posizione.first.wrapped;
    final latitudine = posizionecorrente.latitude;
    final longitudine = posizionecorrente.longitude;
    String url = "https://autosuggest.search.hereapi.com/v1/autosuggest?at="
        +latitudine.toString()+","+longitudine.toString()+"&limit=3&q="+query+"&apiKey="+HERE_API_KEY;
    print(url);
    try {
      var response = await dio.get(url);
      if(response.statusCode == 200){
        locations.sink.add(response.data);
      }
      print(response.data);

    }catch(e){
    }
  }


}