import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:codingstar_app/components/login.dart';
import 'package:codingstar_app/components/mainPage.dart';
import 'package:codingstar_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  bool isauth = false ;
  @override
  void initState(){
    if (FirebaseAuth.instance.currentUser == null){
      setState(() {
        isauth = false ;
      });
    }
    else
      {
        setState(() {
          isauth = true ;
        });
      }
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splashIconSize: 400,splash:"assets/images/Codingo.png", backgroundColor:Color(0xff0a0a0a) ,nextScreen: isauth?mainPage():MyLogin(), duration: 3000,);
  }
}
