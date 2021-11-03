import 'dart:convert';

class HisTruyenModel {
  int? bookID;

  int? lastNum;
  String name;
  String avtBook;

  HisTruyenModel({
    this.bookID,
    required this.name,
    required this.avtBook,
  });

  HisTruyenModel copyWith({
    int? bookID,
    String? name,
    String? avtBook,
  }) {
    return HisTruyenModel(
      bookID: bookID ?? this.bookID,
      name: name ?? this.name,
      avtBook: avtBook ?? this.avtBook,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookID': bookID,
      'name': name,
      'avtBook': avtBook,
    };
  }

  factory HisTruyenModel.fromMap(Map<String, dynamic> map) {
    return HisTruyenModel(
      name: map['name'],
      avtBook: map['avtBook'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HisTruyenModel.fromJson(String source) =>
      HisTruyenModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'HisTruyenModel(bookID: $bookID, name: $name, avtBook: $avtBook)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HisTruyenModel &&
        other.bookID == bookID &&
        other.name == name &&
        other.avtBook == avtBook;
  }

  @override
  int get hashCode => bookID.hashCode ^ name.hashCode ^ avtBook.hashCode;
}
