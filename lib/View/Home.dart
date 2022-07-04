import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:matchy/View/Widgets/matchyCard.dart';
import 'package:matchy/View/Widgets/test.dart';
import 'package:matchy/View/updateProfile.dart';
import '../UTILS/hexColor.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 var cl;
 String? location;
    var image;
    List Matches=[];
List Like=[];
List DLike=[];
     
 Future GetPosition()async{
   bool sevices;
   LocationPermission perm;
   sevices=await Geolocator.isLocationServiceEnabled();
   perm=await Geolocator.checkPermission();
   if(perm==LocationPermission.denied){
     perm=await Geolocator.requestPermission();
   }else if(perm==LocationPermission.always){
     GetLatLong();
   }
 }
  GetLatLong() async {
     Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
    .then((Position position) {
  setState(() {
    getAddressFromLatLng(position.latitude, position.longitude);
  });
}).catchError((e) {
  print(e);
});
  } 
  getAddressFromLatLng(double latitude,double longtitude)async{
    try{
      List<Placemark> p=await placemarkFromCoordinates(latitude, longtitude);
     location=p[0].locality;
      await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).set({
  "Location":location,
  },SetOptions(merge: true));
    }catch(e){
      print(e);
    }
  }
  GetUser()async{
    var value =await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).get();
     image= await value.data()!["imgurll"];
     if(this.mounted){
        setState(() {
       
     });
     }
    
  }
 void matchUserInterests() async {
   try{
     int count = 0;
  var user = FirebaseAuth.instance.currentUser;
  var db = await FirebaseFirestore.instance.collection('Users').get();

  int index = db.docs.indexWhere((element) => element.data()['email'] == user?.email);
  await FirebaseFirestore.instance.collection('Users').get().then((val) {
    setState(() {
      
    });
   
    for (var i = 0; i < val.docs.length; i++) {
      for (var j = 0; j < val.docs[i].data()['interests'].length; j++) {
        if (i != index) {
          if ((val.docs[i].data()['interests'].contains(val.docs[index].data()['interests'][j]))&&
          (!val.docs[index].data()["DLike"].contains(val.docs[i].data()["email"]))&&
          (!val.docs[index].data()["Like"].contains(val.docs[i].data()["email"])
          )||
          
          (val.docs[i].data()['Location'].contains(val.docs[index].data()['Location']))&&
          (!val.docs[index].data()["DLike"].contains(val.docs[i].data()["email"]))&&
          (!val.docs[index].data()["Like"].contains(val.docs[i].data()["email"]))) {
        count++;
        }
      }
      } 
    if (count >= 1) {
   Matches.add(val.docs[i].data());
          } 
                count = 0;
  }
  });
  if(this.mounted){
    setState(() {
    
  });
  }
   }catch(e){

   }
 }
 

 @override
  void initState() {
    GetUser();
    GetPosition();
   this. matchUserInterests();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
     
      
      leadingWidth: 50,
    leading:InkWell(
      onTap: (){
        Get.to(()=>UpdateProfile());
      },
      child: 
        Container(margin: EdgeInsets.only(left: 10),decoration: BoxDecoration(shape: BoxShape.circle,
        image: DecorationImage(image:image.toString().isEmpty||image==null?AssetImage("images/user.jpg") as ImageProvider:
         CachedNetworkImageProvider(image.toString()),fit: BoxFit.cover))),
      
    ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: InkWell(onTap: (){
        print(Matches);
      },child: Container(padding: EdgeInsets.only(top: 10),child: SvgPicture.asset("images/Groupe 9900.svg",height:30))),
      centerTitle:true
      ),
      body: SafeArea(child: MatchyCard())
    );
  }
}