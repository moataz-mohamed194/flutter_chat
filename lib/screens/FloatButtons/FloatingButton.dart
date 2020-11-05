import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../provider/AppColorTheme.dart';
import '../../provider/ContactsProvider.dart';
import '../../provider/HomeProvider.dart';
import '../../provider/oldDataProvider.dart';
import '../../screens/FloatButtons/Setting_Screen.dart';
import 'package:provider/provider.dart';

class FloatingButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FloatingButton();
  }
}

class _FloatingButton extends State<FloatingButton>
    with SingleTickerProviderStateMixin {
  double unitRadianMethod(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  AnimationController animationController;
  Animation degOneTransitionAnimation,
      degTwoTransitionAnimation,
      degThreeTransitionAnimation;
  Animation rotationAnimation;
  @override
  void initState() {
    // TODO: implement initState
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTransitionAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);

    degTwoTransitionAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController);

    degThreeTransitionAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController);

    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _homeProvider = Provider.of<HomeProvider>(context);
    final getOldData = Provider.of<OldDataProvider>(context);
    final cart = Provider.of<ContactProvider>(context, listen: true);

    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _homeProvider.index == 1
            ? Transform.translate(
                offset:
                    Offset.fromDirection(degOneTransitionAnimation.value * 100),
                child: Transform(
                    transform: Matrix4.rotationZ(
                        unitRadianMethod(rotationAnimation.value))
                      ..scale(degOneTransitionAnimation.value),
                    child: FloatingActionButton(
                      heroTag: "Return",
                      backgroundColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        print("vvvvvvvvvvvvv");
                        cart.getAllContacts();
                      },
                      child: Icon(
                        Icons.refresh,
                        color: Theme.of(context).textSelectionColor,
                      ),
                    )),
              )
            : Container(
                width: 0,
              ),
        Transform.translate(
          offset: Offset.fromDirection(degOneTransitionAnimation.value * 100),
          child: Transform(
              transform:
                  Matrix4.rotationZ(unitRadianMethod(rotationAnimation.value))
                    ..scale(degOneTransitionAnimation.value),
              child: FloatingActionButton(
                heroTag: "setting",
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  print("vvvvvvvvvvvvv");
                  getOldData.getData();

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SettingScreen();
                  }));
                },
                child: Icon(
                  Icons.settings,
                  color: Theme.of(context).textSelectionColor,
                ),
              )),
        ),
        Transform.translate(
            offset: Offset.fromDirection(degTwoTransitionAnimation.value * 100),
            child: Transform(
              transform:
                  Matrix4.rotationZ(unitRadianMethod(rotationAnimation.value))
                    ..scale(degTwoTransitionAnimation.value),
              child: Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) => FloatingActionButton(
                        heroTag: "darkAndLight",
                        backgroundColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          notifier.toggleChangeTheme();
                        },
                        child: notifier.darkMode == true
                            ? Icon(
                                CommunityMaterialIcons.weather_sunny,
                                color: Theme.of(context).textSelectionColor,
                              )
                            : Icon(
                                CommunityMaterialIcons.moon_waning_crescent,
                                color: Theme.of(context).textSelectionColor,
                              ),
                      )),
            )),
        Transform.translate(
            offset:
                Offset.fromDirection(degThreeTransitionAnimation.value * 100),
            child: Transform(
                transform:
                    Matrix4.rotationZ(unitRadianMethod(rotationAnimation.value))
                      ..scale(degThreeTransitionAnimation.value),
                child: FloatingActionButton(
                  heroTag: "logOut",
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    print("bbbbbbbbbbbbbb");
                    _homeProvider.logOut(context);
                  },
                  child: Icon(
                    CommunityMaterialIcons.logout,
                    color: Theme.of(context).textSelectionColor,
                  ),
                ))),
        Transform(
            transform:
                Matrix4.rotationZ(unitRadianMethod(rotationAnimation.value)),
            alignment: Alignment.center,
            child: FloatingActionButton(
              heroTag: "menu",
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                if (animationController.isCompleted) {
                  animationController.reverse();
                } else {
                  animationController.forward();
                }
              },
              child: Icon(
                Icons.menu,
                color: Theme.of(context).textSelectionColor,
              ),
            ))
      ],
    );
  }
}
