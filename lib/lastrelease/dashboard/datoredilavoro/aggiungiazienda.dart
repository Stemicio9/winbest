
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/authentication/posizione.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/loginsignup/loginparts/inputwidgets.dart';
import 'package:win/lastrelease/model/azienda.dart';
import 'package:win/lastrelease/model/posizionelatlong.dart';
import 'package:win/lastrelease/widgets/appbar.dart';
import 'package:win/placesandmaps.dart';

class AggiungiAzienda extends StatefulWidget {
  @override
  AggiungiAziendaState createState() {
    // TODO: implement createState
    return AggiungiAziendaState();
  }

}

class AggiungiAziendaState extends State<AggiungiAzienda>{

  TextEditingController nomeaziendacontroller = new TextEditingController();
  TextEditingController indirizzoaziendacontroller = new TextEditingController();

  Azienda azienda = new Azienda();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarcomune("Aggiungi Attività"),
      body:
      Container(
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 15),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child:
              Padding(
                padding: EdgeInsets.only(left: 25),
                child:Text("NOME ATTIVITA'",style: TextStyle(fontSize: 16, color:  Color(0xFF535353), fontWeight: FontWeight.w700),),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5),
            ),
            InputWidgetSingolo(30,0,"Es. Harrods",nomeaziendacontroller),

            Padding(
              padding: EdgeInsets.only(bottom: 15),
            ),

            Align(
              alignment: Alignment.bottomLeft,
              child:
              Padding(
                padding: EdgeInsets.only(left: 25),
                child:Text("INDIRIZZO ATTIVITA'",style: TextStyle(fontSize: 16, color:  Color(0xFF535353), fontWeight: FontWeight.w700),),
              ),
            ),
            Hero(
              child:
              GestureDetector(
                  onTap: (){
                    aggiungiposizioneazienda();
                  },
                  child:
                  AbsorbPointer(
                    child: InputWidgetSingolo(0,30,"Es. Via Torino",indirizzoaziendacontroller),
                  )
              ),
              tag: "Aggiungi via",
            ),


            Padding(
              padding: EdgeInsets.only(bottom: 15),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 25),
            ),
            Center(
              child: buildbuttonsubmit(),
            )


          ],
        ),
      ),
    );
  }


  aggiungiposizioneazienda()async {
    await Posizione.instance.aggiornaposizone();

    PosizioneLatLong posizioneazienda = await Navigator.of(context).push(
    MaterialPageRoute(builder: (c) => CercaVia(conappbar: true))
    );

    setState(() {
      indirizzoaziendacontroller.text = posizioneazienda.via;
      azienda.posizionelatlong = posizioneazienda;
    });
  }

  Widget buildbuttonsubmit(){
    return MaterialButton(

        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),

        elevation: 10,

        color: Color(0xFF2FE000),
        onPressed: pubblicaattivita,
        child:

        Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
            child:
            Text("Aggiungi Attività",
              style:TextStyle(fontSize: 14, color:  Colors.white, fontWeight: FontWeight.w800) ,)
        )

    );
  }

  pubblicaattivita() async {
    if(nomeaziendacontroller.text.isEmpty){
      mostraerrore(context, "Non hai inserito il nome dell'azienda", "");
      return;
    }
    if(azienda.nomelocation == null || azienda.nomelocation.isEmpty){
      mostraerrore(context, "Non hai inserito la posizione dell'azienda", "");
      return;
    }
    azienda.nomeazienda = nomeaziendacontroller.text;

    String result = await Auth.instance.aggiungiazienda(azienda);
    if(result == "ERRORE"){
      mostraerrore(context, "Impossbile aggiungere " + azienda.nomeazienda, "Errore interno del server");
    }else {
      Navigator.of(context).pop("");
    }
  }





  mostraerrore(context,titolo,messaggio){
    Flushbar(
      title: titolo,
      message: messaggio,
      duration: Duration(seconds: 3),
      backgroundGradient: LinearGradient(colors: errorgradient,),
      backgroundColor: Colors.red,
      boxShadows: [BoxShadow(color: Colors.blue[800], offset: Offset(0.0, 2.0), blurRadius: 3.0,)],
    )..show(context);
  }



}