import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matchy/View/B2B.dart';
import 'package:matchy/View/Etudiant.dart';
import 'package:matchy/View/ExploreSante.dart';
import 'package:matchy/View/entreprenurat.dart';
import 'package:matchy/View/updateProfile.dart';

import '../UTILS/hexColor.dart';
import 'Signin.dart';
import 'Widgets/TJob.dart';


class ExploreMatchy extends StatefulWidget {
  const ExploreMatchy({ Key? key }) : super(key: key);

  @override
  State<ExploreMatchy> createState() => _ExploreMatchyState();
}

class _ExploreMatchyState extends State<ExploreMatchy> {
  var image;
    GetUser()async{
    var value =await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).get();
     image= await value.data()!["imgurll"];
     if(this.mounted){
        setState(() {
       
     });
     }
    
  }
  @override
  void initState() {
GetUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     appBar:   AppBar(
      leadingWidth: 50,
    leading:InkWell(
      onTap:(){
        Get.to(()=>UpdateProfile());
      },
      child: Container(margin: EdgeInsets.only(left: 10),decoration: BoxDecoration(shape: BoxShape.circle,
      image: DecorationImage(image:image.toString().isEmpty||image==null?AssetImage("images/user.jpg") as ImageProvider:
       CachedNetworkImageProvider(image.toString()),fit: BoxFit.cover))),
    ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: InkWell(onTap: (){
      },child: Container(padding: EdgeInsets.only(top: 10),child: SvgPicture.asset("images/Groupe 9900.svg",height:30))),
      centerTitle:true
      ), 
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 15),
      child: ListView(children: [
      const  SizedBox(height: 20),
        Text("Bienvenue Sur Matchy Explore",
        style: GoogleFonts.baloo2(
                    textStyle: TextStyle(fontSize: 15,color:HexColor("#2F76BB"),fontWeight: FontWeight.w600))),
        const SizedBox(height: 10),
        Stack(
          children: [
            InkWell(
              onTap: (){
                Get.to(()=>EsEtudiant());
              },
              child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.asset("images/etudiant.png",fit:BoxFit.fill,
              width: MediaQuery.of(context).size.width*0.9,height: 185,)),
            ),
            Positioned(bottom: 15,left: 20,child: Text("Espace Etudiants",style: 
            TextStyle(fontWeight: FontWeight.w600,color: Colors.white,fontSize: 15,fontFamily: "Questrial"),))
          ],
        ),
        const SizedBox(height: 15),
        Row(children: [
          Stack(
            children: [
              InkWell(onTap: (){
                Get.to(()=>B2B());
              },child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.asset("images/B2B.png",fit: BoxFit.fill,width: MediaQuery.of(context).size.width*0.45,height: 170,))),
              Positioned(bottom: 15,left: 15,child: Text("B2B",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white,fontSize: 15,fontFamily: "Questrial"),))
            ],
          ),

          const SizedBox(width:5),
          Stack(
            children: [
              InkWell(
                onTap: (){
                  Get.to(()=>Entreprenuriat());
                },
                child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.asset("images/entre.jpg",fit: BoxFit.fill,width: MediaQuery.of(context).size.width*0.45,height: 170,)
                ),
              ),
              Positioned(bottom: 15,left: 15,child: Text("Entreprenauriat",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white,fontSize: 15,fontFamily: "Questrial"),))

            ],
          )
        ],),
        const SizedBox(height: 15,),
        Row(children: [
           Stack(
            children: [
              InkWell(
                onTap: (){
                  Get.to(()=>TJob());
                },
                child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.asset("images/gff.png",fit: BoxFit.fill,width: MediaQuery.of(context).size.width*0.45,height: 170,)
                ),
              ),
              Positioned(bottom: 15,left: 15,child: Text("Trouver un job",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white,fontSize: 15,fontFamily: "Questrial"),))

            ],
          ),
          const SizedBox(width: 5,),
           Stack(
            children: [
              InkWell(
                onTap: (){
                  Get.to(()=>Sante());
                },
                child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.asset("images/sante.jpg",fit: BoxFit.fill,width: MediaQuery.of(context).size.width*0.45,height: 170,)
                ),
              ),
              Positioned(bottom: 15,left: 15,child: Text("Santé",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white,fontSize: 15,fontFamily: "Questrial"),))

            ],
          )
        ],)
                 
      ]),
      ),
    );
  }
}