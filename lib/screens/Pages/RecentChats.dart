import 'package:flutter/material.dart';
import '../../Database/SQLDatabase.dart';
import '../../Widget/Loading_Widget.dart';
import '../../models/user_model.dart';
import 'package:provider/provider.dart';
import '../../screens/Chat/ChatScreen.dart';

class RecentChats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(child: child, scale: animation);
              },
              child: StreamBuilder<List>(
                  initialData: List(),
                  stream: sQLDatabaseData.getAllOldContacts().asStream(),
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
                                subtitle: Text(_data[position].row[4],
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).textSelectionColor,
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
                                    child:
                                        Image.network(_data[position].row[3]),
                                  ),
                                ))),
                          );
                        },
                      );
                    } else if (snapshot.data.isEmpty &&
                        sQLDatabaseData.start == false) {
                      return LoadingScreen();
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        child: Text("Nothing found!!"),
                      );
                    }
                  })),
        ));
  }
}
