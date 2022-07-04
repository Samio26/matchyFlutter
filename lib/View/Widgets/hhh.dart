import 'dart:collection';
import 'dart:ui';
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';

import '../../UTILS/hexColor.dart';



class card extends StatefulWidget {
   card({ Key? key }) : super(key: key);

  @override
  State<card> createState() => _cardState();
}

class _cardState extends State<card> {
final swipeTrigger=BehaviorSubject<double>();
List Matches= [];
List Like=[];
List DLike=[];
void matchUserInterests() async {
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
          
          (val.docs[i].data()['Location'].contains(val.docs[index].data()['Location']))&&
          (!val.docs[index].data()["DLike"].contains(val.docs[i].data()["email"]))&&
          (!val.docs[index].data()["Like"].contains(val.docs[i].data()["email"]))) {
        count++;
        }
      }
      } 
    if (count >= 1) {
   Matches.add(val.docs[i].data());
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
  matchUserInterests();
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding: EdgeInsets.all(15),
        child: Stack(    
           children: List.generate(Matches.length,(index)=>
             InkWell(
               onTap: (){
                 print(Matches);
               },
               child: Swipable(
                 animationCurve: Curves.easeInOutCubicEmphasized,
                 threshold: 0.5,
                  onSwipeLeft:(Offset){
                    DLike.add(Matches[index]["email"]);
                    FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).update({
                     "DLike":FieldValue.arrayUnion(DLike)
                    });
                    
                    Matches.remove(Matches[index]);
                  
                 print(Matches);
                 setState(() {
                   
                 });
                 },
                 onSwipeRight: (Offset){
                   Like.add(Matches[index]["email"]);
                   FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).update({
                    "Like":FieldValue.arrayUnion(Like),
                   });
                   Matches.remove(Matches[index]);
                   setState(() {
                     
                   });
                 },
                 verticalSwipe: false,
                swipe:swipeTrigger.stream,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          color: HexColor("#FAFAFA"),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: ListView(
                            shrinkWrap: true,                    
                            physics: BouncingScrollPhysics(),
                          children: [
                           Container(
                             height: MediaQuery.of(context).size.height*0.35,
                             child: Stack(children: [
      Container(decoration: BoxDecoration(image: DecorationImage(image:Matches[index]["imgurll"]==null? AssetImage("images/user.jpg") as ImageProvider:
      
      CachedNetworkImageProvider(Matches[index]["imgurll"]),fit: BoxFit.cover)),
      
                          child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 3,sigmaY: 3),
      
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
      
                          ),),
      
                          ),
                         Positioned(
                           bottom: 120,
                           right: MediaQuery.of(context).size.width*0.3,
                           child: Container(
                                        width: 110,
                                        height: 130,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1.5,
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                  spreadRadius: 1,
                                                  blurRadius: 10,
                                                  color: Colors.black.withOpacity(0.1),
                                                  offset: Offset(0, 10))
                                            ],
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
      image:Matches[index]["imgurll"]==null? AssetImage("images/user.jpg") as ImageProvider 
      :CachedNetworkImageProvider(Matches[index]["imgurll"]),
                                                fit: BoxFit.fill)),
                                      ),
                         ),
                           Positioned(
                         left: MediaQuery.of(context).size.width*0.3,
                         bottom: 100,
                         child: InkWell(onTap: (){
                           print(Matches.length);
                         },child: Text(Matches[index]["nom"]==null? Text("")  :Matches[index]["nom"]+" "+Matches[index]["prenom"],
                         style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20),))),
                      Positioned(bottom: 75,left:MediaQuery.of(context).size.width*0.25,
                         child: Text(Matches[index]["Poste"]==""? "":Matches[index]["Poste"]+" chez "+Matches[index]["placeJobb"] ,
                         style: TextStyle(color: Colors.white,fontSize: 15),)),
                       Positioned(bottom:40 ,left: MediaQuery.of(context).size.width*0.27,child: Wrap(children: [
                          Icon(Icons.location_on,color: Colors.white,),
                          Container(),
                          Text(Matches[index]["Location"],style: TextStyle(color: Colors.white),)
                        ],))
                             ],),
                           ),
                            
                           Padding(
                             padding: EdgeInsets.symmetric(horizontal: 30),
                             child: Wrap(
                               spacing: 6.0,
                               runSpacing: 0.0,
                               children: [
                                 for(int i=0;i<Matches[index]["interests"].length;i++)
                              Chip(label: Text("#"+Matches[index]["interests"][i].toString(),style:TextStyle(color: Colors.blue)))                          
                               ]
                            ),
                           ),
                           Divider(thickness: 1.0,),
                           SizedBox(height: 10),
                           Center(child: Column(
                             children: [
                               Text("Objectif actuels",style:
                    GoogleFonts.baloo2(
                      textStyle: TextStyle(fontSize: 18,color:HexColor("#303030"),fontWeight: FontWeight.w600),)),                             
                      for(int i=0;i<Matches[index]["objectifs"].length;i++)
                               Chip(label: Text(Matches[index]["objectifs"][i].toString(),style: TextStyle(color: Colors.blue),)),
                               SizedBox(height: 15),
                               Padding(
                                 padding: const EdgeInsets.symmetric(horizontal:38.0),
                                 child: Text("♣ "+Matches[index]["bio"]+" ♣",softWrap: true,style: TextStyle(fontFamily: "Questrial",fontSize:15),
                                                          )                           ),             
                             ],
                           ),
                            ),
                            Divider(thickness: 1.0,),
                            SizedBox(height: 10),
            Center(child: GestureDetector(
              onTap: (){
                setState(() {
                                  swipeTrigger.add(math.pi);

                });
              },
              child: Text("Expérience",style: GoogleFonts.baloo2(
                        textStyle: TextStyle(fontSize: 18,color:HexColor("#303030"),fontWeight: FontWeight.w600))),
            )),
                            SizedBox(height: 12,),
          Text("\t\t\t\t\t\t\t\t\Expérience:",style:  GoogleFonts.baloo2(
                      textStyle: TextStyle(fontSize: 18,color:HexColor("#303030"),fontWeight: FontWeight.w600))),
