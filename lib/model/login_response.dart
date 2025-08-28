class LoginResponse {
  final String message;
  final String? token;

  LoginResponse({required this.message, this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json["message"],
      token: json["data"],
    );
  }
}

// class LoginResponse {
//   final String message;
//   final String? token;
//   final Map<String, dynamic>? userData;
//   LoginResponse({
//     required this.message,
//     this.token,
//     this.userData,
//   });
//   factory LoginResponse.fromJson(Map<String, dynamic> json) {
//     final data = json["data"];
//     return LoginResponse(
//       message: json["message"],
//       token: data is Map<String, dynamic> ? data["token"] : data, // لو الـ token موجود جوا data
//       userData: data is Map<String, dynamic> ? data : null,       // نخزن باقي البيانات
//     );
//   }
// }
