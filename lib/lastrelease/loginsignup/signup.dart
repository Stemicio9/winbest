import 'package:flutter/material.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/loginsignup/signupparts/sezioni.dart';
import 'package:win/lastrelease/widgets/appbar.dart';


class Signup extends StatefulWidget {
  @override
  SignupState createState() {
    // TODO: implement createState
    return SignupState();
  }

}

class SignupState extends State<Signup> with SingleTickerProviderStateMixin{

  TabController controller;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarcomune("ISCRIVITI"),
        body:
        Container(
            child:
            Column(
              children: <Widget>[
                TabBar(

                    isScrollable: false,
                    controller: controller,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: azzurroscuro,

                    tabs: [
                      new Tab(
                        child: Text("Cerco lavoro" , style: titolonuovo, textAlign: TextAlign.center),
                      ),
                      new Tab(
                        child: Text("Offro lavoro" , style: titolonuovo, textAlign: TextAlign.center),
                      ),
                    ]

                ),
                Expanded(
                    child:
                    GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                        },
                        child: TabBarView(
                            controller: controller,
                            children: <Widget> [
                              Container(
                                // LAVORATORE
                                child: SezioneNuova(true),
                              ),
                              Container(
                                // DATORE
                                child: SezioneNuova(false),
                              )
                            ]
                        )
                    )
                )

              ],
            )
        )
    );
  }


}