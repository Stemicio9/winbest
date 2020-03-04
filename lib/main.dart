import 'package:flutter/material.dart';
import 'package:win/lastrelease/loginsignup/login.dart';
import 'package:win/lastrelease/loginsignup/signup.dart';





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

 //     home: Login(),

      initialRoute: "/",

      routes: {
        '/': (context) => Login(),
        '/signup': (context) => Signup(),
      },
    );
  }



}
