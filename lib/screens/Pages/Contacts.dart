import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Database/SQLDatabase.dart';
import '../../Widget/Loading_Widget.dart';
import '../../models/user_model.dart';
import '../../provider/ContactsProvider.dart';
import '../../screens/Chat/ChatScreen.dart';
import 'package:provider/provider.dart';

class Contact0 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contactProviderData = Provider.of<ContactProvider>(context);
    final sQLDatabaseData = Provider.of<SQLDatabase>(context);
    return Container(
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
            child: FutureBuilder<List>(
              initialData: List(),
              future: sQLDatabaseData.getAllProducts(),
              builder: (context, snapshot) {
                if (snapshot.data.length > 0) {
                  return ListView.builder(
                    itemCount: sQLDatabaseData.results.length,
                    itemBuilder: (_, int position) {
                      var _data = sQLDatabaseData.results;
                      final User currentUser = User(
                          id: _data[position].row[0],
                          name: "${_data[position].row[1]}",
                          phone: "${_data[position].row[2]}",
                          imageUrl: "${_data[position].row[3]}");

                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatScreen(
                              user: currentUser,
                            ),
                          ),
                        ),
                        child: ListTile(
                            title: Text(
                              _data[position].row[1],
                              style: TextStyle(
                                color: Theme.of(context).textSelectionColor,
                              ),
                            ),
                            subtitle: Text(_data[position].row[2],
                                style: TextStyle(
                                  color: Theme.of(context).textSelectionColor,
                                )),
                            leading: Container(
                                child: Container(
                              width: MediaQuery.of(context).size.width /
                                  7.854545455,
                              height: MediaQuery.of(context).size.height /
                                  7.854545455,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(120)),
                                child: Image.network(_data[position].row[3]),
                              ),
                            ))),
                      );
                    },
                  );
                } else if (snapshot.data.length <= 0 &&
                    contactProviderData.loadingStart == false &&
                    sQLDatabaseData.start == false) {
                  return LoadingScreen();
                } else if (snapshot.data.length <= 0 &&
                    contactProviderData.loadingStart == true) {
                  return LoadingScreen();
                } else {
                  return Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: Text("Nothing found!!"),
                  );
                }
              },
            )));
  }
}
