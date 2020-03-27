
import 'package:flutter/material.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/services/utentiservice.dart';
import 'package:win/lastrelease/widgets/appbar.dart';

class PaginaRicercaUtenti extends StatelessWidget {

//  String titolo = "Ricerca utenti";




  PaginaRicercaUtenti();


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: appbarcomune("Ricerca utenti"),

      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(30.0),
            child: TextField(
              onChanged: (value){
                if(value.isNotEmpty)
                Utenti.instance.querylavoratori(value);
                },
              decoration: InputDecoration(
                //             border: OutlineInputBorder(),
                hintText: 'Nome utente',
              ),
            ),
          ),
          Flexible(
            child: StreamBuilder(
              stream: Utenti.instance.lavoratori.stream.asBroadcastStream(),
              builder: (context, snapshot) {

                print("lo snapshot è");
                print(snapshot.data);

                if (!snapshot.hasData)
                  return Center(
                    child:
                    Container(

                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/img/piccoloprincipe.png"),
                                fit: BoxFit.fill

                            )
                        )
                    ),
                  );

                return ListView.builder(
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (context, index) =>
                      GestureDetector(
                          onTap: () {
//                            Navigator.pop(context,Skill(nomeskill:snapshot.data[index].nomeskill , urlimmagine: snapshot.data[index].urlimmagine));
                          },
                          child:ListTile(
                            leading: CircleAvatar(
                              child:  Auth.instance.immagineprofiloaltrui(snapshot.data.data[index]["email"])

                            ),
                            title: Text(snapshot.data.data[index]["email"]),
                            //               subtitle: Text(snapshot.data[index].overview),
                          )
                      ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  FloatingActionButton actionButton(BuildContext context){
    return FloatingActionButton(
      backgroundColor: Color.fromRGBO(254, 167, 10, 1),
      onPressed: () async {
      //  await Navigator.push(context, MaterialPageRoute(builder: (context) => PaginaFiltriRicercaUtente()));
      },
      child: Icon(Icons.search, color: Colors.white,),
    );
  }

}