

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/loginsignup/loginparts/pulsanterettangolarearrotondato.dart';
import 'package:win/lastrelease/services/skillservice.dart';
import 'package:win/lastrelease/widgets/appbar.dart';

class AggiungiSkill extends StatefulWidget {

  String titolo = "Aggiungi mansione";


  AggiungiSkill({this.titolo});

  @override
  AggiungiSkillState createState() {
     return AggiungiSkillState();
  }

}

class AggiungiSkillState extends State<AggiungiSkill>{

  TextEditingController mansionecontroller = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarcomune(this.widget.titolo),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(bottom: 15),),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),

              child: TextField(
            //    autofocus: true,
                controller: mansionecontroller,
                onChanged: (val){
                  if(val.isNotEmpty) {
                    Skills.instance.aggiornaskills(val);
                  }
                  },
                decoration: InputDecoration(
                  hintText: 'Ricerca mansione',
                ),
              ),
             ),

              Flexible(
                child: StreamBuilder(
                  stream: Skills.instance.skills.stream.asBroadcastStream(),
                  builder: (context, snapshot) {

                    if (!snapshot.hasData)
                      return Center(
                        child: Text("Nessuna ricerca"),
                      );

                    return ListView.builder(
                        itemCount: snapshot.data.data.length,
                        itemBuilder: (context, index) {

                          return InkWell(

                            splashColor: azzurroscuro,

                              onTap: () {
                                print("premuto");
                                print(snapshot.data.data[index]);
                                FocusScope.of(context).requestFocus(new FocusNode());
                                mansionecontroller.text = snapshot.data.data[index];

                              },
                              child:
                              riga(snapshot.data.data[index])
                          );
                        }
                    );
                  },
                ),
              ),

            GestureDetector(
              onTap: () async {
                String result = await Auth.instance.aggiungiskill(mansionecontroller.text);
                if(result == "OK"){
                  mostrasuccesso(context, "Mansione aggiunta con successo", "Sarà più facile trovare annunci come " + mansionecontroller.text);
                }else{
                  mostraerrore(context, "Errore del server", "Riprova ad aggiungere la mansione più tardi");
                }
              },
              child: PulsanteRettangolareArrotondato(
                  "Aggiungi mansione", buttongradiant, false),
            ),

            Padding(padding: EdgeInsets.only(bottom: 45),)

          ],
        ),
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


  mostraerrore(context,titolo,messaggio){
    Flushbar(
      title: titolo,
      message: messaggio,
      duration: Duration(seconds: 3),
      backgroundGradient: LinearGradient(colors: errorgradient,),
      backgroundColor: Colors.red,
      boxShadows: [BoxShadow(color: Colors.blue[800], offset: Offset(0.0, 2.0), blurRadius: 3.0,)],
    )..show(context);
  }

  mostrasuccesso(context,titolo,messaggio){
    Flushbar(
      title: titolo,
      message: messaggio,
      duration: Duration(seconds: 3),
      backgroundGradient: LinearGradient(colors: wingradient,),
      backgroundColor: Colors.red,
      boxShadows: [BoxShadow(color: Colors.blue[800], offset: Offset(0.0, 2.0), blurRadius: 3.0,)],
    )..show(context);
  }

}