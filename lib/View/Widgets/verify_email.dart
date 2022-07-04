import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matchy/View/Home.dart';

class verifEmail extends StatefulWidget {
  const verifEmail({ Key? key }) : super(key: key);

  @override
  _verifEmailState createState() => _verifEmailState();
}

class _verifEmailState extends State<verifEmail> {
  bool isEmailVerified=false;
  bool canResendEmail=false;
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerified=FirebaseAuth.instance.currentUser!.emailVerified;
    if(!isEmailVerified){
      sendVerificationEmail();

  timer=    Timer.periodic(
        Duration(seconds: 3),
        (_)=>checkEmail(),
      );
    }
  }
  @override
  void dispose(){
    timer?.cancel();
    super.dispose();
  }

  Future checkEmail()async{
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified=FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if(isEmailVerified) timer?.cancel();
  }
  Future sendVerificationEmail()async{
    try{
    final user=FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
    setState(() {
      canResendEmail=false;});
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        canResendEmail=true;
      });
    }catch(e){
      print("Error sendEmailVerification");
    }
  } 
  @override
  Widget build(BuildContext context) =>isEmailVerified ? HomePage():
     Scaffold(
      appBar: AppBar(
        title: Text("Verification email"),
      ),
      body: Padding(padding: EdgeInsets.all(16),
      
      child: Column(children: [
        Text("A verification email has been sent to your email.",style: TextStyle(fontSize: 25),textAlign: TextAlign.center,),
        SizedBox(height: 20,),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(50),
            
          ),
          onPressed: (){
     canResendEmail? sendVerificationEmail():null;
          }, icon: Icon(Icons.email), label: Text("Resent Email",style: TextStyle(fontSize: 25),)),       
      ],),
      ),
    );
  }
