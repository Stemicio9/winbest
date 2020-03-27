


import 'package:flutter/material.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/dashboard/datoredilavoro/paginaricercautenti.dart';
import 'package:win/lastrelease/dashboard/datoredilavoro/utilities/cardwidget.dart';
import 'package:win/lastrelease/model/annuncio.dart';
import 'package:win/lastrelease/services/annunciservice.dart';
import 'package:win/lastrelease/widgets/animatedfloatingactionbutton.dart';

class PaginaAnnunciDatore extends StatefulWidget{



  @override
  PaginaAnnunciDatoreState createState() {
    return PaginaAnnunciDatoreState();
  }

}


class PaginaAnnunciDatoreState extends State<PaginaAnnunciDatore>{


  int numeropagina = 1;


  int pagenumber = 1;

  PageController pageController;

  int selezionato = 2;


  @override
  void initState() {
    super.initState();
    Annunci.instance.annunciattividatore();
    pageController = PageController(
        viewportFraction: 0.6
    );

    pageController.addListener((){
      if (this.pageController.position.pixels >= this.pageController.position.maxScrollExtent) {
        // Andrebbe implementata la logica per l'impaginazione
        //  this.prendiannunci();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(


        bottomNavigationBar: bottomnavigation(),

        primary: true,
        body: Container(

            child: Column(
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                  ),

                  StreamBuilder(
                    stream: Annunci.instance.annuncilatodatore.stream.asBroadcastStream(),
                    builder: (context, snapshot) {

                      if(snapshot == null){
                        return Container();
                      }

                      if(snapshot.data == null){
                        return Container();
                      }

                      if(snapshot.data.statusCode != 200) {
                        return Center(
                            child: Container()
                        );
                      }

                      else if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(azzurroscuro),
                          ),
                        );
                      }

                      else {
                        return Center(
                          child: Text(contanumerovalori(snapshot.data)> 0 ? numeropagina.toString() + "/" + contanumerovalori(snapshot.data).toString() : "NESSUN ANNUNCIO TROVATO",
                            style: TextStyle(
                                color: Color(0xFFA1A1A1), fontSize: 18, fontWeight: FontWeight.w600
                            ),),
                        );
                      }
                    },
                  ),


                  Container(
                    height: MediaQuery.of(context).size.height * 1.5/2.5,
                    child: StreamBuilder(
                        stream: Annunci.instance.annuncilatodatore.stream.asBroadcastStream(),

                        builder: (context, snapshot) {

                          if(snapshot == null){
                            return Container();
                          }

                          if(snapshot.data == null){
                            return Container();
                          }


                          if(snapshot.data.statusCode != 200) {
                            return Center(
                                child: Text(contanumerovalori(snapshot.data)> 0 ? numeropagina.toString() + "/" + contanumerovalori(snapshot.data).toString() : "NESSUN ANNUNCIO TROVATO",
                                  style: TextStyle(
                                      color: Color(0xFFA1A1A1), fontSize: 18, fontWeight: FontWeight.w600
                                  ),)
                            );
                          }
                          else if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(azzurroscuro),
                              ),
                            );
                          }

                          else {
                            return PageView.builder(
                              pageSnapping: true,
                              onPageChanged: (newpage){
                                setState(() {
                                  numeropagina = newpage+1;
                                });
                              },
                              controller:
                              pageController,

                              itemBuilder: (context, index) => buildItem(context, snapshot.data, index),
                              itemCount: contanumerovalori(snapshot.data),
                            );
                          }
                        }
                    ),
                  )

                ]
            )

        )


    );

  }

  int contanumerovalori(dato){
    return dato.data.length;
  }

  Widget buildItem(context, dato, index){
    /*  if(index >= contanumerovalori(dato)-2){
      print("DOVREI FARE IL FETCH DELLA PROSSIMA PAGINA !!!!");
      prendiannunci();
    } */
    Annuncio annuncio = Annuncio.fromJson(dato.data[index]);
    return CardWidget(annuncio);
  }






  Widget bottomnavigation(){


    FloatingActionButton archivio = new FloatingActionButton.extended(
      backgroundColor:Colors.redAccent,


      elevation: selezionato == 1 ? 30 : 0,

      focusElevation: 20,

      heroTag: "1",
      onPressed: () async {
        await Annunci.instance.archivioannuncidatore();
        setState(() {
          selezionato = 1;
        });
      },
      icon:Icon(
        Icons.archive,
        size: 16,

      ),
      label:  Text("Archivio" , style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),),
    );



    FloatingActionButton attivi = new FloatingActionButton.extended(
      backgroundColor:Color(0xFF2FE000),

      elevation: selezionato == 2 ? 30 : 0,

      focusElevation: 20,

      heroTag: "2",
      onPressed: () async {
        await Annunci.instance.annunciattividatore();
        setState(() {
          selezionato = 2;
        });
      },
      icon:Icon(
        Icons.check,
        size: 16,

      ),
      label:  Text("Attivi" , style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),),
    );


    FloatingActionButton cerca = new FloatingActionButton.extended(
      backgroundColor:calltoactionlogin,

      elevation: selezionato == 3 ? 30 : 0,


      focusElevation: 20,

      heroTag: "3",
      onPressed: (){

        //      Navigator.of(context).push(new MaterialPageRoute(builder: (c) => PaginaConLaRicercaDegliUtenti()));
        Navigator.of(context).push(new MaterialPageRoute(builder: (c) => PaginaRicercaUtenti()));
      },
      icon:Icon(
        Icons.search,
        size: 16,

      ),
      label:  Text("Cerca" , style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),),
    );


    return

      Padding(

          padding: EdgeInsets.only(bottom: 20),

          child: Row(

            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[

              selezionato == 1 ? AnimatedFloatingActionButton(child: archivio, color1: azzurroscuro, color2: azzurroscuro): archivio,

              SizedBox(width: 15,),

              selezionato == 2 ? AnimatedFloatingActionButton(child: attivi, color1: azzurroscuro, color2: azzurroscuro): attivi,

              SizedBox(width: 15,),

              selezionato == 3 ? AnimatedFloatingActionButton(child: cerca, color1: azzurroscuro, color2: azzurroscuro): cerca,



            ],
          )
      );
  }


}
