import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceData {
  SharedPreferenceData._privateConstructor();

  static final SharedPreferenceData _instance =
      SharedPreferenceData._privateConstructor();

  static SharedPreferenceData get instance => _instance;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late final SharedPreferences? prefs;

  Future<bool> load() async {
    prefs = await _prefs;
    return prefs == null;
  }

  bool firstUse() {
    bool flag = false;
    flag = prefs!.getBool('FUse') ?? false;

    return flag;
  }

  String getToken() {
    String token;
    token = prefs!.getString('token') ?? "none";
    return token;
  }

  Future setFirstUse() async {
    await prefs!.setBool('FUse', true);
  }

  Future setToken(String token) async {
    await prefs!.setString('token', token);
  }
}
