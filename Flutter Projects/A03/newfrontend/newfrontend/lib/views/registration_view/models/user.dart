class User {
  final String? username;
  final String? fullname;
  final String? email;
  final String? password;

  const User(this.username, this.fullname, this.email, this.password);

  User.fromJson(Map<String, dynamic> json)
      : fullname = json['fullname'],
        username = json['username'],
        email = json['email'],
        password = json['password'];
  Map<String, dynamic> toJson() => {
        'fullname': fullname,
        'username': username,
        'email': email,
        'password': password
      };
}
