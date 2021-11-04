import 'dart:convert';

import 'package:comic_online/models/models.dart';
import 'package:comic_online/models/truyen_image.dart';
import 'package:intl/intl.dart';

import 'comment_model.dart';

class TruyenChapter {
  int id;
  int bookID;
  String name;
  String tag;
  int viewCount;
  String updateDate;

  TruyenModel? truyenModel;

  List<TruyenImgModel> listImg = [];

  List<CommentModel> listCommentsParent = [];
  List<CommentModel> listCommentsChild = [];

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

  String getNameUpcase() {
    return name.replaceFirst(name[0], name[0].toUpperCase());
  }

  String getUpDateFormat() {
    var inputDate = DateTime.parse(updateDate);
    var outputFormat = DateFormat('hh:mm a dd/MM/yyyy');
    return outputFormat.format(inputDate);
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
