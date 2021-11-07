import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../StatelesssWidget/Constant.dart';

class SplachScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xff090909),
            image: DecorationImage(
              colorFilter:   ColorFilter.mode(
                  Colors.black.withOpacity(0.6), BlendMode.dstATop),
              fit: BoxFit.fill,
              image: AssetImage(
                "assets/images/splachs.png",
              ),
            ),
          ),
          child: Column(
            children: [
              Lottie.asset("assets/images/logo.json",
                  width: 400, height: 500, reverse: true, ),
              Padding(
                padding:const EdgeInsets.only(
                  right: 30,
                  left: 30,
                ),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: TextButton(
                    onPressed: ()=>Navigator.of(context).pushReplacementNamed("/Registers"),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: TextButton(
                  onPressed:()=> Navigator.of(context).pushReplacementNamed("/LoginScreen"),
                  child: const Text("Sign In",
                      style: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ),
              )
            ],
          )),
    );
  }
}
