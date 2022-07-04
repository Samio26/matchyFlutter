import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../UTILS/hexColor.dart';


class PaRest extends StatefulWidget {
  const PaRest({ Key? key }) : super(key: key);

  @override
  State<PaRest> createState() => _PaRestState();
}

class _PaRestState extends State<PaRest> {
  TextEditingController controlEmail=new TextEditingController();
changePassword()async{
  try {
  await FirebaseAuth.instance.sendPasswordResetEmail(email: controlEmail.text.trim());
   showDialog(context: context, builder: (context){
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
              Icon(Icons.email,color: HexColor("#54AAAB"),size: 120,),
            SizedBox(height: 40),
            Text("un lien de Réinitialisation de mot de passe été envoyée vérifier votre email",style: GoogleFonts.baloo2(
                                           textStyle: TextStyle(color: HexColor("#303030"),fontSize: 15,fontWeight: FontWeight.w600,)
                                          ),textAlign: TextAlign.center,),
                                          SizedBox(height: 30,),
                                          GestureDetector(
                                            onTap: (){
                                            launch("https://www.google.com/intl/fr/gmail/about/");
                                            },
                                            child: Container(
                                                                                alignment: Alignment.center,
                                                                                height: 60,
                                                                                child: Text(
                                                'Ouvrir email app',
                                                                              style: GoogleFonts.baloo2(
                                                                                textStyle: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(colors: [
                                                    HexColor("#54AAAB"),
                                                    HexColor("#3C88B5"),
                                                  ],
                                               
                                                  ),
                                                borderRadius: BorderRadius.circular(5)
                                                ),           
                                                                              ),
                                          ),
                                          SizedBox(height: 17),
                                          GestureDetector(
                                            onTap: (){
                                              Get.back();                                            },
                                            child: Text("Fermer, je confirme plus tard",style: GoogleFonts.baloo2(
                                             textStyle: TextStyle(color: HexColor("#303030"),fontSize: 15,fontWeight: FontWeight.w600,)
                                            )),
                                          )
          ],
        ),
      ),
      
    );
  });
  } on FirebaseAuthException catch(e){
  showDialog(context: context, builder: (context){
   if(e.code=="invalid-email"){
     return AlertDialog(
      content: Text("l'adresse email est malformée"),
    );
   } else return AlertDialog(
      content: Text("Aucun utilisateur correspond a cet email"),
    );
  });
  };
}
@override
  void dispose() {
    super.dispose();
    controlEmail.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height:120),
                Center(child: SvgPicture.asset("images/Groupe 9900.svg",height: 70,)),
                const SizedBox(height: 70),
                Text("entrez l’adresse e-mail associée à votre compte et nous vous enverrons un e-mail avec des instructions pour réinitialiser votre mot de passe"
                ,style: GoogleFonts.baloo2(
                                         textStyle: TextStyle(color: HexColor("#2F76BB"),fontSize: 14,fontWeight: FontWeight.w600,)
                                        )),
                                        const SizedBox(height: 15,),
                                        TextFormField(
                               controller: controlEmail,
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
                                    hintText: 'E-MAIL',
                                    suffixIcon: SvgPicture.asset("images/Groupe 422.svg",fit: BoxFit.scaleDown,),
                                    hintStyle: TextStyle(
                                      color: HexColor("#A0A0A0")
                                    ),
                                  ),
                              ),
                              const SizedBox(height: 20,),
                              GestureDetector(
                                onTap:  changePassword,
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 60,
                                    child: Text(
                                            'Changer Mot de Passe',
                                  style: GoogleFonts.baloo2(
                                    textStyle: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),
                                ),
                              ),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                HexColor("#54AAAB"),
                                                HexColor("#3C88B5"),
                                              ],
                                           
                                              ),
                                            borderRadius: BorderRadius.circular(5)
                                            ),           
                                  ),
                              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}