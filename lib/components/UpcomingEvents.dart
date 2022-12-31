import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Events extends StatefulWidget {
  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  Widget cardmaker(QueryDocumentSnapshot data){
    return Container(
      height: MediaQuery.of(context).size.height * .35,
      color:  Color(0xff012120),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: MediaQuery.of(context).size.height/2,
                width: 150,
                margin: EdgeInsets.all(5),

                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(data.get("image")),
                      fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)
                  ),
                  color:  Color(0xff7751FF),
                ),
              ),),
            Expanded(
              flex: 4,
              child: Container(
                height: double.infinity,
                width: 150,
                margin: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex:1,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                        child: Text(
                          "${data.id}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5,),
                        child: Text(
                          data.get("desc"),
                          style: TextStyle(color: Colors.grey,fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Center(
          child: Text(
            'Upcoming Courses'
          ),
        ),
          backgroundColor: Colors.transparent
      ),
      backgroundColor: Color(0xff0a0a0a),
        body:StreamBuilder(
          stream: FirebaseFirestore.instance.collection("upcoming").snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshots){
            List<Widget> w = [];
            if(snapshots.hasData){
              snapshots.data?.docs.forEach((element) {
                w.add(cardmaker(element));
              });
              if (w.isEmpty){
                w.add(Center(
                  child: Text("No upcoming courses"),
                ));
              }
            }
            return ListView(children: w,);
          },
        )

    );
  }
}
