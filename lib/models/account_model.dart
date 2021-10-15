import 'dart:convert';

class AccountModel {
  String name;
  AccountModel({
    required this.name,
  });

  AccountModel copyWith({
    String? name,
  }) {
    return AccountModel(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountModel.fromJson(String source) =>
      AccountModel.fromMap(json.decode(source));

  @override
  String toString() => 'AccountModel(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AccountModel && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
