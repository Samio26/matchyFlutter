import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matchy/View/Widgets/message.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../UTILS/hexColor.dart';



class Sante extends StatefulWidget {
  const Sante({ Key? key }) : super(key: key);

  @override
  State<Sante> createState() => _SanteState();
}

class _SanteState extends State<Sante> {
  final controllerr=SwipableStackController();
  List Matches=[];
  List DLike=[];
  List Like=[];
  String? currentNom,nn,image;
   Timer? timer;
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
   void SanteExplore() async {
   try{
     int count = 0;
  var user = FirebaseAuth.instance.currentUser;
  var db = await FirebaseFirestore.instance.collection('Users').get();
  int index = db.docs.indexWhere((element) => element.data()['email'] == user!.email);
  await FirebaseFirestore.instance.collection('Users').where("secteurActivite",isEqualTo: "Santé" )
  .get().then((val) {
    setState(() {  });
         for (var i = 0; i < val.docs.length; i++) {
           if(val.docs[i].data()["id"]!=user!.uid){
             if ((!val.docs[index].data()["DLike"].contains(val.docs[i].data()["email"]))&&
          (!val.docs[index].data()["Like"].contains(val.docs[i].data()["email"])
          )){
            count++;
           }}
           if(count>=1){
           Matches.add(val.docs[i].data());
           }
           count=0;
         }  
 });
  if(this.mounted){
    setState(() {
    
  });
  }
  

   }catch(e){
print(e);
   }
 }
 GetUser()async{
       await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value)async {
    currentNom=value.data()!["nom"];
    image=value.data()!["imgurll"];
    
       });
 }
  @override
  void initState() {
  super.initState();
   GetUser();

    timer = new Timer.periodic(Duration(seconds: 2), (Timer t) =>   SanteExplore());
 
  }
  @override
