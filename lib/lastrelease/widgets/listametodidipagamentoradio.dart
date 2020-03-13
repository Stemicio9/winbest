
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:win/lastrelease/authentication/abbonamento.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/widgets/popupconferma.dart';

class ListaMetodiDiPagamentoRadio extends StatefulWidget{



  MetodoDiPagamentoContainer metododipagamentoscelto = new MetodoDiPagamentoContainer();



  @override
  ListaMetodiDiPagamentoRadioState createState() {
    // TODO: implement createState
    return ListaMetodiDiPagamentoRadioState();
  }

}

class ListaMetodiDiPagamentoRadioState extends State<ListaMetodiDiPagamentoRadio> {


  @override
  void initState() {
    Abbonamenti.instance.prendimetodidipagamento();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Abbonamenti.instance.metodidipagamento.stream.asBroadcastStream(),
      builder: (context,snapshot){
        if(!snapshot.hasData) return Container();
        if(snapshot.data.data.length == 0) return Text("Non hai metodi di pagamento salvati" , style: testosemplice14,);

          this.widget.metododipagamentoscelto.metodo = PaymentMethod.fromJson(snapshot.data.data[0]);

        return ListView.builder(
          itemCount: snapshot.data.data.length,
            itemBuilder: (context,index) {
            PaymentMethod metodo = PaymentMethod.fromJson(snapshot.data.data[index]);
            MetodoDiPagamentoContainer container = MetodoDiPagamentoContainer();
            container.metodo = metodo;
               return
                 Row(
                 children: <Widget>[

                   Container(
                     width: MediaQuery.of(context).size.width/1.3,
                   child: RadioListTile<MetodoDiPagamentoContainer>(
                       title: Text("**** **** **** " + container.metodo.card.last4 + "\n" +  container.metodo.card.brand),
                       value: container,
                       groupValue: this.widget.metododipagamentoscelto,
                       onChanged: (MetodoDiPagamentoContainer value) {
                         setState(() {
                           this.widget.metododipagamentoscelto = value;
                         });
                       }),
                   ),
                   Padding(padding: EdgeInsets.only(left:15),),
                   ClipOval(
                     child: Container(
                         height: 40.0,
                         width: 40.0,
                         color: Colors.redAccent.withOpacity(0.2),
                         //                color: azzurroscuro.withOpacity(0.2),
                         child: IconButton(
                           onPressed: () async {
                               bool continuare = await popupconferma("Sicuro?", "Vuoi eliminare il metodo di pagamento selezionato?",context);
                               if(continuare){
                                 Abbonamenti.instance.rimuovimetododipagamento(this.widget.metododipagamentoscelto.metodo.id);
                               }
                           },
                           icon: Icon(Icons.delete),
                           color: Colors.redAccent,
                           //                  color: azzurroscuro
                         )),
                   ),

                 ],
                )
               ;
            }
        );
      },
    );
  }

/*

  @override
  Widget build(BuildContext context) {


    if(this.widget.listametodi.length == null || this.widget.listametodi.length == 0){
      return
        Text("NON HAI METODI DI PAGAMENTO SALVATI" , style: TextStyle(fontSize: 16, color:  Color(0xFF535353),fontWeight: FontWeight.w800),);
    }

    return



      ListView.builder(
        itemBuilder: (context, index) {
          PaymentMethod metodo = this.widget.listametodi[index];

          return
            RadioListTile<PaymentMethod>(
              title: Text("**** **** **** " + metodo.card.last4 + "        " +  metodo.card.brand),
              value: metodo,
              groupValue: this.widget.metododipagamentoscelto,
              onChanged: (PaymentMethod value) {
                setState(() {
                  this.widget.metododipagamentoscelto = value;
                });
              },
            );
        },
        itemCount: this.widget.listametodi.length,





      );
  }

  */

}

class MetodoDiPagamentoContainer {
  PaymentMethod metodo;

  @override
  bool operator ==(other) {
    return metodo.id == other.metodo.id;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => metodo.id.hashCode;
}