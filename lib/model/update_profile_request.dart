class UpdateProfileRequest {
  final String? email;
  final int? avaterId; // رقم الصورة المختارة
  final String? name;
  final String? phone;

  UpdateProfileRequest({
    this.email,
    this.avaterId,
    this.name,
    this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      if (email != null) 'email': email,
      if (avaterId != null) 'avaterId': avaterId,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
    };
  }
}
