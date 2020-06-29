
import 'package:flutter/material.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/dashboard/datoredilavoro/utilities/cardwidget.dart';
import 'package:win/lastrelease/dashboard/datoredilavoro/utilities/iconatitolo.dart';
import 'package:win/lastrelease/model/annuncio.dart';
import 'package:win/lastrelease/services/annunciservice.dart';
import 'package:win/lastrelease/widgets/appbar.dart';

class DetailScreenLavoratore extends StatefulWidget {

  Annuncio annuncio;

  DetailScreenLavoratore(this.annuncio);

  @override
  DetailScreenLavoratoreState createState() {
    return DetailScreenLavoratoreState();
  }

}


class DetailScreenLavoratoreState extends State<DetailScreenLavoratore> {





  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: appbarcomune("Annuncio per " + this.widget.annuncio.skill),
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
                image: Auth.instance.immagineprofiloaltruiasdecoration(this.widget.annuncio.pubblicante)
            ),

          ),

          tag: this.widget.annuncio.id,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 25),
        ),

        Center(
            child: Text(this.widget.annuncio.skill, style:TextStyle(fontSize: 18, color:  Color(0xFF535353), fontWeight: FontWeight.w800) ,)
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
            ),  text: this.widget.annuncio.dataora.day.toString() + " " + CardWidget.prendinomemesedanumero(this.widget.annuncio.dataora.month),
                style: TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800)
            ),
            IconaTitolo(icon: Icon(
              Icons.location_on,
              size: 30,
              color: Color(0xFF535353),
            ),  text: this.widget.annuncio.distanza,
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
            ),  text: TimeOfDay.fromDateTime(this.widget.annuncio.dataora).format(context),
                style: TextStyle(fontSize: 14, color:  Color(0xFF535353),fontWeight: FontWeight.w800)
            ),

            IconaTitolo(icon: Icon(
              Icons.euro_symbol,
              size: 30,
              color:  Color(0xFF535353),
            ),  text: this.widget.annuncio.paga != null ? this.widget.annuncio.paga.toString() : "NS",
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
          child: this.widget.annuncio.azienda != null && this.widget.annuncio.azienda.nomeazienda != null ? Text(this.widget.annuncio.azienda.nomeazienda) : Text("", style: TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800),),
        ),

        Center(
          child: this.widget.annuncio.azienda != null && this.widget.annuncio.azienda.posizionelatlong != null ? Text(this.widget.annuncio.azienda.posizionelatlong.titolo) : Text("Non è stata inserita una posizione", style:TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800)),
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
            onPressed: () async {
                var currentauth = await Auth.instance.currentauth.first.wrapped;
                if(this.widget.annuncio.candidati.contains(currentauth.data["email"])){
                  var response = await Annunci.instance.toglicandidatura(this.widget.annuncio.id.toHexString());
                   if(response.data == "Tolta"){
                     await Annunci.instance.prendiannunciqueriedandpaged(false);
                     var response = await Annunci.instance.annunciodaid(this.widget.annuncio.id.toHexString());
                     this.widget.annuncio = Annuncio.fromJson(response.data);
                     setState(() {

                     });
                   }
                }else{
                  var response = await Annunci.instance.candidati(this.widget.annuncio.id.toHexString());
                  if(response.data == "OK"){
                    await Annunci.instance.prendiannunciqueriedandpaged(false);
                    var response = await Annunci.instance.annunciodaid(this.widget.annuncio.id.toHexString());
                    this.widget.annuncio = Annuncio.fromJson(response.data);
                    setState(() {

                    });
                  }
                }
            },
            child:

            FutureBuilder(
              future: Auth.instance.currentauth.first.wrapped,
              builder: (context,snapshot){
                if(!snapshot.hasData) return Container();
                return Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
                  child: this.widget.annuncio.candidati.contains(snapshot.data.data["email"]) ?
                  Text("Togli candidatura",
                    style:TextStyle(fontSize: 14, color:  Colors.white, fontWeight: FontWeight.w800) ,)
                      :
                  Text("Candidati",
                    style:TextStyle(fontSize: 14, color:  Colors.white, fontWeight: FontWeight.w800) ,)
                );
              },
            ),

/*            Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
                child:  this.widget.annuncio.candidati.length == 0 ? Text("Nessun candidato") : this.widget.annuncio.candidati.length == 1 ?
                Text(this.widget.annuncio.candidati.length.toString() + " Candidato",
                  style:TextStyle(fontSize: 14, color:  Colors.white, fontWeight: FontWeight.w800) ,):
                Text(this.widget.annuncio.candidati.length.toString() + " Candidati",
                  style:TextStyle(fontSize: 14, color:  Colors.white, fontWeight: FontWeight.w800) ,)
            ) */

        ),


        Padding(
          padding: EdgeInsets.only(bottom: 25),
        ),

        FutureBuilder(
          future: Auth.instance.currentauth.first.wrapped,
          builder: (context,snapshot){
            if(!snapshot.hasData) return Container();
            return Center(
              child: this.widget.annuncio.scelto == null ?
                  Text("Non è stato ancora scelto un candidato", style:TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800))
                  : this.widget.annuncio.scelto == snapshot.data.data["email"] ?
              Text("Sei stato scelto!", style:TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800)) :
              Text("E' già stato scelto un altro candidato", style:TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800))
            );
          },
        ),


      ],

    );

  }

}