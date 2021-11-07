import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Screen/Details.dart';
import 'package:food_app/model/MealModel.dart';
import 'package:food_app/providers/Favorite_Provider.dart';
import 'package:food_app/providers/MealProvider.dart';
import 'package:food_app/widget/custem_Text.dart';
import 'package:provider/provider.dart';
import '../StatelesssWidget/Constant.dart';
import 'SeeAllToday.dart';

class SeeAllToDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MealProvider>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text("Today Fresh Recipes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
            ),
            Padding(
                padding: const EdgeInsets.only(right: 30),
                child: TextButton(
                  child: const Text("See All",
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 18,
                      )),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SeeAllToDayGrid())),
                ))
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 10),
          child: Container(
            width: double.infinity,
            height: 230,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: prov.Model.length,
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
                                      padding: const EdgeInsets.only(
                                          bottom: 30.0, left: 10, right: 5),
                                      child: Container(
                                        width: 34,
                                        height: 33,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: primaryColor,
                                        ),
                                        child: IconButton(
                                            onPressed: () {
                                              var meal = Meal(
                                                serving:
                                                    prov.Model[index].serving!,
                                                minites:
                                                    prov.Model[index].minites,
                                                calories:
                                                    prov.Model[index].calories,
                                                imageUrl:
                                                    prov.Model[index].imageUrl!,
                                                ingredients: prov
                                                    .Model[index].ingredients,
                                                steps: prov.Model[index].steps,
                                                title: prov.Model[index].title,
                                              );
                                              Provider.of<FavoriteProvider>(
                                                      context,
                                                      listen: false)
                                                  .insertFav(meal);
                                            },
                                            icon: const Icon(
                                              Icons.favorite,
                                              size: 18,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: CachedNetworkImage(
                                          width: 120,
                                          height: 100,
                                          imageUrl: prov.Model[index].imageUrl!,
                                          placeholder: (ctx, index) =>
                                              Image.asset(
                                            "assets/images/lgog-removebg-preview.png",
                                          ),
                                          errorWidget: (ctx, s, w) => Container(
                                            child: Image.asset(
                                                "assets/images/lgog-removebg-preview.png"),
                                          ),
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, top: 20),
                                  child: CustemText(
                                    text: "${prov.Model[index].title}",
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
                                          "${prov.Model[index].calories} Calories",
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
                                          const Icon(
                                            Icons.access_time_rounded,
                                            size: 15,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                              "${prov.Model[index].minites} mins",
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
                                              "${prov.Model[index].serving} serving",
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
}
