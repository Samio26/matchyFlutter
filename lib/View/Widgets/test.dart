
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:swipable_stack/swipable_stack.dart';

import '../../UTILS/hexColor.dart';
import 'message.dart';
class Test extends StatefulWidget {
   Test({ Key? key }) : super(key: key);

  @override
  State<Test> createState() => _MatchyCardState();
}

class _MatchyCardState extends State<Test> {
      final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

final controllerr=SwipableStackController();
List Matches=[];
List Like=[];
  String? currentNom,nn,image;

List DLike=[];
GetUser()async{
       await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value)async {
            currentNom=value.data()!["nom"];
            image=value.data()!["imgurll"];
         
       });
 }

 createChatRoom(String id,[nomUser])async{
   String chatId= getChatRoomId(id, FirebaseAuth.instance.currentUser!.uid);
    List<String> Users=[id,FirebaseAuth.instance.currentUser!.uid];
         FirebaseFirestore.instance.collection("ChatRoom").doc(chatId).set({
           "users":Users,
           "chatRoomid":chatId,
            "nomMsg":nomUser
         },SetOptions(merge: true));

  }
   getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) >= b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
 
 Future matchUserInterests() async {
   try{
     int count = 0;
  var user = FirebaseAuth.instance.currentUser;
  var db = await FirebaseFirestore.instance.collection('Users').get();

  int index = db.docs.indexWhere((element) => element.data()['email'] == user?.email);
  await FirebaseFirestore.instance.collection('Users').get().then((val) {
    setState(() {
      
    });
   
    for (var i = 0; i < val.docs.length; i++) {
      for (var j = 0; j < val.docs[i].data()['interests'].length; j++) {
        if (i != index) {
          if ((val.docs[i].data()['interests'].contains(val.docs[index].data()['interests'][j]))&&
          (!val.docs[index].data()["DLike"].contains(val.docs[i].data()["email"]))&&
          (!val.docs[index].data()["Like"].contains(val.docs[i].data()["email"])
          )||
          
          ((val.docs[i].data()['Location'].contains(val.docs[index].data()['Location']))&&
          (!val.docs[index].data()["DLike"].contains(val.docs[i].data()["email"]))&&
          (!val.docs[index].data()["Like"].contains(val.docs[i].data()["email"]))) ){
        count++;
        } 
      }
      } 
    if (count >= 1) {
  return  Matches.add(val.docs[i].data());
          } 
                count = 0;
  }
  });
  if(this.mounted){
    setState(() {
    
  });
  }
   }catch(e){

   }
 }
@override
  void initState() {
        super.initState();
    this.GetUser();
  this.matchUserInterests();
  }


   bool? change;

  @override
  Widget build(BuildContext context) {

    return   Scaffold(
      key: _scaffoldKey,
      body:FutureBuilder(
        future: matchUserInterests(),
        builder:(context,snapshot){
      return snapshot.hasData? ListView.builder(
        itemCount:(snapshot.data! as dynamic).docs.length,
        itemBuilder:(context,index){
     return Text((snapshot.data! as dynamic).docs[index]["nom"]);
         }):CircularProgressIndicator(); }),
    );
  }
}