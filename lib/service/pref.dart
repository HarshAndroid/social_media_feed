import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  static late SharedPreferences _pref;

  static Future<void> initializeDB() async {
    _pref = await SharedPreferences.getInstance();
  }

  static bool get keepSignedIn => _pref.getBool('keepSignedIn') ?? true;
  static set keepSignedIn(bool v) => _pref.setBool('keepSignedIn', v);

    static bool get isDarkMode => _pref.getBool('isDarkMode') ?? true;
  static set isDarkMode(bool v) => _pref.setBool('isDarkMode', v);

  static set email(String v) => _pref.setString('email', v);
  static String get email => _pref.getString('email') ?? '';

  static set password(String v) => _pref.setString('password', v);
  static String get password => _pref.getString('password') ?? '';
}
