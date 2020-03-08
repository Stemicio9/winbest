


import 'package:flutter/material.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/dashboard/datoredilavoro/aggiungiazienda.dart';
import 'package:win/lastrelease/model/azienda.dart';
import 'package:win/lastrelease/model/skill.dart';

class Profilo extends StatefulWidget {
  @override
  ProfiloState createState() {
    return ProfiloState();
  }

}


class ProfiloState extends State<Profilo>{
  @override
  Widget build(BuildContext context) {
     return Scaffold(
     body: StreamBuilder(
      stream: Auth.instance.currentauth.stream.asBroadcastStream(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }
        if(snapshot.data.data["ruolo"] == "DATORE"){
           return profilodatore();
        }else if(snapshot.data.data["ruolo"] == "LAVORATORE"){
          return profilolavoratore();
        }else{
          return Center(child: Text("Impossibile connettersi al server"));
        }
      },
    )
     );
  }



  Widget profilodatore(){
     return Container(
       child: ListView(
         children: <Widget>[
           //       SizedBox(height: 8.0,),
           UpperSection(),
           SizedBox(height: 18.0,),
           MiddleSectionDatore(mostracontextmenu),
           // Spacer(),
           SizedBox(height: 18.0,),
           Divider(height: 8.0,),
          // AbbonamentoSection(),

           BottomSection(),
         ],
       ),
     );
  }


  Widget profilolavoratore(){
     return Container(
       child:
       ListView(
             children: <Widget>[

               UpperSection(),
               SizedBox(height: 18.0,),
               MiddleSectionLavoratore(),
               // Spacer(),
               SizedBox(height: 18.0,),
               Divider(height: 8.0,),
             ],
           )
     );
  }




  mostracontextmenu() async {

    PopupMenuItem item = new PopupMenuItem(
        value: 1,
        child:
        Container(
            width: MediaQuery.of(context).size.width*2,
            child:
            Center(
              child: Text("Rimuovi"),
            )
        )
    );

    List<PopupMenuItem> items = new List();
    items.add(item);


    var result = await showMenu(context: context,
        position: RelativeRect.fromLTRB(0, MediaQuery.of(context).size.height, MediaQuery.of(context).size.width, 0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),),
        items: items);
    return result;
  }









}


class BottomSection extends StatelessWidget {
  const BottomSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      color: color1.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
                onTap: (){
           //       Navigator.of(context).push(MaterialPageRoute(builder: (c) => ComeFunziona()));
                },
                child: Text('Aiuto' , style: TextStyle(
                  decoration: TextDecoration.underline,
                ),)
            )
          ],
        ),
      ),
    );
  }
}















class MiddleSectionDatore extends StatefulWidget {

  Function mostrapopup;

  MiddleSectionDatore(this.mostrapopup);


  @override
  MiddleSectionDatoreState createState() {
    return MiddleSectionDatoreState();
  }

}


class MiddleSectionDatoreState extends State<MiddleSectionDatore> {


  settastato(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: <Widget>[
          Divider(height: 8.0,),
          ListTile(
            title: Text("Le mie aziende"),
            //      subtitle: Text('31 tasks in 5 categories'),
            trailing: ClipOval(
              child: Container(
                  height: 40.0,
                  width: 40.0,
                  color: Color(0xFF2FE000).withOpacity(0.2),
                  //                color: azzurroscuro.withOpacity(0.2),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (c)=> AggiungiAzienda()));
                    },
                    icon: Icon(Icons.add),
                    color: Color(0xFF2FE000),
                    //                  color: azzurroscuro
                  )),
            ),
          ),
          SizedBox(height: 8.0,),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              height: 130.0,
              child:

              StreamBuilder(
                stream: Auth.instance.currentauth.stream.asBroadcastStream(),
                builder: (context,snapshot) {

                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.all(0.0),
                    scrollDirection: Axis.horizontal,

                    itemBuilder: (context, index) {
                      Azienda a = snapshot.data.data["listaaziende"][index];
                      return ItemCard(
                          Icons.local_activity,
                          a.nomeazienda,
                          a.posizionelatlong.via != null  ? a.posizionelatlong.via : "",
                          a,
                          settastato,
                          this.widget.mostrapopup
                      );
                    },

                    itemCount: snapshot.data.data["listaaziende"].length,

                  );
                }
          )

            ),
          )
        ],
      ),
    );
  }
}


class ItemCard extends StatelessWidget {
  final icon;
  final name;
  final tasks;
  final Azienda azienda;
  final Function settastato;
  final Function mostrapopup;



  const ItemCard(

      this.icon,
      this.name,
      this.tasks,
      this.azienda,
      this.settastato,
      this.mostrapopup
      );
  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
          onLongPress: ()async{

            var result = await mostrapopup();
            if(result == 1) {
              await Auth.instance.rimuoviazienda(azienda.nomeazienda);
              settastato();
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child:

            Container(
              height: 130.0,
              width: 130.0,

              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: wingradients4),
                  borderRadius: BorderRadius.all(Radius.circular(15))

              ),
              child:

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(icon, color: Colors.white,),
                    Spacer(),
                    Text(azienda.nomeazienda, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    SizedBox(height: 4.0,),
                    Text(azienda.posizionelatlong.via != null ? azienda.posizionelatlong.via : "Indirizzo non disponibile", maxLines: 10, style: TextStyle(color: Colors.white.withOpacity(0.9)),),
                  ],
                ),
              ),

            ),

          )
      );
  }
}



