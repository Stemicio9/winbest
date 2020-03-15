
import 'package:flutter/material.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';

class IconaTitolo extends StatelessWidget {


  Icon icon;
  String text;

  TextStyle style = new TextStyle(fontSize: 18 , fontWeight: FontWeight.w700, color: azzurroscuro);



  IconaTitolo({this.icon, this.text, this.style});





  @override
  Widget build(BuildContext context) {


    return

      Padding(

          padding: EdgeInsets.only(top:5, bottom: 5),

          child: Column(


              mainAxisAlignment: MainAxisAlignment.start,

              children: <Widget> [
                this.icon,
                SizedBox(width: 3.0),
                RichText(textAlign: TextAlign.left, text: TextSpan(style: this.style , text: this.text),),
              ])

      )

    ;


  }





}