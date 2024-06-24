import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:flutter_group_project/models/chat_user.dart';

class ChatUserCard extends StatefulWidget
{
  final ChatUser user;

  const ChatUserCard({super.key,required this.user});

  @override
  State<ChatUserCard> createState() =>_ChatUserCardState();


}
class _ChatUserCardState extends State<ChatUserCard>
{
  @override
  Widget build(BuildContext context)
  {
    return Card(
      child: InkWell(
        onTap: (){},
        child:  ListTile(
          leading: const CircleAvatar(child: Icon(CupertinoIcons.person)),
          title: Text(widget.user.name),
          subtitle: Text(widget.user.about,maxLines: 1,style: TextStyle(fontSize: 17),),
          trailing:  const Text('1:30 PM',style: TextStyle(fontSize: 21,color: Colors.black54), ),
        ),



      ),
    );
  }
}