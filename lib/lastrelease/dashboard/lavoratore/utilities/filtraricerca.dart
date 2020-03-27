

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:win/lastrelease/authentication/posizione.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/dashboard/datoredilavoro/utilities/iconatitolo.dart';
import 'package:win/lastrelease/model/azienda.dart';
import 'package:win/lastrelease/model/filtro.dart';
import 'package:win/lastrelease/model/posizionelatlong.dart';
import 'package:win/lastrelease/services/annunciservice.dart';
import 'package:win/lastrelease/widgets/appbar.dart';
import 'package:win/lastrelease/widgets/cercaskill.dart';
import 'package:win/placesandmaps.dart';

class PaginaFiltriLavoratore extends StatefulWidget{


  PaginaFiltriLavoratore();

  @override
  PaginaFiltriLavoratoreState createState() {
    // TODO: implement createState
    return PaginaFiltriLavoratoreState();
  }

}

class PaginaFiltriLavoratoreState extends State<PaginaFiltriLavoratore>{


  Filtro filtro;


  String titolopagina = "FILTRA RICERCA";

  TextEditingController mansioneScelta = TextEditingController();



  String dataselezionata = "";

  String datafinaleselezionata = "";



  double pagascelta;

  PosizioneLatLong posizionescelta = new PosizioneLatLong();

  bool paghespecificate = false;


  Slider distanzaselezionata;
  int valoreselezionato = 1;

  Future<bool> _onWillPop() async{
    await Annunci.instance.prendiannunciqueriedandpaged(0);
    return true;
  }


//  loc.LocationData currentLocation;



  @override
  void initState() {

    filtro = Annunci.instance.filtro;

    if(filtro.skill != null) {
      mansioneScelta.text = filtro.skill;
    }
    if(filtro.datainizio != null) {
      datascelta = convertidata(filtro.datainizio);
    }
    if(filtro.datafine != null) {
      datafinalescelta = convertidata(filtro.datafine);
    }
    if(filtro.paga != null) {
      pagascelta = filtro.paga;
    }
    if(filtro.paghenonspecificate != null) {
      paghespecificate = filtro.paghenonspecificate;
    }

    if(filtro.distanza != null && filtro.distanza > 0){
      valoreselezionato = filtro.distanza;
    }

    if(filtro.posizionepartenza != null){
      posizionescelta = filtro.posizionepartenza;
    }


    cercaposizionecorrente();



    super.initState();
  }


  cercaposizionecorrente() async {


    LocationData locationdata = await Posizione.instance.aggiornaposizone();

    if(locationdata == null) return;

        filtro.posizionepartenza = new PosizioneLatLong(latitudine: locationdata.latitude , longitudine: locationdata.longitude);


      setState(() {

      });
    }



  @override
  Widget build(BuildContext context) {

    distanzaselezionata = new Slider.adaptive(


        value: valoreselezionato.toDouble(),
        min: 1.0,
        max: 50.0,
        divisions: 50,
        activeColor: azzurroscuro,
        inactiveColor: Colors.black,
        label: valoreselezionato.toString() + " km",
        onChanged: (double newValue) {
          setState(() {

            valoreselezionato = newValue.round();

            filtro.distanza = valoreselezionato;

          });
        },
        semanticFormatterCallback: (double newValue) {
          return '${newValue.round()} km';
        }


    );

    Size screenSize = MediaQuery.of(context).size;

    return


      WillPopScope(

        onWillPop: _onWillPop,

        child: Scaffold(
            appBar: appbarcomune(titolopagina),

            body:

            Container(




              child: Column(
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.only(bottom: 35),
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text("CHE MANSIONE CERCHI?" , style: TextStyle(fontSize: 16, color:  Color(0xFF535353), fontWeight: FontWeight.w700)),
                    ),
                  ),
                  selezionemansione(),

                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                  ),

                  selezionadatainizio(),

                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                  ),

                  selezionapaga(screenSize.width),

                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                  ),


                  includinonspecificato(screenSize.width),



