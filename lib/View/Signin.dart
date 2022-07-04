import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matchy/UTILS/hexColor.dart';
import 'package:matchy/View/passwordReset.dart';
import 'package:matchy/View_model/LoginViewModel.dart';
import 'package:matchy/View_model/googleSigninController.dart';
import '../UTILS/googleLogo.dart';
import 'Register.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            brightness: Brightness.light,
          ),
          body: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GetBuilder<LoginController>(
                init: LoginController(),
                builder: (control) => 
                    Form(
                      key: _formkey,
                      child: ListView(
                        children: [
                          const SizedBox(height: 40),
                          Center(
                            child: SvgPicture.asset("images/Groupe 9900.svg",height: 65,)
                          ),
                          const SizedBox(height: 25),
                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                    text:
                                        "Identifiez-vous pour rester au courant de ce qui se\n ",
                                    style: GoogleFonts.baloo2(
                                   textStyle: TextStyle(color: HexColor("#2F76BB"),fontSize: 12,fontWeight: FontWeight.w600),
                                  ),),
                                TextSpan(
                                    text:
                                        "      passe dans votre sphere professionnelle",
                                    style: GoogleFonts.baloo2(
    textStyle: TextStyle(color: HexColor("#2F76BB"),fontSize: 12,fontWeight: FontWeight.w600), 
                                        )
                          )])),
                              SizedBox(height:25),
                          TextFormField(
                            onSaved: (value){
                              control.email=value;
                            },
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
                                hintText: 'E-MAIL',
                                suffixIcon: SvgPicture.asset("images/Groupe 422.svg",fit: BoxFit.scaleDown,),
                                hintStyle: TextStyle(
                                  color: HexColor("#A0A0A0")
                                ),
                              ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onSaved: (Value){
                  control.pass=Value;
                },
                            validator: (val) =>
                                val!.isEmpty ? "* Obligatoire!" : null,
                            obscureText:
                                control.obscure == false ? true : false,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                     borderSide: BorderSide(color:HexColor('#C0C0C0'),
                                  width: 0.7)),
                                enabledBorder: OutlineInputBorder(
                                   borderSide: BorderSide(color: HexColor("#C0C0C0"),
                                  width: 0.7),
                                    borderRadius: BorderRadius.circular(6)),
                                suffixIcon: SvgPicture.asset("images/Groupe 30.svg",fit: BoxFit.scaleDown,),
                                hintText: 'MOT DE PASSE',
                                hintStyle: TextStyle(color: HexColor("#A0A0A0"))
                              ),
                          ),
                          const SizedBox(height: 12,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Get.to(()=>PaRest());
                                },
                                child: Container(margin: EdgeInsets.only(right: 10),child: Text("Mot de passe oublié?",style: GoogleFonts.baloo2(
                                     textStyle: TextStyle(color: HexColor("#2F76BB"),fontSize: 14,fontWeight: FontWeight.w600),
                                    ),)),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 35),
                            child: GestureDetector(
                              onTap: (){
                                _formkey.currentState!.save();
                              if( _formkey.currentState!.validate()){
                                showDialog(
                                  context: context, builder: (_)=>Dialog(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0.0,
                                    insetPadding: EdgeInsets.symmetric(horizontal: 70,vertical: 200),
                                    child: Center(child:CircularProgressIndicator()),
                                )) ; control.SignInEmailandPass();
                              }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 60,
                                child: Text(
                                        'Se CONNECTER',
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
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: (){
                              AuthController().googleSignin(context);
                            },
                            child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                 boxShadow:[
                                   
                                  BoxShadow(
                                    blurRadius: 25.0,
                                    offset: Offset(5,5),
                                    color: HexColor("#61BCA6"),
                                  )
                                 ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                  child: GoogleLogo(
                                    size:23
                                  )),
                                    Text(
                                      "SE CONNECTER AVEC GOOGLE",
                                      style: TextStyle(
                                        color:HexColor("#2F76BB"),
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                )),
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              Get.to(() => Register());
                            },
                            child: Container(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                            HexColor("#54AAAB"),
                                            HexColor("#3C88B5"),
                                          ],
                                          
                                          ),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        width: 1,
                                        color: Colors.grey.shade300)),
                                child: Center(
                                    child: Text("CRÉER UN COMPTE",
                                        style: GoogleFonts.baloo2(
                                textStyle: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),))),
                          ),
                          )],
                      ),
                    )                  
                ),
              ),
            ),
          ),
    );
  }
}
