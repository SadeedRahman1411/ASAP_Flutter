import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group_project/api/api.dart';
import 'package:flutter_group_project/helper/dialogs.dart';
import 'package:flutter_group_project/main.dart';
import 'package:flutter_group_project/models/chat_user.dart';
import 'package:flutter_group_project/widgets/chat_user_card.dart';
import 'package:google_sign_in/google_sign_in.dart';

class homeScreen extends StatefulWidget{
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen>{

  List<ChatUser> list= [];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){},icon: const Icon(CupertinoIcons.home)),
        title:const Text("ASAP"),
        actions: [
          IconButton(onPressed: (){},icon: const Icon(Icons.search)),
          IconButton(onPressed: (){},icon: const Icon(Icons.more_vert))
        ]

        ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
            backgroundColor: Colors.blueAccent,
            onPressed: () async {
              await APIs.auth.signOut();
              GoogleSignIn googleSignIn = GoogleSignIn();
              await googleSignIn.signOut();
              Dialogs.showSnackbar(context, 'Signed out successfully');
            },
            child: Icon(
              Icons.add_comment_rounded,
              color: Colors.white,
            )
         // Set the color of the icon to white
        ),
      ),

      body:StreamBuilder(
        stream:APIs.firestore.collection('users').snapshots(),
      builder: (context, snapshot){

          switch(snapshot.connectionState){
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());

            case ConnectionState.active:
            case ConnectionState.done:



              final data = snapshot.data?.docs;
             list = data?.map((e) => ChatUser.fromJson(e.data())).toList()??[];


           if(list.isNotEmpty)
             {
               return ListView.builder(
                   itemCount: list.length,
                   padding: EdgeInsets.only(top: mq.height *.01),
                   physics: BouncingScrollPhysics(),
                   itemBuilder: (context, index){
                     return  ChatUserCard(user: list[index]);
                     //return Text('Name: ${list[index]}');
                   });
             }
           else
             {
               return const Center(
                  child: Text('No Connections Found!',style: TextStyle(fontSize: 20),),
               );

             }
          }


      },
    ),

    );
  }
}