                  Column(
                      children: <Widget>[

                        Center(
                          child: Text(valoreselezionato.toString() + " KM", style: TextStyle(fontFamily: fontfamily , fontSize: 15 , fontWeight: FontWeight.w700, color: Color(0xFF535353)),),
                        ),


                        Row(
                            children: <Widget>[
                              SizedBox(width: 35,),
                              Text("1 KM" ,style: TextStyle(fontFamily: fontfamily , fontSize: 15 , fontWeight: FontWeight.w700, color: Color(0xFF535353)),),
                              SizedBox(width: 5,),
                              Expanded(
                                  child: Container(

                                    child: distanzaselezionata,
                                  )
                              ),

                              SizedBox(width: 5,),
                              Text("50 KM", style: TextStyle(fontFamily: fontfamily , fontSize: 15 , fontWeight: FontWeight.w700, color: Color(0xFF535353)),),
                              SizedBox(width: 35,),


                            ]
                        )
                      ]
                  ),


                  SizedBox(height: 30,),



                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget> [
                        MaterialButton(

                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),

                          elevation: 10,

                          color: Colors.redAccent,

                          onPressed: (){resetfiltri();} ,
                          child: Text("CANCELLA FILTRI",style:
                          TextStyle(fontSize: 14, color:  Colors.white, fontWeight: FontWeight.w800)),

                        ),
                        MaterialButton(

                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),

                          elevation: 10,

                          color: Color(0xFF2FE000),

                          onPressed: (){Navigator.of(context).pop();} ,
                          child: Text("SALVA FILTRI",style:
                          TextStyle(fontSize: 14, color:  Colors.white, fontWeight: FontWeight.w800)),

                        ),
                      ]
                  )




                ],
              ),



            )








        ),
      );

  }


  void faiapparirericercaskill(BuildContext context) async {


    var result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CercaSkill()));



    setState(() {
      filtro.skill = result;
      mansioneScelta.text = result;
    });

  }



  Widget selezionemansione(){



    return Hero(
      child:

      GestureDetector(
          onTap: (){
            faiapparirericercaskill(context);
          },
          child:
          AbsorbPointer(
            child: TextField(
               decoration: InputDecoration(hintText: "Es. Cameriere"),
               controller: mansioneScelta,
            ),
          )
      ),

      tag: "Mansione",
    );


  }




  Widget selezionapaga(width){

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[

        Container(
            width: MediaQuery.of(context).size.width/3,
            child:
            Center(
              child: GestureDetector(
                onTap : () { faiapparireselezionapaga(context); },
                child: IconaTitolo(icon: Icon(
                  Icons.euro_symbol,
                  size: 30,
                  color:  Color(0xFF535353),
                ),  text: pagascelta == null ? "PAGA MINIMA" : pagascelta == 0 ? "NON SPECIFICATO" : pagascelta.toInt().toString(),
                    style: TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800)
                ),
              ),
            )
        ),

        Container(
            width: MediaQuery.of(context).size.width/3,
            child:
            Center(
              child: GestureDetector(
                onTap : () { faiapparireselezioneposizionepartenza(context); },
                child: IconaTitolo(icon: Icon(
                  Icons.location_on,
                  size: 30,
                  color:  Color(0xFF535353),
                ),  text: posizionescelta == null ? "DA DOVE?" : posizionescelta.via == null ? "NON SPECIFICATO" : posizionescelta.via,
                    style: TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800)
                ),
              ),
            )
        )

        // faiapparireselezioneposizionepartenza(context);



      ],
    );


  }



  Widget includinonspecificato(width){
    return Container(
      margin: EdgeInsets.only(left: 20 , right: 20 , top: 0 ,bottom: 20),

      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text("Includi paghe non specificate", style: TextStyle(fontFamily: fontfamily , fontSize: 15 , fontWeight: FontWeight.w700, color: Color(0xFF535353)),),
          Checkbox(
            value: paghespecificate,
            onChanged: (bool value) {
              setState(() {
                paghespecificate = value;
                filtro.paghenonspecificate = value;
              });
            },
          ),
        ],
      ),

    );
  }


  Widget selezionadatainizio(){

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[


        Container(
            width: MediaQuery.of(context).size.width/3,
            child:
            Center(
              child:
              GestureDetector(
                onTap: ()async{
                  await _selectDate(context);
                },
                child: IconaTitolo(icon: Icon(
                  Icons.today,
                  size: 30,

                  color: Color(0xFF535353),
                ),  text: datascelta == null ? "DA" : datascelta,
                    style: TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800)
                ),
              ),
            )
        ),


        Container(
            width: MediaQuery.of(context).size.width/3,
            child:
            Center(
              child:
              GestureDetector(
                onTap: ()async{
                  await _selectDatefinale(context);
                },
                child: IconaTitolo(icon: Icon(
                  Icons.today,
                  size: 30,

                  color: Color(0xFF535353),
                ),  text: datafinalescelta == null ? "A" : datafinalescelta,
                    style: TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800)
                ),
              ),
            )
        ),
        /*         IconaTitolo(icon: Icon(
                        Icons.location_on,
                        size: 30,
                        color: Color(0xFF535353),
                      ),  text: annuncio.distanza,
                          style: TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800)
                      ), */
