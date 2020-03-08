
import 'package:flutter/material.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/services/comefunzionaservice.dart';
import 'package:win/lastrelease/widgets/appbar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ComeFunziona extends StatefulWidget{
  @override
  ComeFunzionaState createState() {
    // TODO: implement createState
    return ComeFunzionaState();
  }

}



class ComeFunzionaState extends State<ComeFunziona> {






  @override
  void initState() {
    ComeFunzionaService.instance.aggiornacomefunziona();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return
      Scaffold(

          appBar: appbarcomune("Come funziona"),

          body:

          StreamBuilder(
              stream: ComeFunzionaService.instance.comefunziona.stream.asBroadcastStream(),
              builder: (context, snapshot) {

                if(!snapshot.hasData){
                  return Center(
                    child: Text("" , style: testosemplice16,),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _elementosingolo(snapshot.data.data[index], context);
                  },
                );

              }

          )

      );

  }


  Widget _elementosingolo(dynamic video , context){

    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: video["source"],
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    return Column(

      children: <Widget>[
        SizedBox(height: 20,),
        Text(video["titolo"] , style: testosemplice16 , textAlign: TextAlign.center),
        SizedBox(height: 20,),
        Center(
          child: YoutubePlayer(
            controller: _controller,
          ),
        ),
        SizedBox(height: 20,)
      ],
    );
  }



}


