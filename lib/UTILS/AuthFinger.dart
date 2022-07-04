import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class AuthFinger{
  static final _auth=LocalAuthentication();
  static Future<bool> hasBiometric()async{
    try{
return await _auth.canCheckBiometrics;
    }on PlatformException catch(e){
      return false;
    }
  }
  static Future<bool> Authenitcate()async{
    final isAvailable=await hasBiometric();
    if(!isAvailable) return false;
try{
return await _auth.authenticate(localizedReason: "scan fingerprint pour connecter");

 }on PlatformException catch(e){
   return false;
 }
  }
  
}