import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/provider/chatProvider.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget{
  final String message;
  final String date;
  final bool isMe;
  final String id;
  final String isLiked;
  final bool favorite;
  const MessageWidget({this.date,this.isLiked,this.isMe,this.message,this.id, this.user,this.favorite});
  final String user;

  @override
  Widget build(BuildContext context) {
    final Container msg = Container(
      margin: EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color:
        isMe ? Theme.of(context).accentColor : Theme.of(context).cardColor,
        borderRadius: isMe
            ? BorderRadius.only(
          topLeft: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
        )
            : BorderRadius.only(
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          favorite?Container(child:
          Container(child: isMe?Text("To: $user",): Text("From: $user"),alignment: Alignment.topCenter,),):Container(),
          Text(
            "$date",
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            message,
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
    final chatProviderMessage = Provider.of<ChatProvider>(context);

    return Row(
      textDirection: isMe ? TextDirection.rtl : TextDirection.ltr,
      children: <Widget>[

        msg,
        IconButton(
          icon:
          isLiked=="true"
              ? Icon(Icons.favorite)
              :
          Icon(Icons.favorite_border),
          iconSize: 30.0,
          color:
          isLiked=="true"
              ? Theme.of(context).primaryColor
              :
          Colors.blueGrey,
          onPressed: () {
            chatProviderMessage.isLiked(user, id, isLiked);
            print("message : $message");
            print("isMe : $isMe");
            print("date : $date");
            print("id : $id");
          },
        )
      ],
    );

  }

}