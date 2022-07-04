import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:matchy/View/Home.dart';
import 'package:matchy/View/Widgets/Security.dart';
import 'package:matchy/View/Widgets/bottomNavBar.dart';
import 'package:matchy/View/Widgets/identite.dart';

class LoginController extends GetxController {
  bool? obscure = false;
  Rxn<User> _user=Rxn<User>();
   get user=>_user.value?.email;

  
@override 
void onInit(){
  super.onInit();
  _user.bindStream(FirebaseAuth.instance.authStateChanges());
}

  FirebaseAuth _auth=FirebaseAuth.instance;
  String? email,pass;
  checkPass() {
    obscure = !obscure!;
    update();
  }
  void SignInEmailandPass()async{
try{
await _auth.signInWithEmailAndPassword(email:email!.trim(), password:pass!.trim());
Get.offAll(()=>FingerPrint());
}on FirebaseAuthException catch(e){
  Get.back();
  if(e.code=="invalid-email"){
Get.snackbar("Error!!", "Entrer une valide format Email");
  }else if(e.code=="user-disabled"){
    Get.snackbar("Error!!", "Le compte est bloqué par admin");
  }else if(e.code=="user-not-found"){
    Get.snackbar("Error!!", "Aucun utilisateur correspond a cet email");
  }else{
    Get.snackbar("Error!!", "Le mot de passe ou email est incoreecte");

  }
}
}
void createAcoount () async{
  try{
await _auth.createUserWithEmailAndPassword(email: email!.trim(), password: pass!.trim()).then((user)async =>
await FirebaseFirestore.instance.collection("Users").doc(user.user!.uid).set({
  "id":user.user!.uid,
  "email":user.user!.email,
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
})
 );
Get.offAll(()=>identite());
  }on FirebaseAuthException catch(e){
    Get.back();
if(e.code=="invalid-email"){
  Get.snackbar("Error!!", "Entrer une valide format Email");
}else if(e.code=="weak-password"){
  Get.snackbar("Error!!", "Le mot de passe est si facile à deviner. Incluez une gamme de types de caractères pour augmenter la sécurité.");
}else if(e.code=="email-already-in-use"){
  Get.snackbar("error", "Email est déjà utilisé par un autre compte");
}
  }
}



}
