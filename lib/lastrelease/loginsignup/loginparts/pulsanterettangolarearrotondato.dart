import 'package:flutter/material.dart';

class PulsanteRettangolareArrotondato extends StatelessWidget {

  String title;
  List<Color> gradient;
  bool isEndIconVisible;

  PulsanteRettangolareArrotondato(this.title,this.gradient,this.isEndIconVisible);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return roundedRectButton(title, gradient, isEndIconVisible);
  }

  Widget roundedRectButton(
      String title, List<Color> gradient, bool isEndIconVisible) {
    return Builder(builder: (BuildContext mContext) {
      return


        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Stack(
            alignment: Alignment(1.0, 0.0),
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(mContext).size.width / 1.7,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  gradient: LinearGradient(
                      colors: gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
                child: Text(title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                padding: EdgeInsets.only(top: 16, bottom: 16),
              ),
              Visibility(
                visible: isEndIconVisible,
                child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.arrow_forward,
                      size: 40,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        );
    });
  }

}