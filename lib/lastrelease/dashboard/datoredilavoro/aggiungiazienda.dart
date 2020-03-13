
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/authentication/posizione.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/loginsignup/loginparts/pulsanterettangolarearrotondato.dart';
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
      SingleChildScrollView(
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
                child:Text("NOME ATTIVITA'",style: testosemplice16),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5),
            ),

      Container(
        padding: EdgeInsets.symmetric(vertical: 10.0 , horizontal: 35),

        child:

             TextField(
              controller: nomeaziendacontroller,
              decoration: InputDecoration(
               hintText: 'Google',
                ),
              ),

      ),


            Padding(
              padding: EdgeInsets.only(bottom: 15),
            ),

            Align(
              alignment: Alignment.bottomLeft,
              child:
              Padding(
                padding: EdgeInsets.only(left: 25),
                child:Text("INDIRIZZO ATTIVITA'",style: testosemplice16),
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
                    child:

                    Container(
                      padding:EdgeInsets.symmetric(vertical: 10.0 , horizontal: 35),

                      child:
                    TextField(
                      controller: indirizzoaziendacontroller,
                      decoration: InputDecoration(
                        hintText: 'Via Torino, 20',
                      ),
                    ),
                    )


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

    if(posizioneazienda == null || posizioneazienda.via.isEmpty) return;

    setState(() {
      indirizzoaziendacontroller.text = posizioneazienda.via;
      azienda.posizionelatlong = posizioneazienda;
    });
  }

  Widget buildbuttonsubmit(){
    return GestureDetector(
        onTap: pubblicaattivita,
        child: PulsanteRettangolareArrotondato("Pubblica", buttongradiant, false)
    );
  }

  pubblicaattivita() async {
    if(nomeaziendacontroller.text.isEmpty){
      mostraerrore(context, "Non hai inserito il nome dell'azienda", " ");
      return;
    }
    if(azienda.posizionelatlong == null){
      mostraerrore(context, "Non hai inserito la posizione dell'azienda", " ");
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