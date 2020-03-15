



import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';
import 'package:win/lastrelease/loginsignup/loginparts/background.dart';
import 'package:win/lastrelease/loginsignup/loginparts/inputwidgets.dart';
import 'package:win/lastrelease/loginsignup/loginparts/pulsanterettangolarearrotondato.dart';
import 'package:win/lastrelease/loginsignup/recuperapassword.dart';
import 'package:win/lastrelease/widgets/popupconferma.dart';



class Login extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }

}

class LoginState extends State<Login>{


  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();



  @override
  Widget build(BuildContext context) {




    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body:
        GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child:

            Stack(
              children: <Widget>[
                Background(),
                login(context),
              ],
            ))
    );
  }



  Widget login(BuildContext context) {

    return Column(

      children: <Widget>[

        // PADDING INIZIALE
        Padding(
          padding:
          EdgeInsets.only(top: MediaQuery
              .of(context)
              .size
              .height / 3.6),
        ),
        partecontextfields(context),
        spazio(context,45),
        passworddimenticata(),
        spazio(context,45),
        accessoconsocial(),
        spazio(context,40),
        GestureDetector(
          onTap: () {
           //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Signup()));
          //  Navigator.of(context).push(ScaleRotateRoute(page: Signup()));
            Navigator.pushNamed(context, '/signup');
          },
          child: PulsanteRettangolareArrotondato(
              "Crea un Account", signInGradients, false),
        )
      ],

    );

  }





  Widget partecontextfields(context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: MediaQuery
              .of(context)
              .size
              .width / 1.5, bottom: 10),
          child: Text(
            "Accedi",
            style: testosemplice16,
          ),
        ),
        Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            InputWidget(30.0, 0.0, "email@esempio.com", "password",
                emailcontroller, passwordcontroller),
            Padding(
                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/7),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child:

                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/20, right: MediaQuery.of(context).size.width/20),
                          child:

                          Text(
                            'Inserisci le credenziali...',
                            textAlign: TextAlign.end,
                            style: testosemplice12,
                          ),

                        )


                    ),

                    GestureDetector(
                      onTap: (){risultatologin();},
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: ShapeDecoration(
                          shape: CircleBorder(),
                          gradient: LinearGradient(
                              colors: signInGradients,
                              //      colors: signUpGradients,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          size: MediaQuery.of(context).size.height/17,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                )),

          ],
        ),

      ],
    );
  }


  Widget spazio(context,spazio){
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/spazio),
    );
  }



  Widget passworddimenticata(){
    return Center(
        child: GestureDetector(
            onTap: (){
             // Navigator.of(context).push(MaterialPageRoute(builder: (c) => PasswordDimenticata(emailcorrente: emailcontroller.text,)));
        //      recuperapassword
              Navigator.push(context, MaterialPageRoute(builder: (c)=>PasswordDimenticata(emailcorrente: emailcontroller.text,)));
            },
            child: Text("Password dimenticata?",
                style: testosemplice16sottolineato)
        )
    );
  }

  Widget accessoconsocial(){
    return Column(
      children: <Widget>[
        Center(
            child: Text("Oppure accedi con",
                style: testosemplice16)
        ),
        spazio(context,45),
        Center(
          child:
          Row(
            children: <Widget>[
              Expanded(
                  child: Container()
              ),
              MaterialButton(
                child: Image.asset(
                  "assets/img/facebookicon.png", width: 50,),
                onPressed: (){
                //  loginwithfacebook();
                },

              ),
              MaterialButton(
                child: Image.asset("assets/img/ggg.png", width: 50,),

              ),
              Expanded(
                  child: Container()
              ),
            ],
          ),
        ),
      ],
    );
  }


  risultatologin()async{
     showwaitingdialog(context,"Benvenuto");
    bool result = false;
    try {
          result = await Auth.instance.entra(
          emailcontroller.text, passwordcontroller.text);


    }catch (e){

    }
     chiudiwaitingdialog(context);
    if(!result){
      mostraerrore(context);
    }else{

      Auth.instance.aggiornaprofilo();
      Navigator.of(context).pushNamed("/dashboard");
    }
  }


  mostraerrore(context){
    Flushbar(
      title: "Impossibile accedere",
      message: "Credenziali errate",
      duration: Duration(seconds: 3),
      backgroundGradient: LinearGradient(colors: errorgradient,),
      backgroundColor: Colors.red,
      boxShadows: [BoxShadow(color: Colors.blue[800], offset: Offset(0.0, 2.0), blurRadius: 3.0,)],
    )..show(context);
  }


  @override
  void dispose() {
    super.dispose();
  }


}