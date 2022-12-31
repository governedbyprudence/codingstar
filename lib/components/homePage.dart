import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coursePage.dart';


class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  Widget buildcourse(QueryDocumentSnapshot data){
    return Container(
      height: MediaQuery.of(context).size.height/2.6,
      child: Column(
        children: [
          Expanded(
              flex:3,
              child: Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Text(data.id,style: TextStyle(fontSize: 35,color: Colors.white),))
          ),
          Expanded(
            flex: 8,
            child:Container(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("courses").doc(data.id).collection("topics").snapshots(),
                    builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                      List<Widget> w = [];
                      if (snapshot.hasData){
                        snapshot.data!.docs.forEach((element) {
                          w.add(
                            GestureDetector(
                              onTap: (){
                                _tripEditModalBottomSheet(context,data.id,element.id,element.id,element.get("desc"),element.get("image"));
                              },
                              child: Container(
                                height: 150,
                                width: 150,
                                margin: EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    element.id,
                                    style: TextStyle(
                                        shadows: [
                                        Shadow( // bottomLeft
                                        offset: Offset(-1.5, -1.5),
                                      color: Colors.black
                                  ),
                                    Shadow( // bottomRight
                                        offset: Offset(1.5, -1.5),
                                        color: Colors.black
                                    ),
                                    Shadow( // topRight
                                        offset: Offset(1.5, 1.5),
                                        color: Colors.black
                                    ),
                                    Shadow( // topLeft
                                        offset: Offset(-1.5, 1.5),
                                        color: Colors.black
                                    ),],
                                    color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 35),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30)
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(element.get("image")),
                                    fit: BoxFit.cover,
                                  ),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xff015d57),
                                        Color(0xff013a33),
                                        Color(0xff015d90),
                                        Color(0xff012120)
                                      ]
                                  ),

                                ),
                              ),
                            ),
                          );
                        });
                        if(w.isEmpty)w.add(Text("Not available"));
                      }
                      return ListView(children: w,scrollDirection: Axis.horizontal,);
                    }
                )
            ),
          ),
        ],
      ),
    );
  }
 Widget header(){
    return Container(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff0db5ba),
                Color(0xff013a33),
                Color(0xff012120),
                Color(0xff0a0a0a),
              ]
          ),
        ),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    alignment:Alignment.topLeft,
                    padding: EdgeInsets.only(top: 30,left: 10,right: 10),
                    child: Text('Welcome to Codingstar',style: TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.bold),)),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 13,vertical: 10),
                    child: Text('This is a platform where you could learn to code easily !',style: TextStyle(fontSize: 20,color: Colors.white),)),
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white,),
                    borderRadius:  BorderRadius.all(Radius.circular(15)),
                  ),
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {  },
                    child: Text("Show all courses",style: TextStyle(color: Colors.white),),
                  ),
                )

              ],
            )
        ),
      ),
    );
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Codingo'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.search))
        ],
      ),
      body: Container(
          color: Color(0xff0a0a0a),
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("courses").snapshots(),
            builder: (context,AsyncSnapshot<QuerySnapshot> snapshots){
                  List<Widget> w = [header()];
                  if(snapshots.hasData){
                    snapshots.data!.docs.forEach((element) {
                      w.add(buildcourse(element));
                    });
                  }
                  if (w.length == 1){
                    w.add(Text("No Courses available"));
                  }
                  return Column(children: w,);
            },
          )
        )
      ),
    );
  }
  void _tripEditModalBottomSheet(context,String courseName,String topicname,String title,String description,String image_url){
    showModalBottomSheet(context: context, builder: (BuildContext bc){
      return Container(
        height: MediaQuery.of(context).size.height * .65,
        color: Color(0xff012120),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Spacer(),
                  IconButton(
                      onPressed: (){
                    Navigator.of(context).pop();
                  }, icon: Icon(Icons.cancel,color: Colors.white,size: 25,))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                    height: 200,
                    width: 150,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)
                      ),
                      color:  Color(0xff7751FF),
                      image: DecorationImage(
                        image: NetworkImage(image_url),
                        fit: BoxFit.cover,
                      )
                    ),
                  ),),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 200,
                      width: 150,
                      margin: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex:2,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                              child: Text(
                                title,
                                style: TextStyle(
                                    color: Colors.white,
                                  fontSize: 20
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5,),
                              child: Text(
                                description,
                                style: TextStyle(color: Colors.white,fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                      color: Color(0xff012120),
                    ),),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * .92,
                height: 50,
                margin: EdgeInsets.symmetric(vertical: 5),
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> coursePage(course: courseName,name: topicname,)));
                    },
                    child: Text("Lets Go",style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                ),
              ))
            ],
          ),
        ),
      );
    });

  }
}



class notify extends StatefulWidget {
  const notify({Key? key}) : super(key: key);

  @override
  _notifyState createState() => _notifyState();
}

class _notifyState extends State<notify> {
  List<Widget> data=[];
  Widget make_tile(String name){
    return ListTile(
      leading: Text(name),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child:ListView(
        children: data,
      )
    );
  }
}
