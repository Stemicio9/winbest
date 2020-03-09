

import 'package:flutter/material.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/loginsignup/loginparts/inputwidgets.dart';
import 'package:win/lastrelease/loginsignup/loginparts/pulsanterettangolarearrotondato.dart';
import 'package:win/lastrelease/model/datore.dart';
import 'package:win/lastrelease/model/lavoratore.dart';
import 'package:win/lastrelease/widgets/appbar.dart';

class ModificaUtente extends StatefulWidget {
  @override
  ModificaUtenteState createState() {
    return ModificaUtenteState();
  }

}

class ModificaUtenteState extends State<ModificaUtente>{

  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController statuscontroller = new TextEditingController();
  TextEditingController descrizionecontroller = new TextEditingController();
  TextEditingController nomereferentecontroller = new TextEditingController();
  TextEditingController cognomereferentecontroller = new TextEditingController();
  TextEditingController numerotelefonocontroller = new TextEditingController();



  @override
  void initState() {
    Auth.instance.currentauth.first.wrapped.then((profilo) {
      statuscontroller.text = profilo.data["status"];
      descrizionecontroller.text = profilo.data["descrizione"];
      nomereferentecontroller.text = profilo.data["nome"];
      cognomereferentecontroller.text = profilo.data["cognome"];
      numerotelefonocontroller.text = profilo.data["numeroditelefono"];
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: appbarcomune("Modifica profilo"),
       body: SingleChildScrollView(
         child: Column(
           children: <Widget>[

             Padding(
               padding: EdgeInsets.only(bottom: 35),
             ),
             Align(
               alignment: Alignment.centerLeft,
               child:
               Padding(
                 padding: EdgeInsets.only(left: 25),
                 child:Text("INFORMAZIONI GENERICHE",style: testosemplice16,),
               ),
             ),
             Stack(
               alignment: Alignment.centerLeft,
               children: <Widget>[
                 InputWidgetLeft(30.0, 0.0, "descrizione" , "status",TextInputType.text, TextInputType.text,false,false,descrizionecontroller,statuscontroller),
               ],
             ),
             Align(
               alignment: Alignment.centerRight,
               child:
               Padding(
                 padding: EdgeInsets.only(right: 25),
                 child:Text("REFERENZE", style: testosemplice16,),
               ),
             ),
             Stack(
               alignment: Alignment.centerRight,
               children: <Widget>[
                 InputWidgetRight(30.0, 0.0, "Nome" , "Cognome",TextInputType.text,TextInputType.text,nomereferentecontroller,cognomereferentecontroller),
               ],
             ),
             Align(
               alignment: Alignment.centerLeft,
               child:
               Padding(
                 padding: EdgeInsets.only(left: 25),
                 child:Text("PASSWORD E NUMERO DI TELEFONO", style: testosemplice16,),
               ),
             ),
             Stack(
               alignment: Alignment.centerLeft,
               children: <Widget>[
                 InputWidgetLeft(30.0, 0.0, "Password" , "Numero di telefono",TextInputType.visiblePassword, TextInputType.phone,true,false,passwordcontroller,numerotelefonocontroller),
               ],
             ),
             GestureDetector(
                 onTap: (){modificaprofilo();},
                 child: PulsanteRettangolareArrotondato("Modifica", buttongradiant, false)
             )





           ],
         ),
       ),
     );
  }

  modificaprofilo()async{
    String ruolo = await Auth.instance.ruolo();
    String email = await Auth.instance.email();
    if(ruolo == "DATORE"){
      await modificadatore(email);
    }else if(ruolo == "LAVORATORE"){
      await modificalavoratore(email);
    }
    Navigator.of(context).pop();
  }


  modificadatore(email)async{
    Datore modifiche = new Datore(email: email, password: passwordcontroller.text.isNotEmpty ? passwordcontroller.text : "",
    descrizione: descrizionecontroller.text, status: statuscontroller.text, nome: nomereferentecontroller.text,
    cognome: cognomereferentecontroller.text, numeroditelefono: numerotelefonocontroller.text);
    await Auth.instance.modificaprofilo(modifiche);
  }

  modificalavoratore(email)async{
    Lavoratore modifiche = new Lavoratore(email: email, password: passwordcontroller.text.isNotEmpty ? passwordcontroller.text : "",
        descrizione: descrizionecontroller.text, status: statuscontroller.text, nome: nomereferentecontroller.text,
        cognome: cognomereferentecontroller.text, numeroditelefono: numerotelefonocontroller.text);
    await Auth.instance.modificaprofilo(modifiche);
  }


}