import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matchy/UTILS/AuthFinger.dart';
import 'package:matchy/View/Widgets/bottomNavBar.dart';

import '../../UTILS/hexColor.dart';

class FingerPrint extends StatefulWidget {
  const FingerPrint({ Key? key }) : super(key: key);

  @override
  State<FingerPrint> createState() => _FingerPrintState();
}

class _FingerPrintState extends State<FingerPrint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
      Text("Protéger votre compte",
              style:  GoogleFonts.baloo2(
                      textStyle: TextStyle(fontSize: 18,color:HexColor("#2F76BB"),fontWeight: FontWeight.w600))),
                      const SizedBox(height: 30,),
                      Text("Garder vos donées et votre proprieté en sécurité avec la technolgie empreinte digitale",
              style:  GoogleFonts.baloo2(
                      textStyle: TextStyle(fontSize: 12,color:HexColor("#000000"),fontWeight: FontWeight.w600))) ,
                      const SizedBox(height: 50,),
                      Image.asset("images/finger.png",fit: BoxFit.fill,height: 300,width: double.infinity,),
                      const SizedBox(height: 46,),
                           InkWell(
                             onTap: ()async{
                               final isAuth=await AuthFinger.Authenitcate();
                                if(isAuth){
                                  Get.offAll(()=>NavBar());
                                }
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
                                        child: Text("Commencer",
                                            style: GoogleFonts.baloo2(
                                    textStyle: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),))),
                              ),
                           ),
                      
                           ],),
      ),
    );
  }
}