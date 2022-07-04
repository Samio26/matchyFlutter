
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matchy/View/Widgets/message.dart';
import 'package:matchy/services/userService.dart';

import '../UTILS/hexColor.dart';



class Chat extends StatefulWidget {
   Chat({  Key? key}) ;
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var image;
  List Matchess=[];
  List result=[];
  String? currentNom,nn,profile="",x="",chatid,chatId;
  Stream? chat;
 void CheckMatches() async {
   try{
     int count = 0;
  var user = FirebaseAuth.instance.currentUser;
  var db = await FirebaseFirestore.instance.collection('Users').get();

  int index = db.docs.indexWhere((element) => element.data()['email'] == user?.email);
  await FirebaseFirestore.instance.collection('Users').get().then((val) {
    setState(() {
      
    });
   
    for (var i = 0; i < val.docs.length; i++) {
      for (var j = 0; j < val.docs[i].data()['Like'].length; j++) {
        if(i!=index){
          if (val.docs[i].data()['Like'].contains(user!.email)&&
          (val.docs[index].data()['Like'].contains(val.docs[i].data()["email"]))) {
            count++;
          }
      }}
    
    if(count>=1){
    Matchess.add(val.docs[i].data());
    }
    count=0;
    }
  });
  if(this.mounted){
    setState(() {
    
  });}

  for(int h=0;h<Matchess.length;h++){
  await  FirebaseFirestore.instance.collection("Matches")
    .doc(Matchess[h]["id"]).set({
    "photoUrl": Matchess[h]["imgurll"],
     "nom":Matchess[h]["nom"],
     "email":Matchess[h]["email"],
    });
  }

   }catch(e){
  print(e);
   }
 }
 
 GetUser()async{
       await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value)async {
            currentNom=value.data()!["nom"];
           image=value.data()?["imgUrll"];
       });
 }
 
  createChatRoom(String id,nomUser)async{
    chatId= getChatRoomId(id, FirebaseAuth.instance.currentUser!.uid);
    List<String> Users=[id,FirebaseAuth.instance.currentUser!.uid];
    Map<String,dynamic> chatRoomInfomap={
      "users":Users,
      "nomMsg":nomUser
    };
       await  FirestoreUser().createChatRoom(chatId.toString(), chatRoomInfomap);

  }
   getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) >= b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
  
Delete()async{
  FirebaseFirestore.instance.collection("Matches").get().then((value) => {
      for(DocumentSnapshot ds in value.docs){
             ds.reference.delete()
      }
  });
}

@override
  void initState() {
    this.GetUser();
  
   this.CheckMatches();
    super.initState();
  }  
@override
  void dispose() {
    Delete();
    super.dispose();
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: InkWell(onTap: (){
        print(Matchess);
      },child: Container(padding: EdgeInsets.only(top: 10),child: SvgPicture.asset("images/Groupe 9900.svg",height: 30,))),
      elevation: 0.0,
      leadingWidth:65,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      ),
      body: SingleChildScrollView(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        SizedBox(height: 25,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text("Noveaux Matches",textAlign: TextAlign.left,style:
             GoogleFonts.baloo2(
                    textStyle: TextStyle(fontSize: 18,color:HexColor("#2F76BB"),fontWeight: FontWeight.w600)),),
          ),
        ),
        const SizedBox(height: 15,),
        Container(
color: HexColor("#3C88B5").withOpacity(0.07),
          height: 135,child: 
           ListView.builder(
             itemCount:Matchess.length,
            addAutomaticKeepAlives: false,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context,index){
               return Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
             const SizedBox(height: 5),
           GestureDetector(
             onTap: ()async{
                             nn=Matchess[index]["nom"];
                           
  x=  getChatRoomId(Matchess[index]["id"],FirebaseAuth.instance.currentUser!.uid);
 print(x);
 chatid=x!.replaceAll(FirebaseAuth.instance.currentUser!.uid, "").replaceAll("_", "");
 print(chatid);
   QuerySnapshot Queryy=await FirestoreUser().getUserInfo(chatid.toString());
                            setState(() {                      
                            });
                              createChatRoom(Matchess[index]["id"],nn.toString()+ "_"+currentNom.toString());

  Navigator.push(context, MaterialPageRoute(
      builder: (context) => Messagest(
    chatRoomid: getChatRoomId(Matchess[index]["id"], FirebaseAuth.instance.currentUser!.uid),
   photoss: Matchess[index]["imgurll"],
  nomm: Matchess[index]["nom"],
      )
    ));
             },
             child: Container(
               margin: EdgeInsets.only(top:15.0,left: 20),
               height: 80,
               width: 80,
               decoration: BoxDecoration(image: DecorationImage(
                 image:Matchess[index]["imgurll"]==null?AssetImage("images/user.jpg") as ImageProvider:
                  CachedNetworkImageProvider(Matchess[index]["imgurll"]),fit: BoxFit.cover),
                 borderRadius: BorderRadius.circular(5),    
                 ),),
           ),
           SizedBox(height: 6),
                 Text((Matchess[index]["nom"])),
                 ],
               );
           } ),),
        SizedBox(height: 25),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:22.0),
            child: Text("Messages",
            style:  GoogleFonts.baloo2(
                    textStyle: TextStyle(fontSize: 18,color:HexColor("#2F76BB"),fontWeight: FontWeight.w600))),
          )),
        SizedBox(height: 20),
         StreamBuilder(
           stream: FirebaseFirestore.instance.collection("ChatRoom").orderBy("timeSend",descending: true)
  .where("users",arrayContains: FirebaseAuth.instance.currentUser!.uid).snapshots(),
           builder: (context,snapshot){
               return snapshot.hasData? SizedBox(
                 height: MediaQuery.of(context).size.height*1,
                 child: ListView.builder(
                   itemCount: (snapshot.data as dynamic).docs.length,
                   itemBuilder: (context,index){
                    return Column(
                      children: [
                      GestureDetector(
                        onTap: (){
                          nn=Matchess[index]["nom"];                           
                          Navigator.push(context, MaterialPageRoute(
      builder: (context) => Messagest(
    chatRoomid: getChatRoomId(Matchess[index]["id"], FirebaseAuth.instance.currentUser!.uid),
    photoss: (snapshot.data as dynamic).docs[index]["photoUrl"],
    nomm: (snapshot.data! as dynamic).docs[index]["nomMsg"].toString().replaceAll(currentNom.toString(), "").replaceAll("_", "")
      )
    ));
    setState(() {
      
    });
    },
                        child:ListTile(
                            leading: Container(height:60,width: 60,decoration: BoxDecoration(shape: BoxShape.circle,
                          image: DecorationImage(image: (snapshot.data! as dynamic).docs[index]["photoUrl"]==null||
                          (snapshot.data! as dynamic).docs[index]["photoUrl"].toString().isEmpty? AssetImage("images/user.jpg") as ImageProvider:
                           CachedNetworkImageProvider((snapshot.data! as dynamic).docs[index]["photoUrl"]!),fit: BoxFit.cover))),
                           
                                 title:Text((snapshot.data! as dynamic).docs[index]["nomMsg"].toString().replaceAll(currentNom.toString(), "").replaceAll("_", "")),         
                       subtitle:Text((snapshot.data! as dynamic).docs[index]["lastMessage"]),
                          ),
                      ),
                        Divider()
                      ],
                    );
                 
                 }),
               ):Center(child: CircularProgressIndicator.adaptive());  
         })
      ],),
      ),
    );
  }
}