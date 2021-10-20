import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/Screen/HomePage.dart';
import 'package:food_app/StatelesssWidget/Constant.dart';
import 'package:food_app/providers/Favorite_Provider.dart';
import 'package:food_app/widget/custem_Text.dart';
import 'package:lottie/lottie.dart';

import 'Screen/Details.dart';
import 'model/MealModel.dart';

class FavoriteMeal extends StatefulWidget {
  @override
  _FaviriteMealState createState() => _FaviriteMealState();
}

class _FaviriteMealState extends State<FavoriteMeal> {
  var width;
  var height;
  FavoriteProvider _helper = FavoriteProvider();
  List<Meal>? _meal = [];

  @override
  void initState() {
    viewList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: primaryColor,
              leading: IconButton(
                onPressed: () =>
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>HomePage())),
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.grey.shade600,
              ),
              title: Text(
                "Favorites Meal",
                style: TextStyle(color: Colors.grey.shade300),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red.shade600,
                    ),
                    child: const Icon(
                      Icons.favorite_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
            body: (_meal == null || _meal!.length == 0)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .07),
                        child: Lottie.asset(
                          "assets/images/Love.json",
                          width: 300,
                          height: 400,
                          reverse: false,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .12, top: 40),
                        child: const Text("No Meals Added ..!",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            )),
                      ),
                    ],
                  )
                : SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: height * .03,
                          right: width * 0.035,
                          left: width * 0.035,
                          bottom: height * .02),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 1,
                        width: MediaQuery.of(context).size.width * 1,
                        child: ListView.separated(
                          separatorBuilder: (ctx, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemBuilder: (ctx, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: InkWell(
                                onTap: () =>
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => Details(
                                              _meal![index],
                                            ))),
                                child: Container(
                                    height: height * 0.2,
                                    // width: width*0.7,
                                    color: Colors.grey.shade800,
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.only(
                                              left: 10.0,
                                            ),
                                            child: CachedNetworkImage(
                                              width: width * 0.15,
                                              height: 50,
                                              imageUrl: "${_meal![index].imageUrl}",
                                              placeholder: (ctx, index) =>
                                                  Image.asset(
                                                "assets/images/lgog-removebg-preview.png",
                                              ),
                                              errorWidget: (ctx, s, w) => Container(
                                                child: Image.asset(
                                                    "assets/images/lgog-removebg-preview.png"),
                                              ),
                                            )),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 20.0),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: const CustemText(
                                                  text: "Main Dish",
                                                  color: Colors.blue,
                                                  fontsize: 14,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            CustemText(
                                              text: "${_meal![index].title}",
                                              color: accentColor,
                                              fontsize: 17,
                                              overflow: TextOverflow.clip,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            CustemText(
                                              text:
                                                  " ${_meal![index].calories} Calories",
                                              color: primaryColor,
                                              fontsize: 13,
                                              fontw: FontWeight.bold,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.access_time_rounded,
                                                      size: 18,
                                                      color: Colors.grey,
                                                    ),
                                                    Text(
                                                        " ${_meal![index].minites} mins",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: primaryColor,
                                                        )),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.room_service_outlined,
                                                      size: 20,
                                                      color: Colors.grey,
                                                    ),
                                                    Text(
                                                        " ${_meal![index].serving} serving",
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
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: height * .07,
                                              left: width * 0.01),
                                          child: IconButton(
                                            onPressed: () {
                                              var alert = AlertDialog(
                                                title: Text("Notice",
                                                    style: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: 15)),
                                                content: Container(
                                                  height: 50,
                                                  child: Column(
                                                    children: [
                                                      Divider(color:primaryColor,),
                                                      Text("Are You Sure you want to Remove this Meal ?",
                                                          style: TextStyle(
                                                              color: Colors.white54,
                                                              fontSize: 14)),
                                                    ],
                                                  ),
                                                ),
                                                backgroundColor:
                                                    Colors.grey.shade800,
                                                shape: RoundedRectangleBorder(),
                                                elevation: 2,
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: primaryColor),
                                                      )),

                                                  TextButton(
                                                      onPressed: () {
                                                        Meal meal = _meal![index];
                                                        deleteAll(meal);
                                                        Navigator.of(context).pop();
                                                        Fluttertoast.showToast(
                                                          msg: "Meal Is Removed",
                                                          textColor: Colors.black,
                                                          backgroundColor:
                                                              primaryColor,
                                                          fontSize: 12,
                                                          toastLength:
                                                              Toast.LENGTH_SHORT,
                                                        );
                                                      },
                                                      child: Text("Ok",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  primaryColor))),
                                                ],
                                              );
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) =>
                                                      alert);
                                            },
                                            icon: const Icon(
                                              Icons.delete_forever,
                                              size: 35,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            );
                          },
                          itemCount: _meal!.length,
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }

  void viewList() {
    _helper.viewData().then((value) {
      setState(() {
        _meal = value;
      });
    });
  }

  void deleteAll(Meal meal) {
    setState(() {
      _helper.delete(meal);
      viewList();
    });
  }
}
