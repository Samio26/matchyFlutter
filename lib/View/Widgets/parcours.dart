import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:matchy/View/Widgets/regles.dart';

import '../../UTILS/hexColor.dart';

class Parcours1 extends StatefulWidget {
  const Parcours1({Key? key}) : super(key: key);
  @override
  _ParcoursState createState() => _ParcoursState();
}

class _ParcoursState extends State<Parcours1> {
  String? selected;
  String? selected1;
  DateTime dateDebut = new DateTime.now();
  DateTime dateFin = new DateTime.now();
  List Experience=[];
  Map<String,dynamic> details={};
                                       
  TextEditingController PosteController = new TextEditingController();
  TextEditingController ChezController = new TextEditingController();
  Future addUserInfo()async{
    await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).set({
      "anneeExperience":selected,
      "secteurActivite":selected1,
    },SetOptions(merge: true));
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
        title: Text("Parcours professionnel",
            style: GoogleFonts.baloo2(
         textStyle: TextStyle(fontSize: 18,color:HexColor("#2F76BB"),fontWeight: FontWeight.bold),)),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              SizedBox(height: 35),
              Text(
                "Combien d'années",
                style: GoogleFonts.baloo2(
              textStyle: TextStyle(fontSize: 18,color:HexColor("#6F6F6F"),fontWeight: FontWeight.bold),)
              ),
              Text("d'expérience avez-vous",
                  style: GoogleFonts.baloo2(
              textStyle: TextStyle(fontSize: 18,color:HexColor("#6F6F6F"),fontWeight: FontWeight.bold),)),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
      decoration: InputDecoration(focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: HexColor("#C0C0C0"))),
),
                hint: Text("Nombre d'année",style: TextStyle(color: HexColor("#C4C4C4")),),
                items: ["1", "+2", "+5", "+7", "+10"]
                    .map((e) => DropdownMenuItem(
                          child: Text("$e"),
                          value: e,
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selected = val as String;
                  });
                },
              ),
              SizedBox(height: 25),
              Text("Secteur d'activité",
                  style: GoogleFonts.baloo2(
              textStyle: TextStyle(fontSize: 18,color:HexColor("#6F6F6F"),fontWeight: FontWeight.bold),)),
              SizedBox(height: 10),
              DropdownButtonFormField(
decoration: InputDecoration(focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: HexColor("#C0C0C0"))),
),
                hint: Text("Choisir votre secteur d'activité",style: TextStyle(color: HexColor("#C4C4C4")),),
                items: ["Santé", "Finance", "IT"]
                    .map((e) => DropdownMenuItem(
                          child: Text("$e"),
                          value: e,
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selected1 = val as String;
                  });
                },
              ),
              SizedBox(height: 25),
              Text("Expérience",
                  style: GoogleFonts.baloo2(
              textStyle: TextStyle(fontSize: 18,color:HexColor("#6F6F6F"),fontWeight: FontWeight.bold),)),
                      SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap:true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: Experience.length,
                        itemBuilder:(context,index)
                      { 
                      return Container(
                        height: 60,
                        child: ListView(
                          children:[
                                    SingleChildScrollView(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                        child:  Text(Experience[index]["Poste"],
                  style: GoogleFonts.baloo2(
              textStyle: TextStyle(fontSize: 14,color:HexColor("#61BCA6"),fontWeight: FontWeight.bold),)),
                                          ),
                                         
                                       /*   IconButton(
                        onPressed: () {
                                                                   Experience[index]["Poste"]==""  ?null:   showModalBottomSheet(
                                                      isScrollControlled: true,
                      
                              context: context, builder: ((builder) => bottom()));
                        },
                        icon: Icon(Icons.edit, color: Experience[index]["Poste"]==""? Colors.grey.shade300: Colors.blue),
                                          )*/
                                        ],
                                      ),
                                    ),
                                    Text(Experience[index]["placeJobb"],
                  style: GoogleFonts.baloo2(
              textStyle: TextStyle(fontSize: 14,color:HexColor("#303030"),fontWeight: FontWeight.bold),)),
                                   /* SizedBox(height: 10),
                                    Text(
                                      "${dateDebut.day}/${dateDebut.month}/${dateDebut.year}-${dateFin.day}/${dateFin.month}/${dateFin.year}",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 20, fontFamily: "Questrial"),
                                    )*/]),
                      );}),
              SizedBox(height: 25),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: HexColor("#C0C0C0"))),
                    hintText: "Ajouter une expérience",
                    hintStyle: TextStyle(color: HexColor("#C4C4C4")),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add,color: Colors.grey,),
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                            context: context, builder: ((builder) => bottom()));
                      },
                    )),
              ),
              SizedBox(height: 180),
              GestureDetector(
                onTap: ()async{
                  if(selected==null||selected1==null){
                    Get.snackbar("Error", "Veuillez vous Saisir Votre années d'expériences et votre secteur?");
                  
                  }else if(Experience.isEmpty){
                    Get.snackbar("Error", "Veuillez vous saisir une expérience profesionnelle");
                  }else{
                  await addUserInfo();
                    Get.to(() => Regles());
                }},
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
                  child: Text("Terminer",style: GoogleFonts.baloo2(
        textStyle: TextStyle(fontSize: 14,color:Colors.white,fontWeight: FontWeight.bold),),),
                  width: double.infinity,
                  height: 55,
                 
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
  
  Widget bottom() {
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
              Text("Ajouter une Expérience",style:GoogleFonts.baloo2(
                    textStyle: TextStyle(fontSize: 14,color:HexColor("#2F76BB"),fontWeight: FontWeight.bold),) ,),
            ],
          ),
          SizedBox(height: 60),
    Container(
height: MediaQuery.of(context).size.height*1,
    width: MediaQuery.of(context).size.width,
    padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  decoration: BoxDecoration(color: HexColor("#3C88B5").withOpacity(0.07),borderRadius: BorderRadius.only(topRight: Radius.circular(35),topLeft: Radius.circular(35))),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                                children: [
                                  const SizedBox(height: 75),
                                   Align(alignment: Alignment.topLeft,child: Text("Poste",style: 
              GoogleFonts.baloo2(
              textStyle: TextStyle(fontSize: 16,color:HexColor("#737373"),fontWeight: FontWeight.bold)))),
                                  TextFormField(
                                      controller: PosteController,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6),
                                               borderSide: BorderSide(color:HexColor('#C0C0C0'),
                                            width: 0.7)),
                        hintText: "EX:Web Developer",
                        hintStyle: TextStyle(color: Colors.grey),border: OutlineInputBorder())),
                                  SizedBox(height: 20),
                                   Align(alignment: Alignment.topLeft,child: Text("Chez",style: 
              GoogleFonts.baloo2(
              textStyle: TextStyle(fontSize: 16,color:HexColor("#737373"),fontWeight: FontWeight.bold)))),
                                  TextFormField(
                                    controller: ChezController,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6),
                                               borderSide: BorderSide(color:HexColor('#C0C0C0'),
                                            width: 0.7)),
                                        hintText: "EX:DOT-IT", hintStyle: TextStyle(color: Colors.grey),
                                        border:OutlineInputBorder() ),
                                  ),
                                 SizedBox(height: 20),
                                  Align(alignment: Alignment.topLeft,child: Text("Date de début",style: 
              GoogleFonts.baloo2(
              textStyle: TextStyle(fontSize: 16,color:HexColor("#737373"),fontWeight: FontWeight.bold)))),
                                  TextFormField(
                                    onTap: ()async{
                        DateTime? newDate1 = await showDatePicker(
                        context: context,
                        initialDate: dateDebut,
                        firstDate: DateTime(1990),
                        lastDate: DateTime.now(),
                                        );
                                        if (newDate1 == null) return;
                                        setState(() {
                        dateDebut = newDate1;
                                        });
                                    },
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.calendar_month),
                                      hintText: "Date",hintStyle: TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder()
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                   Align(alignment: Alignment.topLeft,child: Text("Date de fin",style: 
              GoogleFonts.baloo2(
              textStyle: TextStyle(fontSize: 16,color:HexColor("#737373"),fontWeight: FontWeight.bold)))),
                                TextFormField(
                                    onTap: ()async{
 DateTime? newDate2 = await showDatePicker(
                        context: context,
                        initialDate: dateFin,
                        firstDate: DateTime(1990),
                        lastDate: DateTime.now(),
                                        );
                        if (newDate2 == null) return;
                        setState(() {
                         dateFin =newDate2;
                                        });
                                    },
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.calendar_month),
                                      hintText: "Date",hintStyle: TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder()
                                    ),
                                  ),
                                      SizedBox(height:30),
                                       GestureDetector(
                                   onTap: ()async{
         details={
"dateDebut":Jiffy(dateDebut).format("MMM do yyyy"),
  "dateFin":dateFin==DateTime.now()?"1":Jiffy(dateFin).format("MMM do yyyy"),
   "Poste":PosteController.text,
   "placeJobb":ChezController.text, 
                                       };
                                       Experience.add(details);
                                       PosteController.clear();
                                       ChezController.clear();
                       await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).set({
                         "experience":Experience
                       },SetOptions(merge: true));
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
                                               textStyle: TextStyle(fontSize: 14,color:Colors.white,fontWeight: FontWeight.bold),),),                           ),
                                 )
                                ],
                              ),
                      ),
                    ),
    )]
    )
    );
  }
}
