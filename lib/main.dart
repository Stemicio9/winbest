import 'package:flutter/material.dart';
import 'package:win/lastrelease/authentication/auth.dart';
import 'package:win/lastrelease/dashboard/dashboard.dart';
import 'package:win/lastrelease/loginsignup/login.dart';
import 'package:win/lastrelease/loginsignup/signup.dart';
import 'package:win/placesandmaps.dart';





void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'W1N',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,

      builder: (context, child) =>
          MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child),

//      home: processalogininiziale(),

      initialRoute: "/",

      routes: {
        '/': (context) => Login(),
//      '/': (context) => CercaVia(),
        '/signup': (context) => Signup(),
        '/dashboard': (context) => Dashboard()
      },
    );
  }



  processalogininiziale(){
    return FutureBuilder(
        future: Auth.instance.gialoggato(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else
              if(snapshot.data) {
                Auth.instance.aggiornaprofilo();
                return Dashboard();
              }else {
                return Login();
              }
          }

        }
    );
  }


}
