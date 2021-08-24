class User {
  final int? id;
  final String? email;
  final String? first_name;
  final String? last_name;
  final String? avatar;

  User({this.avatar, this.first_name, this.id, this.last_name, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      avatar: json['avatar'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'first_name': first_name,
        'last_time': last_name,
        'avatar': avatar,
      };
}
