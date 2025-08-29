import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/register_request.dart';

class ApiManager {
  static String baseUrl = "https://route-movie-apis.vercel.app";

  static Future<Map<String, dynamic>> registerUser(RegisterRequest request) async {
    final url = Uri.parse("$baseUrl/auth/register");
    try {
      print("🌍 Sending request to: $url");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": request.name,
          "email": request.email,
          "password": request.password,
          "confirmPassword": request.confirmPassword,
          "phone": "+2${request.phone}",
          "avaterId" : request.avaterId
        }),
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