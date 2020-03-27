
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:win/lastrelease/authentication/abbonamento.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/dashboard/datoredilavoro/gestioneabbonamento.dart';
import 'package:win/lastrelease/dashboard/datoredilavoro/utilities/customradio.dart';
import 'package:win/lastrelease/dashboard/datoredilavoro/utilities/iconatitolo.dart';
import 'package:win/lastrelease/model/annuncio.dart';
import 'package:win/lastrelease/model/azienda.dart';
import 'package:win/lastrelease/services/annunciservice.dart';
import 'package:win/lastrelease/widgets/cercaskill.dart';
import 'package:win/lastrelease/widgets/popupconferma.dart';

class PubblicaAnnuncio extends StatefulWidget {
  @override
  PubblicaAnnuncioState createState() {
    return PubblicaAnnuncioState();
  }

}

class PubblicaAnnuncioState extends State<PubblicaAnnuncio> {

  Azienda aziendascelta = new Azienda();

  TextEditingController mansionecontroller = new TextEditingController();
  String urlmansione;

  TextEditingController noteaggiuntivecontroller = new TextEditingController();

  final dateFormat = DateFormat("dd-MM-yyyy");

  final hourFormat = TimeOfDayFormat.HH_colon_mm;

  DateTime selectedDate = DateTime.now();
  String datascelta;

  TimeOfDay selectedTime = TimeOfDay.now();
  String orascelta;

  double pagascelta;

  CustomRadio radio;


  bool ricercaskillattiva = false;

  @override
  void initState() {
    Abbonamenti.instance.aggiornaabbonamento();
    radio = new CustomRadio(oggettopagaselezionato);
    super.initState();
  }

  Future<Null> _selectDate(BuildContext context) async {

    if(selectedDate == null) {
      selectedDate = DateTime.now();
    }

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now().add(Duration(days: -1)),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      datascelta = convertidata(picked);
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context ) async {
    if(selectedTime == null) {
      selectedTime = TimeOfDay.now();
    }
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null)

