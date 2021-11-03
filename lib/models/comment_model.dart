import 'dart:convert';

class CommentModel {
  int id;
  int accountID;
  int listchapID;
  String content;
  int parentID;
  int bookID;
  String userName;
  String chapName;

  CommentModel({
    required this.id,
    required this.accountID,
    required this.listchapID,
    required this.content,
    required this.parentID,
    required this.bookID,
    required this.userName,
    required this.chapName,
  });

  CommentModel copyWith({
    int? id,
    int? accountID,
    int? listchapID,
    String? content,
    int? parentID,
    int? bookID,
    String? userName,
    String? chapName,
  }) {
    return CommentModel(
      id: id ?? this.id,
      accountID: accountID ?? this.accountID,
      listchapID: listchapID ?? this.listchapID,
      content: content ?? this.content,
      parentID: parentID ?? this.parentID,
      bookID: bookID ?? this.bookID,
      userName: userName ?? this.userName,
      chapName: chapName ?? this.chapName,
    );
  }

  String getNameUpcase() {
    return content.replaceFirst(content[0], content[0].toUpperCase());
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'accountID': accountID,
      'listchapID': listchapID,
      'content': content,
      'parentID': parentID,
      'bookID': bookID,
      'userName': userName,
      'chapName': chapName,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'],
      accountID: map['accountID'],
      listchapID: map['listchapID'],
      content: map['content'],
      parentID: map['parentID'],
      bookID: map['bookID'],
      userName: map['userName'],
      chapName: map['chapName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CommentModel(id: $id, accountID: $accountID, listchapID: $listchapID, content: $content, parentID: $parentID, bookID: $bookID, userName: $userName, chapName: $chapName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CommentModel &&
        other.id == id &&
        other.accountID == accountID &&
        other.listchapID == listchapID &&
        other.content == content &&
        other.parentID == parentID &&
        other.bookID == bookID &&
        other.userName == userName &&
        other.chapName == chapName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        accountID.hashCode ^
        listchapID.hashCode ^
        content.hashCode ^
        parentID.hashCode ^
        bookID.hashCode ^
        userName.hashCode ^
        chapName.hashCode;
  }
}
