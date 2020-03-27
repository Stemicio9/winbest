
import 'package:flutter/material.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/dashboard/datoredilavoro/utilities/cardwidget.dart';
import 'package:win/lastrelease/dashboard/datoredilavoro/utilities/iconatitolo.dart';
import 'package:win/lastrelease/dashboard/datoredilavoro/utilities/listacandidati.dart';
import 'package:win/lastrelease/model/annuncio.dart';
import 'package:win/lastrelease/widgets/appbar.dart';

class DetailScreen extends StatelessWidget {

  Annuncio annuncio;

  DetailScreen(this.annuncio);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: appbarcomune("Annuncio per " + annuncio.skill),
        body:         Stack(
            children: <Widget>[
              //  BackgroundSoloBottom(),
              _crearCuerpo(context),
            ])
    );


  }

  Widget _crearCuerpo(context) {

    return Column(
      children: <Widget>[

        Padding(
          padding: EdgeInsets.only(bottom: 25),
        ),

        Hero(
          child:

          Container(

            height: 120,
            width: 120,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(80)),
              image: Auth.instance.immagineprofiloaltruiasdecoration(annuncio.pubblicante)
            ),

          ),

          tag: annuncio.id,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 25),
        ),

        Center(
            child: Text(annuncio.skill, style:TextStyle(fontSize: 18, color:  Color(0xFF535353), fontWeight: FontWeight.w800) ,)
        ),

        Padding(
          padding: EdgeInsets.only(bottom: 25),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconaTitolo(icon: Icon(
              Icons.today,
              size: 30,

              color: Color(0xFF535353),
            ),  text: annuncio.dataora.day.toString() + " " + CardWidget.prendinomemesedanumero(annuncio.dataora.month),
                style: TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800)
            ),
            IconaTitolo(icon: Icon(
              Icons.location_on,
              size: 30,
              color: Color(0xFF535353),
            ),  text: annuncio.distanza,
                style: TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800)
            ),

          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconaTitolo(icon: Icon(
              Icons.timer,
              size: 30,
              color:  Color(0xFF535353),
            ),  text: TimeOfDay.fromDateTime(annuncio.dataora).format(context),
                style: TextStyle(fontSize: 14, color:  Color(0xFF535353),fontWeight: FontWeight.w800)
            ),

            IconaTitolo(icon: Icon(
              Icons.euro_symbol,
              size: 30,
              color:  Color(0xFF535353),
            ),  text: annuncio.paga != null ? annuncio.paga.toString() : "NS",
                style: TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800)
            ),
          ],
        ),

        Padding(
          padding: EdgeInsets.only(bottom: 15),
        ),

        Center(
            child: Text("Posizione: ", style:TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800) ,)
        ),

        Center(
          child: annuncio.azienda != null && annuncio.azienda.nomeazienda != null ? Text(annuncio.azienda.nomeazienda) : Text("", style: TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800),),
        ),

        Center(
          child: annuncio.azienda != null && annuncio.azienda.posizionelatlong != null ? Text(annuncio.azienda.posizionelatlong.titolo) : Text("Non è stata inserita una posizione", style:TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800)),
        ),

        Padding(
          padding: EdgeInsets.only(bottom: 25),
        ),

        MaterialButton(

            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),

            elevation: 10,

            color: azzurroscuro,
            onPressed: (){
              if(annuncio.candidati.length > 0 ){

                Navigator.of(context).push(MaterialPageRoute(builder: (c) => ListaCandidati(annuncio.candidati,annuncio.id.toHexString(),annuncio.scelto)));
              }
            },
            child:

            Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
                child:  annuncio.candidati.length == 0 ? Text("Nessun candidato") : annuncio.candidati.length == 1 ?
                Text(annuncio.candidati.length.toString() + " Candidato",
                  style:TextStyle(fontSize: 14, color:  Colors.white, fontWeight: FontWeight.w800) ,):
                Text(annuncio.candidati.length.toString() + " Candidati",
                  style:TextStyle(fontSize: 14, color:  Colors.white, fontWeight: FontWeight.w800) ,)
            )

        ),


        Padding(
          padding: EdgeInsets.only(bottom: 25),
        ),

        Center(
          child: annuncio.scelto != null ? Text("VERRA' A LAVORARE " + annuncio.scelto, style:TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800)) : Text("Non hai ancora scelto il candidato giusto", style:TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800)),
        ),

      ],

    );

  }

}