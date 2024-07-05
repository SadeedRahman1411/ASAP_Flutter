import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group_project/api/api.dart';
import 'package:flutter_group_project/helper/dialogs.dart';
import 'package:flutter_group_project/models/chat_user.dart';
import 'package:flutter_group_project/widgets/chat_user_card.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.home),
        ),
        title: const Text("ASAP"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
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
          child: const Icon(
            Icons.add_comment_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: APIs.firestore.collection('profiles').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final data = snapshot.data?.docs;
            list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];

            if (list.isNotEmpty) {
              return ListView.builder(
                itemCount: list.length,
                padding: EdgeInsets.only(top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.01),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ChatUserCard(user: list[index]);
                },
              );
            } else {
              return const Center(
                child: Text(
                    'No Connections Found!', style: TextStyle(fontSize: 20)),
              );
            }
          }
        },
      ),
    );
  }
}