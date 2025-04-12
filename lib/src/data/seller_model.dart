class SellerModel {
  final String name;
  final String mobile;
  final String email;
  final String aadhaarNumber;
  final String aadhaarImageUrl;
  final String profileImageUrl;

  SellerModel({
    required this.name,
    required this.mobile,
    required this.email,
    required this.aadhaarNumber,
    required this.aadhaarImageUrl,
    required this.profileImageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mobile': mobile,
      'email': email,
      'aadhaarNumber': aadhaarNumber,
      'aadhaarImageUrl': aadhaarImageUrl,
      'profileImageUrl': profileImageUrl,
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  factory SellerModel.fromJson(Map<String, dynamic> json) {
    return SellerModel(
      name: json['name'],
      mobile: json['mobile'],
      email: json['email'],
      aadhaarNumber: json['aadhaarNumber'],
      aadhaarImageUrl: json['aadhaarImageUrl'],
      profileImageUrl: json['profileImageUrl'],
    );
  }
}
