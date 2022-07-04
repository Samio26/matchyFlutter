import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matchy/UTILS/hexColor.dart';
import 'package:matchy/View/Signin.dart';


class UpdateProfile extends StatefulWidget {
  const UpdateProfile({ Key? key }) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  List Objectifs=[];
  List interests=[];
  String? image,nom,prenom,bio,poste,placejob,location,debut,fin,secteuractivite,diplome,niveau,annee;
  int? score;
  scoreProgress(){
    int progresscore=0;
    if(image!=null){
      progresscore=progresscore+50;
    }
     if(interests.length>2){
      progresscore=progresscore+30;
    }
    if(Objectifs.length>2){
      progresscore=progresscore+20;
    }if(image==null){
      progresscore=45;
    }
    return progresscore;
  }
  GetUser()async{
    await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value)async {
         image=await value.data()!["imgurll"];
         nom=await value.data()!["nom"];
         prenom=await value.data()!["prenom"];
        bio=await value.data()!["bio"];
        poste=await value.data()!["Poste"];  
        placejob=await value.data()!["placeJobb"];
        location=await value.data()!["Location"];
        debut=await value.data()!["dateDebut"];
        fin=await value.data()!["DateFin"];
        secteuractivite=await value.data()!["secteurActivite"];
        diplome=await value.data()!["diplome"];
        Objectifs=await value.data()!["objectifs"];
        interests=await value.data()!["interests"];
        niveau=await value.data()!["NiveauEduc"];
        annee=await value.data()!["anneeExperience"];
      
    });
    
     if(this.mounted){
        setState(() {
       
     });
     }
    
  }
  @override
  void initState() {
        super.initState();
GetUser();
scoreProgress();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
         actions: [
           IconButton(onPressed: ()async{
              await FirebaseAuth.instance.signOut();
        Get.offAll(()=>Login());
           }, icon: Image.asset("images/deconnexion.png"))
         ],
         leading: InkWell(
        onTap: (){
          Get.back();
        },
        child: SvgPicture.asset("images/Groupe 9908.svg",fit: BoxFit.scaleDown,)),
         title: 
  Text('Modifier le profile',style: GoogleFonts.baloo2(
  textStyle: TextStyle(fontSize: 16,color: HexColor("#2F76BB"),fontWeight: FontWeight.w600),
  ),
),
       centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
       ),
       body:ListView(
    children: [
       const SizedBox(height:50),
       Container(
         height: MediaQuery.of(context).size.height*1-0.2,
         decoration: BoxDecoration(color: HexColor("#3C88B5").withOpacity(0.07),
                       borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(50))),
         width: double.infinity,
         child: Column(
           children: [
             Container(
               height: 150,
               child: Stack(
                 overflow:Overflow.visible ,
                 children: [
                      
                          Positioned(
                              top: -51,
                              left: 0,
                              right: 0,
                              child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                     image: DecorationImage(image:image.toString().isEmpty||image==null?AssetImage("images/user.jpg") as ImageProvider:
               CachedNetworkImageProvider(image.toString()),fit: BoxFit.scaleDown),
                                  border: Border.all(
                                    width: 4,
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.blue.withOpacity(0.2),
                                        offset: Offset(0, 10))
                                  ],
                                  shape: BoxShape.circle,
                                  ),
                                    ),
                            ),
 Positioned(
   top: 55,
   right: MediaQuery.of(context).size.width*0.34,
   child: Container(alignment: Alignment.center,
     height: 28,width: 120,
   decoration: BoxDecoration(color: HexColor("#2F76BB"),
   borderRadius: BorderRadius.circular(20),
   ),
   child: InkWell(
     onTap: (() => print(scoreProgress())),
     child: Text("Complété a "+scoreProgress().toString()+"%",style: GoogleFonts.baloo2(
                 textStyle: TextStyle(fontSize: 14,color: HexColor("#FFFFFF"),fontWeight: FontWeight.w400),
                 ),),
   ),
   )),
                    Positioned(
                top:90,
                right: 0,
                left: 0,
                child: Column(
                children: [
                Text(nom.toString()+" "+prenom.toString(),style: GoogleFonts.baloo2(
               textStyle: TextStyle(fontSize: 16,color: HexColor("#303030"),fontWeight: FontWeight.w600),
               ),
             ),
             const SizedBox(height: 7),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Icon(Icons.location_on,size: 15,color: Colors.black),
                 Text(location.toString(),style: GoogleFonts.baloo2(
                   textStyle: TextStyle(fontSize: 16,color: HexColor("#303030"),fontWeight: FontWeight.w600),
                   ),
                 ),
               ],
             ),
                ],
                     )),
                     
              
               ]),
             ),
                          SizedBox(height: 15,),

              Padding(
                padding: EdgeInsets.only(left: 30,right: 50),
                child: Wrap(
                   children: [ 
                   SvgPicture.asset("images/bio.svg"),
                                     Text(bio.toString()),
                                     SvgPicture.asset("images/bio2.svg")
                           
                 ],),
              ),
             Divider(color: HexColor("#2F76BB26"),),
             Text("centres d'interets",style: GoogleFonts.baloo2(
               textStyle: TextStyle(fontSize: 16,color: HexColor("#303030"),fontWeight: FontWeight.w600),
               ),),
               const SizedBox(height: 18),
             Padding(
                 padding: EdgeInsets.symmetric(horizontal: 15),
                 child: Wrap(
                   runAlignment: WrapAlignment.spaceBetween,
                 children: [
                  for(int i=0;i<interests.length;i++)
                       Container(
                         margin: EdgeInsets.only(left: 5,right: 5,bottom: 5),
                         padding: EdgeInsets.all(5),
                         decoration:BoxDecoration(
                           border: Border.all(
                             color: HexColor("#2F76BB"),
                             width: 1.5
                           ),
                           borderRadius: BorderRadius.circular(8)
                         ),
                         child: Text(interests[i],style: GoogleFonts.baloo2(
                 textStyle: TextStyle(fontSize: 12,color: HexColor("#2F76BB"),fontWeight: FontWeight.w600),
                 )),
                 ),

                 ]),),
            Divider(color: HexColor("#2F76BB26"),),
 Text("Objectifs actuels",style: GoogleFonts.baloo2(
               textStyle: TextStyle(fontSize: 16,color: HexColor("#303030"),fontWeight: FontWeight.w600),
               ),),
               const SizedBox(height: 18),
             Padding(
                 padding: EdgeInsets.symmetric(horizontal: 15),
                 child: Wrap(
                   runAlignment: WrapAlignment.spaceBetween,
                 children: [
                  for(int i=0;i<Objectifs.length;i++)
                       Container(
                         margin: EdgeInsets.only(left: 5,right: 5,bottom: 5),
                         padding: EdgeInsets.all(5),
                         decoration:BoxDecoration(
                           border: Border.all(
                             color: HexColor("#2F76BB"),
                             width: 1.5
                           ),
                           borderRadius: BorderRadius.circular(8)
                         ),
                         child: Text(Objectifs[i],style: GoogleFonts.baloo2(
                 textStyle: TextStyle(fontSize: 12,color: HexColor("#2F76BB"),fontWeight: FontWeight.w600),
                 )),
                 ),

                 ]),),
                             Divider(color: HexColor("#2F76BB26"),),
