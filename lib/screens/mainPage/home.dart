import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Widget/CategorySelector.dart';
import '../../screens/FloatButtons/FloatingButton.dart';
import '../../provider/HomeProvider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<HomeProvider>(context);
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
      body: StatefulWrapper(
        onInit: () {
          data.getMainData();
        },
        child: Column(
          children: <Widget>[
            CategorySelector(),
            Expanded(
          flex: 1,
          child: data.widgets[data.index0],
        )
          ],
        ),
      ),
      floatingActionButton: FloatingButton(),
    );
  }
}
class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;  const StatefulWrapper({@required this.onInit, @required this.child});  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}class _StatefulWrapperState extends State<StatefulWrapper> {@override
void initState() {
  if(widget.onInit != null) {
    widget.onInit();
  }
  super.initState();
}  @override
Widget build(BuildContext context) {
  return widget.child;
}
}