
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:win/lastrelease/authentication/posizione.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/model/posizionelatlong.dart';
import 'package:win/lastrelease/widgets/appbar.dart';



final String HERE_ACCESS_KEY_ID = "zcqKHSZhPkLnXEpIz4136A";
final String HERE_ACCESS_KEY_SECRET = "pMXG_IN3YKQv25DH_Meg8aushJLf2JkNRE2S53grrbw9UcATRqa_oKWQGuVXQpk8VuuZz7w3UuJI0IznWeNMAQ";

final String API_KEY_NON_MAPBOX = "AIzaSyDrHlzmdHzADbFfeI8guddlk1FtbkE_LIs";

final String language = "it";
final String country = "IT";
final String apikey = "pk.eyJ1Ijoic3RlZmFub21pY2VsaSIsImEiOiJjazN1a3ZmN2MwZGh4M2dwa2dsbXFxejI0In0.Qi0f4fnK8eWYYqELWRozig";


class CercaVia extends StatefulWidget{


  bool conappbar;

  CercaVia({this.conappbar});


  @override
  CercaViaState createState() {
    return CercaViaState();
  }

}


class CercaViaState extends State<CercaVia>{


  LocationData posizione;

  @override
  void initState() {
 //   Auth.instance.entraInHere();
    Posizione.instance.aggiornaposizone();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    if(this.widget.conappbar) return ricerca();
    return
      Container(
      child: colonna()
      );

  }




  Widget ricerca(){
    return

      Scaffold(
        appBar: this.widget.conappbar ?  appbarcomune("Cerca via")  : null,
        body:
          colonna()
      );
  }


  Widget colonna(){
    return  Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),

          child: TextField(
            autofocus: true,
            onChanged: (val){Posizione.instance.cercasuHERE(val);},
            decoration: InputDecoration(
              hintText: 'Ricerca via',
            ),
          ),

        ),
        Flexible(
          child: StreamBuilder(
            stream: Posizione.instance.locations.stream.asBroadcastStream(),
            builder: (context, snapshot) {



              if (!snapshot.hasData)
                return Center(
                  child: Text("Nessuna ricerca"),
                );

              return ListView.builder(
                  itemCount: snapshot.data["items"].length,
                  itemBuilder: (context, index) {
                    final title = snapshot.data["items"][index]["title"];
                    final street = snapshot.data["items"][index]["address"]["street"];
                    final resultType = snapshot.data["items"][index]["resultType"];
                    return GestureDetector(
                        onTap: () {
                          print(snapshot.data[index]);
                          final latitudine = snapshot.data["items"][index]["position"]["lat"];
                          final longitudine = snapshot.data["items"][index]["position"]["lng"];
                          PosizioneLatLong result = PosizioneLatLong(latitudine: latitudine,longitudine: longitudine, via: street,titolo: title);
                          Navigator.of(context).pop(result);
                        },
                        child:
                        riga(title,street,resultType)
                    );
                  }
              );
            },
          ),
        ),
      ],
    );
  }


  Widget riga(title,street,resultType){
    return
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 30),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title != null ? title : "", style: testosemplice14,),
              Padding(padding: EdgeInsets.only(bottom: 3),),
              Text(street != null ? street : "", style: testosemplice12,)
            ],
          ),
        ),
        Icon(
          resultType == null ? Icons.search:
          resultType == "street" ? Icons.streetview :
          resultType == "houseNumber" ? Icons.home :
          resultType == "place" ? Icons.place :
          Icons.search,
          color: Color(0xFFA0A0A0),
          size: 30,
        )
      ],
    )
      );
  }



}