Text("Expérience",style: GoogleFonts.baloo2(
               textStyle: TextStyle(fontSize: 16,color: HexColor("#303030"),fontWeight: FontWeight.w600),
               ),),
               const SizedBox(height: 18),
               Padding(
                 padding: EdgeInsets.symmetric(horizontal: 20),
                 child: ListView(
                   shrinkWrap: true,
                   physics: NeverScrollableScrollPhysics(),
                   children: [
                   Text("Expérience:" +annee.toString()+" ans",style: GoogleFonts.baloo2(
                 textStyle: TextStyle(fontSize: 14,color: HexColor("#303030"),fontWeight: FontWeight.w600),
                 ),),
                 SizedBox(height: 15),
                 Text("Mon secteur d'activité: "+secteuractivite.toString(),style: GoogleFonts.baloo2(
               textStyle: TextStyle(fontSize: 14,color: HexColor("#303030"),fontWeight: FontWeight.w600),
               ),),
                 SizedBox(height: 15),
                  Text("Niveau d'education: "+niveau.toString(),style: GoogleFonts.baloo2(
               textStyle: TextStyle(fontSize: 14,color: HexColor("#303030"),fontWeight: FontWeight.w600),
               ),),
               
                 ],),
                 
               )
           ],
         ),
           
       ),
       
]));
  }
}















