import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codingstar_app/components/login.dart';
import 'package:codingstar_app/components/mainPage.dart';
import 'package:codingstar_app/components/register.dart';
import 'package:codingstar_app/components/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "splash",
    routes: {
      "splash":(context)=>splashscreen(),
      "first":(context)=>first(),
      "home":(context)=>mainPage(),
      "login":(context)=>MyLogin(),
      "register":(context)=>MyRegister(),
    },
  ));
}

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  _firstState createState() => _firstState();
}

class _firstState extends State<first> {
  void test(){
    FirebaseFirestore.instance.collection("temp").get().then((value) => print(value.docs.first.get("data"))).catchError((err)=>print(err));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
        onPressed: test,
        child: Text("App"),
      ),
    );
  }
}

