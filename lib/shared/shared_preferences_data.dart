import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceData {
  SharedPreferenceData._privateConstructor();

  static final SharedPreferenceData _instance =
      SharedPreferenceData._privateConstructor();

  static SharedPreferenceData get instance => _instance;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences? prefs;

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
    token = prefs!.getString('token') ?? "guest";
    return token;
  }

  Future setFirstUse() async {
    await prefs!.setBool('FUse', true);
  }

  Future setToken(String token) async {
    await prefs!.setString('token', token);
  }

  bool checkHistoryBook(int bookID) => prefs!.containsKey('$bookID');

  List<String> getListHistoryBook(String key) {
    List<String> list;
    list = prefs!.getStringList(key) ?? [];
    return list;
  }

  String? getHistoryBook(int bookID) {
    return prefs!.getString('$bookID');
  }

  Future saveReadBook(int bookID, int chapID) async {
    List<String> listBook = getListHistoryBook('historyBook');
    listBook.add(bookID.toString());
    if (!checkHistoryBook(bookID)) {
      await prefs!.setStringList('historyBook', listBook);
      await prefs!.setString('$bookID', chapID.toString());
    }
  }

  List<String> getListHistorySearch() {
    List<String> list;
    list = prefs!.getStringList('hisSearch') ?? [];
    return list;
  }

  Future saveHisSearch(String search) async {
    List<String> listSearch = getListHistorySearch();
    int index = listSearch.indexOf(search);
    if (index < 0) {
      listSearch.add(search);
      await prefs!.setStringList('hisSearch', listSearch);
    }
  }
}
