import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class QuizPage extends StatefulWidget {
  QueryDocumentSnapshot data;
  QuizPage({required this.data});
  @override
  State<QuizPage> createState() => _QuizPageState(data: data);
}

class _QuizPageState extends State<QuizPage> {
  QueryDocumentSnapshot data;
  int _sel_index = -1 ;
  Text mess = Text("");
  _QuizPageState({required this.data});
  check_ans(String ans){
    print(data.get("correct"));
    if (data.get("correct").toString().toLowerCase() == ans.toLowerCase()){
      setState(() {
        mess = Text("Absolutely Correct !",style: TextStyle(color: Colors.green,fontSize: 25),);
      });
    }
    else{
      mess = Text("Looks like its wrong !",style: TextStyle(color: Colors.red,fontSize: 25),);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(data.id),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
          backgroundColor: Color(0xff0a0a0a)
      ),
      backgroundColor: Color(0xff0a0a0a),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                        width: MediaQuery.of(context).size.width,
                        child: Text(data.get("question"),style: TextStyle(color:Colors.white,fontSize: 28,fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                )
            ),
            Expanded(child: mess),
            Expanded(
                flex: 7,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              _sel_index = 0 ;
                            });
                            check_ans(data.get("first"));
                          },
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width/1.1,
                            decoration: BoxDecoration(
                              color: _sel_index==0?Color(0xff395999):Color(0xff202538),
                              border: Border.all(
                                  color: Color(0xff395999),
                                  width: 4
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                              child: Text(data.get("first"),style: TextStyle(fontSize: 20,color: Colors.white,),),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              _sel_index = 1 ;
                            });
                            check_ans(data.get("second"));
                          },
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width/1.1,
                            decoration: BoxDecoration(
                              color: _sel_index==1?Color(0xff395999):Color(0xff202538),
                              border: Border.all(
                                  color: Color(0xff395999),
                                  width: 4
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(25)),

                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                              child: Text(data.get("second"),style: TextStyle(fontSize: 20,color: Colors.white,),),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              _sel_index = 2 ;
                            });
                            check_ans(data.get("third"));
                          },
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width/1.1,
                            decoration: BoxDecoration(
                              color: _sel_index==2?Color(0xff395999):Color(0xff202538),
                              border: Border.all(
                                  color: Color(0xff395999),
                                  width: 4
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                              child: Text(data.get("third"),style: TextStyle(fontSize: 20,color: Colors.white,),),
                            ),
                          ),
                        ),
                      ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      _sel_index = 3 ;
                    });
                    check_ans(data.get("fourth"));
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width/1.1,
                    decoration: BoxDecoration(
                      color: _sel_index==3?Color(0xff395999):Color(0xff202538),
                      border: Border.all(
                          color: Color(0xff395999),
                          width: 4
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                      child: Text(data.get("fourth"),style: TextStyle(fontSize: 20,color: Colors.white,),),
                              ),
                            ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
