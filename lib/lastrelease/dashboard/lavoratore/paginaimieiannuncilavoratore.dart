

import 'package:flutter/material.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/dashboard/lavoratore/utilities/cardwidgetlavoratore.dart';
import 'package:win/lastrelease/model/annuncio.dart';
import 'package:win/lastrelease/model/filtro.dart';
import 'package:win/lastrelease/services/annunciservice.dart';
import 'package:win/lastrelease/widgets/animatedfloatingactionbutton.dart';

class PaginaMieiAnnunciLavoratore extends StatefulWidget{
  @override
  PaginaMieiAnnunciLavoratoreState createState() {
    return PaginaMieiAnnunciLavoratoreState();
  }

}


class PaginaMieiAnnunciLavoratoreState extends State<PaginaMieiAnnunciLavoratore> {


  int selezionato = 2;

  int numeropagina = 1;


  PageController pageController;

  Filtro filtro;



  @override
  void initState() {
    super.initState();
    filtro = Annunci.instance.filtro;

    //  timer = Timer.periodic(Duration(seconds: 60), (Timer t) => refresh());
    // annunciService.prendimieiannuncidatore();
    Annunci.instance.annunciattivilavoratore();


    pageController = PageController(
        viewportFraction: 0.6
    );

  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(

        bottomNavigationBar: bottomnavigation(),

        body: Container(


            child: Column(
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                  ),

                  StreamBuilder(
                    stream:  Annunci.instance.esploraannunci.stream.asBroadcastStream(),
                    builder: (context, snapshot) {

                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(azzurroscuro),
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(contanumerovalori(snapshot.data)> 0 ?  "ANNUNCIO " + numeropagina.toString() + " DI " + contanumerovalori(snapshot.data).toString() : "NESSUN ANNUNCIO TROVATO",
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
                        stream:  Annunci.instance.esploraannunci.stream.asBroadcastStream(),

                        builder: (context, snapshot) {

                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(azzurroscuro),
                              ),
                            );
                          } else {
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


        ),

    primary: true,
    );
  }




  int contanumerovalori(dato){
    return dato.data.length;
  }

  Widget buildItem(context, dato, index){
    Annuncio annuncio = Annuncio.fromJson(dato.data[index]);
    return CardWidgetLavoratore(annuncio);
  }





























  Widget bottomnavigation(){


    FloatingActionButton archivio = new FloatingActionButton.extended(
      backgroundColor:Colors.redAccent,


      elevation: selezionato == 1 ? 30 : 0,

      focusElevation: 20,

      heroTag: "1",
      onPressed: () async {
        await Annunci.instance.archivioannuncilavoratore();
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
        await Annunci.instance.annunciattivilavoratore();
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



    return

      Padding(

          padding: EdgeInsets.only(bottom: 20),

          child: Row(

            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[

              selezionato == 1 ? AnimatedFloatingActionButton(child: archivio, color1: azzurroscuro, color2: azzurroscuro): archivio,

              SizedBox(width: 15,),

              selezionato == 2 ? AnimatedFloatingActionButton(child: attivi, color1: azzurroscuro, color2: azzurroscuro): attivi,

            ],
          )
      );
  }



}