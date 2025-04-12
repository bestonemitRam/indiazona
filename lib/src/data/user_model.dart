// models/user_model.dart

class UserModel {
  final String referenceCode;
  final String name;
  final String email;
  final String phone;

  UserModel({
    required this.referenceCode,
    required this.name,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'referenceCode': referenceCode,
      'name': name,
      'email': email,
      'phone': phone,
      'createdAt': DateTime.now().toIso8601String(),
    };
  }
}
