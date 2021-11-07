import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/StatelesssWidget/Constant.dart';
import 'package:food_app/model/MealModel.dart';
import 'package:food_app/widget/custem_Text.dart';
import 'package:page_transition/page_transition.dart';

import 'HomePage.dart';

class Details extends StatefulWidget {
  Meal? model;

  Details(this.model);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> with TickerProviderStateMixin {
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

  var width;
  var height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.002, left: width * 0.01),
                    child: IconButton(
                        onPressed: () =>Navigator.of(context).push(PageTransition(
                            type: PageTransitionType.rightToLeft,child: HomePage()
                        )),                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: primaryColor,
                          size: 22,
                        )),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, left: width * 0.05),
                    child: Text(
                      "${widget.model!.title}\n",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: width * 0.05),
                    child: CustemText(
                      text: "${widget.model!.calories} Calories",
                      color: primaryColor,
                      fontsize: 13,
                      fontw: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: width * 0.05,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 18,
                              color: Colors.grey.shade700,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("${widget.model!.minites} mins",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                )),
                          ],
                        ),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(top: 8.0, left: width * 0.05,),
                          child: CachedNetworkImage(
                            width: 140,
                            height: 150,
                            imageUrl:
                            "${widget.model!.imageUrl}",
                            placeholder: (ctx,index)=>  Image.asset(
                              "assets/images/lgog-removebg-preview.png",
                            ),
                            errorWidget:(ctx,s,w)=> Container(
                              child: Image.asset(
                                  "assets/images/lgog-removebg-preview.png"),
                            ),
                          )

                      )
                    ]),
                Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.05,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.room_service_outlined,
                        size: 18,
                        color: Colors.grey.shade700,
                      ),
                     const SizedBox(
                        width: 5,
                      ),
                      Text("${widget.model!.serving} serving",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          )),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.05, top: height*0.03, bottom: height*0.02),
                        child:const Align(
                          alignment: Alignment.topLeft,
                          child: Text("Ingredients ~ ",
                              style: TextStyle(
                                fontSize: 20,
                                color: primaryColor,
                              )),
                        ),
                      ),
                       SizedBox(
                        width: width * 0.23,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: TextButton(
                          onPressed: BottomSheetVal,
                          child: ScaleTransition(
                            scale: _animation,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                 const Text("For Steps",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: accentColor,
                                      )),
                                const  Icon(
                                    Icons.fast_forward_rounded,
                                    color: accentColor,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 25.0, right: 10, bottom: 30),
                  child: Text("${widget.model!.ingredients}",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                          letterSpacing: 1)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget? BottomSheetVal() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.grey.shade800,
        shape:const RoundedRectangleBorder(
            borderRadius:const BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.87,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: InkWell(
                          child:const Divider(
                            thickness: 3,
                            color: accentColor,
                          ),
                          onTap: () => Navigator.of(context).pop(),
                        ),
                      ),
                      width: 100,
                    ),
                    Padding(
                      padding:const EdgeInsets.only(right: 0.0),
                      child: Wrap(
                        spacing: 5.0,
                        runSpacing: 5.0,
                        direction: Axis.horizontal,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:const EdgeInsets.only(top: 30.0, left: 25),
                              child: Text(
                                "${widget.model!.title}\n",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 15),
                        child: CustemText(
                          text: "${widget.model!.calories} Calories",
                          color: primaryColor,
                          fontsize: 13,
                          fontw: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 18,
                            color: Colors.grey.shade400,
                          ),
                        const  SizedBox(
                            width: 5,
                          ),
                          Text("${widget.model!.minites} mins",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade400,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25.0,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.room_service_outlined,
                                  size: 18,
                                  color: Colors.grey.shade400,
                                ),
                              const  SizedBox(
                                  width: 5,
                                ),
                                Text("${widget.model!.serving} serving",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade400,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 28.0, right: 28, top: 15, bottom: 15),
                      child:  Divider(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, bottom: 20),
                      child:const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Steps",
                          style: TextStyle(
                              fontSize: 18,
                              color: primaryColor,
                              overflow: TextOverflow.visible,
                              letterSpacing: 2),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 10, bottom: 40),
                      child: Text(
                        "${widget.model!.steps}",
                        style: TextStyle(
                            fontSize: 15.5,
                            color: Colors.grey.shade400,
                            letterSpacing: 2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
