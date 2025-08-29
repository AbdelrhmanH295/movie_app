import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/update_profile_request.dart';

class ProfileApiManager {
  static const String baseUrl = "https://route-movie-apis.vercel.app";

  // 🔹 GET Profile
  static Future<Map<String, dynamic>> getProfile({String? token}) async {
    final url = Uri.parse("$baseUrl/profile");
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"success": false, "message": "Failed to fetch profile"};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // 🔹 PATCH Update Profile
  static Future<Map<String, dynamic>> updateProfile(
    UpdateProfileRequest request, {
    String? token,
  }) async {
    final url = Uri.parse("$baseUrl/profile");
    try {
      final response = await http.patch(
        url,
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
        body: jsonEncode(request.toJson()),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"success": false, "message": "Failed to update profile"};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // 🔹 DELETE Profile
  static Future<Map<String, dynamic>> deleteProfile({String? token}) async {
    final url = Uri.parse("$baseUrl/profile");
    try {
      final response = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"success": false, "message": "Failed to delete profile"};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
}
