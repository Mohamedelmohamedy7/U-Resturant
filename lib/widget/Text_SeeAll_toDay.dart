import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Screen/Details.dart';
import 'package:food_app/providers/MealProvider.dart';
import 'package:food_app/widget/custem_Text.dart';
import 'package:provider/provider.dart';
 import '../StatelesssWidget/Constant.dart';
import 'SeeAllToday.dart';

class SeeAllToDay extends StatefulWidget {
  const SeeAllToDay({Key? key}) : super(key: key);

  @override
  State<SeeAllToDay> createState() => _SeeAllToDayState();
}

class _SeeAllToDayState extends State<SeeAllToDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: CustemText(
                text: "Today Fresh Recipes",
                color: Colors.white,
                fontsize: 20,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(right: 30),
                child: TextButton(
                  child: Text("See All",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 18,
                      )),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SeeAllToDayGrid())),
                ))
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 10),
          child: Container(
            width: double.infinity,
            height: 230,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: Provider.of<MealProvider>(context).Model.length,
              itemBuilder: (ctx, index) {
                return Container(
                  width: 180,
                  height: 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Card(
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => Details(
                                    Provider.of<MealProvider>(context,
                                            listen: false)
                                        .Model[index]))),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 50.0),
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.favorite_sharp,
                                            size: 25,
                                            color: primaryColor,
                                          )),
                                    ),
                                    FadeInImage(
                                        imageErrorBuilder: (  context,   Object exception,   StackTrace? stackTrace) {
                                          print('Error Handler');
                                          return Container(
                                            width: 120,
                                            height: 100,
                                            child: Image.asset("assets/images/lgog-removebg-preview.png"),
                                          );
                                        },
                                          width: 120,
                                        height: 100,
                                        placeholder: AssetImage(
                                          "assets/images/lgog-removebg-preview.png",
                                        ),
                                        image: NetworkImage(Provider.of<MealProvider>(context,
                                                  listen: false)
                                              .Model[index]
                                              .imageUrl!,
                                        )),

                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, top: 20),
                                  child: CustemText(
                                    text:
                                        "${Provider.of<MealProvider>(context).Model[index].title}",
                                    color: Colors.white,
                                    fontw: FontWeight.bold,
                                    fontsize: 18,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 10),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: CustemText(
                                      text:
                                          "${Provider.of<MealProvider>(context).Model[index].calories} Calories",
                                      color: primaryColor,
                                      fontsize: 13,
                                      fontw: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time_rounded,
                                            size: 15,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                              "${Provider.of<MealProvider>(context).Model[index].minites} mins",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: primaryColor,
                                              )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.room_service_outlined,
                                            size: 18,
                                            color: Colors.grey,
                                          ),
                                          Text(
                                              "${Provider.of<MealProvider>(context).Model[index].serving} serving",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: primaryColor,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      color: Colors.grey.shade800,
                      elevation: 2,
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) => SizedBox(
                width: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
  Imageerror(){
    return Image.asset(
      "assets/images/lgog-removebg-preview.png",
    );
  }
}