Matches[index]["dateFin"]==null?Text(""):
Text("\t\t\t\t\t\t\t\t\t\t"+"${Matches[index]["dateDebut"]}"+"/"+"${Matches[index]["DateFin"]}"
                            ,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15,fontFamily: "Questrial",color: HexColor("#6F6F6F"))),
                            SizedBox(height: Matches[index]["secteuractivite"]==null? 0:15),
                            Matches[index]["secteuractivite"]==null? Text(""):
                            Text( "\t\t\t\t\t\t\t\t\Mon secteur d'activité:",style: 
                            GoogleFonts.baloo2(
                      textStyle: TextStyle(fontSize: 18,color:HexColor("#303030"),fontWeight: FontWeight.w600)),),
                          SizedBox(height:Matches[index]["secteuractivite"]==null? 0:8),
                                Text(
                                 Matches[index]["secteuractivite"]==null?"": "${Matches[index]["secteuractivite"]}",softWrap: false,
                                 style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15,fontFamily: "Questrial",color: HexColor("#6F6F6F")),),
                             SizedBox(height: Matches[index]["secteuractivite"]==null? 0:15),
                         Matches[index]["diplome"]==""? Text("")   :  
                         Text("\t\t\t\t\t\t\t\t\Formations:",style: 
                          GoogleFonts.baloo2(
                      textStyle: TextStyle(fontSize: 18,color:HexColor("#303030"),fontWeight: FontWeight.w600))),
                            SizedBox(height: 8),
                            Text("\t\t\t\t\t\t\t\t"+Matches[index]["diplome"],softWrap: false,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15,fontFamily: "Questrial"),),
                        SizedBox(height: 50,),
                      
                        ],          
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                   
                 ),
             ),
           
         )),
      ));
        } 

  }
  