/* Positioned(
                top:80,
                right: 0,
                left: 0,
                child: Column(
                children: [
                Text(nom.toString()+" "+prenom.toString(),style: GoogleFonts.baloo2(
               textStyle: TextStyle(fontSize: 16,color: HexColor("#303030"),fontWeight: FontWeight.w600),
               ),
             ),
             
                ],
                     )),
                     /*Positioned(
               top: 110,
               left: MediaQuery.of(context).size.width*.38, 
                child: Text(poste.toString()+"@"+placejob.toString())),*/
               Positioned(
                 top: 170,
                 left: MediaQuery.of(context).size.width*0.1,
                 child: Wrap(
                   children: [ 
                   SvgPicture.asset("images/bio.svg"),
                                     SizedBox(width:240 ,child: Text(bio.toString())),
                                     SvgPicture.asset("images/bio2.svg")
             
               ],),
               ),
                Positioned(top: 250,child: Container(width: MediaQuery.of(context).size.width*1,height: 2,
                color:HexColor("#3C88B5").withOpacity(0.1))),
                Positioned(top: 255,left: MediaQuery.of(context).size.width*0.33,child: Text("centres d'interets",style: GoogleFonts.baloo2(
               textStyle: TextStyle(fontSize: 16,color: HexColor("#303030"),fontWeight: FontWeight.w600),
               ),
             )),
                  Positioned(
                    top: 285,
                    child: SizedBox(
               width: MediaQuery.of(context).size.width,
               child: Padding(
                 padding: EdgeInsets.symmetric(horizontal: 8),
                 child: Wrap(
                 children: [
                  for(int i=0;i<interests.length;i++)
                       Container(
                         margin: EdgeInsets.only(left: 5,right: 5,bottom: 5),
                         padding: EdgeInsets.all(5),
                         decoration:BoxDecoration(
                           border: Border.all(
                             color: HexColor("#2F76BB"),
                             width: 1.5
                           ),
                           borderRadius: BorderRadius.circular(8)
                         ),
                         child: Text(interests[i],style: GoogleFonts.baloo2(
                 textStyle: TextStyle(fontSize: 12,color: HexColor("#2F76BB"),fontWeight: FontWeight.w600),
                 ))),]),
               ),
                    ),
                  ),
                Positioned(top: 362,child: Container(width: MediaQuery.of(context).size.width*1,height: 2,
                color:HexColor("#3C88B5").withOpacity(0.1))),
                 Positioned(top: 370,left: MediaQuery.of(context).size.width*0.33,child: Align(
                   alignment: Alignment.center,
                   child: Text("Objectifs actuels",style: GoogleFonts.baloo2(
                   textStyle: TextStyle(fontSize: 16,color: HexColor("#303030"),fontWeight: FontWeight.w600),
                   ),
                 ),
                 )),
                 Positioned(
                   top: 400,
                   left: 30,
                   child: Wrap(
                     spacing: 10,
                     children: [
                   for(int i=0;i<Objectifs.length;i++)
                   Container(
                     padding: EdgeInsets.all(5),
                     decoration:BoxDecoration(
                       border: Border.all(
                         color: HexColor("#2F76BB"),
                         width: 1.5
                       ),
                       borderRadius: BorderRadius.circular(8)
                     ),
                     child: Text(Objectifs[i],style: GoogleFonts.baloo2(
                   textStyle: TextStyle(fontSize: 12,color: HexColor("#2F76BB"),fontWeight: FontWeight.w600),
                   ))),]
                   )
                 ),
                Positioned(top: 495,child: Container(width: MediaQuery.of(context).size.width*1,height: 2,
                color:HexColor("#3C88B5").withOpacity(0.1))), 
                 Positioned(top: 510,left: MediaQuery.of(context).size.width*0.38,child: Text("Expérience",style: GoogleFonts.baloo2(
                 textStyle: TextStyle(fontSize: 16,color: HexColor("#303030"),fontWeight: FontWeight.w600),
                 ),
                 )),
                  Positioned(top: 550,left: MediaQuery.of(context).size.width*.075,child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text:
                                            "Expérience: ",
                                        style: GoogleFonts.baloo2(
                 textStyle: TextStyle(color: HexColor("#303030"),fontSize: 14,fontWeight: FontWeight.w600),
               ),),
                                    TextSpan(
                                        text:annee==null?"Quelles Sont votre nombres d'expériences?":annee.toString()+" ans"
                                            ,
                                        style: GoogleFonts.baloo2(
                 textStyle: TextStyle(color: HexColor("#303030").withOpacity(0.5),fontSize: 14,fontWeight: FontWeight.w600), 
                                            )
                              )])),
                 ),
                Positioned(top: 580,left: MediaQuery.of(context).size.width*.075,child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text:
                                            "Mon secteur d'activité: ",
                                        style: GoogleFonts.baloo2(
                 textStyle: TextStyle(color: HexColor("#303030"),fontSize: 14,fontWeight: FontWeight.w600),
               ),),
                                    TextSpan(
                                        text:secteuractivite==null?"Quel est votre secteur?":
                                            secteuractivite.toString(),
                                        style: GoogleFonts.baloo2(
                 textStyle: TextStyle(color: HexColor("#303030").withOpacity(0.5),fontSize: 14,fontWeight: FontWeight.w600), 
                                            )
                              )])),
                 ),
                  Positioned(top: 610,left: MediaQuery.of(context).size.width*.075,child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text:
                                            "Niveau Education: ",
                                        style: GoogleFonts.baloo2(
                 textStyle: TextStyle(color: HexColor("#303030"),fontSize: 14,fontWeight: FontWeight.w600),
               ),),
                                    TextSpan(
                                        text:niveau==""?"Quel est votre Niveau?":
                                            niveau.toString(),
                                        style: GoogleFonts.baloo2(
                 textStyle: TextStyle(color: HexColor("#303030").withOpacity(0.5),fontSize: 14,fontWeight: FontWeight.w600), 
                                            )
                              )])),
                 ),
                  Positioned(top: 640,left: MediaQuery.of(context).size.width*.075,child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text:
                                            "Formation: ",
                                        style: GoogleFonts.baloo2(
                 textStyle: TextStyle(color: HexColor("#303030"),fontSize: 14,fontWeight: FontWeight.w600),
               ),),
                                    TextSpan(
                                        text:diplome==""?"Quel est votre Formation?":
                                            diplome.toString(),
                                        style: GoogleFonts.baloo2(
                 textStyle: TextStyle(color: HexColor("#303030").withOpacity(0.5),fontSize: 14,fontWeight: FontWeight.w600), 
                                            )
                              )])),
                 ),*/