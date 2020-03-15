
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/widgets/customcircularprogressindicator.dart';

    Future<bool> popupconferma(String titolo, String domanda, context) async {

        // set up the buttons
        Widget si = FlatButton(
        child: Text("NO"),
        onPressed:  () {
          Navigator.of(context).pop(false);
          },
        );
      Widget no = FlatButton(
        child: Text("SI"),
        onPressed:  () {
          Navigator.of(context).pop(true);
          },
      );

        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: Text(titolo, style: testosemplice14),
          content: Text(domanda,style: testosemplice14),
          actions: [
            si,
            no,
          ],
        );

         var result = await showDialog(
             context: context,
             builder: (context){return alert;}
         );

         return result;
    }


     mostraerrore(context,titolo,errore,{durata = 3}){
      Flushbar(
       title: titolo,
       message: errore,
       duration: Duration(seconds: durata),
       backgroundGradient: LinearGradient(colors: errorgradient,),
       backgroundColor: Colors.red,
       boxShadows: [BoxShadow(color: Colors.blue[800], offset: Offset(0.0, 2.0), blurRadius: 3.0,)],
      )..show(context);
}

mostrasuccesso(context,titolo,messaggio,{durata = 3}){
  Flushbar(
    title: titolo,
    message: messaggio,
    duration: Duration(seconds: durata),
    backgroundGradient: LinearGradient(colors: wingradient,),
    backgroundColor: Colors.red,
    boxShadows: [BoxShadow(color: Colors.blue[800], offset: Offset(0.0, 2.0), blurRadius: 3.0,)],
  )..show(context);
}




showwaitingdialog(context,String titolo){
      var dialog = AlertDialog(
         title: Text(titolo.isNotEmpty ? titolo : "", style: testosemplice14,),
         backgroundColor: Colors.grey.withOpacity(0.01),
         content: WinIndicator(),
      );

      return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context){
            return dialog;
          });
}

chiudiwaitingdialog(context){
      Navigator.of(context).pop();
}