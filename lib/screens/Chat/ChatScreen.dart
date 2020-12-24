import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/Widget/Loading_Widget.dart';
import 'package:flutter_chat_ui_starter/provider/HomeProvider.dart';
import '../../models/user_model.dart';
import '../../provider/chatProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ChatScreen extends StatelessWidget {
  final User user;

  ChatScreen({this.user});
  String d0;
  getMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.d0 = prefs.get('PhoneNumber').toString();
  }

  _buildMessage(String message, bool isMe, String date, context) {
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
    return Row(
      textDirection: isMe ? TextDirection.rtl : TextDirection.ltr,
      children: <Widget>[
        msg,
        IconButton(
          icon:
              /*message.isLiked
              ? Icon(Icons.favorite)
              :*/
              Icon(Icons.favorite_border),
          iconSize: 30.0,
          color:
              /*message.isLiked
              ? Theme.of(context).primaryColor
              : */
              Colors.blueGrey,
          onPressed: () {},
        )
      ],
    );
  }

  //the text controller
  final TextEditingController _textEditingController = TextEditingController();
  //the design of enter messages component
  _buildMessageComposer(String phone, context, String name, String image) {
    final chatProviderMessage = Provider.of<ChatProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Theme.of(context).cursorColor,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textEditingController,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
//              _textEditingController.text.isEmpty ??
              //chatProviderMessage.sendAndRetrieveMessage();
              chatProviderMessage.sendMessage(
                  phone, _textEditingController.text, name, image);
              _textEditingController.clear();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final getMessageService = Provider.of<HomeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          user.name,
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    child: StreamBuilder(
                      stream: FirebaseDatabase()
                          .reference()
                          .child('Account')
                          .child("${getMessageService.d0}")
                          .child('Chat')
                          .child('${user.phone}')
                          .onValue,
                      builder: (context, snapshot) {
                        print(
                            "Account; ${getMessageService.d0}; Chat; ${user.phone}");
                        List<Widget> children;
                        try{
                        if(snapshot.hasError){
                          children = <Widget>[ Center(
                            child: Text("${snapshot.error}"),
                          )];
                        }else{
                          Event e;
                          Map<dynamic, dynamic> map ;
                          List<dynamic> list;
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              children = <Widget>[Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                child: Text("Nothing found!!"),
                              )];
                              break;
                            case ConnectionState.waiting:
                              children = <Widget>[LoadingScreen()];
                              break;
                            case ConnectionState.active:
                              e = snapshot.data;
                              map = e.snapshot.value;
                              list = map.values.toList()
                                ..sort((a, b) => b['Time'].compareTo(a['Time']));
                              children = <Widget>[Expanded(
                                // width:MediaQuery.of(context).size.width,
                                //
                                // height: MediaQuery.of(context).size.height-161,
                                child: ListView.builder(
                                  itemCount: list.length,
                                  reverse: true,
                                  itemBuilder: (context, index) {
                                    Timestamp myTimeStamp =
                                    Timestamp.fromMicrosecondsSinceEpoch(
                                        list[index]["Time"]);
                                    DateTime myDateTime = myTimeStamp.toDate();
                                    String myDateTime0 = myDateTime.toString();
                                    return _buildMessage(
                                        list[index]["Body"],
                                        list[index]["isMe"],
                                        "${myDateTime0.substring(0, 16)}",
                                        context);
                                  },
                                ),
                              )];
                              break;
                            case ConnectionState.done:
                              e = snapshot.data;
                              map = e.snapshot.value;
                              list = map.values.toList()
                                ..sort((a, b) => b['Time'].compareTo(a['Time']));
                              children = <Widget>[Expanded(

                                //height: MediaQuery.of(context).size.height-161,
                                child: ListView.builder(
                                  itemCount: list.length,
                                  reverse: true,
                                  itemBuilder: (context, index) {
                                    Timestamp myTimeStamp =
                                    Timestamp.fromMicrosecondsSinceEpoch(
                                        list[index]["Time"]);
                                    DateTime myDateTime = myTimeStamp.toDate();
                                    String myDateTime0 = myDateTime.toString();
                                    return _buildMessage(
                                        list[index]["Body"],
                                        list[index]["isMe"],
                                        "${myDateTime0.substring(0, 16)}",
                                        context);
                                  },
                                ),
                              )];
                              break;
                          }
                        }}catch(e){
                          return Center(
                            child: Text("${e}"),
                          );
                        }
                        return Column(
                          children: children,
                        );
                      },
                    )),
              ),
            ),
            _buildMessageComposer(
                user.phone, context, user.name, user.imageUrl),
          ],
        ),
      ),
    );
  }
}
