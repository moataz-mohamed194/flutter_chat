import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/provider/SignUpProvider.dart';
import 'package:provider/provider.dart';

class ChooseImage extends StatefulWidget {
  const ChooseImage({
    Key key,
  }) : super(key: key);

  @override
  _ChosseImageState createState() => _ChosseImageState();
}

class _ChosseImageState extends State<ChooseImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                Provider.of<SignUpProvider>(context, listen: false)
                    .openCamera(context);
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              child: ListTile(
                leading: Icon(
                  Icons.camera,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  "Camera",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          GestureDetector(
            onTap: () {
              Provider.of<SignUpProvider>(context, listen: false)
                  .openGallery(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              child: ListTile(
                leading: Icon(
                  Icons.image,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  "Gallery",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
