import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Widget/CategorySelector.dart';
import '../../screens/FloatButtons/FloatingButton.dart';
import '../../provider/HomeProvider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  int indexData;

  //HomeScreen(this.indexData);

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<HomeProvider>(context, listen: true);
    //data.index = 0;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          'Chats',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          CategorySelector(),
          /*Consumer<HomeProvider>(
              // selector: (context, fontiSize2) => fontiSize2.getFontize2,
              builder: (context, fontSize, widget) {
            print('$widget Hi from font size 2 consumer!${fontSize.index}');
            return*/
          Expanded(
            flex: 1,
            child: data.widgets[data.index],
          ) /*;
          })*/
        ],
      ),
//      ),
      floatingActionButton: FloatingButton(),
    );
  }
}
