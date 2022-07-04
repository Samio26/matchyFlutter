import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matchy/View/Widgets/parcours.dart';

import '../../UTILS/hexColor.dart';


class Parcours extends StatefulWidget {
  const Parcours({ Key? key }) : super(key: key);

  @override
  _ParcoursState createState() => _ParcoursState();
}

class _ParcoursState extends State<Parcours> {
  TextEditingController diplomeController=new TextEditingController();
    TextEditingController universiteController=new TextEditingController();
Future addUserinfo()async{
 await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).set({
      "NiveauEduc":selected,
      "diplome":diplomeController.text,
      "universite":universiteController.text
  },SetOptions(merge: true));
}
  String? selected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: InkWell(
        onTap: (){
          Get.back();
        },
        child: SvgPicture.asset("images/Groupe 9908.svg",fit: BoxFit.scaleDown,)),
          title: Text("Formation",style: GoogleFonts.baloo2(
         textStyle: TextStyle(fontSize: 18,color:HexColor("#2F76BB"),fontWeight: FontWeight.bold),),),
          centerTitle: true,
      ),
      body: Container(child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
      child:ListView(children: [
        SizedBox(height: 45),
       Text("Niveau d'éducation",style:
       GoogleFonts.baloo2(
              textStyle: TextStyle(fontSize: 18,color:HexColor("#6F6F6F"),fontWeight: FontWeight.bold),)),
       SizedBox(height: 20),
     DropdownButtonFormField(hint: Text("Choisir votre niveau formation",style: TextStyle(color: HexColor("#C4C4C4")),),
     decoration: InputDecoration(                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: HexColor("#C0C0C0"))),
),
     items: ["Baccalauréat ou inférieur","BAC+2","Licence(BAC+3)","Master(BAC+5)","Doctorat ou équivalent"].map((e) => DropdownMenuItem(child: Text("$e"),value: e,)).toList(),
     onChanged: (val){
setState(() {
  selected=val  as String;
});
     },
     )  ,
     SizedBox(height: 40),
      Text("Formation",style:  GoogleFonts.baloo2(
              textStyle: TextStyle(fontSize: 18,color:HexColor("#6F6F6F"),fontWeight: FontWeight.bold),) ),
      SizedBox(height: 20,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(universiteController.text,softWrap: true,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600,fontFamily: "Questrial",fontSize: 20),)),
          IconButton(onPressed: (){

         universiteController.text.isEmpty?null: showModalBottomSheet(
        isScrollControlled: true,context: context, builder: ((builder)=>Bottom()));
          },
          icon: Icon(Icons.edit,color: universiteController.text.isEmpty?Colors.grey.shade400: Colors.blue,))
        ],
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(diplomeController.text,style:TextStyle(color: Colors.black87,fontWeight: FontWeight.w500))),
      SizedBox(height: 20,),
     TextFormField(
                       readOnly: true,
                       decoration: InputDecoration(hintText: "Ajouter votre formation",
                   focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: HexColor("#C0C0C0"))),                    
                       hintStyle: TextStyle(color: HexColor("#C4C4C4")),
                       suffixIcon: IconButton(onPressed: (){
                         showModalBottomSheet(isScrollControlled: true,context: context, builder: ((builder)=>Bottom()));
                       },icon: Icon(Icons.add,color: Colors.grey,),)
                       ),
                     ),
     SizedBox(height: 230),
     GestureDetector(
       onTap: ()async{
         if(selected==null||diplomeController.text.isEmpty||universiteController.text.isEmpty){
           Get.snackbar("Error", "Veuillez Vous saisir votre niveau d'education et votre Formation");
         }else{
         await addUserinfo();
         Get.to(()=>Parcours1());
       }},
       child: Container(decoration: BoxDecoration(
         gradient:  LinearGradient(colors: [
                                            HexColor("#54AAAB"),
                                            HexColor("#3C88B5"),
                                            ],
                                            
                                            ),
                                            borderRadius: BorderRadius.circular(6)
                                            
                    
       ),alignment: Alignment.center,child: Text("Enregistrer et continuer",
       style:GoogleFonts.baloo2(
        textStyle: TextStyle(fontSize: 14,color:Colors.white,fontWeight: FontWeight.bold),),),width: double.infinity,height: 55,),
     ),
      ],) ,
      ),
      ),
    );
  }
