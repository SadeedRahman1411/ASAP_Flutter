
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_group_project/api/api.dart';
import'package:flutter_group_project/main.dart';
import 'package:flutter_group_project/screens/home_screen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../helper/dialogs.dart';
class loginScreen extends StatefulWidget{
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen>{
  bool _isAnimate = false;

  @override
  void initState()
  {
    super.initState();
    Future.delayed(Duration(milliseconds: 500),(){
      setState(() {
        _isAnimate=true;
      });
    });
  }

  _handleGooglebtnclick()
  {
    Dialogs.showProgressBar(context);
    _signInWithGoogle().then((user){
      Navigator.pop(context);

      if(user!=null)
        {
          log('\nUser: ${user.user}');
          log('\nUserAdditionalInfo: ${user.additionalUserInfo}');

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => HomeScreen()) );
        }
    });
  }



  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential = await APIs.auth.signInWithCredential(credential);

      // Check if user exists in Firestore 'users' collection
      final user = userCredential.user;
      final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

      // Check if the user already exists in the Firestore collection
      final DocumentSnapshot snapshot = await usersCollection.doc(user!.uid).get();

      // If user does not exist, save their email to Firestore
      if (!snapshot.exists) {
        await usersCollection.doc(user.uid).set({
          'email': user.email,
          // Add any other user info you want to store
        });
      }

      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle Error: $e');
      Dialogs.showSnackbar(context, "Problem with net");
      return null;
    }
  }
  @override
  Widget build(BuildContext context){
    //mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("Welcome to ASAP"),


      ),
      body: Stack(children: [
        AnimatedPositioned(
           top: mq.height * .15,
            right: _isAnimate?mq.width * .15 : -mq.width * .5,
            width: mq.width * .7,
            duration: const Duration(seconds: 1),
            child: Image.asset('assets/images/ic_launcher.png')),
        Positioned(
            top: mq.height * .65,
            left: mq.width * .05,
            width: mq.width * .9,
            height:mq.height * .06,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(159, 252, 82, 180),shape: StadiumBorder()),
                onPressed: (){
                _handleGooglebtnclick();
                },
                icon: Image.asset('assets/images/google.png',height: mq.height *.04,),
                label: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black,fontSize: 18),
                      children: [
                  TextSpan(text: "Login with "),
                  TextSpan(text: "Google",style: TextStyle(fontWeight: FontWeight.w900)),
                ]

                        ),
                ),
            )
        ),
      ]),
    );
  }
}
