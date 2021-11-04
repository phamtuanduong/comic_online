import 'dart:convert';

class FollowBookModel {
  int id;
  int bookID;
  int lastChap;
  String namebook;
  String avt;
  String lastChapUpdate;
  int newChap;
  String newChapUpdate;

  FollowBookModel({
    required this.id,
    required this.bookID,
    required this.lastChap,
    required this.namebook,
    required this.avt,
    required this.lastChapUpdate,
    required this.newChap,
    required this.newChapUpdate,
  });

  FollowBookModel copyWith({
    int? id,
    int? bookID,
    int? lastChap,
    String? namebook,
    String? avt,
    String? lastChapUpdate,
    int? newChap,
    String? newChapUpdate,
  }) {
    return FollowBookModel(
      id: id ?? this.id,
      bookID: bookID ?? this.bookID,
      namebook: namebook ?? this.namebook,
      avt: avt ?? this.avt,
      lastChap: lastChap ?? this.lastChap,
      lastChapUpdate: lastChapUpdate ?? this.lastChapUpdate,
      newChap: newChap ?? this.newChap,
      newChapUpdate: newChapUpdate ?? this.newChapUpdate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bookID': bookID,
      'lastChap': lastChap,
      'namebook': namebook,
      'avt': avt,
      'lastChapUpdate': lastChapUpdate,
      'newChap': newChap,
      'newChapUpdate': newChapUpdate,
    };
  }

  factory FollowBookModel.fromMap(Map<String, dynamic> map) {
    return FollowBookModel(
      id: map['id'],
      bookID: map['bookID'],
      lastChap: map['lastChap'],
      namebook: map['namebook'],
      avt: map['avt'],
      lastChapUpdate: map['lastChapUpdate'],
      newChap: map['newChap'],
      newChapUpdate: map['newChapUpdate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FollowBookModel.fromJson(String source) =>
      FollowBookModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FollowBookModel(id: $id, bookID: $bookID, lastChap: $lastChap, namebook: $namebook, avt: $avt, lastChapUpdate: $lastChapUpdate, newChap: $newChap, newChapUpdate: $newChapUpdate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FollowBookModel &&
        other.id == id &&
        other.bookID == bookID &&
        other.lastChap == lastChap &&
        other.namebook == namebook &&
        other.avt == avt &&
        other.lastChapUpdate == lastChapUpdate &&
        other.newChap == newChap &&
        other.newChapUpdate == newChapUpdate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        bookID.hashCode ^
        lastChap.hashCode ^
        namebook.hashCode ^
        avt.hashCode ^
        lastChapUpdate.hashCode ^
        newChap.hashCode ^
        newChapUpdate.hashCode;
  }
}
