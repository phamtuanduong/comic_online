import 'dart:convert';

class PersionModel {
  int id;
  String fullname;
  String email;
  int gender;
  String? birthdate;

  PersionModel({
    required this.id,
    required this.fullname,
    required this.email,
    required this.gender,
    this.birthdate,
  });

  PersionModel copyWith({
    int? id,
    String? fullname,
    String? email,
    int? gender,
    String? birthdate,
  }) {
    return PersionModel(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      birthdate: birthdate ?? this.birthdate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'gender': gender,
      'birthdate': birthdate,
    };
  }

  factory PersionModel.fromMap(Map<String, dynamic> map) {
    return PersionModel(
      id: map['id'],
      fullname: map['fullname'],
      email: map['email'],
      gender: map['gender'],
      birthdate: map['birthdate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PersionModel.fromJson(String source) =>
      PersionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PersionModel(id: $id, fullname: $fullname, email: $email, gender: $gender, birthdate: $birthdate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PersionModel &&
        other.id == id &&
        other.fullname == fullname &&
        other.email == email &&
        other.gender == gender &&
        other.birthdate == birthdate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullname.hashCode ^
        email.hashCode ^
        gender.hashCode ^
        birthdate.hashCode;
  }
}
