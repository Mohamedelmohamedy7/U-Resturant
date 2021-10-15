 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Screen/Details.dart';
import 'package:food_app/providers/MealProvider_Recommend.dart';
import 'package:provider/provider.dart';

import '../StatelesssWidget/Constant.dart';
import 'custem_Text.dart';

class RecommendedMeals extends StatefulWidget {
  const RecommendedMeals({Key? key}) : super(key: key);

  @override
  _RecommendedMealsState createState() => _RecommendedMealsState();
}

class _RecommendedMealsState extends State<RecommendedMeals> {
  var width;
  var height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return  SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(top:height*0.01,bottom:height*0.019, right: width*0.01, left: width*0.01),
        child: Container(
          height: height*0.4,
          width: width*0.87,
          child: ListView.separated(
              separatorBuilder: (ctx, index) {
                return SizedBox(
                  height: 13,
                );
              },
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: ()=>Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => Details(
                              Provider.of<MealProviderRecommend>(context,
                                  listen: false)
                                  .RecommendModel[index]))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                        height: height*0.23,
                         color: Colors.grey.shade800,
                        child: Row(
                          children: [
                            FadeInImage(
                                imageErrorBuilder: (  context,   Object exception,   StackTrace? stackTrace) {
                                  print('Error Handler');
                                  return Container(
                                    width: width*0.25,
                                    height: height*0.3,
                                    child: Image.asset("assets/images/lgog-removebg-preview.png"),
                                  );
                                },
                                width: width*0.25,
                                height: height*0.3,
                                placeholder: AssetImage(
                                  "assets/images/lgog-removebg-preview.png",
                                ),
                                image: NetworkImage(
                                  Provider.of<MealProviderRecommend>(context,
                                      listen: false)
                                      .RecommendModel[index]
                                      .imageUrl!,
                                )),
                            SizedBox(
                              width: width*0.03,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top:height*0.03),
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
                                  height: 10,
                                ),
                                CustemText(
                                  text: "${ Provider.of<MealProviderRecommend>(context,
                                      listen: false)
                                      .RecommendModel[index]
                                      .title!}",
                                  color: accentColor,
                                  fontsize: 20,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustemText(
                                  text: "${ Provider.of<MealProviderRecommend>(context,
                                listen: false)
                                    .RecommendModel[index]
                                    .calories!} Calories",
                                  color: primaryColor,
                                  fontsize: 13,
                                  fontw: FontWeight.bold,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time_rounded,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                        Text(" ${ Provider.of<MealProviderRecommend>(context,
                                            listen: false)
                                            .RecommendModel[index]
                                            .minites!} mins",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: primaryColor,
                                            )),
                                      ],
                                    ),
                                    SizedBox(width: 10,),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.room_service_outlined,
                                          size: 20,
                                          color: Colors.grey,
                                        ),
                                        Text("${ Provider.of<MealProviderRecommend>(context,
                                            listen: false)
                                            .RecommendModel[index]
                                            .serving!} serving",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: primaryColor,
                                            )
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ],
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(bottom:height*0.1),
                            //   child: IconButton(
                            //       onPressed: () {},
                            //       icon: Icon(
                            //         Icons.favorite_sharp,
                            //         size: 25,
                            //         color: primaryColor,
                            //       )),
                            // ),
                          ],
                        )),
                  ),
                );
              },
              itemCount:  Provider.of<MealProviderRecommend>(context).RecommendModel.length),
        ),
      ),
    );
  }
}
