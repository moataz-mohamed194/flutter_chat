import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/Widget/Loading_Widget.dart';
import 'package:flutter_chat_ui_starter/Widget/MessageWidget.dart';
import 'package:flutter_chat_ui_starter/provider/HomeProvider.dart';
import 'package:provider/provider.dart';

class Favorite extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final getMessageService = Provider.of<HomeProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child:  Container(
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child:StreamBuilder(
                stream: FirebaseDatabase()
                    .reference()
                    .child('Account')
                    .child("${getMessageService.d0}")
                    .child('Chat')
                    .onValue,
                builder: (context, snapshot) {
                  List<Widget> children;
                  try{
                    if(snapshot.hasError){
                      return Center(
                        child: Text("${snapshot.error}"),
                      );
                    }else{
                      Event e;
                      Map<dynamic, dynamic> map ;
                      List<dynamic> list, list0;
                      var result = [];
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
                          list = map.values.toList();
                      for(int i=0;i<list.length;i++){
                        for(int j=0;j<list[i].length;j++){
                          Map list1=list[i];
                          list0 = list1.values.toList();
                          if(list0[j]['isLiked']=='true') {
                            print(list0[j]);
                            result.add(list0[j]);
                          }
                        }
                      }
                          children = <Widget>[ Expanded(
                            child: ListView.builder(
                              itemCount: result.length,
                              itemBuilder: (context, index) {
                                Timestamp myTimeStamp =
                                Timestamp.fromMicrosecondsSinceEpoch(
                                    result[index]["Time"]);
                                DateTime myDateTime = myTimeStamp.toDate();
                                String myDateTime0 = myDateTime.toString();
                                return MessageWidget(date: "${myDateTime0.substring(0, 16)}",
                                    isLiked: "${result[index]["isLiked"]}",
                                    id: "${result[index]["Time"]-7200000000}",
                                    isMe: result[index]["isMe"],
                                    message: "${result[index]["Body"]}",
                                    user: "${result[index]['to']}",favorite: true,);},
                            ),
                          )];
                          break;
                        case ConnectionState.done:
                          e = snapshot.data;
                          map = e.snapshot.value;
                          list = map.values.toList();
                          for(int i=0;i<list.length;i++){
                            for(int j=0;j<list[i].length;j++){
                              Map list1=list[i];
                              list0 = list1.values.toList();
                              if(list0[j]['isLiked']=='true') {
                                print(list0[j]);
                                result.add(list0[j]);
                              }
                            }
                          }
                          children = <Widget>[ Expanded(
                            child: ListView.builder(
                              itemCount: result.length,
                              itemBuilder: (context, index) {
                                Timestamp myTimeStamp =
                                Timestamp.fromMicrosecondsSinceEpoch(
                                    result[index]["Time"]);
                                DateTime myDateTime = myTimeStamp.toDate();
                                String myDateTime0 = myDateTime.toString();

                                return MessageWidget(date: "${myDateTime0.substring(0, 16)}",
                                    isLiked: "${result[index]["isLiked"]}",
                                    id: "${result[index]["Time"]-7200000000}",
                                    isMe: result[index]["isMe"],
                                    message: "${result[index]["Body"]}",
                                    user: "${result[index]['to']}",favorite: true,);
                              },
                            ),
                          ) ];

                          break;
                      }}
                    }catch(e){
                    return Center(
                      child: Text("$e"),
                    );
                  }
                  return Column(
                    children: children,
                  );
                },
              )
              ),
        ),

    );
  }
}
