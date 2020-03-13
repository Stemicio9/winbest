


import 'package:flutter/material.dart';
import 'package:win/lastrelease/authentication/abbonamento.dart';
import 'package:win/lastrelease/dashboard/datoredilavoro/checkout.dart';
import 'package:win/lastrelease/model/prodottoabbonamento.dart';

class ProductCard extends StatelessWidget {
  final ProdottoAbbonamento product;

  const ProductCard({Key key, @required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final spacer = SizedBox(height: 8.0);




    final name = Text(
      product.nome.toUpperCase(),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),
    );


    final price = Text(
      "\€${product.prezzo.toString()}",
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );


    return
      Container(
        //  padding: EdgeInsets.symmetric(horizontal: 3),
          child: MaterialButton(
            elevation: 10,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            onPressed: () async {
              var intent = await Abbonamenti.instance.creaintentodipagamento(product.nome);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>
              PaginaCheckOut(product, intent)
              ));


            },

            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 150,
                    child: Abbonamenti.instance.prodottoabbonamento(product.nome),
                  ),
                  spacer,
                  name,
                  spacer,
                  spacer,
                  price
                ],
              ),
            ),
          )
      );
  }
}