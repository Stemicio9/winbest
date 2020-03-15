


import 'package:flutter/material.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/services/skillservice.dart';
import 'package:win/lastrelease/widgets/appbar.dart';

class CercaSkill extends StatefulWidget {
  @override
  CercaSkillState createState() {
    return CercaSkillState();
  }

}


class CercaSkillState extends State<CercaSkill>{

  TextEditingController mansionecontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarcomune("Che mansione cerchi?"),

      body:

          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child:
      Column(children: <Widget>[

      TextField(
        controller: mansionecontroller,
        onChanged: (value){
          if(value.isNotEmpty)
          Skills.instance.aggiornaskills(value);
        },
      ),

      Padding(padding: EdgeInsets.symmetric(vertical: 7),),

      Flexible(
      child: StreamBuilder(
        stream: Skills.instance.skills.stream.asBroadcastStream(),
        builder: (context, snapshot) {

          if (!snapshot.hasData)
            return Center(
              child: Text("Nessuna ricerca"),
            );

          return

            ListView.builder(
                itemCount: snapshot.data.data.length,
                itemBuilder: (context, index) {

                  return InkWell(

                      splashColor: azzurroscuro,

                      onTap: () {

                        Navigator.of(context).pop(snapshot.data.data[index]);

                      },
                      child:
                      riga(snapshot.data.data[index])
                  );
                }

            );
        },
      )
      )

      ],)

          )
    );
  }



  Widget riga(skill){
    return
      Padding(
          padding: EdgeInsets.symmetric(vertical: 5,horizontal: MediaQuery.of(context).size.width/8),
          child:

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child:
                  Text(skill , style: testosemplice16)
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  image: Skills.instance.skillimageasdecoration(skill),
                ),
                //     color: Colors.white,
              )
            ],
          )
      );
  }

}