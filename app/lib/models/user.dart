class User {
  String email;
  String password;
  String? token;

  User({required this.email, required this.password, this.token});

  //clear user
  void clear() {
    email = "";
    password = "";
    token = "";
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
