import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchy/View/Home.dart';

import '../ChatScreen.dart';
import '../MatchyExplore.dart';



class NavBar extends StatefulWidget {
  const NavBar({ Key? key }) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex=0;
  List <Widget> screen=[
  HomePage(),
  ExploreMatchy(),
  Chat(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
bottomNavigationBar:
      BottomNavigationBar(
        onTap: (index){
            setState(() {
              selectedIndex=index;
            });
           
        },
        
        elevation: 5.0,
        currentIndex: selectedIndex,
        items: [
       BottomNavigationBarItem(icon:Image(color:selectedIndex==0? Colors.blue:null,image: AssetImage("images/1.png"),),label:""),
       BottomNavigationBarItem(icon: Image(color:selectedIndex==1? Colors.blue:null,image: AssetImage("images/2.png"),),label:""),
       BottomNavigationBarItem(icon:Image(color:selectedIndex==2? Colors.blue:null,image: AssetImage("images/4.png"),),label:""),
      ],),
      body:screen[selectedIndex] ,
    );
  }
}