import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/model/http_exception.dart';
import 'package:food_app/providers/auth_provdier.dart';
import 'package:food_app/widget/custem_Text.dart';
import 'package:provider/provider.dart';
import '../../StatelesssWidget/Constant.dart';

class LoginScreen extends StatefulWidget {
  @override
  _RegistersState createState() => _RegistersState();
}

class _RegistersState extends State<LoginScreen> {
  bool loading = false;
  GlobalKey<FormState> _globalKey = GlobalKey();
  Map<String, String> _authData = {"email": "", "password": ""};

  Future<void> _submit() async {
    if (!_globalKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _globalKey.currentState!.save();

    try {
      loading = true;
      await Provider.of<AuthProvider>(context, listen: false)
          .login(_authData["email"]!, _authData["password"]!)
          .then((value) {
        Timer(Duration(seconds: 2), () {
          loading = false;
          Navigator.of(context).pushReplacementNamed("/HomePage");
        });
      });
    } on HttpException catch (error) {
      var error_message = "Authentication failed";
      if (error.toString().contains("EMAIL_EXISTS"))
        error_message = "Invalid Email";
      else if (error.toString().contains("INVALID_EMAIL"))
        error_message = "this Eamil is not valid";
      else if (error.toString().contains("WEAK_PASSWORD"))
        error_message = "this password is weak";
      else if (error.toString().contains("EMAIL_NOT_FOUND"))
        error_message = "could not found user with this email";
      else if (error.toString().contains("INVALID_PASSWORD")) {
        error_message = "password is invalid";
      }
      _showErrordialog(error_message);
    } catch (error) {
      const error_message = "could not authenticate you ,try again later";
      _showErrordialog(error_message);
    }
  }

  void _showErrordialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("An Error Occurred"),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      loading = false;
                    });
                    Navigator.of(ctx, rootNavigator: true).pop();
                  },
                  child: Text("okey !"))
            ],
          );
        });
  }

  var visable = true;
  var width;
  var height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xff090909),
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.dstATop),
            fit: BoxFit.fill,
            image: AssetImage(
              "assets/images/splachs.png",
            ),
          ),
        ),
        child: Form(
          key: _globalKey,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: height * 0.16),
                  child: const CustemText(
                    text: "Sign In",
                    fontsize: 28,
                    color: accentColor,
                    fontw: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: height * 0.13,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                  child: TextFormField(
                    cursorHeight: 28,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "this Field is Required";
                      } else if (!val.contains("@")) {
                        return "Invalid email";
                      }
                    },
                    onSaved: (val) {
                      _authData["email"] = val!.trim();
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(
                          color: Colors.red[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade50)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.grey,
                          size: 25,
                        ),
                        hintText: "Email Address",
                        hintStyle: TextStyle(
                            color: Colors.grey.shade400, fontSize: 16)),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                  child: TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "this Field is Required";
                      } else if (val.length < 6) {
                        return "Password is to short at least 6 Character";
                      }
                    },
                    onSaved: (val) {
                      _authData["password"] = val!.trim();
                    },
                    cursorHeight: 25,
                    keyboardType: TextInputType.number,
                    obscureText: visable,
                    obscuringCharacter: "*",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(
                          color: Colors.red[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        suffixIcon: IconButton(
                            icon: visable == true
                                ? Icon(Icons.visibility_off_outlined,
                                    size: 22, color: Colors.grey.shade400)
                                : Icon(Icons.visibility_outlined,
                                    size: 22, color: primaryColor),
                            onPressed: () {
                              setState(() {
                                visable = !visable;
                              });
                            }),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade50)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ),
                        prefixIcon: Icon(
                          Icons.lock_outlined,
                          color: Colors.grey,
                        ),
                        hintText: "Password",
                        hintStyle: TextStyle(
                            color: Colors.grey.shade400, fontSize: 16)),
                  ),
                ),
                loading == true
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: height * 0.25),
                          child: SpinKitFadingCircle(
                            color: primaryColor,
                            duration: Duration(seconds: 1),
                            size: 60,
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: height * 0.1,
                              right: width * 0.07,
                              left: width * 0.07,
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: TextButton(
                                onPressed: _submit,
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                      color: accentColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don\'t have an account?",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: accentColor,
                                ),
                              ),
                              TextButton(
                                  onPressed: () => Navigator.of(context)
                                      .pushReplacementNamed("/Registers"),
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
