
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputWidget extends StatelessWidget {
  final double topRight;
  final double bottomRight;
  final String hinttext1;
  final String hinttext2;
  TextEditingController controller1;
  TextEditingController controller2;

  InputWidget(this.topRight, this.bottomRight, this.hinttext1,this.hinttext2,this.controller1,this.controller2);

  @override
  Widget build(BuildContext context) {
    return

      Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 40),
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                child: Material(
                  elevation: 10,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(bottomRight),
                          topRight: Radius.circular(topRight))),
                  child: Padding(
                    padding: EdgeInsets.only(left: 40, right: 20, top: 10, bottom: 10),
                    child: TextField(
                      controller: controller1,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: hinttext1,
                          hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14, fontWeight: FontWeight.w900)),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 40, bottom: 30),
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                child: Material(
                  elevation: 10,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(topRight),
                          topRight: Radius.circular(bottomRight))),
                  child: Padding(
                    padding: EdgeInsets.only(left: 40, right: 20, top: 10, bottom: 10),
                    child: TextField(
                      obscureText: true,
                      controller: controller2,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: hinttext2,
                          hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14, fontWeight: FontWeight.w900)),
                    ),
                  ),
                ),
              ),
            )
          ]

      );
  }
}


class InputWidgetSingolo extends StatelessWidget {

  final double topRight;
  final double bottomRight;
  final String hinttext;
  TextEditingController controller;


  InputWidgetSingolo(this.topRight, this.bottomRight, this.hinttext,this.controller);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      child: Material(
        elevation: 10,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(bottomRight),
                topRight: Radius.circular(topRight))),
        child: Padding(
          padding: EdgeInsets.only(left: 40, right: 20, top: 10, bottom: 10),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hinttext,
                hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14, fontWeight: FontWeight.w900)),
          ),
        ),
      ),
    );
  }

}



class InputWidgetRight extends StatelessWidget {
  final double topRight;
  final double bottomRight;
  final String hinttext1;
  final String hinttext2;
  final TextInputType type1;
  final TextInputType type2;
  TextEditingController controller1;
  TextEditingController controller2;

  InputWidgetRight(this.topRight, this.bottomRight, this.hinttext1,this.hinttext2,this.type1,this.type2,this.controller1,this.controller2);

  @override
  Widget build(BuildContext context) {
    return

      Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 40),
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                child: Material(
                  elevation: 10,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(bottomRight),
                          topLeft: Radius.circular(topRight))),
                  child: Padding(
                    padding: EdgeInsets.only(left: 40, right: 20, top:1,bottom:1),
                    child: TextFormField(
                      validator: (val) => val.isEmpty ? 'Campo richiesto' : null,
                      controller: controller1,
                      keyboardType: type1,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: hinttext1,
                          hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14, fontWeight: FontWeight.w900)),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, bottom: 30),
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                child: Material(
                  elevation: 10,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(topRight),
                          topLeft: Radius.circular(bottomRight))),
                  child: Padding(
                    padding: EdgeInsets.only(left: 40, right: 20, top:1,bottom:1),
                    child: TextFormField(
                      validator: (val) => val.isEmpty ? 'Campo richiesto' : null,
                      controller: controller2,
                      keyboardType: type2,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: hinttext2,
                          hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14, fontWeight: FontWeight.w900)),
                    ),
                  ),
                ),
              ),
            )
          ]

      );
  }
}



class InputWidgetLeft extends StatelessWidget {
  final double topRight;
  final double bottomRight;
  final String hinttext1;
  final String hinttext2;
  final TextInputType type1;
  final TextInputType type2;
  final bool password;
  final bool date;
  TextEditingController controller1;
  TextEditingController controller2;

  InputWidgetLeft(this.topRight, this.bottomRight, this.hinttext1,this.hinttext2, this.type1,this.type2,this.password,this.date,this.controller1,this.controller2);

  @override
  Widget build(BuildContext context) {
    return

      Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 40),
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                child: Material(
                  elevation: 10,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(bottomRight),
                          topRight: Radius.circular(topRight))),
                  child: Padding(
                    padding: EdgeInsets.only(left: 40, right: 20, top:1,bottom:1),
                    child: TextFormField(
                      validator: (val) => val.isEmpty ? 'Campo richiesto' : null,
                      controller:controller1,
                      keyboardType: type1,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: hinttext1,
                          hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14, fontWeight: FontWeight.w900)),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 40, bottom: 30),
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                child: Material(
                  elevation: 10,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(topRight),
                          topRight: Radius.circular(bottomRight))),
                  child: Padding(
                    padding: EdgeInsets.only(left: 40, right: 20, top:1,bottom:1),
                    child:

                    date?
                    InkWell(
                        onTap: (){_selectDate(context);},
                        child: IgnorePointer(
                          child: TextFormField(
                            validator: (val) => val.isEmpty ? 'Campo richiesto' : null,
                            controller: controller2,
                            obscureText: password ? true : false,
                            onTap: (){
                              if(date){
                                _selectDate(context);
                              }
                            },
                            keyboardType: type2,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: hinttext2,
                                hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14, fontWeight: FontWeight.w900)),
                          ),
                        )
                    )

                        :TextFormField(
                      controller: controller2,
                      obscureText: password ? true : false,
                      keyboardType: type2,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: hinttext2,
                          hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14, fontWeight: FontWeight.w900)),
                    ),




                  ),
                ),
              ),
            )
          ]

      );
  }

  final dateFormat = DateFormat("dd-MM-yyyy");


  String convertidata(DateTime data){
    return dateFormat.format(data);
  }


  DateTime selectedDate = DateTime.now();


  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1920),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      controller2.text = convertidata(picked);
  }


}