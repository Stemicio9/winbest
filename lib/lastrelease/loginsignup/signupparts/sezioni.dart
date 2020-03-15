
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/loginsignup/loginparts/inputwidgets.dart';
import 'package:win/lastrelease/loginsignup/loginparts/pulsanterettangolarearrotondato.dart';
import 'package:win/lastrelease/loginsignup/recuperapassword.dart';
import 'package:win/lastrelease/model/datore.dart';
import 'package:win/lastrelease/model/lavoratore.dart';
import 'package:win/lastrelease/services/iscrizioni.dart';
import 'package:win/lastrelease/widgets/popupconferma.dart';


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
     SingleChildScrollView(

      child: Form(
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
                  child:Text("CREDENZIALI",style: testosemplice16,),
                ),
              ),
              Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  InputWidgetLeft(30.0, 0.0, "emai@example.com" , "password",TextInputType.text, TextInputType.text,true,false,emailcontroller,passwordcontroller),
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
                  child:Text("INFO GENERICHE", style: testosemplice16,),
                ),
              ),
              Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  InputWidgetLeft(30.0, 0.0, "Numero di telefono" , "Data di nascita",TextInputType.phone, TextInputType.datetime,false,true,numerotelefonocontroller,datanascitacontroller),
                ],
              ),
              GestureDetector(
                  onTap: (){_submitForm(context);},
                  child: PulsanteRettangolareArrotondato("Iscriviti", buttongradiant, false)
              )
            ],
          )
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
        print("MI REGISTRO COME LAVORATORE");
        registraticomelavoratore(context);
      }else{
        // STO OFFRENDO LAVORO, CREO UN DATORE
        registraticomedatore(context);
      }

    }
  }


  Future registraticomedatore(context) async {
    showwaitingdialog(context,"In attesa di rgistrazione");
    DateTime data = dateFormat.parse(datanascitacontroller.text);
    Datore datore = new Datore(email: emailcontroller.text,password:
    passwordcontroller.text, nome: nomereferentecontroller.text,
        cognome: cognomereferentecontroller.text, datanascita:data ,
        numeroditelefono: numerotelefonocontroller.text);
    Datore iscritto = await iscriviticomedatore(datore);
    if(iscritto == null){
      chiudiwaitingdialog(context);
      mostraerrore(context);
    }else{
      // Iscrizione andata a BUON FINE
      chiudiwaitingdialog(context);
      Navigator.of(context).pushNamed("/dashboard");
    }
  }


  final dateFormat = DateFormat("dd-MM-yyyy");


  Future registraticomelavoratore(context) async {

    showwaitingdialog(context,"In attesa di rgistrazione");

    DateTime data = dateFormat.parse(datanascitacontroller.text);

    Lavoratore daiscrivere = new Lavoratore(email: emailcontroller.text,password:
    passwordcontroller.text, nome: nomereferentecontroller.text,
        cognome: cognomereferentecontroller.text, datanascita:data ,
        numeroditelefono: numerotelefonocontroller.text);

    Lavoratore iscritto = await iscrviticomelavoratore(daiscrivere);

    if(iscritto == null){
      // Qui andrebbe lanciato un errore, vediamo come
      chiudiwaitingdialog(context);
      mostraerrore(context);
    }else{
      // Iscrizione andata a BUON FINE
      chiudiwaitingdialog(context);
      Navigator.of(context).pushNamed("/dashboard");
    }


  }
  
  
  mostraerrore(context){
    Flushbar(
      title: "Utente già iscritto",
      message: "Esiste già un utente " + emailcontroller.text,
      duration: Duration(seconds: 5),
      backgroundGradient: LinearGradient(colors: errorgradient,),
      backgroundColor: Colors.red,
      mainButton: FlatButton(onPressed: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=> PasswordDimenticata(emailcorrente: emailcontroller.text,)));
        },
        child: Text("Recupera account",  style: stiletestoappbar),),
      boxShadows: [BoxShadow(color: Colors.blue[800], offset: Offset(0.0, 2.0), blurRadius: 3.0,)],
    )..show(context);
  }







}