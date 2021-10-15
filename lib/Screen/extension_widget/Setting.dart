import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:food_app/StatelesssWidget/Constant.dart';
import 'package:food_app/widget/custem_Text.dart';
import 'package:lottie/lottie.dart';

import 'CustemDrawer.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var _selected;
  var _selected1;
  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      lowerBound: 0.5,
      upperBound: 1)
    ..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var isSwitchOn = false;
  var isSwitchOn1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: BlackColor,
      drawer: Custem_Drwaer(),
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: BlackColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: IconButton(icon: Icon(
            Icons.arrow_back_ios_rounded, size: 20, color: primaryColor,)
              ,
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed("/HomePage"),
              ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Lottie.asset("assets/images/logo.json",
                width: 100, height: 120, repeat: false),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 22, right: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: CustemText(
                      text: "Settings",
                      fontsize: 23,
                      color: accentColor,
                      fontw: FontWeight.bold,
                      space: 1,
                    ),
                  ),
                  ScaleTransition(
                    scale: _animation,
                    child: Text("Soon...",
                        style: TextStyle(
                          fontSize: 22,
                          color: primaryColor,
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                width: 320,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0),
                      child: Icon(
                        Icons.language_outlined,
                        color: Colors.grey,
                        size: 25,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: CustemText(
                        text: "Language",
                        color: accentColor,
                        fontsize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 70.0),
                      child: DropdownButton(
                        value: _selected,
                        onChanged: (newValue) {
                          setState(() {
                            _selected = newValue;
                          });
                        },
                        items: ['English', 'Arabic', 'Spanish', 'Germany']
                            .map((lang) {
                          return DropdownMenuItem(
                            child: new Text(
                              lang,
                              style: TextStyle(color: primaryColor),
                            ),
                            value: lang,
                          );
                        }).toList(),
                        hint: Text("English",
                            style: TextStyle(color: primaryColor)),
                        style: TextStyle(
                            color: Colors.grey.shade700, fontSize: 16),
                        icon: Icon(Icons.arrow_drop_down_circle),
                        dropdownColor: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30.0, left: 30, top: 30),
              child: Divider(
                height: 2,
                color: Colors.grey.shade500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 22),
              child: Align(
                alignment: Alignment.topLeft,
                child: CustemText(
                  text: "Notification",
                  fontsize: 20,
                  color: accentColor,
                  fontw: FontWeight.bold,
                  space: 1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                width: 320,
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 22.0, top: 20),
                          child: Icon(
                            Icons.notifications_none,
                            color: Colors.grey,
                            size: 25,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 20),
                          child: Column(
                            children: [
                              CustemText(
                                text: "Push Notification",
                                color: accentColor,
                                fontsize: 18,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 35.0, top: 20),
                          child: FlutterSwitch(
                            toggleSize: 20,
                            height: 24,
                            width: 50,
                            value: isSwitchOn1,
                            toggleColor: Colors.grey.shade400,
                            activeColor: Colors.deepOrange,
                            inactiveColor: Colors.deepOrangeAccent,
                            onToggle: (value) {
                              setState(() {
                                isSwitchOn1 = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, right: 30, left: 20),
                      child: Divider(height: 2, color: accentColor,),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 22.0, top: 20),
                          child: Icon(
                            Icons.email_outlined,
                            color: Colors.grey,
                            size: 25,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 20),
                          child: Column(
                            children: [
                              CustemText(
                                text: "Email Notification",
                                color: accentColor,
                                fontsize: 18,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, top: 20),
                          child: FlutterSwitch(
                            toggleSize: 20,
                            height: 25,
                            width: 50,
                            value: isSwitchOn,
                            toggleColor: Colors.grey.shade400,
                            activeColor: Colors.deepOrange,
                            inactiveColor: Colors.deepOrangeAccent,
                            onToggle: (value) {
                              setState(() {
                                isSwitchOn = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
