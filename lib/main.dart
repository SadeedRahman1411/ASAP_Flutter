import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_group_project/screens/home_screen.dart';
import 'package:flutter_group_project/screens/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_group_project/screens/splash_screen.dart';
import 'firebase_options.dart';

late Size mq;



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]).then((value){
    _initializeFirebase();
    runApp(MyApp());
  });

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ASAP',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 2,
           iconTheme: IconThemeData(color: Colors.white70),
           titleTextStyle: TextStyle(color: Colors.white70,fontSize: 25,fontWeight: FontWeight.bold ),
          backgroundColor: (Colors.blueAccent),
      )),
      home: const splashScreen()
    );
  }
}

_initializeFirebase() async
{
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,);
}


