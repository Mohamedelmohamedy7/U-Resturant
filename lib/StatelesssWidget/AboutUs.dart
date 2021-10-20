import 'package:flutter/material.dart';
import 'package:food_app/StatelesssWidget/Constant.dart';
import 'package:lottie/lottie.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: const Color(0xff090909),
            image: DecorationImage(
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.05), BlendMode.dstATop),
              fit: BoxFit.cover,
              image: AssetImage(
                "assets/images/splachs.png",
              ),
            ),
          ),
          // color:Colors.grey.shade800,
          height: double.infinity,
          width: double.infinity,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding:const EdgeInsets.only(bottom: 170.0),
                            child: IconButton(
                                onPressed: () => Navigator.of(context)
                                    .pushReplacementNamed("/HomePage"),
                                icon:const Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: primaryColor,
                                  size: 22,
                                )),
                          ),
                        ),
                        const  SizedBox(
                          width: 40,
                        ),
                        Lottie.asset("assets/images/logo.json",
                            width: 200,
                            height: 200,
                            reverse: true,
                            repeat: true),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 10,bottom: 40),
                      child:const  Text(
                        "Bonjour,,\n\n Hope Our App be useful in our App You can access to ingredients of any meal ,"
                        "Be sure if You  do all steps true you wail have awesome meal , ingredients taken from more "
                        "popular Chef in the world with our app you don't need to search in the internet in thousand of website "
                        "and don't know if this is the best way to cook this meal but in our App we guarantee this for the reason "
                        "that has written before\n\n  We're on Community, so text any one of our team members will get back to you as soon as we can. "
                        "Because whether you're on the hunt for recipe-substitution advice, a pantry cooking assist,"
                        " or ideas for simple meals your kids will love, cooking is always better with a little help from your "
                            "friends. \n\n There’s cooking, and then there’s cooking with passion, creativity, and love. At Little Rae’s,"
                            " we firmly believe that the energy you put into a recipe is just as important as the ingredients you use. "
                            "And we’re not alone."
                            " Below is a collection of quotes about cooking from the heart that will make you look at food in a whole new light."
                            "\n\n Cooking is like painting or writing a song. Just as there are only so many notes or colors, "
                            "there are only so many flavors—it’s how you combine them that sets you apart.\n\n Cooking demands attention, patience, and above all,"
                            " a respect for the gifts of the earth. It is a form of worship,"
                            " a way of giving thanks.\n\n This is often accomplished with an illustration or infographic that presents your business model in an easy-to-digest manner,"
                            " like this one used by Taluma Totes that explains how they source materials for their products and how donations help support the country of origin.""",
                        style:const TextStyle(
                            fontSize: 15.5,
                            color: Colors.white60,
                            overflow: TextOverflow.visible,
                            letterSpacing: 2),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
