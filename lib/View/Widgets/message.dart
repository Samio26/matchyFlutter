
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:matchy/UTILS/hexColor.dart';
import 'package:matchy/View/Widgets/bottomNavBar.dart';
import 'package:matchy/services/userService.dart';
import 'package:random_string/random_string.dart';

import '../ChatScreen.dart';


class Messagest extends StatefulWidget {
   Messagest( {this.photoss,this.nomm,this.chatRoomid}) ;
String? photoss;
String? nomm,chatRoomid;


  @override
  State<Messagest> createState() => _MessagesState();
}

class _MessagesState extends State<Messagest> {
TextEditingController MessageControl=new TextEditingController();
String? msgid="";
var nom,image;
 bool? sendByMe;
Future getUserinfo()async{
 var collec=  await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).get();
  nom=await collec.data()!["nom"];
  image=await collec.data()!["imgurll"];
  }
sendMsg(bool sendClicked)async{
  String message=MessageControl.text;
  if(MessageControl.text.isNotEmpty){

  Map<String,dynamic> msgInfoMap= {
      "Message":message,
      "SendBy":FirebaseAuth.instance.currentUser!.uid,
      "Time":DateTime.now().millisecondsSinceEpoch
    };
    if(msgid==""){
      msgid=randomAlphaNumeric(12);
    }
    FirestoreUser().addMessage(widget.chatRoomid.toString(), msgid, msgInfoMap).then((value) {
    Map<String,dynamic> lastmsginfoMap={
   "lastMessage":message,
      "timeSend":DateTime.now(),
      "photoUrl":widget.photoss,
      "nom":widget.nomm
    };
    FirestoreUser().updateLastmsg(widget.chatRoomid.toString(), lastmsginfoMap);
    });
    if(sendClicked){
MessageControl.text="";
    msgid="";
    }
    
  }
}
@override
  void dispose() {
MessageControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: InkWell(
          onTap: (){
            Get.back();
          },
          child: SvgPicture.asset("images/Groupe 9908.svg",fit: BoxFit.scaleDown,)),
        title: Row(children: [
         
        Text(widget.nomm.toString(),style: TextStyle(color: Colors.black),)
        ],),
      ),
      body: Column(
    
        children: [
          Expanded(
            child: Container(
    color: HexColor("#3C88B5").withOpacity(0.07),
              child: 
                 StreamBuilder(
                   stream: FirebaseFirestore.instance.collection("ChatRoom").doc(widget.chatRoomid)
                   .collection("chat").orderBy("Time",descending: true).snapshots(),
                   builder: (context,snapsot){
                   return snapsot.hasData? ListView.builder(
                      physics: BouncingScrollPhysics(),
                                   shrinkWrap: true,
                                   reverse: true,
                                   itemCount: (snapsot.data! as dynamic).docs.length,
                                   itemBuilder: (context,index){
                                   return Container(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: (snapsot.data! as dynamic).docs[index]["SendBy"]==FirebaseAuth.instance.currentUser!.uid ? 0 : 24,
          right: (snapsot.data! as dynamic).docs[index]["SendBy"]==FirebaseAuth.instance.currentUser!.uid ? 24 : 0),
      alignment: (snapsot.data! as dynamic).docs[index]["SendBy"]==FirebaseAuth.instance.currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: (snapsot.data! as dynamic).docs[index]["SendBy"]==FirebaseAuth.instance.currentUser!.uid
            ? EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(
            top: 13, bottom: 13, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: (snapsot.data! as dynamic).docs[index]["SendBy"]==FirebaseAuth.instance.currentUser!.uid ? BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
            ) :
            BorderRadius.only(
        topLeft: Radius.circular(23),
          topRight: Radius.circular(23),
          bottomRight: Radius.circular(23)),
          boxShadow: [
            BoxShadow(
             color: HexColor("#2F76BB3A"),
             blurRadius: 4.0,
             spreadRadius: 1.0,
             offset: Offset(0,4)
    
            )
          ],
            gradient: LinearGradient(
              colors: (snapsot.data! as dynamic).docs[index]["SendBy"]==FirebaseAuth.instance.currentUser!.uid ? [
                const Color(0xff007EF4),
                const Color(0xff2A75BC)
              ]
                  : [
                HexColor("#FFFFFF"),
                HexColor("FFFFFF")
              ],
            )
        ),
        child: Text((snapsot.data! as dynamic).docs[index]["Message"],
            textAlign: TextAlign.start,
            style: TextStyle(
            color: (snapsot.data! as dynamic).docs[index]["SendBy"]==FirebaseAuth.instance.currentUser!.uid? Colors.white:Colors.black,
            fontSize: 16,
            fontFamily: 'OverpassRegular',
            fontWeight: FontWeight.w300)),
      ),
    );
    }
    ):Container();
                    } )
                     
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            height: 80,
            child: Row(
            children: [
              IconButton(onPressed:(){
                sendMsg(true);
              } ,
               icon: Icon(Icons.send_outlined,color: Colors.blue,)),
              Expanded(
                child: TextFormField(
                  onFieldSubmitted: (v){
                    sendMsg(true);
                  },
                  
                  textInputAction: TextInputAction.send,
                  autocorrect: true,
                  enableSuggestions: true,
                 
                  controller: MessageControl,
                  decoration:InputDecoration(
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none),
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                    filled: true,fillColor: Colors.blue.shade100.withOpacity(.4),
                    hintText: "Ecrire Ici...",contentPadding: const EdgeInsets.only(bottom: 5,top: 5,left:20)),
                ),
              ),
          ],
        ),)
            ]    ,
      ),
    );
  }
}