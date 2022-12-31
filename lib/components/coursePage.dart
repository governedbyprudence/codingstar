import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codingstar_app/components/QuizPage.dart';
import 'package:codingstar_app/components/descriptionPage.dart';
import 'package:codingstar_app/components/topicPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class coursePage extends StatefulWidget {
  String course;
  String name;
  coursePage({required this.course,required this.name});
  @override
  State<coursePage> createState() => _coursePageState(course: course,name: name);
}

class _coursePageState extends State<coursePage> {
  String course,name;
  List<List<Color>> colors =[
    [Colors.green,Colors.greenAccent,Colors.blueAccent],
    [Colors.red,Colors.redAccent,Colors.yellowAccent],
    [Color(0xff0783b7),Color(0xff06b2f4),Color(0xff50c9f7)],
    [Colors.red,Colors.redAccent,Colors.yellowAccent],
    [Colors.red,Colors.redAccent,Colors.yellowAccent],
  ];
  _coursePageState({required this.course,required this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0a0a0a),
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("courses").doc(course).collection("topics").doc(name).collection("elements").snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshots){
          List<Widget>  w = [];
          if (snapshots.hasData){
            int i = 0;
            snapshots.data?.docs.forEach((element) {
              w.add(_container(element,element.get("type"),element.id, colors[i%5]));
              i++;
            });
            if (w.isEmpty)w.add(Text("No data"));
          }
          return ListView(children: w,);
        },
      ),
    );
  }
 Widget _container(QueryDocumentSnapshot data,String type,String topicName,List<Color> color){
    return GestureDetector(
      onTap: (){
        if (type == "text")
        Navigator.push(context, MaterialPageRoute(builder: (context)=> DescribingPage(data: data,)));
      else
          Navigator.push(context, MaterialPageRoute(builder: (context)=> QuizPage(data : data)));
        },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration:BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            begin:Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: color
          )
        ),
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        width:MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/8,

        child: Text(topicName,style:TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold
        )),
      ),
    );
 }
}
