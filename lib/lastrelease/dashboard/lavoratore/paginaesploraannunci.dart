
import 'package:flutter/material.dart';
import 'package:win/lastrelease/authentication/posizione.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/dashboard/lavoratore/utilities/cardwidgetlavoratore.dart';
import 'package:win/lastrelease/dashboard/lavoratore/utilities/filtraricerca.dart';
import 'package:win/lastrelease/model/annuncio.dart';
import 'package:win/lastrelease/model/filtro.dart';
import 'package:win/lastrelease/services/annunciservice.dart';

class EsploraAnnunci extends StatefulWidget {
  @override
  EsploraAnnunciState createState() {
    return EsploraAnnunciState();
  }

}


class EsploraAnnunciState extends State<EsploraAnnunci>{

  int numeropagina = 1;


  int pagenumber = 1;

  PageController pageController;

  Filtro filtro;



  @override
  void initState() {
    super.initState();
    filtro = Annunci.instance.filtro;

    //  timer = Timer.periodic(Duration(seconds: 60), (Timer t) => refresh());
    // annunciService.prendimieiannuncidatore();
    Annunci.instance.prendiannunciqueriedandpaged(pagenumber);


    pageController = PageController(
        viewportFraction: 0.6
    );


    pageController.addListener((){
      if (this.pageController.position.pixels >= this.pageController.position.maxScrollExtent) {
        // Andrebbe implementata la logica per l'impaginazione
        //  this.prendiannunci();
        pagenumber++;
        Annunci.instance.prendiannunciqueriedandpaged(pagenumber);

      }
    });
  }


  settastato() async {
    Annunci.instance.prendiannunciqueriedandpaged(pagenumber);
    setState(() {

    });
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

        )


    );

  }

  int contanumerovalori(dato){
    return dato.data.length;
  }

  Widget buildItem(context, dato, index){
    Annuncio annuncio = Annuncio.fromJson(dato.data[index]);
    return CardWidgetLavoratore(annuncio);
  }


  prendiannunci()async{
      await  Annunci.instance.prendiannunciqueriedandpaged(pagenumber);
  }




  Widget bottomnavigation(){


    return

      Padding(

          padding: EdgeInsets.only(bottom: 20),

          child: Row(

            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[


              new FloatingActionButton.extended(
                backgroundColor:calltoactionlogin,

                focusElevation: 20,

                heroTag: "1",
                onPressed: (){

                  Navigator.of(context).push(new MaterialPageRoute(builder: (c) => PaginaFiltriLavoratore()));

                },
                icon: Image.asset("assets/img/abacus.png", width: 16,),
                label:  Text("Filtra" , style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),),
              ),



            ],
          )
      );
  }



}