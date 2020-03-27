
import 'package:flutter/material.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/dashboard/datoredilavoro/utilities/detailscreen.dart';
import 'package:win/lastrelease/dashboard/datoredilavoro/utilities/iconatitolo.dart';
import 'package:win/lastrelease/model/annuncio.dart';
import 'package:win/lastrelease/services/skillservice.dart';

class CardWidget extends StatelessWidget {



  Annuncio annuncio;

  CardWidget(this.annuncio);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: _crearContenedor(context),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailScreen(annuncio) )
        );
      },
    );

  }


  Widget corpototale(context){

    return Stack(
      children: <Widget>[
        annuncio.scelto != null ?
        Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
              decoration: BoxDecoration(
                  color: Color(0xFF2FE000),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),

                  ) // green shaped
              ),
              child: Text("SCELTO!"),
            )
        ) : Container(),
        _crearContenedor(context)
      ],
    );

  }

  Widget _crearContenedor(context) {
    return

      Center(
        child:

        SizedBox(
            width: 210,
            height: 325,
            child:

            Stack(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30) , topRight: Radius.circular(30)),


                          color: Colors.white,

                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color.fromARGB(30, 0, 0, 0),
                                offset: Offset(0.0, 10.0),
                                spreadRadius: 0,
                                blurRadius: 10
                            )
                          ]
                      ),

                      child:

                      Column(
                        children: <Widget>[
                          //  Padding(padding: EdgeInsets.only(bottom: 10),),

                          Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only( topRight: Radius.circular(30)),

                              ),

                              child:

                              Container(

                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.only( topRight: Radius.circular(30)),
                                    color: Colors.white
                                ),


                                child: Row(
                                    children:<Widget>[
                                      Padding(padding: EdgeInsets.only(right: 20),),
                                      Container(

                                          width: 50,
                                          height: 50,
                                          alignment: Alignment.topLeft,

                                          child: Skills.instance.skillimage(annuncio.skill)

                                      ),
                                      Flexible(
                                          child: Container(

                                            child: Text(annuncio.skill , style: TextStyle( fontSize: 14, color: azzurroscuro, fontWeight: FontWeight.w600),),

                                          )
                                      ),
                                      //   Expanded(child:Container()),

                                    ]
                                ),

                              )



                          ),

                          Container(
                            height: 3,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: wingradient),
                            ),
                          ),

                          Padding(padding: EdgeInsets.only(bottom: 10),),

                          Container(
                            height: 50,
                            width: 50,
                            child: Center(
                                child: _crearImagenFondo()
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 5),),

                          FutureBuilder(
                            future: Auth.instance.getprofilo(annuncio.pubblicante),
                            builder: (context,snapshot){
                              if(!snapshot.hasData) return Container();
                              var nome = snapshot.data["nome"];
                              var cognome = snapshot.data["cognome"];
                              return Center(
                                child: Text(nome + " " + cognome, style: TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w600),),
                              );
                            },
                          ),


                          Padding(padding: EdgeInsets.only(bottom: 15),),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              IconaTitolo(icon: Icon(
                                Icons.today,
                                size: 30,

                                color: Color(0xFF535353),
                              ),  text: annuncio.dataora.day.toString() + " " + prendinomemesedanumero(annuncio.dataora.month),
                                  style: TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800)
                              ),


                              IconaTitolo(icon: Icon(
                                Icons.timer,
                                size: 30,
                                color:  Color(0xFF535353),
                              ),  text: TimeOfDay.fromDateTime(annuncio.dataora).format(context),
                                  style: TextStyle(fontSize: 14, color:  Color(0xFF535353),fontWeight: FontWeight.w800)
                              ),

                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[


                              IconaTitolo(icon: Icon(
                                Icons.euro_symbol,
                                size: 30,
                                color:  Color(0xFF535353),
                              ),  text: annuncio.paga != null ? annuncio.paga.toString() : "NS",
                                  style: TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800)
                              ),
                            ],
                          ),


                          Padding(padding: EdgeInsets.only(bottom: 15),),





                          Expanded(child:Container()),



                          Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                //   border: Border.all(color: azzurroscuro, width: 2),
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)),
                                // color: azzurroscuro

                              ),

                              child:
                              Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Center(
                                      child:
                                      annuncio.candidati.length == 0 ? Text("Nessun candidato" , style: TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800),) : annuncio.candidati.length == 1 ?
                                      Text(annuncio.candidati.length.toString() + " Candidato",
                                        style:TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800) ,):
                                      Text(annuncio.candidati.length.toString() + " Candidati",
                                        style:TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800) ,)

                                  )
                              )

                          )





                        ],
                      )












                  ),



                  annuncio.scelto != null ?
                  Positioned(

                      top: 0,
                      //   right: 0,
                      left: 0,
                      child:

                      new RotationTransition(
                          turns: new AlwaysStoppedAnimation(-30 / 360),
                          child:

                          Container(
                            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                            decoration: BoxDecoration(
                                color: Color(0xFF2FE000),
                                borderRadius: BorderRadius.only(


                                ) // green shaped
                            ),
                            child: Text("SCELTO!" , style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                          )
                      )) : Container(),



                ]
            )

        ),







      );
  }

  Widget _crearHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Column(
            children: <Widget>[
              Text(annuncio.dataora.day.toString(), style: TextStyle(color: azzurroscuro, fontSize: 30, fontWeight: FontWeight.bold)),
              //           Text(, style: TextStyle(color: azzurroscuro)),
              Text(prendinomemesedanumero(annuncio.dataora.month) + " "+ annuncio.dataora.year.toString(), style: TextStyle(color: azzurroscuro , fontSize: 10)),
            ],
          ),
        ),

        Text(
            annuncio.azienda != null && annuncio.azienda.nomeazienda != null ?
            annuncio.azienda.nomeazienda : annuncio.pubblicante,
            style: TextStyle(color: azzurroscuro, fontSize: 15, fontWeight: FontWeight.bold)
        ),


        Container(
          // QUA POTREMMO METTERE LA PAGA
          child:
          Column(
              children: <Widget> [
                Text(annuncio.paga.toInt().toString(), style: TextStyle(color: azzurroscuro, fontSize: 30, fontWeight: FontWeight.bold)),
                //     Icon(Icons.euro_symbol, color: azzurroscuro, size: 10),
                Text("€" ,  style: TextStyle(color: azzurroscuro , fontSize: 10)),
              ]
          ),
          margin: EdgeInsets.only(right: 10),
        )
      ],
    );

  }

  Widget _crearImagenFondo() {
    return Hero(
      child:

      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(80)),
          image: Auth.instance.immagineprofiloaltruiasdecoration(annuncio.pubblicante),
        ),

      ),

      tag: annuncio.id,
    );



  }

  Widget _mensaje() {
    return Container(
      alignment: Alignment.bottomLeft,
      margin: EdgeInsets.only(bottom: 20, left: 20),
      child: Text(
        annuncio.azienda != null && annuncio.azienda.nomeazienda != null ? annuncio.azienda.nomeazienda: "NON E' STATA INSERITA LA POSIZIONE",
        style: TextStyle(
            color: azzurroscuro,
            fontSize: 15
        ),
      ),
    );
  }

  static String prendinomemesedanumero(int numero){

    switch(numero){
      case 1:
        return "GEN";
      case 2:
        return "FEB";
      case 3:
        return "MAR";
      case 4:
        return "APR";
      case 5:
        return "MAG";
      case 6:
        return "GIU";
      case 7:
        return "LUG";
      case 8:
        return "AGO";
      case 9:
        return "SET";
      case 10:
        return "OTT";
      case 11:
        return "NOV";
      case 12:
        return "DIC";
    }

  }


}








