

import 'package:flutter/material.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';


appbarcomune (String titolo) {
  return new AppBar(
    primary: false,
      backgroundColor: azzurroscuro,
      title: Text(titolo, style: stiletestoappbar
      ),
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),)
  );
}


appbarcomunestreamed(){
  return new AppBar(

      backgroundColor: azzurroscuro,
      title:

      StreamBuilder(
          stream: Auth.instance.currentauth.stream.asBroadcastStream(),
          builder: (context,snapshot){
            if (!snapshot.hasData) {
              return Text("", style: stiletestoappbar
              );
            }else{
              return Text(snapshot.data.data["nome"], style: stiletestoappbar
              );
            }
          }
      ),

      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),)
  );
}

