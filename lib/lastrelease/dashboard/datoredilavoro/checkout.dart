
import 'package:flutter/material.dart';
import 'package:flutter_stripe_payment/flutter_stripe_payment.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:win/lastrelease/authentication/abbonamento.dart';

import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/loginsignup/loginparts/pulsanterettangolarearrotondato.dart';
import 'package:win/lastrelease/model/prodottoabbonamento.dart';
import 'package:win/lastrelease/widgets/appbar.dart';
import 'package:win/lastrelease/widgets/listametodidipagamentoradio.dart';
import 'package:win/lastrelease/widgets/popupconferma.dart';

class PaginaCheckOut extends StatefulWidget {


  ProdottoAbbonamento prodottoAbbonamento;

  String intent;



  PaginaCheckOut(this.prodottoAbbonamento,this.intent);


  @override
  PaginaCheckOutState createState() {
    return PaginaCheckOutState();
  }

}


class PaginaCheckOutState extends State<PaginaCheckOut>{

  ListaMetodiDiPagamentoRadio listametodiradio = ListaMetodiDiPagamentoRadio();


  bool accettato = true;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarcomune("Acquista"),
      body: Container(
        child:
        Column(
          children: <Widget> [
           Padding(padding: EdgeInsets.only(bottom: 25),),

           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Column(
                 children: <Widget>[

                   Center(
                       child: Text("Stai acquistando: " , style: testosemplice16,)
                   ),
                   Padding(padding: EdgeInsets.only(bottom: 7),),
                   Center(
                       child: Text(this.widget.prodottoAbbonamento.nome , style: testosemplice16,)
                   ),
                   Padding(padding: EdgeInsets.only(bottom: 7),),
                   Center(child:  Text(this.widget.prodottoAbbonamento.prezzo.toInt().toString() +  " €",style: testosemplice16,))

                 ],
               ),

               Padding(padding: EdgeInsets.symmetric(horizontal: 10),),

               Container(
                   width: 100,
                   height: 100,
                   child: Abbonamenti.instance.prodottoabbonamento(this.widget.prodottoAbbonamento.nome)
               )

             ],
           ),


           Padding(padding: EdgeInsets.only(bottom: 25),),


           Flexible(
           child: listametodiradio,
           ),
           Padding(padding: EdgeInsets.only(bottom: 15),),


           GestureDetector(
             onTap:creametododipagamento,
             child: PulsanteRettangolareArrotondato(
                 "Aggiungi carta", calltoactiongradient, false),
           ),

           GestureDetector(
             onTap:paga,
             child: PulsanteRettangolareArrotondato(
                 "Acquista", buttongradiant, false),
           ),


            Flexible(child: Container(),),

            contattaci(),
        ]
        )
      ),
    );
  }


  creametododipagamento() async{
    var paymentResponse = await Abbonamenti.instance.flutterStripePayment.addPaymentMethod();
    print("STATUS = ");
    print(paymentResponse.status);
    print("ERRORE = ");
    print(paymentResponse.errorMessage);
    if(paymentResponse.status == PaymentResponseStatus.succeeded)
    {

      var res = await Abbonamenti.instance.salvametododipagamento(paymentResponse.paymentMethodId);
      print(res);
      setState(() {

      });
    }else{
      mostraerrore(context,"Impossibile salvare metodo di pagamento", "Metodo di pagamento non supportato");
    }
  }

  double trasformadoubleinnumerocentesimi(double valore){
    double part =  valore*100;
    return part;
  }

  paga() async {
    var metodo = this.listametodiradio.metododipagamentoscelto.metodo;

    var response = await Abbonamenti.instance.flutterStripePayment.confirmPaymentIntent( this.widget.intent,
        metodo.id,
        trasformadoubleinnumerocentesimi(this.widget.prodottoAbbonamento.prezzo));

    if(response.status == PaymentResponseStatus.succeeded){
      bool result = await Abbonamenti.instance.confermapagamento(this.widget.prodottoAbbonamento.nome);
      if(result) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        mostrasuccesso(
            context,"Acquistato", "Abbonamento acquistato con sucesso");
      }else{
        mostraerrore(context, "Errore", "Annunci non accreditati, cercheremo di risolvere al più presto");
    }

  }

  }


  Widget contattaci() {
    return Container(
      height: 50.0,
      color: color1.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("METODO DI PAGAMENTO NON ACCETTATO?  " , style: TextStyle( fontSize: 10
            )),
            GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (c) => Container()));
                },
                child: Text('Contattaci' , style: TextStyle(
                  decoration: TextDecoration.underline,
                ),)
            )
          ],
        ),
      ),
    );
  }



/*
  prendimetodi()async {
    var lista = await pagamentiservice.prendimetodidipagamento();
    List<PaymentMethod> listametodi = new List();
    for(var elemento in lista){
      listametodi.add(PaymentMethod.fromJson(elemento));
    }
    listametodiradio = ListaMetodiDiPagamentoRadio(listametodi);
    if(listametodi.length > 0) {
      listametodiradio.metododipagamentoscelto = listametodi[0];
    }
    setState(() {

    });
  }

*/

