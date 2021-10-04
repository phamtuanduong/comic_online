import 'dart:convert';

class TheLoaiTruyenModel {
  int id;
  String name;
  String tag;
  TheLoaiTruyenModel({
    required this.id,
    required this.name,
    required this.tag,
  });

  TheLoaiTruyenModel copyWith({
    int? id,
    String? name,
    String? tag,
  }) {
    return TheLoaiTruyenModel(
      id: id ?? this.id,
      name: name ?? this.name,
      tag: tag ?? this.tag,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'tag': tag,
    };
  }

  factory TheLoaiTruyenModel.fromMap(Map<String, dynamic> map) {
    return TheLoaiTruyenModel(
      id: map['id'],
      name: map['name'],
      tag: map['tag'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TheLoaiTruyenModel.fromJson(String source) =>
      TheLoaiTruyenModel.fromMap(json.decode(source));

  @override
  String toString() => 'TheLoaiTruyenModel(id: $id, name: $name, tag: $tag)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TheLoaiTruyenModel &&
        other.id == id &&
        other.name == name &&
        other.tag == tag;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ tag.hashCode;
}
