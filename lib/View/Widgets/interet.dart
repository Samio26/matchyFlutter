import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matchy/UTILS/hexColor.dart';
import 'package:matchy/View/Widgets/formation.dart';

class Interet extends StatefulWidget {
  const Interet({Key? key}) : super(key: key);
  @override
  _InteretState createState() => _InteretState();
}
class _InteretState extends State<Interet> {
  TextEditingController textController = new TextEditingController();
  List<String> list = [];
  List<String> objectifs=[];
  bool embauch=false,trouver=false,trouvAssoc=false,investir=false,trouverInves=false,DevelopperBuisnes=false,recrFreelance=false,
  TrouverFree=false,Amis=false,inspi=false;

  Future addInfo()async{
    await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).set({
      "interests":list,
      "objectifs":objectifs,
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
        title: Text(
          "Vos objectifs",
          style: GoogleFonts.baloo2(
         textStyle: TextStyle(fontSize: 18,color:HexColor("#2F76BB"),fontWeight: FontWeight.bold),)
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27.0),
          child: ListView(
            children: [
              SizedBox(
                height: 25,
              ),
              Text(
                "Vos centres d'intérets",
                style: GoogleFonts.baloo2(
              textStyle: TextStyle(fontSize: 18,color:HexColor("#6F6F6F"),fontWeight: FontWeight.bold),)
              ),
              Text(
                "Quels sont vos centres d'intérets professionnels et personnels.",
                style: GoogleFonts.baloo2(
              textStyle: TextStyle(fontSize: 12,color:HexColor("#303030"),fontWeight: FontWeight.w400),)
              ),
              SizedBox(height: 12),
              Form(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: HexColor("#C0C0C0"))),         
                        hintText: "Saisissez un centre d'intéret",
                        hintStyle: TextStyle(color: Colors.grey),
                        suffix: InkWell(
                          onTap: () {
                            list.add(textController.text.toLowerCase());
                            textController.clear();
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          child: Text(
                            "Ajouter",
                            style: TextStyle(color:HexColor("#61BCA6")),
                          ),
                        )),
                  ),
                  Wrap(
                      spacing: 6.0,
                      children: List.generate(list.length, (index) {
                        return Chip(
                          label: Text(list[index]),
                          backgroundColor: Colors.grey.shade200,
                        );
                      })),
                  SizedBox(height: 40),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Ce que vous cherchez",
                      style: GoogleFonts.baloo2(
              textStyle: TextStyle(fontSize: 18,color:HexColor("#6F6F6F"),fontWeight: FontWeight.bold),)
              ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "En quoi la communauté peut-elle vous aider?",
                      style: GoogleFonts.baloo2(
              textStyle: TextStyle(fontSize: 12,color:HexColor("#303030"),fontWeight: FontWeight.w400),)
              ),
                  ),
                  SizedBox(height: 20),
                ],
              )),

              Row(
                children: [
                SvgPicture.asset("images/g.svg"),
                  SizedBox(width: 20),
                  Center(
                    child: Container(
                      padding:EdgeInsets.only(right: 5,left: 5) ,
                      decoration: BoxDecoration(
                        color: embauch?Colors.blue.shade100.withOpacity(.5):null,
                          borderRadius: BorderRadius.circular(8),
                          border:embauch?Border.all(width: 0,color: Colors.transparent)
                          :Border.all(width: 1, color:HexColor("#929292"))),
                    child: TextButton(child: Text("Embaucher",style: TextStyle(color: !embauch? HexColor("#929292"):HexColor("#2F76BB")),),onPressed: (){
                        print(objectifs.length);
                      if(   objectifs.length>4){
                        return null;
                      }else if(objectifs.length==3){
                        setState(() {
                        embauch=!embauch;
                        });
                      }else{
                                  setState(() {
          embauch=!embauch;
                        });
                      }
              
              
                       embauch? objectifs.add("Embaucher"):objectifs.remove("Embaucher");
                       objectifs.length>3?Get.snackbar("error", "maximnum 3"):null;
                      }),
                    ),
                  ),
                  SizedBox(width:5),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(
                           right: 5, left: 5),
                      decoration: BoxDecoration(
                        color: trouver?Colors.blue.shade100.withOpacity(.5):null,
                          borderRadius: BorderRadius.circular(8),
                          border:trouver?Border.all(width: 0,color: Colors.transparent): Border.all(width: 1, color: HexColor("#929292"))),
                      child: TextButton(child: Text("Trouver un job",style: TextStyle(color:!trouver? HexColor("#929292"):HexColor("#2F76BB")),),onPressed: (){
                        setState(() {
                          trouver=!trouver;
                        });
                       trouver? objectifs.add("trouver un Job"):objectifs.remove("trouver un Job");
                      }
                    ),
                  ),
                   ) ],
              ),
              SizedBox(height: 5),
              Center(
                child: Container(
                  padding:
                      EdgeInsets.only( right: 10, left: 10),
                  decoration: BoxDecoration(
                     color: trouvAssoc?Colors.blue.shade100.withOpacity(.5):null,
                      borderRadius: BorderRadius.circular(8),
                      border:trouvAssoc?Border.all(width: 0,color: Colors.transparent): Border.all(width: 1, color: HexColor("#929292"))),
                  child: TextButton(child: Text("Trouver des associeés",style: TextStyle(color:!trouvAssoc? HexColor("#929292"):HexColor("#2F76BB")),),onPressed: (){
                    setState(() {
                      trouvAssoc=!trouvAssoc;
                    });
                    trouvAssoc?objectifs.add("Trouver des associeés"):objectifs.remove("Trouver des associeés");
                  })
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                runSpacing: 4.0,
                spacing: 6.0,
                children: [
                  SvgPicture.asset("images/Groupe 413.svg"),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(
                           right: 10, left: 10),
                      decoration: BoxDecoration(
                        color: investir?Colors.blue.shade100.withOpacity(.5):null,
                          borderRadius: BorderRadius.circular(8),
                          border:investir?Border.all(width: 0,color: Colors.transparent): Border.all(width: 1, color: HexColor("#929292"))),
                      child:TextButton(child: Text("investir dans des projets",style: TextStyle(color:!investir? HexColor("#929292"):HexColor("#2F76BB")),),onPressed: (){
                       setState(() {
                          investir=!investir;
                       });
                        investir?objectifs.add("investir dans des projets"):objectifs.remove("investir dans des projets");
                      })
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(
                           right:10, left: 10),
                      decoration: BoxDecoration(
                        color: trouverInves?Colors.blue.shade100.withOpacity(0.5):null,
                          borderRadius: BorderRadius.circular(8),
                          border:trouverInves? Border.all(width: 0,color: Colors.transparent): Border.all(width: 1, color: HexColor("#929292"))),
                      child: TextButton(child: Text("Trouver des investisseur",style: TextStyle(color:!trouverInves?HexColor("#929292"):HexColor("#2F76BB")),),onPressed: (){
                      setState(() {
                      trouverInves=!trouverInves;
                      });
                       trouverInves? objectifs.add("Trouver des investisseur"):objectifs.remove("Trouver des investisseur");
                      })
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(
                        right: 10, left: 10),
                      decoration: BoxDecoration(
                        color: DevelopperBuisnes?Colors.blue.shade100.withOpacity(.5):null,
                          borderRadius: BorderRadius.circular(8),
                          border:DevelopperBuisnes?Border.all(width: 0,color: Colors.transparent): Border.all(width: 1, color:HexColor("#929292"))),
                      child: TextButton(child: Text("Développer mon buisness",style: TextStyle(color:!DevelopperBuisnes? HexColor("#929292"):HexColor("#2F76BB")),),onPressed: (){
                        setState(() {
                          DevelopperBuisnes=!DevelopperBuisnes;
                        });
                        DevelopperBuisnes? objectifs.add("Développer mon buisness"):objectifs.remove("Développer mon buisness");
                      })
                    ),
                  ),
                ],
              ),
              Wrap(
                runSpacing: 6.0,
                spacing: 6.0,
                children: [
               SvgPicture.asset("images/Groupe 414.svg"),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(
                           right: 10, left: 10),
                      decoration: BoxDecoration(
                        color: recrFreelance?Colors.blue.shade100.withOpacity(.5):null,
                          borderRadius: BorderRadius.circular(8),
                          border:recrFreelance?Border.all(width: 0,color: Colors.transparent): Border.all(width: 1, color:HexColor("#929292"))),
                      child: TextButton(child: Text("Recruter des freelancer",style: TextStyle(color:!recrFreelance? HexColor("#929292"):HexColor("#2F76BB")),),onPressed: (){
                        setState(() {
                          recrFreelance=!recrFreelance;
                        });
                       recrFreelance? objectifs.add("Recruter des freelancer"):objectifs.remove("Recruter des freelancer");
                      })
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(
                           right: 10, left: 10),
                      decoration: BoxDecoration(
                        color: TrouverFree?Colors.blue.shade100.withOpacity(.5):null,
                          borderRadius: BorderRadius.circular(8),
                          border:TrouverFree?Border.all(width: 0,color: Colors.transparent): Border.all(width: 1, color: HexColor("#929292"))),
                      child: TextButton(child: Text("Trouver des projets Freelance",style: TextStyle(color:!TrouverFree? HexColor('#929292'):HexColor("#2F76BB")),),onPressed: (){
                        setState(() {
                          TrouverFree=!TrouverFree;
                        });
                       TrouverFree? objectifs.add("Trouver des projets Freelance"):objectifs.remove("Trouver des projets Freelance");
                      })
                    ),
                  ),
                ],
              ),
              SizedBox(height: 45),
              GestureDetector(
                onTap: ()async{
                  if ((list.length==0)||(objectifs.length==0)){
                    Get.snackbar("Alert", "Ajouter vos centres d'interets et ton objectifs");
                  }else if(objectifs.length>3){
                  Get.snackbar("Alert", "Maximum 3 objectifs");
                  }else
                  
                  { await addInfo();
                  print(objectifs);
                  Get.to(()=>Parcours());}
                 
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
                  child: Text("Enregistrer et continuer",
                  style: GoogleFonts.baloo2(
                                textStyle: TextStyle(fontSize: 14,color:Colors.white,fontWeight: FontWeight.bold),)),
                  width: double.infinity,
                  height: 55,
                ),
              ),
              SizedBox(
                height: 28,
              )
            ],
          ),
        ),
      ),
    );
  }
}