/*
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          appBar: appbarcomune("Acquista"),
          body:  Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[


              SizedBox(height: 25,),

              Center(
                  child: Text(this.widget.prodottoAbbonamento.nome , style: TextStyle(fontSize: 16, color:  Color(0xFF535353),fontWeight: FontWeight.w800),)
              ),

              Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width/3,

                    child:
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text(this.widget.prodottoAbbonamento.prezzo.toInt().toString() + "€", style: TextStyle(fontSize: 16, color:  Color(0xFF535353),fontWeight: FontWeight.w800))),
                  ),
                  Expanded(

                      child:
                      Container(
                          width: 100,
                          height: 100,
                          child: Abbonamenti.instance.prodottoabbonamento(this.widget.prodottoAbbonamento.nome)
                             )
                  )
                ],
              ),

              /*
              final image = Image.network(
        baseurl+'prendifileabbonamento/'+product.nome+'?access_token='+token,

        );

           */

              SizedBox(height: 25,),

              this.listametodiradio == null ?
              Center(
                child: CircularProgressIndicator(),
              ) :

              this.listametodiradio.listametodi.length > 0 ?
              Center(
                child: Text("I TUOI METODI DI PAGAMENTO" , style: TextStyle(fontSize: 16, color:  Color(0xFF535353),fontWeight: FontWeight.w800),),
              ) : Container(),
              SizedBox(height: 15,),
              /*         Container(
            height: MediaQuery.of(context).size.height/3,
          child:
          Center(child: listametodiradio != null ? listametodiradio : Container())
          ), */
              Expanded(
                child: listametodiradio != null ? listametodiradio : Container(),
              ),

              SizedBox(height: 15,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget> [
                    Center(
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        elevation: 10,
                        color: Colors.redAccent,
                        onPressed: rimuovimetododipagamentoselezionato , child: Text("RIMUOVI METODO",
                          style:TextStyle(fontSize: 12, color:  Colors.white, fontWeight: FontWeight.w800)),),
                    ),
                    Center(
                        child:
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          elevation: 10,
                          color: calltoactionlogin,
                          onPressed: creametododipagamento, child: Text("AGGIUNGI METODO",
                            style:TextStyle(fontSize: 12, color:  Colors.white, fontWeight: FontWeight.w800)),)
                    ),
                  ]
              ),

              SizedBox(height: 5,),
              Center(
                  child:
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    elevation: 10,
                    color: Color(0xFF2FE000),
                    onPressed: ()async{

                      var metodo = this.listametodiradio.metododipagamentoscelto;

                      print("STO PAGANDO CON IL METODO SELEZIONATO : ");
                      print(metodo.id);




                      var response = await FlutterStripePayment.confirmPaymentIntent( this.widget.intent,
                          metodo.id,
                          trasformadoubleinnumerocentesimi(this.widget.prodottoAbbonamento.prezzo));


                      //     PaymentIntent payint = new PaymentIntent(clientSecret: this.widget.intent, paymentMethodId: metodo.id);

                      //     var resp = await StripePayment.confirmPaymentIntent(payint);

                      print(response.status);

                      if(response.status == PaymentResponseStatus.succeeded){
                        await pagamentiservice.confermapagamento(this.widget.prodottoAbbonamento.nome);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(
                            msg: "Pagamento andato a buon fine",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 4,
                            backgroundColor: Color(0xFF2FE000),
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }

                    },

                    child: Text("PAV'",
                        style:TextStyle(fontSize: 12, color:  Colors.white, fontWeight: FontWeight.w800)),)
              ),

              contattaci(),

            ],
          )

      );
  }
*/

/*
  Widget contattaci() {
    return Container(
      height: 50.0,
      color: color1.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("METODO DI PAGAMENTO NON ACCETTATO?  " , style: TextStyle( fontSize: 10
            )),
            GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (c) => Contattaci()));
                },
                child: Text('Contattaci' , style: TextStyle(
                  decoration: TextDecoration.underline,
                ),)
            )
          ],
        ),
      ),
    );
  }

  rimuovimetododipagamentoselezionato() async {

    var result = await pagamentiservice.rimuovimetododipagamento(listametodiradio.metododipagamentoscelto.id);


    var lista = await pagamentiservice.prendimetodidipagamento();

    List<PaymentMethod> listametodi = new List();
    for(var elemento in lista){
      listametodi.add(PaymentMethod.fromJson(elemento));
    }

    listametodiradio = ListaMetodiDiPagamentoRadio(listametodi);
    if(listametodi.length > 0) {
      listametodiradio.metododipagamentoscelto = listametodi[0];
    }
    setState(() {

    });

  }

  creaintentodipagamento() async {
    String intentid = await pagamentiservice.creaintentodipagamento(this.widget.prodottoAbbonamento.nome);
  }


  creametododipagamento() async{
    var paymentResponse = await FlutterStripePayment.addPaymentMethod();
    print("STATUS = ");
    print(paymentResponse.status);
    print("ERRORE = ");
    print(paymentResponse.errorMessage);
    if(paymentResponse.status == PaymentResponseStatus.succeeded)
    {
      var res = await salvametododipagamento(paymentResponse);
      print(res);
      setState(() {

      });
    }else{

      Fluttertoast.showToast(
          msg: "Metodo di pagamento non accettato",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 4,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0
      );



    }
  }


  vuoisalvaremetododipagamento(BuildContext context,PaymentResponse paymentResponse) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Vuoi salvare il metodo di pagamento?'),
          content: Text("Non dovrai reinserire i dati della carta in futuro"),
          actions: <Widget>[
            FlatButton(
              child: Text("SI"),
              onPressed: () {
                //Put your code here which you want to execute on Yes button click.
                Navigator.of(context).pop();
              },
            ),

            FlatButton(
              child: Text("NO"),
              onPressed: () {
                //Put your code here which you want to execute on No button click.
                Navigator.of(context).pop();
              },
            ),

          ],
        );
      },
    );
  }


  salvametododipagamento(PaymentResponse paymentResponse)async {
    var result = await pagamentiservice.salvametododipagamentosenzapagareconpyid(paymentResponse.paymentMethodId);
    return result;
  }



  double trasformadoubleinnumerocentesimi(double valore){
    double part =  valore*100;
    // int result = part.toInt();
    return part;
  }
*/

}
