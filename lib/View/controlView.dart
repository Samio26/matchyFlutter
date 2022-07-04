import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchy/View/Home.dart';
import 'package:matchy/View/Signin.dart';
import 'package:matchy/View/Widgets/bottomNavBar.dart';
import 'package:matchy/View_model/LoginViewModel.dart';


class Controll extends StatelessWidget {
  const Controll({ Key? key }) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>false,
      child: Obx((){
        return (Get.find<LoginController>().user==null)
      ?Login():NavBar();
      }
        
      ),
    );
  }
}