class UpperSection extends StatelessWidget {
  const UpperSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 32.0, right: 32.0, bottom: 32.0,top: 16),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(),
                  Icon(
                    Icons.edit,
                    color: azzurroscuro,
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              /*   CircleAvatar(
                backgroundImage: profileImage,
              ), */
              ImmagineProfiloWidget(),
              SizedBox(
                height: 16.0,
              ),
              StreamBuilder(
                stream: Auth.instance.currentauth.stream.asBroadcastStream(),
              builder: (context,snapshot) {
                if(!snapshot.hasData) return Container();
                return Text(
                  snapshot.data.data["nome"] != null && snapshot.data.data["cognome"] != null ? snapshot.data.data["nome"] + " " + snapshot.data.data["cognome"] : snapshot.data.data["email"],
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                );
              }
              ),
              SizedBox(
                height: 4.0,
              ),
              StreamBuilder(
                  stream: Auth.instance.currentauth.stream.asBroadcastStream(),
                  builder: (context,snapshot) {
                    if(!snapshot.hasData) return Container();
                    return Text(
                      snapshot.data.data["status"] != null ? snapshot.data.data["status"] : "",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.grey
                      ),
                    );
                  }
              ),
            ],
          ),
        ),
/*        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: Container(
            height: 4.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [color1, color2])),
          ),
        ), */


        Padding(
          padding: EdgeInsets.only(left: 15.0, right: 35.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                  children:<Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      child:
                      //GaugeChart.withSampleData()
                      //    Odo(inputValue: 100,size: 70,)
                      valoreprofilo(),
                    )
                  ]
              ),
              Column(
                children: <Widget>[
                  Text(
                    '65',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Text(
                    'Match',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    '38',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Text(
                    'Positivi',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    '27',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Text(
                    'Black List',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget valoreprofilo() {
    // se buono pollice in su, altrimenti pollice in giù
    bool val = true;

    if(val){
      return Icon(Icons.thumb_up, size: 54, color: azzurroscuro);
    }else{
      return Icon(Icons.thumb_down, size: 54, color: Colors.redAccent);
    }
  }

}


class ImmagineProfiloWidget extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () {
        _buildAboutDialog(context);
      },


      child:

      StreamBuilder(
        stream: Auth.instance.currentauth.stream.asBroadcastStream(),
     builder: (context,snapshot){
      return Container(
        width: 120.0,
        height: 120.0,
        decoration: BoxDecoration(
          image: Auth.instance.immagineprofiloasdecoration(),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 0.0,
          ),
        ),
      );
     }
      )


    );
  }


  _buildAboutDialog(BuildContext context) async{
    //  return new RadialMenu();


    // await prendiimmaginiprofilo();
/*
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) =>

    //      PaginaImmaginiProfilo()

      )
    ); */

  }





}

/*

class AbbonamentoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Padding(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    convertidata(abbonamento.fineabbonamento),
                    style: TextStyle(fontSize: 15.0),
                  ),
                  Text(
                    'Scadenza',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    abbonamento.annuncirimasti.toString(),
                    style: TextStyle(fontSize: 15.0),
                  ),
                  Text(
                    'Annunci',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),

              Center(
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    color:Color(0xFF2FE000),
                    elevation: 10,
                    onPressed: ()async{
/*
                      await prodottiAbbonamentiService.prendiprodottiabbonamenti();

                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>

                          PaginaGestioneAbbonamento()

                      )); */
                    },
                    child: Text("Abbonamento" , style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w200,
                    ),),
                  )
              )

            ],
          )
      );
  }

  final dateFormat = DateFormat("dd-MM-yyyy");

  String convertidata(DateTime data){
    return dateFormat.format(data);
  }




}
*/



class MiddleSectionLavoratore extends StatelessWidget {




  MiddleSectionLavoratore();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: <Widget>[
          Divider(height: 8.0,),
          ListTile(
            title: Text("Lista mansioni"),
            trailing: ClipOval(
              child: Container(
                  height: 40.0,
                  width: 40.0,
                  color: Color(0xFF2FE000).withOpacity(0.2),
                  //                color: azzurroscuro.withOpacity(0.2),
                  child: IconButton(
                    onPressed: () {
                //      Navigator.of(context).push(MaterialPageRoute(builder: (c)=> AggiungiSkill()));
                    },
                    icon: Icon(Icons.add),
                    color: Color(0xFF2FE000),
                    //                  color: azzurroscuro
                  )),
            ),
            //      subtitle: Text('31 tasks in 5 categories'),
          ),
          SizedBox(height: 8.0,),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              height: 130.0,
              child:

              StreamBuilder(
                  stream: Auth.instance.currentauth.stream.asBroadcastStream(),
                builder: (context, snapshot) {

                  if(!snapshot.hasData) return Container();
                  if (snapshot.data.data["listaskill"].length == 0) return Container();

                  return ListView.builder(
                    padding: EdgeInsets.all(0.0),
                    scrollDirection: Axis.horizontal,

                    itemBuilder: (context, index) {

                      Skill skill = snapshot.data.data["listaskill"][index];
                      return ItemCardLavoratore(
                        Icons.work,
                        skill.nomeskill,
                      );
                    },

                    itemCount: snapshot.data.data.length,

                  );
                }


              )

            ),
          )
        ],
      ),
    );
  }
}


class ItemCardLavoratore extends StatelessWidget {
  final icon;
  final name;


  const ItemCardLavoratore(

      this.icon,
      this.name
      );
  @override
  Widget build(BuildContext context) {
    return

      GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child:

            Container(
              height: 130.0,
              width: 130.0,

              decoration: BoxDecoration(



                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: wingradients4),
                  borderRadius: BorderRadius.all(Radius.circular(15))

              ),
              child:

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(icon, color: Colors.white,),
                    Spacer(),
                    Text(name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),

                  ],
                ),
              ),



            ),




          )
      );
  }
}
