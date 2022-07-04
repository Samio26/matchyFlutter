import 'package:shared_preferences/shared_preferences.dart';

class Preferences{
static  setHome()async{
    final prefs=await SharedPreferences.getInstance();
     prefs.setBool('Home', true);
  }
  static getHome()async{
    final prefs=await SharedPreferences.getInstance();
    prefs.getBool('Home');
  }
}