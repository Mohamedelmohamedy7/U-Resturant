import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Screen/Details.dart';
import 'package:food_app/Screen/HomePage.dart';
import 'package:food_app/StatelesssWidget/Constant.dart';
import 'package:food_app/model/MealModel.dart';
import 'package:food_app/widget/Search/SearchService.dart';
import 'package:page_transition/page_transition.dart';

import '../custem_Text.dart';

class SearchFilterWidget extends StatefulWidget {
  const SearchFilterWidget({Key? key}) : super(key: key);

  @override
  _SearchFilterWidgetState createState() => _SearchFilterWidgetState();
}

class _SearchFilterWidgetState extends State<SearchFilterWidget> {
  var queryResultSet = [];
  var tempSearchStore = [];

  initalSearch(String value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    try {
      var captlizationValue =
          value.substring(0, 1).toUpperCase() + value.substring(1);
      if (queryResultSet.length == 0 && value.length == 1) {
        SearchService().searchByName(value).then((QuerySnapshot docsData) {
          for (int i = 0; i < docsData.docs.length; ++i) {
            queryResultSet.add(docsData.docs[i].data());
          }
        });
        SearchService().searchByRecommend(value).then((QuerySnapshot docsData) {
          for (int i = 0; i < docsData.docs.length; ++i) {
            queryResultSet.add(docsData.docs[i].data());
          }
        });
      } else {
        tempSearchStore = [];
        queryResultSet.forEach((element) {
          if (element["title"].startsWith(captlizationValue)) {
            setState(() {
              tempSearchStore.add(element);
            });
          }
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  var width;
  var height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body:  SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: SafeArea(
            child: Column(children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.01),
                  child: IconButton(
                      onPressed: () =>Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.rightToLeft,child: HomePage()
                      )),
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: primaryColor,
                        size: 22,
                      )),
                ),
              ),
              SizedBox(height: 15,),
                Container(
                  width: width * 0.9,
                  child: TextField(
                    style: TextStyle(color: Colors.white,fontSize: 18),
                    cursorHeight: 23,
                     cursorWidth: 3,
                    cursorColor: Colors.white,
                    onChanged: (val) {
                      setState(() {
                        initalSearch(val);
                      });
                    },
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.grey.shade800)),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.grey.shade800),
                      ),
                      prefixIcon:const Icon(
                        Icons.search_rounded,
                        color: Colors.white38,
                        size: 25,
                      ),
                      fillColor: Colors.grey.shade800,
                      filled: true,
                      hintText: "Search for recipes",
                      hintStyle:
                          TextStyle(color: Colors.grey.shade500, fontSize: 19),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              const  SizedBox(height: 30,),
                 Padding(
                   padding: const EdgeInsets.only(bottom: 8.0),
                   child: Container(
                         width: width * 1,
                        height: height * 0.75,
                        child: ListView(
                           children: tempSearchStore.map((elemnt) {
                            return buildResultCard(elemnt);
                          }).toList(),
                        )),
                 ),

              ]),
          ),
      ),
      
    );
  }

  Widget buildResultCard(elemnt) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15, top: 15),
      child: Container(
        height: height * 0.25,
        width: width * 0.2,
        child: InkWell(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => Details(Meal.fromjson(elemnt)))),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  CachedNetworkImage(
                    width: width * 0.25,
                    height: height * 0.3,
                    imageUrl:  elemnt["imageUrl"],
                    placeholder: (ctx, index) =>
                        Image.asset(
                          "assets/images/lgog-removebg-preview.png",
                        ),
                    errorWidget: (ctx, s, w) => Container(
                      child: Image.asset(
                          "assets/images/lgog-removebg-preview.png"),
                    ),
                  ),

                    SizedBox(
                    width: width * 0.03,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(top: height * 0.03),
                        child:const Align(
                          alignment: Alignment.topLeft,
                          child: CustemText(
                            text: "Main Dish",
                            color: Colors.blue,
                            fontsize: 14,
                          ),
                        ),
                      ),
                      const  SizedBox(
                        height: 10,
                      ),
                      CustemText(
                        text: elemnt["title"],
                        color: accentColor,
                        fontsize: 20,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const  SizedBox(
                        height: 10,
                      ),
                      CustemText(
                        text: "${elemnt["calories"]} Calories",
                        color: primaryColor,
                        fontsize: 13,
                        fontw: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              const  Icon(
                                Icons.access_time_rounded,
                                size: 18,
                                color: Colors.grey,
                              ),
                              Text(" ${elemnt["minites"]} mins",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: primaryColor,
                                  )),
                            ],
                          ),
                          const   SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              const  Icon(
                                Icons.room_service_outlined,
                                size: 20,
                                color: Colors.grey,
                              ),
                              Text(" ${elemnt["servising"]} serving",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: primaryColor,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
