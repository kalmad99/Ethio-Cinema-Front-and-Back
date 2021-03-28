import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {

    static addStringToSF(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);
}

    static getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('token');
 
  return stringValue;
}

static destroyStringValuesSF() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}


 }