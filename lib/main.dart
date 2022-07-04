import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matchy/View/Signin.dart';
import 'package:matchy/View/controlView.dart';
import 'package:matchy/binding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:matchy/UTILS/onBoardInfo.dart';

import 'UTILS/hexColor.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    final prefs=await SharedPreferences.getInstance();
    final showHome=prefs.getBool("home")?? false;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp(showHomee: showHome));
}

class MyApp extends StatelessWidget {
  final bool showHomee;
  const MyApp({required this.showHomee});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
            home: showHomee? Controll():onBoard(),
      debugShowCheckedModeBanner: false,
      initialBinding: binding(),
      routes: {
        "login":(context){
          return Login();
        }
      },
    );
  }
}



class onBoard extends StatefulWidget {
  const onBoard({ Key? key }) : super(key: key);

  @override
  State<onBoard> createState() => _onBoardState();
}

class _onBoardState extends State<onBoard> {
  final Control=PageController();
  bool isLastPage=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        onPageChanged: ((index) {
          setState(() {
            isLastPage=index==2;
          });
        }),
        controller: Control,
        itemCount: 3,
        itemBuilder: (_,i){
        return Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height*0.93),
            Align(alignment: Alignment.topRight,child: GestureDetector(
               onTap:()async{
                       Get.to(()=>Controll());
                                    final prefs=await SharedPreferences.getInstance();
                                     prefs.setBool("home",true);                                } ,
              child: Container(margin: EdgeInsets.only(right: 20),child: Text("Skip",
                                       style: GoogleFonts.baloo2(
                                    textStyle: TextStyle(fontSize: 18,color:HexColor("#3C88B5"),fontWeight: FontWeight.bold),)),
              ),
            )),
           Image.asset(onBaord.images[i].toString(),height: 420),
           SmoothPageIndicator(
             effect: WormEffect(
               dotHeight: 14,
               dotWidth: 14,
               dotColor: Colors.black12,
             ),
             onDotClicked: (index)=>Control.animateToPage(index, duration: Duration(milliseconds: 400), curve: Curves.easeInCubic),
             controller: Control, count: 3),
           const SizedBox(height: 20),
                Text(onBaord.titles[i],
                      style: GoogleFonts.baloo2(
                        textStyle: TextStyle(fontSize: 24,color:HexColor("#080808"),fontWeight: FontWeight.bold),)),      
                        Padding(
                          padding: EdgeInsets.only(left: 40 ,right: 25
                           ),
                          child: Text(onBaord.description[i],
                      style: GoogleFonts.baloo2(
                          textStyle: TextStyle(fontSize: 15,color: HexColor("#8D8D8D"),fontWeight: FontWeight.w500),)),
                        ),  
                              const SizedBox(height: 15),
                              
           GestureDetector(
             onTap: ()=>Control.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeInCubic),
             child:!isLastPage? Container(
                    alignment:Alignment.center,
                                  height:60,
                                  width: 230,
                                   decoration: BoxDecoration(gradient: LinearGradient(colors: [
                                              HexColor("#54AAAB"),
                                              HexColor("#3C88B5"),
                                            ],
                                   ),
                                          borderRadius: BorderRadius.circular(5)
                                          ),           
                                  child: Text("Continuer",
                                     style: GoogleFonts.baloo2(
                                  textStyle: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),)),
                                ):GestureDetector(
                                  onTap: ()async{
                                    Get.to(()=>Controll());
                                    final prefs=await SharedPreferences.getInstance();
                                     prefs.setBool("home",true);
                                  },
                                  child: Container(
                                                    alignment:Alignment.center,
                                    height:60,
                                    width: 230,
                                     decoration: BoxDecoration(gradient: LinearGradient(colors: [
                                                HexColor("#54AAAB"),
                                                HexColor("#3C88B5"),
                                              ],
                                     ),
                                            borderRadius: BorderRadius.circular(5)
                                            ),           
                                    child: Text("Terminer",
                                       style: GoogleFonts.baloo2(
                                    textStyle: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),))),
                                ),
           ),
                              
          ],
        );
      }),
    );
  }
}
