import 'dart:convert';

import 'package:comic_online/models/persion_model.dart';

class AccountModel {
  String username;
  String password;
  String email;

  PersionModel? persionModel;

  AccountModel({
    required this.username,
    required this.password,
    required this.email,
  });

  AccountModel copyWith({
    String? username,
    String? password,
    String? email,
  }) {
    return AccountModel(
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'email': email,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      username: map['username'],
      password: map['password'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountModel.fromJson(String source) =>
      AccountModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'AccountModel(username: $username, password: $password, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AccountModel &&
        other.username == username &&
        other.password == password &&
        other.email == email;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode ^ email.hashCode;
}
