import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/dashboard/datoredilavoro/utilities/detailscreen.dart';
import 'package:win/lastrelease/dashboard/lavoratore/utilities/detailscreenlavoratore.dart';
import 'package:win/lastrelease/model/annuncio.dart';
import 'package:win/lastrelease/services/annunciservice.dart';

FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


void firebaseCloudMessaging_Listeners(context) {
  if (Platform.isIOS) iOS_Permission();

  _firebaseMessaging.getToken().then((token){
    Auth.instance.aggiornatokenfirebase(token);
  });

  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      print('on message $message');
      String idannuncio = message['data']['idannuncio'];

      print("ID ANNUNCIO = " + idannuncio);

      if(idannuncio == "CAND"){
        dialogcandidatura(message, idannuncio,context);
      }
      else {
        dialogpubblicatoannunciochetipuointeressare(message, idannuncio,context);
      }
    },
    onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
    },
    onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
    },
  );
}

void iOS_Permission() {
  _firebaseMessaging.requestNotificationPermissions(
      IosNotificationSettings(sound: true, badge: true, alert: true)
  );
  _firebaseMessaging.onIosSettingsRegistered
      .listen((IosNotificationSettings settings)
  {
    print("Settings registered: $settings");
  });
}


dialogcandidatura(message,idannuncio, context){
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: ListTile(
        title: Text(message['notification']['title']),
        subtitle:
        GestureDetector(
            onTap: () async {
              Annuncio annuncio = await Annunci.instance.annunciodaid(idannuncio);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailScreen(annuncio)));
            },
            child:
            Container(
                padding: EdgeInsets.only(top: 15 , bottom: 15),
                child:
                Row(
                    children: <Widget> [
                      Text("Pubblicato da  "),
                      Text(message['data']['pubblicante'] , style: scritteloginsottolineate,)
                    ]
                )
            )
        ),
        //  trailing: Text("Pubblicato da  " + message['data']['pubblicante']),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}


dialogpubblicatoannunciochetipuointeressare(message,idannuncio,context){
  showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
          content: ListTile(
            title: Text(message['notification']['title']),
            subtitle:
            GestureDetector(
                onTap: () async {
                  Annuncio annuncio = await Annunci.instance
                      .annunciodaid(idannuncio);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DetailScreenLavoratore(annuncio)));
                },
                child:
                Container(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child:
                    Row(
                        children: <Widget>[
                          Text("Pubblicato da  "),
                          Text(message['data']['pubblicante'],
                            style: scritteloginsottolineate,)
                        ]
                    )
                )
            ),
            //  trailing: Text("Pubblicato da  " + message['data']['pubblicante']),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
  );
}