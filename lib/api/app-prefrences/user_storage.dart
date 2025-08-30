import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  /// حفظ بيانات المستخدم في SharedPreferences
  static Future<void> saveUser(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("userId", userData["id"].toString());
    await prefs.setString("name", userData["name"] ?? '');
    await prefs.setString("email", userData["email"] ?? '');
    await prefs.setString("phone", userData["phone"] ?? '');
    await prefs.setString("avatar", userData["avatar"] ?? 'assets/images/avatar1_image.png');
  }

  /// استرجاع بيانات المستخدم
  static Future<Map<String, dynamic>> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      "userId": prefs.getString("userId") ?? '',
      "name": prefs.getString("name") ?? '',
      "email": prefs.getString("email") ?? '',
      "phone": prefs.getString("phone") ?? '',
      "avatar": prefs.getString("avatar") ?? 'assets/images/avatar1_image.png',
    };
  }

  /// تحديث صورة المستخدم (Avatar)
  static Future<void> saveAvatar(String avatarPath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("avatar", avatarPath);
  }

  /// مسح بيانات المستخدم بالكامل
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("userId");
    await prefs.remove("name");
    await prefs.remove("email");
    await prefs.remove("phone");
    await prefs.remove("avatar");
  }
}
