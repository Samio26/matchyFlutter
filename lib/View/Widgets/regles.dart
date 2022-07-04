import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matchy/View/Home.dart';
import 'package:matchy/View/Widgets/Security.dart';
import 'package:matchy/View/Widgets/bottomNavBar.dart';
import 'package:matchy/View/Widgets/verify_email.dart';
import 'package:matchy/reglesInfo.dart';

import '../../UTILS/hexColor.dart';

class Regles extends StatefulWidget {
  const Regles({Key? key}) : super(key: key);

  @override
  _ReglesState createState() => _ReglesState();
}

class _ReglesState extends State<Regles> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>false,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SvgPicture.asset("images/Groupe 9900.svg",height: 60),
                    const SizedBox(height: 10,),
                    Text(
                      "Bienvenue sur Matchy",
                      style: GoogleFonts.baloo2(
         textStyle: TextStyle(fontSize: 16,color:HexColor("#2F76BB"),fontWeight: FontWeight.bold),)
                    ),
                    SizedBox(height: 5),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text:
                              "Voici les régles: merci de les respecter pour une\n ",
                          style: GoogleFonts.baloo2(
         textStyle: TextStyle(fontSize: 14,color:HexColor("#303030"),fontWeight: FontWeight.w400),)),
                      TextSpan(
                          text:
                              "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\texpérience au top.",
                          style: GoogleFonts.baloo2(
         textStyle: TextStyle(fontSize: 14,color:HexColor("#303030"),fontWeight: FontWeight.w400),))
                    ])),
                    SizedBox(height: 35),
                    Expanded(
                      child: ListView.builder(
                         shrinkWrap: true,
                         physics: NeverScrollableScrollPhysics(),
                          itemCount: ReglesInfo.info.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.check_outlined,
                                          color: HexColor("#61BCA6"), size: 20,),
                                      SizedBox(width: 15),
                                      Text(
                                        ReglesInfo.info[index]["title"],
                                        style: GoogleFonts.baloo2(
         textStyle: TextStyle(fontSize: 16,color:HexColor("#6F6F6F"),fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                  
                                  Text(ReglesInfo.info[index]["description"],
                                      style: GoogleFonts.baloo2(
         textStyle: TextStyle(fontSize: 14,color:HexColor("#303030"),fontWeight: FontWeight.w400))),
                                ],
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: 30,),
                    GestureDetector(
                       onTap: () {
                          Get.offAll(()=>FingerPrint());
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
                          child: Text("J'accepte",style:  GoogleFonts.baloo2(
                            textStyle: TextStyle(fontSize: 14,color:Colors.white,fontWeight: FontWeight.bold),),),
                          width: double.infinity,
                          height: 55,
                          ),
                    ),
                    SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
