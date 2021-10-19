import 'dart:async';
import 'package:flutter/material.dart';
 import 'package:food_app/StatelesssWidget/Constant.dart';
 import 'package:food_app/providers/auth_provdier.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Custem_Drwaer extends StatefulWidget{
  const Custem_Drwaer({Key? key}) : super(key: key);

  @override
  _Custem_DrwaerState createState() => _Custem_DrwaerState();
}
  class _Custem_DrwaerState extends State<Custem_Drwaer> {
  var loading = false;
  @override
  Widget build(BuildContext context) {
     return loading==true? Scaffold(body: Container(
       width: double.infinity,
       color:primaryColor,
       height: double.infinity,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Padding(
             padding: const EdgeInsets.only(right: 20.0),
             child: Lottie.asset("assets/images/bye.json",
               width: 200, height: 300, reverse: false, ),
           ),
           Padding(
             padding: const EdgeInsets.only(left: 10.0),
             child:const Text("Hope You back Soon ",style: TextStyle(
               color: Colors.white,
               fontWeight: FontWeight.bold,
               fontSize: 25,
                letterSpacing: 4,
             ),),
           ),
           SizedBox(height: 50,),
         ],
       ),
     ),):Drawer(
          child: Container(
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
            height:double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 30),
                  child: Lottie.asset("assets/images/logo.json",
                      width: 250, height: 220, repeat: true),
                ),
                 Padding(
                   padding: const EdgeInsets.only(left: 18.0,right: 70),
                   child: Column(
                     children: [
                         TextButtonIcon(text: "Home",icon: Icon(Icons.home,size: 25,color:Colors.grey.shade600,),onPressed:
                       (){
                         Navigator.of(context).pushReplacementNamed("/HomePage");
                       }),
                       const SizedBox(height: 10,) ,
                       const  Divider(height: 10,color: Colors.orange,thickness: 0.6,),
                       TextButtonIcon(text: "Favorite",icon: Icon(Icons.favorite_outline,size: 17,color: Colors.grey.shade600),
                           onPressed: ()=>  Navigator.of(context).pushReplacementNamed("/FavoriteMeal")),
                       const SizedBox(height: 10,),
                       const Divider(height: 10,color: Colors.orange,thickness: 0.6,),
                       TextButtonIcon(text: "Settings",icon: Icon(Icons.settings,size: 20,color: Colors.grey.shade600,),
                           onPressed: ()=> Navigator.of(context).pushReplacementNamed("/Setting")),
                       const  SizedBox(height: 10,),
                       const  Divider(height: 10,color: Colors.orange,thickness: 0.6,),
                       TextButtonIcon(text: "About Us",icon: Icon(Icons.info_outline,size: 17,color: Colors.grey.shade600,),onPressed:  (){
                             Navigator.of(context).pushReplacementNamed("/AboutUs");
                         }),
                       const  SizedBox(height: 10,),
                       const  Divider(height: 10,color: Colors.orange,thickness: 0.6,),
                       TextButtonIcon(text: "Sign Out",icon: Icon(Icons.login_sharp,size: 20,color: Colors.grey.shade600,),
                           onPressed: (){
                         try {
                           loading = true;
                           Provider.of<AuthProvider>(context, listen: false)
                               .logout()
                               .then((value) async {
                             Timer(Duration(seconds: 4), () {
                               loading = false;
                               Navigator.of(context).pushReplacementNamed(
                                   "/LoginScreen");
                             });
                           });
                         }catch(e) {
                           print(e.toString());
                         }
                         }),

                       const   SizedBox(height: 15,),
                     ],
                   ),
                 )
                   ],

            ),
          ),
    );
  }
  Widget TextButtonIcon({required VoidCallback onPressed, required Icon icon, required String text}){
    return   Align(
      alignment: Alignment.topLeft,
      child: TextButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: Text(text,style: TextStyle(
          fontSize: 15,
          color: Colors.grey.shade500,
         ),),
      ),
    );
  }
}