void dispose() {
  timer!.cancel();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Matches.length<1? Scaffold(body: Center(child: CircularProgressIndicator.adaptive())):Scaffold(
   
 body:  SafeArea(
   child: Padding(
        padding: EdgeInsets.only(top:50,left: 15,right: 15,bottom: 15),
        child: SwipableStack( 
          builder: (ctx,proprietes){
          
           return ListView(
             children: [
               ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: SingleChildScrollView(
          child: Column(
                children: [
                  Card(
                    color: HexColor("#e2ecf5"),
                    shadowColor:HexColor("#e2ecf5") ,
                    child: ListView(
                      shrinkWrap:true,
                      physics: BouncingScrollPhysics(),
                    children: [
                     Container(
                       height: MediaQuery.of(context).size.height*0.35,
                       child: Stack(children: [
                    Container(decoration: BoxDecoration( image: DecorationImage(
                                          image:Matches[proprietes.index]["imgurll"]==null? AssetImage("images/user.jpg") 
                                          as ImageProvider: CachedNetworkImageProvider(Matches[proprietes.index]["imgurll"]),
                                          fit: BoxFit.fill)),
                    child: Container(
                    decoration: BoxDecoration(
                     gradient: LinearGradient(colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.3)
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.bottomRight
                    )
                    ),    
                    ),
                    ),
                 
                     Positioned(
                   left: 30,
                   bottom: 70,
                   child: 
  Text(Matches[proprietes.index]["prenom"]+" "+Matches[proprietes.index]["nom"],style: GoogleFonts.baloo2(
                     textStyle: TextStyle(fontSize: 20,color: HexColor("#FFFFFF"),fontWeight: FontWeight.bold),
                     )),
                   ),
                 Positioned(
                   left: 30,
                   bottom: 50,
                   child:  Text(Matches[proprietes.index]["experience"][0]["Poste"]+" Chez " +Matches[proprietes.index]["experience"][0]["placeJobb"],style: GoogleFonts.baloo2(
                     textStyle: TextStyle(fontSize: 14,color: HexColor("#FFFFFF"),fontWeight: FontWeight.w400),
                     )),
                 ),
                      Positioned(
                   left: 30,
                   bottom: 30,
                   child: Row(
                     children: [
                       Icon(Icons.location_on,size: 15,color: HexColor('#FFFFFF'),),
                       const SizedBox(width: 3),
                     Matches[proprietes.index]["Location"]==null?Text(""):  Text(Matches[proprietes.index]["Location"],style: GoogleFonts.baloo2(
                         textStyle: TextStyle(fontSize: 14,color: HexColor("#FFFFFF"),fontWeight: FontWeight.w400),
                         )),
                     ],
                   ),
                 ),
                       ],),
                     ),
                      SizedBox(height: 20),
                     Padding(
                       padding: EdgeInsets.symmetric(horizontal: 30),
                       child: Wrap(
                         children: [
                   for(int i=0;i<Matches[proprietes.index]["interests"].length;i++)
                   Container(
                     margin: EdgeInsets.symmetric(horizontal: 5),
                     padding: EdgeInsets.all(5),
                     decoration:BoxDecoration(
                       border: Border.all(
                         color: HexColor("#2F76BB"),
                         width: 1.5
                       ),
                       borderRadius: BorderRadius.circular(8)
                     ),
                     child: Text(Matches[proprietes.index]["interests"][i],style: GoogleFonts.baloo2(
                       textStyle: TextStyle(fontSize: 12,color: HexColor("#2F76BB"),fontWeight: FontWeight.w600),
                       ))                   )]
                       )
                     ),
                     Divider(thickness: 1.0,),
                     SizedBox(height: 7),
                     Center(child: Column(
                       children: [
                  Text("Objectifs actuels",style: GoogleFonts.baloo2(
                   textStyle: TextStyle(fontSize: 16,color: HexColor("#303030"),fontWeight: FontWeight.w600),
                   ),
                  ), 
                  const SizedBox(height: 6), 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:8.0),
                    child: Wrap(
                      runSpacing: 5,
                      children: [              
                     for(int i=0;i<Matches[proprietes.index]["objectifs"].length;i++)
                     Container(
                       padding: EdgeInsets.all(5),
                       margin: EdgeInsets.symmetric(horizontal: 5),
                       decoration:BoxDecoration(
                         border: Border.all(
                           color: HexColor("#2F76BB"),
                           width: 1.5
                         ),
                         borderRadius: BorderRadius.circular(8)
                       ),
                       child: Text(Matches[proprietes.index]["objectifs"][i],style: GoogleFonts.baloo2(
                     textStyle: TextStyle(fontSize: 12,color: HexColor("#2F76BB"),fontWeight: FontWeight.w600),
                     ))),]),
                  ),
                         SizedBox(height: 15),
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal:38.0),
                           child: Wrap(
                             children: [
                           SvgPicture.asset("images/bio.svg"),
                               SizedBox(width:240 ,child: Text(Matches[proprietes.index]["bio"])),
                               SvgPicture.asset("images/bio2.svg"),
                             ],
                           ),
                         ),             
                       ],
                     ),
                      ),
                      Divider(thickness: 1.0,),
                      SizedBox(height: 10),
                      Center(child: Text("Expérience",style: GoogleFonts.baloo2(
                   textStyle: TextStyle(fontSize: 16,color: HexColor("#303030"),fontWeight: FontWeight.w600),
                   ),
                  ),),
                      SizedBox(height: 12),
                     Padding(
                       padding: EdgeInsets.symmetric(horizontal: 20),
                       child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(children: [
                                TextSpan(
                                    text:
                                        "Expérience: ",
                                    style: GoogleFonts.baloo2(
                         textStyle: TextStyle(color: HexColor("#303030"),fontSize: 14,fontWeight: FontWeight.w600),
                       ),),
                                TextSpan(
                                    text:                        
                                  Matches[proprietes.index]["anneeExperience"]==null?"":Matches[proprietes.index]["anneeExperience"]+" ans",

                                    style: GoogleFonts.baloo2(
                         textStyle: TextStyle(color: HexColor("#303030").withOpacity(0.5),fontSize: 14,fontWeight: FontWeight.w600), 
                                        )
                          )])),
                     ),
                      SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: [
                                TextSpan(
                                    text:
                                        "Secteur d'activité: ",
                                    style: GoogleFonts.baloo2(
                      textStyle: TextStyle(color: HexColor("#303030"),fontSize: 14,fontWeight: FontWeight.w600),
                    ),),
                                TextSpan(
                                    text:
                                       Matches[proprietes.index]["secteurActivite"],
                                    style: GoogleFonts.baloo2(
                      textStyle: TextStyle(color: HexColor("#303030").withOpacity(0.5),fontSize: 14,fontWeight: FontWeight.w600), 
                                        )
                          )])),
                  ),
                       SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: [
                                TextSpan(
                                    text:
                                        "Formation: ",
                                    style: GoogleFonts.baloo2(
              textStyle: TextStyle(color: HexColor("#303030"),fontSize: 14,fontWeight: FontWeight.w600),
            ),),
                                TextSpan(
                                    text:
                                        Matches[proprietes.index]["diplome"],
                                    style: GoogleFonts.baloo2(
              textStyle: TextStyle(color: HexColor("#303030").withOpacity(0.5),fontSize: 14,fontWeight: FontWeight.w600), 
                                        )
                          )])),
          ),
                              SizedBox(height: 50,),
                        
                           
                  ],          
                    ),
                  ),
                ],
          ),
        ),
          ),
             ],
           );
        },itemCount: Matches.length,
        allowVerticalSwipe: false,
          onSwipeCompleted: (index,direction){
            if(direction==SwipeDirection.right){
               Like.add(Matches[index]["email"]);
                 FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).update({
                  "Like":FieldValue.arrayUnion(Like),
                 });
                 
               if(Matches[index]["Like"].contains(FirebaseAuth.instance.currentUser!.email)){
                     showDialog(context: context, builder: (context)=>Dialog(
                                    insetPadding: EdgeInsets.symmetric(horizontal: 70,vertical: 200),
                                    backgroundColor:Colors.transparent,
                                    elevation: 0.0,
                                    child: Column(children: [
Text("Congratulations!",style: GoogleFonts.baloo2(
                     textStyle: TextStyle(fontSize: 20,color: HexColor("#FFFFFF"),fontWeight: FontWeight.w600),
                     )),
                     SizedBox(height: 20),
                    Stack(
                       overflow: Overflow.visible,
                       children: [
          CircleAvatar(radius: 45,backgroundImage:image==null?AssetImage("images/user.jpg")as ImageProvider :
          CachedNetworkImageProvider(image.toString())
),
 Positioned(
   top: 5,
   left: 35,
   child: CircleAvatar(radius: 45,backgroundImage:Matches[index]["imgurll"]==null?AssetImage("images/user.jpg")as ImageProvider :
   CachedNetworkImageProvider(Matches[index]["imgurll"])
 ),
 ),
                     ],),
                     SizedBox(height: 24),
                     Text("Vous et "+Matches[index]["nom"]+" souhaitez discuter N'attendez plus...",textAlign: TextAlign.center,style: GoogleFonts.baloo2(
                     textStyle: TextStyle(fontSize: 16,color: HexColor("#FFFFFF"),fontWeight: FontWeight.w500),
                     )),
                     
                     SizedBox(height: 30),
      
                    ],),
                                  ));
               }
            }
                 
            
           if(direction==SwipeDirection.left){
               DLike.add(Matches[index]["email"]);
                  FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).update({
                   "DLike":FieldValue.arrayUnion(DLike)
                  });
                  
           }
          },
          
        controller:controllerr,
        swipeAssistDuration:Duration(milliseconds: 50) ,
          swipeAnchor: SwipeAnchor.bottom
        ),
      ),

 ),   
   floatingActionButton: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      SizedBox(width: 10,),
      FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(
          Icons.replay_outlined
        ),
        onPressed: ()async{
                  controllerr.rewind();
                 
        },
        heroTag: "h",
      ),
         FloatingActionButton.large(
        backgroundColor: Colors.red,
        child: Icon(
          Icons.favorite
        ),
        onPressed: () {
        controllerr.next(swipeDirection: SwipeDirection.right);
        },
        heroTag: "k",
      ),
      FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.clear_outlined
        ),
        onPressed: () {
                  controllerr.next(swipeDirection: SwipeDirection.left);

        },
        heroTag: "t",
      )
    ]
  )  
    );
  }
}

