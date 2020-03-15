
import 'package:flutter/material.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';

class CustomRadio extends StatefulWidget {

  Function onclick;
  RadioModel selecteditem;

  CustomRadio(this.onclick);

  @override
  createState() {
    return new CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> sampleData = new List<RadioModel>();

  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sampleData.add(new RadioModel(false, 0));
    //   this.widget.selecteditem = sampleData[0];
    sampleData.add(new RadioModel(false, 30));
    sampleData.add(new RadioModel(false, 40));
    sampleData.add(new RadioModel(false, 50));
    sampleData.add(new RadioModel(false, 60));
  }

  @override
  Widget build(BuildContext context) {

    return new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sampleData.length,
        itemBuilder: (BuildContext context, int index) {
          return new InkWell(
              splashColor: azzurroscuro,
              onTap: () {
                setState(() {
                  print("SELEZIONATO IL " + index.toString());
                  if (index != 4) {
                    this.controller.text = "";
                    sampleData.forEach((element) => element.isSelected = false);
                    sampleData[index].isSelected = true;
                    this.widget.selecteditem = sampleData[index];
                    this.widget.onclick();
                  } else {

                  }
                });
              },
              child: index != 4 ? new RadioItem(sampleData[index]) :
              Container(
                padding: EdgeInsets.only(left: 5),
                width: 40,
                child: TextField(
                    controller: controller,

                    onEditingComplete: () {

                      if(controller.text == null || controller.text.isEmpty){
                        FocusScope.of(context).requestFocus(FocusNode());
                        return;
                      }

                      setState(() {
                        sampleData.forEach((element) => element.isSelected = false);
                      });
                      this.widget.selecteditem = new RadioModel(true, double.parse(controller.text));
                      this.widget.onclick();
                      FocusScope.of(context).requestFocus(FocusNode());
                    },

                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                      //    border: InputBorder.none,
                        hintText: "+ / -",
                        hintStyle: TextStyle(color: Color(0xFF535353),
                            fontSize: 16,
                            fontWeight: FontWeight.w900)),

                    textAlign: TextAlign.center,
                    onChanged: (str) {

                    },

                    style: new TextStyle(
                      //fontWeight: FontWeight.bold,

                        fontSize: 14.0)),
              )
          );
        }
    );
    /*new RadioItemSelector(sampleData[index], (){
              setState(() {
                print("SELEZIONATO IL " + index.toString());
                sampleData.forEach((element) => element.isSelected = false);
                sampleData[index].isSelected = true;
                this.widget.selecteditem = sampleData[index];
                this.widget.onclick();
              }) */




  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(5.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //    mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 35.0,
            width: 35.0,
            child: new Center(
              child: new Text(

                  _item.buttonText == 0 ?
                  "NS" :
                  _item.buttonText.toInt().toString(),


                  style: new TextStyle(
                      color:
                      _item.isSelected ? Colors.white : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 14.0)),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected
                  ? azzurroscuro
                  : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected
                      ? azzurroscuro
                      : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          )
        ],
      ),
    );
  }
}


class RadioItemSelector extends RadioItem {

  Function onchange;

  TextEditingController controller = new TextEditingController();

  RadioItemSelector(RadioModel item, this.onchange) : super(item);




  @override
  Widget build(BuildContext context) {

    return new Container(
      margin: new EdgeInsets.all(5.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //    mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 35.0,
            width: 35.0,

            padding: EdgeInsets.only(top:5,bottom: 5,left: 10,right: 10),

            child: new Center(



              child: new TextField(


                  controller: controller,

                  onEditingComplete: (){
                    controller.text = "";
                    this.onchange();
                    FocusScope.of(context).requestFocus(FocusNode());
                  },

                  keyboardType: TextInputType.number,

                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "+|-",
                      hintStyle: TextStyle(color: Color(0xFF535353), fontSize: 14, fontWeight: FontWeight.w900)),

                  onChanged: (str){
                    this._item.buttonText = double.parse(str);
                  },

                  style: new TextStyle(
                      color:
                      _item.isSelected ? Colors.white : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 14.0)),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected
                  ? azzurroscuro
                  : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected
                      ? azzurroscuro
                      : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          )
        ],
      ),
    );
  }










}




class RadioModel {
  bool isSelected;
  double buttonText;

  RadioModel(this.isSelected, this.buttonText);
}