Widget Bottom(){
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height*0.93),
          Row(
            children: [
              SizedBox(width:10 ),
              InkWell(onTap: (){
                Get.back();
              },child: Icon(Icons.close)),
              SizedBox(width: MediaQuery.of(context).size.width*0.25),
              Text("Ajouter une formation",style:GoogleFonts.baloo2(
                    textStyle: TextStyle(fontSize: 14,color:HexColor("#2F76BB"),fontWeight: FontWeight.bold),) ,),
            ],
          ),
          SizedBox(height: 60),
          Container(height: MediaQuery.of(context).size.height*1,
          width: MediaQuery.of(context).size.width,
          padding:
                  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  decoration: BoxDecoration(color:  HexColor("#3C88B5").withOpacity(0.07),borderRadius: BorderRadius.only(topRight: Radius.circular(35),topLeft: Radius.circular(35))),
           child:Form(
             child:
       SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                     children: [
                       SizedBox(height: 75),
                       Align(alignment: Alignment.topLeft,child: Text("École*",style: 
              GoogleFonts.baloo2(
              textStyle: TextStyle(fontSize: 16,color:HexColor("#737373"),fontWeight: FontWeight.bold)))),
                        TextFormField(
                          maxLength: 150,
                          controller: diplomeController,
                                      validator: (val) =>
                                          val!.isEmpty ? "* Obligatoire!" : null,
                                      autocorrect: true,
                                      textCapitalization: TextCapitalization.words,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6),
                                               borderSide: BorderSide(color:HexColor('#C0C0C0'),
                                            width: 0.7)),
                                            focusedBorder:OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6),
                                               borderSide: BorderSide(color:HexColor('#C0C0C0'),
                                            width: 0.7)), 
                                          hintText: 'Ex:Institut supérieur des beaux arts Sousse',
                                          hintStyle: TextStyle(
                                            color: HexColor("#A0A0A0")
                                          ),
                                        ),
                                    ),
                                 SizedBox(height:15),
                                 Align(alignment: Alignment.topLeft,child: Text("Diplome*",style: 
              GoogleFonts.baloo2(
              textStyle: TextStyle(fontSize: 16,color:HexColor("#737373"),fontWeight: FontWeight.bold)))),
                                   TextFormField(
                                     maxLength: 100,
                                      controller: universiteController,
                                      validator: (val) =>
                                          val!.isEmpty ? "* Obligatoire!" : null,
                                      autocorrect: true,
                                      textCapitalization: TextCapitalization.words,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
    
                                            borderRadius: BorderRadius.circular(6),
                                               borderSide: BorderSide(color:HexColor('#C0C0C0'),
                                            width: 0.7)),
                                            focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6),
                                               borderSide: BorderSide(color:HexColor('#C0C0C0'),
                                            width: 0.7)),
                                          hintText: 'EX:Licence',
                                          hintStyle: TextStyle(
                                            color: HexColor("#A0A0A0")
                                          ),
                                        ),
                                    ),
                                 SizedBox(height: 20),
                                 GestureDetector(
                                   onTap: (){
                                    Get.back();
    
                                   },
                                   child: Container(
                                     alignment: Alignment.center,
                                     decoration: BoxDecoration(
                                       gradient: LinearGradient(colors: [
                                                      HexColor("#54AAAB"),
                                            HexColor("#3C88B5"),
                                                    ],
                                                    
                                                    ),
                                                    borderRadius: BorderRadius.circular(6)
                                                    ),
                                     
                                     width: double.infinity-90,
                                     height: 55,                                             
                                   child: Text("Ajouter",style: 
              GoogleFonts.baloo2(
              textStyle: TextStyle(fontSize: 14,color:Colors.white,fontWeight: FontWeight.bold)))),
                                 )
                     ],
                         ),
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}