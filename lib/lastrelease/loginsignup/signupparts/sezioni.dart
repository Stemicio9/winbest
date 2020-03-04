
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/loginsignup/loginparts/inputwidgets.dart';
import 'package:win/lastrelease/loginsignup/loginparts/pulsanterettangolarearrotondato.dart';


class SezioneNuova extends StatelessWidget{

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController nomereferentecontroller = new TextEditingController();
  TextEditingController cognomereferentecontroller = new TextEditingController();
  TextEditingController numerotelefonocontroller = new TextEditingController();
  TextEditingController datanascitacontroller = new TextEditingController();
  bool cercooffro;  // TRUE = CERCO, FALSE = OFFRO

  SezioneNuova(this.cercooffro);

  @override
  Widget build(BuildContext context) {
    return

      Form(
          key: _formKey,
          autovalidate: false,

          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 15),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child:
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child:Text("CREDENZIALI",style: TextStyle(fontSize: 16, color: Color(0xFF999A9A), fontWeight: FontWeight.w700),),
                ),
              ),
              Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[

                  InputWidgetLeft(30.0, 0.0, "JohnDoe@example.com" , "password",TextInputType.text, TextInputType.text,true,false,emailcontroller,passwordcontroller),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child:
                Padding(
                  padding: EdgeInsets.only(right: 25),
                  child:Text("REFERENZE", style: TextStyle(fontSize: 16, color: Color(0xFF999A9A), fontWeight: FontWeight.w700),),
                ),
              ),
              Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                  InputWidgetRight(30.0, 0.0, "JohnDoe@example.com" , "password",TextInputType.text,TextInputType.text,nomereferentecontroller,cognomereferentecontroller),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child:
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child:Text("INFO GENERICHE", style: TextStyle(fontSize: 16, color: Color(0xFF999A9A), fontWeight: FontWeight.w700),),
                ),
              ),
              Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  InputWidgetLeft(30.0, 0.0, "JohnDoe@example.com" , "password",TextInputType.phone, TextInputType.datetime,false,true,numerotelefonocontroller,datanascitacontroller),
                ],
              ),
              GestureDetector(
                  onTap: (){_submitForm(context);},
                  child: PulsanteRettangolareArrotondato("Iscriviti", signInGradients, false)
              )
            ],
          )
      );
  }


  void _submitForm(context) {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      print('Form is not valid!  Please review and correct.');
    } else {

      if(cercooffro){
        // STO CERCANDO LAVORO, CREO UN LAVORATORE
        registraticomelavoratore(context);
      }else{
        // STO OFFRENDO LAVORO, CREO UN DATORE
        registraticomedatore(context);
      }

    }
  }


  Future registraticomedatore(context) async {

  }


  final dateFormat = DateFormat("dd-MM-yyyy");


  Future registraticomelavoratore(context) async {

  }




}