
import 'package:flutter/material.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';

class MenuLaterale extends StatelessWidget {





  List<String> listaelementimenu = new List();

  TextStyle style = new TextStyle(color: Colors.white ,fontSize: 20);


  TextStyle stylemenuitem = new TextStyle(color: Colors.white ,fontSize: 18 );



  @override
  Widget build(BuildContext context) {






    return new Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.






      child: MediaQuery.removePadding(context: context,

          child:

          Container(

              decoration: BoxDecoration(
                  gradient: LinearGradient(

                      begin: Alignment.bottomCenter,

                      end: Alignment.topCenter,

                      //    colors: [Color.fromRGBO(3, 168, 236, 1), Color.fromRGBO(0, 113, 232, 1)  ]
                      colors: [azzurroscuro,azzurroscuro]


                  )

              ),

              child:


              Container(

                /*                  decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                baseurl+'images/provasfondowin.png?access_token='+token),
                            fit: BoxFit.fill

                        )
                    ), */


                child: ListView(

                  children: costruiscilista(context),

                ),
              )

          )
      )
      ,
    );

  }



  costruiscilista(context){


    String v1 = "Policy privacy";
    String v2 = "Come funziona?";
    String v3 = "Contattaci";
    String v4 = "Eventi";
    String v5 = "Logout";

    listaelementimenu.add(v1);
    listaelementimenu.add(v2);
    listaelementimenu.add(v3);
    listaelementimenu.add(v4);
    listaelementimenu.add(v5);


    List<Widget> lista = new List();
    lista.add(
        DrawerHeader(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              //      colors: [ Color.fromRGBO(52, 201, 189, 1), Colors.blueAccent]
                colors: [Colors.white, Colors.white]

            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                  color: Colors.indigo[600],
                  image: Auth.instance.immagineprofiloasdecoration(),
                  borderRadius: BorderRadius.all(
                      Radius.circular(100.0)),)),
          ),


        ));

    lista.add(creatile(v1, paginapolicyprivacy, context , IconData(60223, fontFamily: 'MaterialIcons')));
    lista.add(creatile(v2, comefunziona, context, IconData(59515, fontFamily: 'MaterialIcons')));
    lista.add(creatile(v3, contattaci, context, IconData(57529, fontFamily: 'MaterialIcons')));
    lista.add(creatile(v4, eventi, context , IconData(59512, fontFamily: 'MaterialIcons') , comingsoon: true));
    lista.add(creatile(v5, logout, context, IconData(59513, fontFamily: 'MaterialIcons')));


    listaelementimenu.clear();


    return lista;

  }



  void paginapolicyprivacy(context){

  //  {Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicy()));}

  }

  void comefunziona(context){

  //  {Navigator.push(context, MaterialPageRoute(builder: (context) => ComeFunziona()));}

  }

  void contattaci(context){

  //  {Navigator.push(context, MaterialPageRoute(builder: (context) => Contattaci()));}

  }

  void eventi(context){

    // {Navigator.push(context, MaterialPageRoute(builder: (context) => Eventi()));}
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            content: Text("Arriveremo con tutte le informazioni sui nostri eventi"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))
            ),

          );
        }
    );

  }

  void logout(context){
   // loginService.esci(context);
  }


  ListTile creatile(String s , Function f, context, IconData icona ,{ bool comingsoon = false}){
    return new ListTile(

      title:
      Align(
          alignment: Alignment.center,
          child:
          Row(
              children:<Widget>[
                Icon(icona , color:Colors.white),
                SizedBox(width: 15,),
                Expanded(

                  child:Text(s, style: TextStyle(fontFamily: fontfamily , fontSize: 18 , fontWeight: FontWeight.w700, color: Colors.white ,)),

                ),

                Container(
                  child: comingsoon ?
                  Container(
                    child: new Text (
                        "Coming soon",
                        style: new TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                        )
                    ),
                    decoration: new BoxDecoration (
                        borderRadius: new BorderRadius.all(new Radius.circular(100.0)),
                        color: Colors.purpleAccent
                    ),
                    padding: new EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                  ): Container(),
                )

              ]

          )
      ),
      onTap: () {
        f(context);
      },
    );
  }




}