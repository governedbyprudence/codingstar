import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'homePage.dart';
import 'UpcomingEvents.dart';
import 'profile.dart';
class mainPage extends StatefulWidget {
  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {

  int _currentIndex = 0;
 List <Widget> page=[
   homePage(),
   Events(),
   profile(),
 ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[_currentIndex],
      backgroundColor: Color(0xff202538),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: Color(0xff012120),
        onTap: (value) {
          setState(() => _currentIndex = value);
        },
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.home,size: 30,color: Colors.grey,),
            activeIcon: Icon(Icons.home,size: 35,color: Colors.white,)
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.book,size: 30,color: Colors.grey,),
            activeIcon: Icon(Icons.book,size: 35,color: Colors.white,)
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.person,size: 30,color: Colors.grey,),
            activeIcon:Icon(Icons.person,size: 35,color: Colors.white,)
          ),
        ],
      ),
    );
  }
}
//0xff2d1d45