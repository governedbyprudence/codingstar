import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  TextEditingController _username= new TextEditingController();
  TextEditingController _password= new TextEditingController();
  bool loading = false ;
  final googleSignin = GoogleSignIn();
  String err_mess="";
  loginUser(String email,String password)async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), password: password.trim())
        .then((value) => Navigator.popAndPushNamed(context, "home"))
        .catchError((err){
      print(err.code);
      setState(() {
        loading = false ;
        if(err.code == "user-not-found")err_mess="Did you Sign up ?";
        else if(err.code == "invalid-email")err_mess="Please write in a valid email.";
        else if(err.code == "wrong-password")err_mess="Your entered data is not correct.";
        else err_mess="";
      });
    });
  }
  // loginUser_google(){
  //   await FirebaseAuth.instance.signInwith
  // }
  signingoogle()async{
   final user = await googleSignin.signIn().catchError((err)=>print(err));
   if (user == null) return;
   final google_auth =await user.authentication;
   final credential = GoogleAuthProvider.credential(
      accessToken: google_auth.accessToken,
     idToken: google_auth.idToken,
   );
   final user_cred=FirebaseAuth.instance.signInWithCredential(credential).then((value){
     FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid).set({
       "email":FirebaseAuth.instance.currentUser?.email,
       "type" :"user",
       "name" : FirebaseAuth.instance.currentUser?.displayName,
       "subscribed" : false,
     });
     Navigator.popAndPushNamed(context, "home");
   }).catchError((err)=>print(err.code));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   tileMode: TileMode.mirror,
        //   colors: [
        //     Color(0xff0096c7),
        //     Color(0xff00b4d8),
        //     Color(0xff48cae4),
        //     Color(0xff90e0ef),
        //     Color(0xffade8f4),
        //   ]
        // )
        color: Color(0xff0a0a0a),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 150),
              child: Text(
                'Student Login',
                style: TextStyle(color: Colors.white,textBaseline: TextBaseline.alphabetic, fontSize: 33,fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.38),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(padding:EdgeInsets.only(left: 35,bottom: 10),child: Text(err_mess,style: TextStyle(fontSize:20,color: Colors.red),)),
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextFormField(
                            controller:_username,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: _password,
                            style: TextStyle(color: Colors.black),
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 40,
                            child: loading?CircularProgressIndicator():Text(""),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: (){
                                    signingoogle();
                                },
                                child: Row(
                                  children: [
                                    FaIcon(FontAwesomeIcons.google),
                                    Text(
                                      '   Sign in using Google',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15, fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff013a33),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                        if(_username.text.isNotEmpty && _password.text.isNotEmpty){
                                          setState(() {
                                            loading = true;
                                          });
                                          loginUser(_username.text, _password.text);
                                        }
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(context, "register");
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}