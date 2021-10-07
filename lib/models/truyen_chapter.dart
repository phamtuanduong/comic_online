import 'dart:convert';

class TruyenChapter {
  int id;
  int bookID;
  String name;
  String tag;
  int viewCount;
  String updateDate;

  TruyenChapter({
    required this.id,
    required this.bookID,
    required this.name,
    required this.tag,
    required this.viewCount,
    required this.updateDate,
  });

  TruyenChapter copyWith({
    int? id,
    int? bookID,
    String? name,
    String? tag,
    int? viewCount,
    String? updateDate,
  }) {
    return TruyenChapter(
      id: id ?? this.id,
      bookID: bookID ?? this.bookID,
      name: name ?? this.name,
      tag: tag ?? this.tag,
      viewCount: viewCount ?? this.viewCount,
      updateDate: updateDate ?? this.updateDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bookID': bookID,
      'name': name,
      'tag': tag,
      'viewCount': viewCount,
      'updateDate': updateDate,
    };
  }

  factory TruyenChapter.fromMap(Map<String, dynamic> map) {
    return TruyenChapter(
      id: map['id'],
      bookID: map['bookID'],
      name: map['name'],
      tag: map['tag'],
      viewCount: map['viewCount'],
      updateDate: map['updateDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TruyenChapter.fromJson(String source) =>
      TruyenChapter.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TruyenChapter(id: $id, bookID: $bookID, name: $name, tag: $tag, viewCount: $viewCount, updateDate: $updateDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TruyenChapter &&
        other.id == id &&
        other.bookID == bookID &&
        other.name == name &&
        other.tag == tag &&
        other.viewCount == viewCount &&
        other.updateDate == updateDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        bookID.hashCode ^
        name.hashCode ^
        tag.hashCode ^
        viewCount.hashCode ^
        updateDate.hashCode;
  }
}
