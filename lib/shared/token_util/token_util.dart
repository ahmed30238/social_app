import 'package:fire_one/shared/constants/local/shared_pref.dart';

class TokenUtil {
  static String _token = "";
  static Future<void> saveToken({required String myToken}) async {
    CachHelper.saveData(key: TokenEnum.token.name, value: myToken);
    loadTokenToMemory();
  }

  static Future<void> loadTokenToMemory() async {
    _token = CachHelper.getData(key: TokenEnum.token.name) ?? "";
  }

  static Future<String> getTokenFromMemory() async {
    return _token;
  }

  static Future<void> clearToken() async {
    await CachHelper.removeData(key: TokenEnum.token.name);
    _token = "";
  }
}

enum TokenEnum { token }