/*
        GestureDetector(
          onTap: (){_selectTime(context);},
          child: IconaTitolo(icon: Icon(
            Icons.timer,
            size: 30,
            color:  Color(0xFF535353),
          ),  text: orascelta == null ? "A CHE ORA?" : orascelta,
              style: TextStyle(fontSize: 14, color:  Color(0xFF535353),fontWeight: FontWeight.w800)
          ),
        ) */

      ],
    );


  }






  Future<Null> faiapparireselezionapaga(BuildContext context) async {

    var paga;

    var result = showDialog<String>(
      context: context,
      barrierDismissible: true, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('PAGA'),
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        labelText: 'Paga', hintText: 'es. 50'),
                    onChanged: (value) {
                      setState(() {
                        filtro.paga = double.parse(value);
                        this.pagascelta = double.parse(value);
                      });
                    },
                  ))
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop(paga);
              },
            ),
          ],
        );
      },
    );





  }


  Future<Null> faiapparireselezioneposizionepartenza(BuildContext context) async {


      await Posizione.instance.aggiornaposizone();

      PosizioneLatLong posizioneazienda = await Navigator.of(context).push(
          MaterialPageRoute(builder: (c) => CercaVia(conappbar: true))
      );

      if(posizioneazienda == null || posizioneazienda.via.isEmpty) return;



    filtro.posizionepartenza = posizioneazienda;
    setState(() {

    });

  }




  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.3,
      height: 2.0,
      color: azzurroscuro,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  DateTime selectedDate = DateTime.now();
  String datascelta;
  TextEditingController datacontroller = new TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now().add(Duration(days: -1)),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        datascelta = convertidata(picked);
      });
    setState(() {
      filtro.datainizio = picked;
      selectedDate = picked;
    });


  }


  DateTime selectedDatefinale = DateTime.now();
  String datafinalescelta;

  Future<Null> _selectDatefinale(BuildContext context) async {
    selectedDatefinale = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDatefinale,
        firstDate: DateTime.now().add(Duration(days: -1)),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDatefinale)
      setState(() {
        datafinalescelta = convertidata(picked);
      });
    setState(() {
      filtro.datafine = picked;
      selectedDatefinale = picked;
    });


  }





  final dateFormat = DateFormat("dd-MM-yyyy");

  String convertidata(DateTime data){
    return dateFormat.format(data);
  }

  salvafiltri(){
    filtro.posizionepartenza = posizionescelta;
    filtro.distanza = valoreselezionato;
    filtro.skill =  mansioneScelta.text;
    filtro.paga  =  pagascelta;
    filtro.paghenonspecificate = paghespecificate;
    filtro.datainizio = selectedDate;
    filtro.datafine = selectedDatefinale;
  }

  resetfiltri(){
    filtro = new Filtro();
    posizionescelta = new PosizioneLatLong();
    valoreselezionato = 1;
    mansioneScelta.text = "";
    pagascelta = null;
    paghespecificate = false;
    selectedDate = DateTime.now();
    selectedDatefinale = DateTime.now();
    datascelta = null;
    datafinalescelta = null;
    setState(() {

    });
  }

}