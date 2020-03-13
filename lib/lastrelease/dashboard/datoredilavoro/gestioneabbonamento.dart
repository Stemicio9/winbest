


import 'package:flutter/material.dart';
import 'package:win/lastrelease/authentication/abbonamento.dart';
import 'package:win/lastrelease/model/prodottoabbonamento.dart';
import 'package:win/lastrelease/widgets/ProdottoAbbonamentoCard.dart';
import 'package:win/lastrelease/widgets/appbar.dart';

class PaginaGestioneAbbonamento extends StatefulWidget {
  @override
  PaginaGestioneAbbonamentoState createState() {
    // TODO: implement createState
    return PaginaGestioneAbbonamentoState();
  }

}

class PaginaGestioneAbbonamentoState extends State<PaginaGestioneAbbonamento>{





  @override
  Widget build(BuildContext context) {

    Abbonamenti.instance.aggiornapacchetti();
    return
      Scaffold(

          appBar: appbarcomune("Abbonamenti"),

          body:


          StreamBuilder(

              stream: Abbonamenti.instance.pacchetti.stream.asBroadcastStream(),

              builder: (context,snapshot) {



                if(!snapshot.hasData) return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );

                return
                  Container(

                      padding: EdgeInsets.symmetric(horizontal: 16),

                      child:

                      Column(

                          children: <Widget> [

                            SizedBox(height: 15,),

                            /*              Center(
                  child: Text("I NOSTRI ABBONAMENTI" , style: titolo),
                ), */

                            SizedBox(height: 15,),

                            Expanded(
                              child : GridView.builder(
                                itemBuilder: (BuildContext context, int index) {
                                  return ProductCard(product: ProdottoAbbonamento.fromJson(snapshot.data.data[index]));
                                },
                                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 15.0,
                                  mainAxisSpacing: 15.0,
                                  childAspectRatio: 0.75,
                                ),
                                itemCount: snapshot.data.data.length,
                              ),
                            )

                          ]
                      )

                  );
              }

          )



      );

  }





}