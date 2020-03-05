
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/loginsignup/loginparts/inputwidgets.dart';
import 'package:win/lastrelease/loginsignup/loginparts/pulsanterettangolarearrotondato.dart';
import 'package:win/lastrelease/loginsignup/recuperapassword.dart';
import 'package:win/lastrelease/model/lavoratore.dart';
import 'package:win/lastrelease/services/iscrizioni.dart';


class SezioneNuova extends StatelessWidget{

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController nomereferentecontroller = new TextEditingController();
  TextEditingController cognomereferentecontroller = new TextEditingController();
  TextEditingController numerotelefonocontroller = new TextEditingController();
  TextEditingController datanascitacontroller = new TextEditingController();
  bool cercooffro;  // TRUE = CERCO, FALSE = OFFRO


  ProgressDialog pr;

  SezioneNuova(this.cercooffro);

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    pr.style(
        message: 'Stai entrando in W1N',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w700),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w700)
    );
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

  }


  final dateFormat = DateFormat("dd-MM-yyyy");


  Future registraticomelavoratore(context) async {

    await mostraprogressdialog(context);

    DateTime data = dateFormat.parse(datanascitacontroller.text);

    Lavoratore daiscrivere = new Lavoratore(email: emailcontroller.text,password:
    passwordcontroller.text, nome: nomereferentecontroller.text,
        cognome: cognomereferentecontroller.text, datanascita:data ,
        numeroditelefono: numerotelefonocontroller.text);

    Lavoratore iscritto = await iscrviticomelavoratore(daiscrivere);

    if(iscritto == null){
      // Qui andrebbe lanciato un errore, vediamo come
      await nascondiprogressdialog();
      mostraerrore(context);
    }else{
      // Iscrizione andata a BUON FINE
      await nascondiprogressdialog();
      print(iscritto.toJson());
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


  mostraprogressdialog(context)async {
    await pr.show();
  }


  nascondiprogressdialog()async{
    await pr.hide();
  }





}