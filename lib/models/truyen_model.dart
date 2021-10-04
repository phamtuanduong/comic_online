import 'dart:convert';

import 'package:flutter/foundation.dart';

class TruyenModel {
  int id;
  int authorID;
  String name;
  String tag;
  String description;
  String avtBook;
  int rate;
  int rateCount;
  int follow;
  int likeCount;
  String status;
  int lastNumChap;
  int totalView;
  String lastUpdate;
  List<String> categories;

  TruyenModel({
    required this.id,
    required this.authorID,
    required this.name,
    required this.tag,
    required this.description,
    required this.avtBook,
    required this.rate,
    required this.rateCount,
    required this.follow,
    required this.likeCount,
    required this.status,
    required this.lastNumChap,
    required this.totalView,
    required this.lastUpdate,
    required this.categories,
  });

  TruyenModel copyWith({
    int? id,
    int? authorID,
    String? name,
    String? tag,
    String? description,
    String? avtBook,
    int? rate,
    int? rateCount,
    int? follow,
    int? likeCount,
    String? status,
    int? lastNumChap,
    int? totalView,
    String? lastUpdate,
    List<String>? categories,
  }) {
    return TruyenModel(
      id: id ?? this.id,
      authorID: authorID ?? this.authorID,
      name: name ?? this.name,
      tag: tag ?? this.tag,
      description: description ?? this.description,
      avtBook: avtBook ?? this.avtBook,
      rate: rate ?? this.rate,
      rateCount: rateCount ?? this.rateCount,
      follow: follow ?? this.follow,
      likeCount: likeCount ?? this.likeCount,
      status: status ?? this.status,
      lastNumChap: lastNumChap ?? this.lastNumChap,
      totalView: totalView ?? this.totalView,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'authorID': authorID,
      'name': name,
      'tag': tag,
      'description': description,
      'avtBook': avtBook,
      'rate': rate,
      'rateCount': rateCount,
      'follow': follow,
      'likeCount': likeCount,
      'status': status,
      'lastNumChap': lastNumChap,
      'totalView': totalView,
      'lastUpdate': lastUpdate,
      'categories': categories,
    };
  }

  factory TruyenModel.fromMap(Map<String, dynamic> map) {
    return TruyenModel(
      id: map['id'],
      authorID: map['authorID'],
      name: map['name'],
      tag: map['tag'],
      description: map['description'],
      avtBook: map['avtBook'],
      rate: map['rate'],
      rateCount: map['rateCount'],
      follow: map['follow'],
      likeCount: map['likeCount'],
      status: map['status'],
      lastNumChap: map['lastNumChap'],
      totalView: map['totalView'],
      lastUpdate: map['lastUpdate'],
      categories: List<String>.from(map['categories']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TruyenModel.fromJson(String source) =>
      TruyenModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TruyenModel(id: $id, authorID: $authorID, name: $name, tag: $tag, description: $description, avtBook: $avtBook, rate: $rate, rateCount: $rateCount, follow: $follow, likeCount: $likeCount, status: $status, lastNumChap: $lastNumChap, totalView: $totalView, lastUpdate: $lastUpdate, categories: $categories)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TruyenModel &&
        other.id == id &&
        other.authorID == authorID &&
        other.name == name &&
        other.tag == tag &&
        other.description == description &&
        other.avtBook == avtBook &&
        other.rate == rate &&
        other.rateCount == rateCount &&
        other.follow == follow &&
        other.likeCount == likeCount &&
        other.status == status &&
        other.lastNumChap == lastNumChap &&
        other.totalView == totalView &&
        other.lastUpdate == lastUpdate &&
        listEquals(other.categories, categories);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        authorID.hashCode ^
        name.hashCode ^
        tag.hashCode ^
        description.hashCode ^
        avtBook.hashCode ^
        rate.hashCode ^
        rateCount.hashCode ^
        follow.hashCode ^
        likeCount.hashCode ^
        status.hashCode ^
        lastNumChap.hashCode ^
        totalView.hashCode ^
        lastUpdate.hashCode ^
        categories.hashCode;
  }
}
