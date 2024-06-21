class UserModel {
  final String? id;
  final String? email;
  final String? password;
  final String? fullName;
  final String? number;
  final String? profile;

  UserModel({
    required this.profile,
    required this.id,
    required this.email,
    required this.password,
    required this.fullName,
    required this.number,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      profile: json['profile'],
      id: json['id'],
      email: json['email'],
      password: json['password'],
      fullName: json['fullName'],
      number: json['number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile': profile,
      'id': id,
      'email': email,
      'password': password,
      'fullName': fullName,
      'number': number,
    };
  }
}
