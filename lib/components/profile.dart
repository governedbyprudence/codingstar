import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class profile extends StatefulWidget{
  @override
  profile_page createState () => profile_page();

}
class profile_page extends State<profile>{
  late String? name="",email="";
  TextEditingController _name = new TextEditingController();
  @override
  void initState() {
    super.initState();
    setState(() {
      name = FirebaseAuth.instance.currentUser!.displayName;
      email = FirebaseAuth.instance.currentUser!.email;
    });
    _name.text = name!;
  }
  name_dialog(){
    return showDialog(context: context, builder:(context) =>SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _name,
          ),
        ),
        TextButton(onPressed: (){
          if (_name.text.isNotEmpty){
            FirebaseAuth.instance.currentUser?.updateDisplayName(_name.text.trim()).then((value) {
              setState(() {
                name = FirebaseAuth.instance.currentUser!.displayName!;
              });
            });
          }
          Navigator.pop(context);
        }, child: Text("Save")),
      ],
    ));
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
        backgroundColor: Color(0xff0a0a0a),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 15),
              alignment: Alignment.center,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 65,
                    backgroundImage: NetworkImage('https://picsum.photos/300'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:15),
                    child: Text(name==null?"":name!,style:TextStyle(color: Colors.white,fontSize: 20)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:15,bottom: 20),
                    child: Text(email==null?"":email!,style:TextStyle(color: Colors.white,fontSize: 15)),
                  ),
                  ElevatedButton(
                    onPressed: (){},
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: GestureDetector(
                          onTap: (){
                            name_dialog();
                          },
                          child: Text('Edit Name')),
                        ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff48bf53),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    width: MediaQuery.of(context).size.width/1.3,
                    height: MediaQuery.of(context).size.height/4,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)
                              ),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                              colors: [
                                Color(0xff02251f),
                                Color(0xff11823b),
                                Color(0xff48bf53),
                                Color(0xff91f009),
                              ]
                            )
                          ),
                            width:double.infinity,
                            height: 50,
                            child: Center(child: Text('Upgrade to Pro',style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),))),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            Divider(thickness: 2,color: Color(0x32a7a5a5),),
            ListTile(
              onTap: (){
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, "login");
              },
              leading: Icon(Icons.logout,color: Colors.white,),
              title:Text('Logout',style: TextStyle(color: Colors.white),),
            ),

            SizedBox(
              height: 30,
            )
          ],
        ),
      )],
    ));
  }
}