import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/register_request.dart';

class ApiManager {
  static String baseUrl = "https://route-movie-apis.vercel.app";

  static Future<Map<String, dynamic>> registerUser(RegisterRequest request) async {
    // هنا بنضيف البارامز في اللينك
    final url = Uri.parse(
      "$baseUrl/auth/register"
      "?name=${request.name}"
      "&email=${request.email}"
      "&password=${request.password}"
      "&confirmPassword=${request.confirmPassword}"
      "&phone=${request.phone}"
    );

    try {
      print("🌍 Sending request to: $url");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Cache-Control": "no-cache",
          "Accept": "*/*",
          "Accept-Encoding": "gzip, deflate, br",
          "Connection": "keep-alive",
          "Host": "route-movie-apis.vercel.app",
        },
      );

      print("🔢 Status Code: ${response.statusCode}");
      print("📦 Raw Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return {
          "success": false,
          "message": "Registration failed",
          "error": jsonDecode(response.body),
        };
      }
    } catch (e) {
      print("❌ Network Error: $e");
      return {"success": false, "message": "Network Error: $e"};
    }
  }
}