      orascelta = convertiOra(picked);
    setState(() {

      selectedTime = picked;
    });


  }

  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder(
        future: Abbonamenti.instance.abbonamentoterminato(),
        builder: (context, snapshot) {

          if(!snapshot.hasData) return Container();

          print("STATUS ABBONAMENTO ");
          print(snapshot.data);

          return !snapshot.data ?
           Scaffold(
            //   resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 25),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child:
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child:Text("MANSIONE",style: TextStyle(fontSize: 16, color:  Color(0xFF535353), fontWeight: FontWeight.w700),),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                    ),


                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                    child: GestureDetector(
                        onTap: ()async {
                          String result = await faiapparirericercaskill();
                          mansionecontroller.text = result;
                        },
                        child:
                            AbsorbPointer(
                        child: TextField(
                          controller: mansionecontroller,
                        )
                            )
                    )
                    ),



                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text("PER QUALE AZIENDA?" , style: TextStyle(fontSize: 16, color:  Color(0xFF535353), fontWeight: FontWeight.w700)),
                    ),
                    _buildsceltaazienda(),


                    Padding(
                      padding: EdgeInsets.only(bottom: 25),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[


                        GestureDetector(
                          onTap: ()async{
                            await _selectDate(context);
                          },
                          child: IconaTitolo(icon: Icon(
                            Icons.today,
                            size: 30,

                            color: Color(0xFF535353),
                          ),  text: datascelta == null ? "QUANDO?" : datascelta,
                              style: TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800)
                          ),
                        ),


                        GestureDetector(
                          onTap: (){_selectTime(context);},
                          child: IconaTitolo(icon: Icon(
                            Icons.timer,
                            size: 30,
                            color:  Color(0xFF535353),
                          ),  text: orascelta == null ? "A CHE ORA?" : orascelta,
                              style: TextStyle(fontSize: 14, color:  Color(0xFF535353),fontWeight: FontWeight.w800)
                          ),
                        )

                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 25),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[


                        IconaTitolo(icon: Icon(
                          Icons.euro_symbol,
                          size: 30,
                          color:  Color(0xFF535353),
                        ),  text: pagascelta == null ? "" : pagascelta == 0 ? "NON SPECIFICATO" : pagascelta.toInt().toString(),
                            style: TextStyle(fontSize: 14, color:  Color(0xFF535353), fontWeight: FontWeight.w800)
                        ),
                      ],
                    ),

                    Container(
                        height: 55,
                        //    width: MediaQuery.of(context).size.width,
                        child:
                        Center(
                            child:
                            Container(
                              width: 270,
                              child: radio,
                            )
                        )
                    ),

                    _buildnoteaggiuntive(),

                    Container(
                      height: 100,

                      child: Center(
                        child: buildbuttonsubmit(),
                      ),
                    ),



                    //           SizedBox(height: 150,)








                  ],
                )
            ),
          ):

          Center(
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(bottom: 85),),
                  Text("Abbonamento scaduto" , style: TextStyle(fontSize: 14, color:  Color(0xFF535353),fontWeight: FontWeight.w800)) ,
                  Padding(padding: EdgeInsets.only(bottom: 25),),
                  MaterialButton(

                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),

                      elevation: 10,

                      color: Colors.redAccent,
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (c)=>  PaginaGestioneAbbonamento()));
                      },
                      child:

                      Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
                          child:
                          Text("Acquista annunci",
                            style:TextStyle(fontSize: 14, color:  Colors.white, fontWeight: FontWeight.w800) ,)
                      )

                  )
                ],
              ),
            ),
          )

          ;
        },
      );



  }



  Widget _buildnoteaggiuntive(){
    return Container(
      margin: EdgeInsets.only( left: 25),
      height: 40,
      child: TextFormField(keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: noteaggiuntivecontroller,
          textInputAction: TextInputAction.done,
          style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w400, color: Color(0xFF535353)),
          decoration: const InputDecoration(
            border: InputBorder.none,
            icon: const Icon(Icons.text_fields, color: Color(0xFF535353),),
            hintText: 'Note aggiuntive',
            //    labelText: 'Note aggiuntive',
            //    labelStyle: TextStyle(fontFamily: "Montserrat" , fontSize: 14 , fontWeight: FontWeight.w400, color: Color(0xFF535353)),
            hintStyle: TextStyle( fontSize: 12 , fontWeight: FontWeight.w400, color: Color(0xFF535353)),
          )
      ),

    );
  }



  Widget _buildsceltaazienda(){


    return

      FutureBuilder(
        future: Auth.instance.aziendecorrenti(),
        builder: (context,snapshot){
          if(!snapshot.hasData) return Container();
          List<Azienda> listaaziende = snapshot.data;
          print(listaaziende);
          if(listaaziende.length > 0) aziendascelta = listaaziende[0];
          return
            Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child:
                Column(
                    children: <Widget> [
                      Center(
                          child:


                                InputDecorator(

                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Es. Apple",
                                        hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14, fontWeight: FontWeight.w900)),



                                    child: DropdownButtonHideUnderline(
                                        child:
                                        DropdownButton<Azienda>(
                                            items:
                                            listaaziende.map<DropdownMenuItem<Azienda>>((Azienda value) {

                                              return DropdownMenuItem<Azienda>(
                                                value: value,
                                                child: Text(value.nomeazienda),
                                              );
                                            }).toList(),

                                            style: TextStyle(fontSize: 16, color: Color(0xFF999A9A), fontWeight: FontWeight.w700),

                                            value: aziendascelta,
                                            onChanged: (Azienda newValue) {
                                              setState(() {
                                                aziendascelta = newValue;
                                              });
                                            }
                                        )
                                    )
                                ),

                      )

                    ]

                )
            );
        }
      );
  }


  Widget buildbuttonsubmit(){

    return
      MaterialButton(

          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),

          elevation: 10,

          color: azzurroscuro,
          onPressed: (){
            pubblicaannuncio();
          },
          child:

          Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
              child:
              Text("Pubblica Annuncio",
                style:TextStyle(fontSize: 14, color:  Colors.white, fontWeight: FontWeight.w800) ,)
          )

      );


  }



  String convertidata(DateTime data){
    return data.day.toString() + " " + prendinomemesedanumero(data.month);
  }


  String convertiOra(TimeOfDay time){
    return time.format(context);
  }

  static String prendinomemesedanumero(int numero){

    switch(numero){
      case 1:
        return "GEN";
      case 2:
        return "FEB";
      case 3:
        return "MAR";
      case 4:
        return "APR";
      case 5:
        return "MAG";
      case 6:
        return "GIU";
      case 7:
        return "LUG";
      case 8:
        return "AGO";
      case 9:
        return "SET";
      case 10:
        return "OTT";
      case 11:
        return "NOV";
      case 12:
        return "DIC";
    }

  }


  aggiornapaga(paga){
    setState(() {
      this.pagascelta = paga;
    });
  }


  oggettopagaselezionato(){
    pagascelta = radio.selecteditem.buttonText;
    setState(() {

    });
  }

  refreshall(){
    selectedDate = DateTime.now();
    datascelta = null;
    selectedTime = TimeOfDay.now();
    orascelta = null;
    pagascelta = null;
    radio = new CustomRadio(oggettopagaselezionato);
    mansionecontroller.text = "";
    noteaggiuntivecontroller.text = "";
  }


  pubblicaannuncio() async {
    Annuncio annuncio = new Annuncio();
    annuncio.paga = pagascelta;
    annuncio.noteaggiuntive = noteaggiuntivecontroller.text;
    DateTime data = new DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedTime.hour, selectedTime.minute);
    annuncio.dataora = data;
    annuncio.candidati = new List();
    annuncio.skill = mansionecontroller.text;
    annuncio.pubblicante = await Auth.instance.autenticazionecorrenteemail();
    annuncio.azienda = aziendascelta;
    var res = await Annunci.instance.pubblicaannuncio(annuncio);
    Annuncio ann = Annuncio.fromJson(res.data);
    if(ann != null && ann.id != null){
      mostrasuccesso(context, "Annuncio pubblicato","Da adesso tutti potranno vedere l'annuncio!");
    }

  }


  Future<String> faiapparirericercaskill() async {

     var result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CercaSkill()));

     return result;

  }




}

