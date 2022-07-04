import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matchy/UTILS/config.dart';
import 'package:matchy/View_model/LoginViewModel.dart';
import '../UTILS/hexColor.dart';
import 'Register.dart';
import 'Widgets/identite.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController passControl = new TextEditingController();
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
                builder: (control) =>   Form(
                      key: _formkey,
                      child: ListView(
                        children: [
                          SizedBox(height: 45),
                          Center(
                            child: SvgPicture.asset("images/Groupe 9900.svg",height: 65)
                          ),
                          SizedBox(height: 25),
                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                               TextSpan(
                                    text:
                                        "Identifiez-vous pour rester au courant de ce qui se\n ",
                                    style: GoogleFonts.baloo2(
    textStyle: TextStyle(color: HexColor("#2F76BB"),fontSize: 12,fontWeight: FontWeight.w600),
  ),), TextSpan(
                                    text:
                                        "      passe dans votre sphere professionnelle",
                                    style: GoogleFonts.baloo2(
    textStyle: TextStyle(color: HexColor("#2F76BB"),fontSize: 12,fontWeight: FontWeight.w600), 
                                        )
                          )])),
                              SizedBox(height: 35),
                          TextFormField(
                            onSaved: (value){
                              control.email=value;
                            },
                            validator: (val) =>
                                val!.isEmpty ? "* Obligatoire!" : null,
                            cursorColor: Colors.purple,
                            autocorrect: true,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                     borderSide: BorderSide(color:HexColor('#C0C0C0'),
                                  width: 0.7)),
                                enabledBorder: OutlineInputBorder(
                                   borderSide: BorderSide(color: Colors.grey.shade400,
                                  width: 0.7),
                                    borderRadius: BorderRadius.circular(6)),
                                hintText: 'E-MAIL',
                                suffixIcon: SvgPicture.asset("images/Groupe 422.svg",fit: BoxFit.scaleDown,)
                                ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onSaved: (value){
                              control.pass=value;
                            },
                            controller: passControl,
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
                                  borderSide: BorderSide(color: Colors.grey.shade400,
                                  width: 0.7
                                  ),
                                    borderRadius: BorderRadius.circular(6)),
                                suffixIcon: SvgPicture.asset("images/Groupe 30.svg",fit: BoxFit.scaleDown,),
                                hintText: 'Mot DE PASSE',
                              ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "!required";
                              } else if (passControl.text != val) {
                                return "!incorrecte";
                              } else {
                                return null;
                              }
                            },
                            obscureText:
                                control.obscure == false ? true : false,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                     borderSide: BorderSide(color:HexColor('#C0C0C0'),
                                  width: 0.7)),
                                enabledBorder: OutlineInputBorder(
                                   borderSide: BorderSide(color: Colors.grey.shade400,
                                  width: 0.7,),
                                    borderRadius: BorderRadius.circular(6)),
                                
                                suffixIcon: SvgPicture.asset("images/Groupe 30.svg",fit: BoxFit.scaleDown,),
                                hintText: 'Confirmer',
                                ),
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 35),
                            child: GestureDetector(
                              onTap: (){
                                _formkey.currentState!.save();
                                if(_formkey.currentState!.validate()){
                                  showDialog(context: context, builder: (context)=>Dialog(
                                    insetPadding: EdgeInsets.symmetric(horizontal: 70,vertical: 200),
                                    backgroundColor:Colors.transparent,
                                    elevation: 0.0,
                                    child: Center(child: CircularProgressIndicator()),
                                  ));
                                 control.createAcoount();
                                
                                }
                              },
                              child: Container(
                                alignment:Alignment.center,
                                height:60,
                                 decoration: BoxDecoration(gradient: LinearGradient(colors: [
                                            HexColor("#54AAAB"),
                                            HexColor("#3C88B5"),
                                          ],
                                 ),
                                        borderRadius: BorderRadius.circular(5)
                                        ),           
                                child:Text("CRÉER UN COMPTE",
                                        style: GoogleFonts.baloo2(
                                textStyle: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),)),
                              ),
                            ),
                          ),
                         
                        ],
                      ),
                    )
                  
                ),
              ),
            ),
          )
    );
  }
}
