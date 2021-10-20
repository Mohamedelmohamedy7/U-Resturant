import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Screen/Details.dart';
import 'package:food_app/StatelesssWidget/Constant.dart';
import 'package:food_app/model/MealModel.dart';
import 'package:food_app/providers/Favorite_Provider.dart';
import 'package:food_app/providers/MealProvider_Recommend.dart';
import 'package:provider/provider.dart';

import 'custem_Text.dart';

class RecommendedAllToDayGrid extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<RecommendedAllToDayGrid> {
  Meal? meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Recommend Recipes",
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey.shade400,
          ),
        ),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
          ),
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed("/HomePage"),
          iconSize: 20,
          color: Colors.grey.shade500,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20.0, right: 20, left: 20, bottom: 20),
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            child: ListView.separated(
                separatorBuilder: (ctx, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (ctx, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => Details(
                                  Provider.of<MealProviderRecommend>(context,
                                          listen: false)
                                      .RecommendModel[index]))),
                      child: Container(
                          height: 150,
                          width: 100,
                          color: Colors.grey.shade800,
                          child: Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10.0,
                                  ),
                                  child: CachedNetworkImage(
                                    width: 50,
                                    height: 50,
                                    imageUrl:Provider.of<MealProviderRecommend>(
                                        context,
                                        listen: false)
                                        .RecommendModel[index]
                                        .imageUrl!,
                                    placeholder: (ctx,index)=>  Image.asset(
                                      "assets/images/lgog-removebg-preview.png",
                                    ),
                                    errorWidget:(ctx,s,w)=> Container(

                                      child: Image.asset(
                                          "assets/images/lgog-removebg-preview.png"),
                                    ),
                                  ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: const Align(
                                      alignment: Alignment.topLeft,
                                      child: CustemText(
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
                                    text:
                                        "${Provider.of<MealProviderRecommend>(context, listen: false).RecommendModel[index].title!}",
                                    color: accentColor,
                                    fontsize: 17,
                                    overflow: TextOverflow.clip,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustemText(
                                    text:
                                        "${Provider.of<MealProviderRecommend>(context, listen: false).RecommendModel[index].calories!} Calories",
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
                                              "${Provider.of<MealProviderRecommend>(context, listen: false).RecommendModel[index].minites!} mins",
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
                                              "${Provider.of<MealProviderRecommend>(context, listen: false).RecommendModel[index].serving!} serving",
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
                                padding: const EdgeInsets.only(
                                  bottom: 60.0,
                                  left: 10,
                                ),
                                child: Container(
                                  width: 34,
                                  height: 33,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primaryColor,
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        meal = Meal(
                                          serving: Provider.of<
                                                      MealProviderRecommend>(
                                                  context,
                                                  listen: false)
                                              .RecommendModel[index]
                                              .serving!,
                                          minites: Provider.of<
                                                      MealProviderRecommend>(
                                                  context,
                                                  listen: false)
                                              .RecommendModel[index]
                                              .minites,
                                          calories: Provider.of<
                                                      MealProviderRecommend>(
                                                  context,
                                                  listen: false)
                                              .RecommendModel[index]
                                              .calories,
                                          imageUrl: Provider.of<
                                                      MealProviderRecommend>(
                                                  context,
                                                  listen: false)
                                              .RecommendModel[index]
                                              .imageUrl!,
                                          ingredients: Provider.of<
                                                      MealProviderRecommend>(
                                                  context,
                                                  listen: false)
                                              .RecommendModel[index]
                                              .ingredients,
                                          steps: Provider.of<
                                                      MealProviderRecommend>(
                                                  context,
                                                  listen: false)
                                              .RecommendModel[index]
                                              .steps,
                                          title: Provider.of<
                                                      MealProviderRecommend>(
                                                  context,
                                                  listen: false)
                                              .RecommendModel[index]
                                              .title,
                                        );
                                        Provider.of<FavoriteProvider>(context,
                                                listen: false)
                                            .insertFav(
                                          meal!,
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.favorite_outlined,
                                        size: 18,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ],
                          )),
                    ),
                  );
                },
                itemCount:
                    Provider.of<MealProviderRecommend>(context, listen: false)
                        .RecommendModel
                        .length),
          ),
        ),
      ),
    );
    
  }
}
