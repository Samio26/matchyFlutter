
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:matchy/View/Home.dart';
import 'package:matchy/View/Widgets/Security.dart';
import 'package:matchy/View/Widgets/identite.dart';

class AuthController{
 Stream<User?> get auth=>FirebaseAuth.instance.authStateChanges();
 User get user =>FirebaseAuth.instance.currentUser!;
  Future<bool> googleSignin(BuildContext context)async{
   bool res=false;
     try{
  final GoogleSignInAccount? user= await GoogleSignIn().signIn();
  final GoogleSignInAuthentication? Auth=await user?.authentication;
  final cred=GoogleAuthProvider.credential(
    accessToken: Auth?.accessToken,
    idToken: Auth?.idToken,
  );
  UserCredential userCredential= await FirebaseAuth.instance.signInWithCredential(cred);

 User? userr=userCredential.user;
 if(userr!=null){
   if(userCredential.additionalUserInfo!.isNewUser)
{
     Get.to(()=>identite());
  await FirebaseFirestore.instance.collection("Users").doc(userr.uid).set({
  "id":userr.uid,
  "email":userr.email,
  "nom":"",
  "prenom":"",
  "bio":"",
  "imgurll":"",
  "etat":0,
  "interests":[],
  "objectifs":[],
  "NiveauEduc":"",
  "diplome":"",
  "universite":"",
  "anneeExperience":"",
  "secteurActivite":"",
  "Location":null,
  "Like":[],
  "DLike":[],
  });
}
else{
Get.to(()=>FingerPrint());

}
 res=true;
 }
     }on FirebaseException catch(e){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message!)));
    res=false;
     }
     return res;
   }
   void signout()async{
     try{
  FirebaseAuth.instance.signOut();
     }catch(e){

     }
   }
 }