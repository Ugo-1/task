class CustomUser {
  final String id;
  final String email;
  final String userName;

  CustomUser({
    required this.id,
    required this.email,
    required this.userName,
  });

  factory CustomUser.fromJson(json) {
    return CustomUser(
      id: json['id'],
      email: json['email'],
      userName: json['userName'],
    );
  }

  Map<String, String> toJson(){
    return {
      'id': id,
      'email': email,
      'userName': userName,
    };
  }
}
