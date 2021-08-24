class AuthUser {
  int? id;
  final String firstName;
  final String lastName;
  final String email;
  final String userName;

  AuthUser(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.userName});

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'username': userName,
      };

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      userName: json['username'],
    );
  }
}
