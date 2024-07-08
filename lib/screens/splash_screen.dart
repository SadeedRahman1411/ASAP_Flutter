
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_group_project/api/api.dart';
import'package:flutter_group_project/main.dart';
import 'package:flutter_group_project/screens/auth/login_screen.dart';
import 'package:flutter_group_project/screens/home_screen.dart';

class splashScreen extends StatefulWidget{
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen>{
  bool _isAnimate = false;

  @override
  void initState()
  {
    super.initState();
    Future.delayed(Duration(milliseconds: 1500),(){
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      //Re-direct here


     if(APIs.auth.currentUser !=null)
       {
         log('\nUser: ${APIs.auth.currentUser}');
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const HomeScreen()));
       }
     else
       {
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const LoginScreen()));
       }

    });
  }
  @override
  Widget build(BuildContext context){
    mq = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
        AnimatedPositioned(
            top: mq.height * .35,
            right: mq.width * .15,
            width: mq.width * .7,
            duration: const Duration(seconds: 1),
            child: Image.asset('assets/images/ic_launcher.png')),
        Positioned(
            bottom: mq.height * .33,
            width: mq.width,
            child: const Text("🐵 Welcome to ASAP 🐵",
                textAlign: TextAlign.center,
                style:TextStyle(
                fontSize: 32,
            color: Colors.black,
              letterSpacing: .5,
            )
            )
                ),
      ]
    ),
    );
  }
}
