import 'dart:convert';

import 'package:comic_online/global.dart';

class TruyenImgModel {
  int id;
  String path;
  TruyenImgModel({
    required this.id,
    required this.path,
  });

  String getLink(int bookID, int chapID) {
    if (!path.contains("https")) {
      return Global.baseApiUri +
          "/uploads/" +
          "BOOK-" +
          bookID.toString() +
          "/CHAP-" +
          chapID.toString() +
          "/" +
          path;
    }
    return path;
  }

  TruyenImgModel copyWith({
    int? id,
    String? path,
  }) {
    return TruyenImgModel(
      id: id ?? this.id,
      path: path ?? this.path,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'path': path,
    };
  }

  factory TruyenImgModel.fromMap(Map<String, dynamic> map) {
    return TruyenImgModel(
      id: map['id'],
      path: map['path'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TruyenImgModel.fromJson(String source) =>
      TruyenImgModel.fromMap(json.decode(source));

  @override
  String toString() => 'TruyenImgModel(id: $id, path: $path)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TruyenImgModel && other.id == id && other.path == path;
  }

  @override
  int get hashCode => id.hashCode ^ path.hashCode;
}
