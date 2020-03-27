


import 'package:flutter/material.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/dashboard/dashboardwidgets/bottomnavy.dart';
import 'package:win/lastrelease/dashboard/datoredilavoro/pubblicaannuncio.dart';
import 'package:win/lastrelease/dashboard/lavoratore/paginaesploraannunci.dart';
import 'package:win/lastrelease/dashboard/profilologged.dart';
import 'package:win/lastrelease/menulaterale/menulaterale.dart';

import 'datoredilavoro/paginaannuncidatore.dart';

class Dashboard extends StatefulWidget{
  @override
  DashboardState createState() {
    return DashboardState();
  }



}


class DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin{


  int _currentIndex = 0;
  PageController _pageController;

  Profilo profilo = new Profilo();

  PubblicaAnnuncio pubblicaAnnuncio = new PubblicaAnnuncio();

  PaginaAnnunciDatore paginaAnnunciDatore = new PaginaAnnunciDatore();

  EsploraAnnunci esploraAnnunci = new EsploraAnnunci();


  @override
  void initState() {
    _pageController = PageController(initialPage: _currentIndex,keepPage: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth.instance.currentauth.stream.asBroadcastStream(),
      builder: (context,snapshot){
          if (!snapshot.hasData) {
            return Scaffold(
              body: Container(
                child: Center(
                  child: CircularProgressIndicator()
                ),
              ),
            );
          }else if(snapshot.data.data["email"] != null && snapshot.data.data["email"] != "") {
            return costruiscicorpocentrale();
          }else {
            return Scaffold(
              body: Container(
                child: Center(
                  child: Text("Impossibile connettersi al server" , style: testosemplice16,),
                ),
              ),
            );
          }
      }
    );
  }


  Widget corpopagina(){

  }



  costruiscicorpocentrale(){
    return StreamBuilder(
      stream: Auth.instance.currentauth.stream.asBroadcastStream(),
        builder: (context,snapshot){

          if (!snapshot.hasData) {
            return Scaffold(
              body: Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }


          if(snapshot.data.data["ruolo"] == "DATORE"){
            return Scaffold(
              drawer: new Drawer(
                child: new MenuLaterale(),
              ),
              appBar: appbar(),
              body: bodydatore(),
              bottomNavigationBar: bottomnavigationbardatore(),
            );
          }else if(snapshot.data.data["ruolo"] == "LAVORATORE"){
            return Scaffold(
              drawer: new Drawer(
                child: new MenuLaterale(),
              ),
              appBar: appbar(),
              body: bodylavoratore(),
              bottomNavigationBar: bottomnavigationbarlavoratore(),
            );
          }else if(snapshot.data.data["ruolo"] == "AMMINISTRATORE"){
             return Scaffold(
               body: Container(),
             );
          }else{
            return Scaffold(
              body: Container(
                child: Center(
                  child: Text("IMPOSSIBILE CONNETTERSI AL SERVER"),
                ),
              ),
            );
          }
        }
    );
  }




   appbar(){
     return new AppBar(

         backgroundColor: azzurroscuro,
         title:

         StreamBuilder(
             stream: Auth.instance.currentauth.stream.asBroadcastStream(),
             builder: (context,snapshot){
               if (!snapshot.hasData) {
                 return Text("", style: stiletestoappbar
                 );
               }else{
                 return Text(snapshot.data.data["nome"], style: stiletestoappbar
                 );
               }
             }
         ),

         centerTitle: true,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.vertical(
             bottom: Radius.circular(30),
           ),)
     );
  }



  bodylavoratore(){
    return SizedBox.expand(
      child: PageView(
        controller: _pageController,

        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: <Widget>[
          esploraAnnunci,
          Container(
            child: Text("2"),
          ),
          Container(
            child: Text("3"),
          ),
          profilo
   //       esploraAnnunci,
   //       paginaannunci,
   //       notifiche,
   //       profilo,
        ],
      ),
    );
  }



  bottomnavigationbarlavoratore(){

    return BottomNavyBar(
      selectedIndex: _currentIndex,
      onItemSelected: (index) {


        setState(() {
          _currentIndex = index;
        });

        _pageController.jumpToPage(index);
      },
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
            title: Text('Esplora'),
            icon: Icon(Icons.search),
            activeColor: azzurroscuro
        ),
        BottomNavyBarItem(
            title: Text('Miei annunci'),
            icon: Icon(Icons.description),
            activeColor: azzurroscuro
        ),
        BottomNavyBarItem(
            title: Text('Notifiche'),
            icon: Icon(Icons.notifications),
            activeColor: azzurroscuro
        ),
        BottomNavyBarItem(
            title: Text('Profilo'),
            icon: Icon(Icons.person),
            activeColor: azzurroscuro
        ),
      ],
    );

  }



  bodydatore() {
    return SizedBox.expand(
      child: PageView(
        controller: _pageController,

        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: <Widget>[
          paginaAnnunciDatore,
          pubblicaAnnuncio,
          Container(
            child: Text("3"),
          ),
          profilo
     /*     paginaannunci,
          pubblica,
          notifiche,
          profilo, */
        ],
      ),
    );
  }


  bottomnavigationbardatore(){
    return  BottomNavyBar(
      selectedIndex: _currentIndex,
      onItemSelected: (index) {


        setState(() {
          _currentIndex = index;
        });

        _pageController.jumpToPage(index);
      },
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
            title: Text('Annunci'),
            icon: Icon(Icons.search),
            activeColor: azzurroscuro
        ),
        BottomNavyBarItem(
            title: Text('Pubblica annunci'),
            icon: Icon(Icons.publish),
            activeColor: azzurroscuro
        ),
        BottomNavyBarItem(
            title: Text('Notifiche'),
            icon: Icon(Icons.notifications),
            activeColor: azzurroscuro
        ),
        BottomNavyBarItem(
            title: Text('Profilo'),
            icon: Icon(Icons.person),
            activeColor: azzurroscuro
        ),
      ],
    );
  }

}

