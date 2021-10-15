import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/providers/MealProvider.dart';
import 'package:food_app/widget/RecommendedCook.dart';
import 'package:food_app/widget/RecommendedSeeToALL.dart';
import 'package:food_app/widget/SearchWidget.dart';
import 'package:food_app/widget/Text_SeeAll_toDay.dart';
import 'package:food_app/widget/custem_Text.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../StatelesssWidget/Constant.dart';
import 'extension_widget/CustemDrawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  var width;
  var height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      color: primaryColor,
      backgroundColor: Colors.black,
      edgeOffset: 3,
      strokeWidth: 4,
      displacement: 70,
      onRefresh: () => _refreshHome(context),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: BlackColor,
        drawer: Custem_Drwaer(),
        appBar: AppBar(
          toolbarHeight: height * 0.07,
          backgroundColor: BlackColor,
          leading: Builder(builder: (context) {
            return IconButton(
                icon: Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.02,
                  ),
                  child: Image.asset(
                    "assets/images/menu2.png",
                    width: width * 0.08,
                    height: height * 0.04,
                  ),
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                });
          }),
          actions: [
            Lottie.asset("assets/images/logo.json",
                width: width * 0.25, height: height * 0.2, repeat: false),
          ],
        ),
        body:
            // Provider.of<MealProvider>(context).loading &&Provider.of<MealProvider>(context).loading == true ?
            // Center(child: CircularProgressIndicator(),):
            SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.01, left: width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Bonjour,",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "What Would You Like to Cook today ?,",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: width * 0.06),
                    child: SearchFilterWidget(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: height * 0.02,
                    ),
                    child: SeeAllToDay(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.01,
                        left: width * 0.03,
                        right: width * 0.05),
                    child: Divider(
                      height: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: CustemText(
                            text: "Recommended",
                            color: Colors.white,
                            fontsize: width * 0.055,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: width * 0.05),
                            child: TextButton(
                              child: Text("See All",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: width * 0.048,
                                  )),
                              onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RecommendedAllToDayGrid())),
                            ))
                      ],
                    ),
                  ),
                  RecommendedMeals(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refreshHome(context) async {
    await Provider.of<MealProvider>(context, listen: false).getData();
  }
}
