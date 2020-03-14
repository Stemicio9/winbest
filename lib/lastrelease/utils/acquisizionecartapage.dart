


import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/utils/inputformatters.dart';
import 'package:win/lastrelease/utils/paymentcard.dart';
import 'package:win/lastrelease/widgets/appbar.dart';
import 'package:win/lastrelease/widgets/popupconferma.dart';

class AcquisizioneCarta extends StatefulWidget {
  @override
  AcquisizioneCartaState createState() {
    return AcquisizioneCartaState();
  }

}
class AcquisizioneCartaState extends State<AcquisizioneCarta>{


  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _formKey = new GlobalKey<FormState>();
  var numberController = new TextEditingController();
  var _paymentCard = PaymentCard();
  var _autoValidate = false;


  @override
  void initState() {
    super.initState();
    _paymentCard.type = CardType.Others;
    numberController.addListener(_getCardTypeFrmNumber);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        appBar: appbarcomune("Inserisci carta"),
        body: new Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: new Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: new ListView(
                children: <Widget>[
                  new SizedBox(
                    height: 20.0,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: false,
                      icon: const Icon(
                        Icons.person,
                        size: 40.0,
                      ),
                      hintText: 'Nome sulla carta',
                      labelText: 'Nome',
                    ),
                    onSaved: (String value) {
                      _paymentCard.name = value;
                    },
                    keyboardType: TextInputType.text,
                    validator: (String value) =>
                    value.isEmpty ? fieldReq : null,
                  ),
                  new SizedBox(
                    height: 30.0,
                  ),
                  new TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      new LengthLimitingTextInputFormatter(19),
                      new CardNumberInputFormatter()
                    ],
                    controller: numberController,
                    decoration: new InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: false,
                      icon: CardUtils.getCardIcon(_paymentCard.type),
                      hintText: 'Numero sulla carta?',
                      labelText: 'Numero',
                    ),
                    onSaved: (String value) {
                      print('onSaved = $value');
                      print('Num controller has = ${numberController.text}');
                      _paymentCard.number = CardUtils.getCleanedNumber(value);
                    },
                    validator: CardUtils.validateCardNum,
                  ),
                  new SizedBox(
                    height: 30.0,
                  ),
                  new TextFormField(
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      new LengthLimitingTextInputFormatter(4),
                    ],
                    decoration: new InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: false,
                      icon: new Image.asset(
                        'assets/img/card_cvv.png',
                        width: 40.0,
                        color: Colors.grey[600],
                      ),
                      hintText: 'Numero dietro la carta',
                      labelText: 'CVV',
                    ),
                    validator: CardUtils.validateCVV,
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      _paymentCard.cvv = int.parse(value);
                    },
                  ),
                  new SizedBox(
                    height: 30.0,
                  ),
                  new TextFormField(
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      new LengthLimitingTextInputFormatter(4),
                      new CardMonthInputFormatter()
                    ],
                    decoration: new InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: false,
                      icon: new Image.asset(
                        'assets/img/calender.png',
                        width: 40.0,
                        color: Colors.grey[600],
                      ),
                      hintText: 'MM/YY',
                      labelText: 'Data di scadenza',
                    ),
                    validator: CardUtils.validateDate,
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      List<int> expiryDate = CardUtils.getExpiryDate(value);
                      _paymentCard.month = expiryDate[0];
                      _paymentCard.year = expiryDate[1];
                    },
                  ),
                  new SizedBox(
                    height: 50.0,
                  ),
                  new Container(
                    alignment: Alignment.center,
                    child: _getPayButton(),
                  )
                ],
              )),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    numberController.removeListener(_getCardTypeFrmNumber);
    numberController.dispose();
    super.dispose();
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(numberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    setState(() {
      this._paymentCard.type = cardType;
    });
  }

  void _validateInputs() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      setState(() {
        _autoValidate = true; // Start validating on every change.
      });
      mostraerrore(context, "Impossibile aggiungere carta" ,'Correggi gli errori');
    } else {
      form.save();
      // Encrypt and send send payment details to payment gateway
   //   mostrasuccesso(context,"Carta aggiunta" , 'Metodo di pagaento valido');
     Navigator.of(context).pop(_paymentCard);
    }
  }

  Widget _getPayButton() {
    if (Platform.isIOS) {
      return new CupertinoButton(
        onPressed: _validateInputs,
        color: CupertinoColors.activeBlue,
        child:  Text(
          pay,
          style: const TextStyle(fontSize: 17.0),
        ),
      );
    } else {
      return new RaisedButton(
        onPressed: _validateInputs,
        color: azzurroscuro,
        splashColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(100.0)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 80.0),
        textColor: Colors.white,
        child: new Text(
          pay.toUpperCase(),
          style: const TextStyle(fontSize: 17.0),
        ),
      );
    }
  }




}