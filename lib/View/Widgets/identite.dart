import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matchy/UTILS/hexColor.dart';
import 'package:matchy/View/Widgets/interet.dart';
class identite extends StatefulWidget {
  const identite({Key? key}) : super(key: key);
  @override
  _identiteState createState() => _identiteState();
}

class _identiteState extends State<identite> {
  int? selected = 0;
  XFile? imageFile;
  var bio,nomm,prenomm,imgUrll;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  Future UploadPhoto()async{
   if(imageFile!=null){
     await storage.ref('Users/${imageFile!.name}').putFile(File(imageFile!.path));
     
imgUrll=await storage.ref('Users/${imageFile!.name}').getDownloadURL();

   }else{
     print("ff");
   }   
  }
  Future addInfoUser()async{
    await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).set({
 "nom":nomm,
 "prenom":prenomm,
 "bio":bio,
 "imgurll":imgUrll,
 "etat":selected,
},SetOptions(merge: true));
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: ()async=>false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: ListView(
            children: [
              Center(
                  child: Text(
                "Votre identité",
                style: GoogleFonts.baloo2(
                                  textStyle: TextStyle(fontSize: 18,color: HexColor("#2F76BB"),fontWeight: FontWeight.bold),)
              )),
              SizedBox(height: 40),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(image:
                         imageFile==null?AssetImage("images/user.jpg"):FileImage(File(imageFile!.path)) as ImageProvider,fit: BoxFit.cover),
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
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                              
                           showModalBottomSheet(context: context, builder: (context)=>BottomSheet(context));
      
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.lightBlue, width: 2),
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.camera_alt_sharp,
                              color: Colors.blue,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Moi",
                        style: GoogleFonts.baloo2(
                                  textStyle: TextStyle(fontSize: 18,color: HexColor("#2F76BB"),fontWeight: FontWeight.bold),)
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        onSaved: (val){
                          prenomm=val;
                        },
                        validator: (val){
                          if(val!.isEmpty){
                            return "Voulez Vous saisir votre prenom";
                          }
                        },
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: HexColor("#C0C0C0"))),
                          hintText: "Prénom",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onSaved: (val){
                          nomm=val;
                        },
                        validator: (val){
                          if(val!.isEmpty){
                       return "Voulez Vous saisir votre nom";
                          }
                        },
                        decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: HexColor("#C0C0C0"))),
                          hintText: "Nom",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 25),
                      Text(
                        "Bio",
                        style: GoogleFonts.baloo2(
                                  textStyle: TextStyle(fontSize: 18,color: HexColor("#2F76BB"),fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        onSaved: (val){
                          bio=val;
                        },
                        validator: (val){
                          if(val!.isEmpty){
                            return "Voulez vous saisir une courte description";
                          }
                        },
                        decoration: InputDecoration(
                                             focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: HexColor("#C0C0C0"))),
       
                            hintText: "Ajouter une courte description",
                            hintStyle: TextStyle(color: Colors.grey)),
                        maxLength: 250,
                      ),
                      Text(
                        "Je suis",
                        style: GoogleFonts.baloo2(
                                  textStyle: TextStyle(fontSize: 18,color: HexColor("#2F76BB"),fontWeight: FontWeight.bold),)
                      ),
                      SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            selected == 0 || selected == 2
                                ? OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        selected = 1;
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 20,
                                          bottom: 20,
                                          right: 10,
                                          left: 10),
                                      child: Text(
                                        "Professionel",
                                        style: TextStyle(color:HexColor("#2F76BB")),
                                      ),
                                    ))
                                : OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                        backgroundColor: HexColor("#2F76BB")),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 20,
                                              bottom: 20,
                                              right: 10,
                                              left: 10),
                                          child: Text(
                                            "Professionel",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        Icon(Icons.check_outlined,
                                            color: Colors.white)
                                      ],
                                    )),
                            selected == 0 || selected == 1
                                ? OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        selected = 2;
                                      });
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            top: 20,
                                            bottom: 20,
                                            right: 20,
                                            left: 20),
                                        child: Text(
                                          "Etudiant",
                                          style: TextStyle(color: HexColor("#2F76BB")),
                                        )))
                                : OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                        backgroundColor: HexColor("#2F76BB")),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 20,
                                              bottom: 20,
                                              right: 20,
                                              left: 20),
                                          child: Text(
                                            "Etudiant",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        Icon(Icons.check_outlined,
                                            color: Colors.white),
                                      ],
                                    ),                                                                                                                            
                                  ),
                          ]),
                      SizedBox(height: 25),
                      GestureDetector(
                        onTap: ()async{
                          _formkey.currentState!.save();
                          if(_formkey.currentState!.validate()){
                    showDialog(
                                    context: context, builder: (_)=>Dialog(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0.0,
                                    insetPadding: EdgeInsets.symmetric(horizontal: 70,vertical: 200),
                                    child: Center(child:CircularProgressIndicator()),));     
                                    await UploadPhoto();                  
                                   addInfoUser();
                                  Get.to(()=>Interet());
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                         decoration: BoxDecoration( gradient: LinearGradient(colors: [
                                             HexColor("#54AAAB"),
                                            HexColor("#3C88B5"),
                                            ],
                                            
                                            ),
                                            borderRadius: BorderRadius.circular(6)
                                            ),
                                            
                            child: Text("Enregistrer et continuer",
                            style:  GoogleFonts.baloo2(
                                  textStyle: TextStyle(fontSize: 14,color:Colors.white,fontWeight: FontWeight.bold),),),
                            height: 55,
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final PickedFile = await picker.pickImage(source: source,imageQuality: 85);
    setState(() {
      if(PickedFile!=null){
      imageFile = XFile(PickedFile.path);
    }else{
      print("nothing selceted");
    }
    
    }); 
  }
final firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;
  Widget BottomSheet(BuildContext context) {
    return Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Text(
              "Choisir la photo de profile",
              style: GoogleFonts.baloo2(
                      textStyle: TextStyle(fontSize: 14,color:HexColor("#2F76BB"),fontWeight: FontWeight.bold),)
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton.icon(
                    onPressed: () async {
                      takePhoto(ImageSource.camera);
                      
                    },
                    icon: Icon(Icons.camera,color: HexColor("#2F76BB")),
                    label: Text("Camera",style: GoogleFonts.baloo2(
                      textStyle: TextStyle(fontSize: 14,color:HexColor("#2F76BB"),fontWeight: FontWeight.bold),),)),
                FlatButton.icon(
                    onPressed: () async {
                      takePhoto(ImageSource.gallery);
                    },
                    icon: Icon(Icons.image,color: HexColor("#2F76BB"),),
                    label: Text("Gallerie",style:GoogleFonts.baloo2(
                      textStyle: TextStyle(fontSize: 14,color:HexColor("#2F76BB"),fontWeight: FontWeight.bold),),) ,),
              ],
            )
          ],
        ));
  }
}
