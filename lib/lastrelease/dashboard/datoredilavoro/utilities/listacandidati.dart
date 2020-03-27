
import 'package:flutter/material.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/model/lavoratore.dart';
import 'package:win/lastrelease/services/annunciservice.dart';
import 'package:win/lastrelease/widgets/appbar.dart';

class ListaCandidati extends StatefulWidget {


  List<String> listacandidati;
  String hex;
  String emailscelto;


  ListaCandidati(this.listacandidati,this.hex,this.emailscelto);


  @override
  ListaCandidatiState createState() {
    return ListaCandidatiState();
  }

}

class ListaCandidatiState extends State<ListaCandidati>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarcomune("Scegli candidato"),
      body: Container(
        height: 100,
        margin: EdgeInsets.only(top: 20),
        child: ListView.builder(
            itemCount: this.widget.listacandidati.length,
            itemBuilder: (context,index){
              return

                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),

                    child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children : <Widget>[

                          Container(

                            child:
                            GestureDetector(
                                onTap: (){
                               //   Navigator.of(context).push(MaterialPageRoute(builder: (c)=> VisitaProfiloLavoratore(this.widget.listacandidati[index])));
                                },
                                child: Container(
                                    height: 80.0,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        color: Colors.indigo[600],
                                        image: Auth.instance.immagineprofiloaltruiasdecoration(widget.listacandidati[index]),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100.0))
                                        ,
                                        border: Border.all(width: 0, color: Colors.white)))
                            ),

                          ),

                          GestureDetector(
                              onTap: (){
                               // Navigator.of(context).push(MaterialPageRoute(builder: (c)=> VisitaProfiloLavoratore(this.widget.listacandidati[index])));
                              },
                              child: Text(this.widget.listacandidati[index], style: TextStyle(fontSize: 18,
                                  fontWeight: FontWeight.w600))
                          )

                          ,

          /*                FutureBuilder(
                              future: annunciService.giacandidato(this.widget.listacandidati[index], this.widget.hex),
                              builder:  (BuildContext context, AsyncSnapshot snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  if (snapshot.data) {
                                    print("FUTURE BUILDER");
                                    print(snapshot.data);
                                    return Text(
                                        "già impegnato",
                                        style:TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800));
                                  } else {
                                    print("FUTURE BUILDER FALSE");
                                    print(snapshot.data);
                                    return new Container();
                                  }
                                } else {
                                  return new CircularProgressIndicator();
                                }
                              }

                          ), */




                          this.widget.emailscelto == null ? MaterialButton(

                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),

                              elevation: 10,

                              color: Color(0xFF2FE000),
                              onPressed: () async{
                           /*     var resp = await Annunci.instance.sceglicandidato
                                  (this.widget.hex,this.widget.listacandidati[index].email);
                                if(resp){
                                  setState(() {

                                  });
                                } */
                              },
                              child:

                              Padding(
                                  padding: EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
                                  child: Text("SCEGLI" , style: TextStyle(color: Colors.white),)
                              )

                          ) :
                          this.widget.emailscelto == this.widget.listacandidati[index] ?
                          Container(
                              child:
                              Container(
                                child: new Text (
                                    "SCELTO!",
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700
                                    )
                                ),
                                decoration: new BoxDecoration (
                                    borderRadius: new BorderRadius.all(new Radius.circular(100.0)),
                                    color: azzurroscuro
                                ),
                                padding: new EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                              )
                          )
                              :
                          Container(),

                        ]
                    )
                );
            }
        ),
      ),
    );
  }

}