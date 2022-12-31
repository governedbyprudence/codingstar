import 'package:flutter/material.dart';
import 'descriptionPage.dart';

class topicPage extends StatefulWidget {

  String topicName;
  topicPage(this.topicName);

  @override
  State<topicPage> createState() => _topicPageState();

}

class _topicPageState extends State<topicPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff202538),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          title: Text(widget.topicName),
          backgroundColor: Color(0xff202538),
          actions: [
          ],
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            _container('Introduction'),
            _container('Starting with Python')
          ],
        ),
      ),
    );
  }
  Widget _container(String topicName){
    return GestureDetector(
      onTap: (){
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> DescribingPage()));
      },
      child: Container(
        decoration:BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
                begin:Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff7751FF),
                  Color(0xff8970fa),
                ]
            )
        ),
        alignment: Alignment.center,
        margin: EdgeInsets.all(10),
        width:MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/8,
        child: Text(topicName,style:TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold
        )),
      ),
    );
}}
