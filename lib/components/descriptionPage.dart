import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DescribingPage extends StatefulWidget {
  QueryDocumentSnapshot data;
  DescribingPage({required this.data});
  @override
  State<DescribingPage> createState() => _describingPageState(data : data);
}

class _describingPageState extends State<DescribingPage> {
  QueryDocumentSnapshot data;
  _describingPageState({required this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.id),
        backgroundColor: Color(0xff0a0a0a),
      ),
      backgroundColor: Color(0xff0a0a0a),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child:  CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child:Stack(
                children:[
                  Container(
                    height: MediaQuery.of(context).size.height/2,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                         image: NetworkImage(data.get("image")),
                        fit: BoxFit.contain
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)
                      ),
                    ),
                  ),
                  Positioned(
                    top: 320,
                    child: ClipRect(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)
                          ),
                          color: Color(0xff0a0a0a),
                        ),
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 9,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(data.get("desc"),style: TextStyle(fontSize: 20,color: Colors.white),),
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],

        ),
        ),
         );
  }
}
