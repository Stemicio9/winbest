
import 'package:flutter/material.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/loginsignup/loginparts/inputwidgets.dart';
import 'package:win/lastrelease/loginsignup/loginparts/pulsanterettangolarearrotondato.dart';
import 'package:win/lastrelease/services/iscrizioni.dart';
import 'package:win/lastrelease/widgets/appbar.dart';

class PasswordDimenticata extends StatefulWidget {

  String emailcorrente;

  PasswordDimenticata({this.emailcorrente});


  @override
  PasswordDimenticataState createState() {
    return PasswordDimenticataState();
  }

}

class PasswordDimenticataState extends State<PasswordDimenticata>{

  TextEditingController mailcontroller = new TextEditingController();

  String risposta;

  @override
  void initState() {
    if(this.widget.emailcorrente != null){
      mailcontroller.text =this.widget.emailcorrente;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appbarcomune("Recupera password"),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 25),
          ),
          Padding(
            padding: EdgeInsets.only(left: MediaQuery
                .of(context)
                .size
                .width / 1.5, bottom: 10),
            child: Text(
              "Email",
              style: TextStyle(fontSize: 16,
                  color: Color(0xFF999A9A),
                  fontWeight: FontWeight.w700),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
          child: InputWidgetSingolo(30,0,"esempio@email.it",mailcontroller),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 25),
          ),


          risposta != null ?
          Center(
          child: Text(risposta,
              textAlign: TextAlign.center,
              style:
              TextStyle(fontSize: 16,
              color: Color(0xFF999A9A),
              fontWeight: FontWeight.w700))
          )
              : Container(),

          Padding(
            padding: EdgeInsets.only(bottom: 25),
          ),

          buildbuttonsubmit(),

        ],
      ),
    );
  }



  Widget buildbuttonsubmit(){
 /*   return MaterialButton(

        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),

        elevation: 10,

        color: Color(0xFF2FE000),
        onPressed: (){
          richiedinuovapassword();
        },
        child:

        Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
            child:
            Text("Recupera password",
              style:TextStyle(fontSize: 14, color:  Colors.white, fontWeight: FontWeight.w800) ,)
        )

    ); */

    return GestureDetector(
    onTap: () {
          richiedinuovapassword();
    },
    child: PulsanteRettangolareArrotondato(
    "Recupera password", buttongradiant, false),
    );

  }


  richiedinuovapassword() async{
 /*   String result = await utenteService.passworddimenticata(mailcontroller.text);
    setState(() {
      risposta = result;
    }); */
     String result = await passworddimenticata(mailcontroller.text);
     setState(() {
       risposta = result;
     });
  }

}