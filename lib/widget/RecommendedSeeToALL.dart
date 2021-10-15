import 'package:flutter/material.dart';
import 'package:food_app/Screen/Details.dart';
import 'package:food_app/StatelesssWidget/Constant.dart';
 import 'package:food_app/providers/MealProvider_Recommend.dart';
import 'package:provider/provider.dart';

import 'custem_Text.dart';

class RecommendedAllToDayGrid extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<RecommendedAllToDayGrid> {
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
                                  child: FadeInImage(
                                      imageErrorBuilder: (  context,   Object exception,   StackTrace? stackTrace) {
                                        print('Error Handler');
                                        return Container(
                                          width: 50,
                                          height: 50,
                                          child: Image.asset("assets/images/lgog-removebg-preview.png"),
                                        );
                                      },
                                      width: 50,
                                      height: 50,
                                      placeholder: AssetImage(
                                        "assets/images/lgog-removebg-preview.png",
                                      ),
                                      image: NetworkImage(
                                        Provider.of<MealProviderRecommend>(context,
                                            listen: false)
                                            .RecommendModel[index]
                                            .imageUrl!,
                                      ))),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: CustemText(
                                        text: "Main Dish",
                                        color: Colors.blue,
                                        fontsize: 14,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustemText(
                                    text:
                                    "${ Provider.of<MealProviderRecommend>(context,
                                        listen: false)
                                        .RecommendModel[index].title!}",
                                    color: accentColor,
                                    fontsize: 17,
                                    overflow: TextOverflow.clip,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustemText(
                                    text:
                                    "${ Provider.of<MealProviderRecommend>(context,
                                        listen: false)
                                        .RecommendModel[index].calories!} Calories",
                                    color: primaryColor,
                                    fontsize: 13,
                                    fontw: FontWeight.bold,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time_rounded,
                                            size: 18,
                                            color: Colors.grey,
                                          ),
                                          Text(
                                              "${ Provider.of<MealProviderRecommend>(context,
                                                  listen: false)
                                                  .RecommendModel[index].minites!} mins",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: primaryColor,
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.room_service_outlined,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                          Text(
                                              "${ Provider.of<MealProviderRecommend>(context,
                                                  listen: false)
                                                  .RecommendModel[index].serving!}serving",
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
                                    bottom: 90.0, left: 10),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.favorite_sharp,
                                      size: 25,
                                      color: primaryColor,
                                    )),
                              ),
                            ],
                          )),
                    ),
                  );
                },
                itemCount:  Provider.of<MealProviderRecommend>(context,
                    listen: false)
                    .RecommendModel.length),
          ),
        ),
      ),
    );
    ;
  }
}
