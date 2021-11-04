import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:comic_online/models/models.dart';

class TruyenModel {
  int id;
  int authorID;
  String name;
  String tag;
  String description;
  String avtBook;
  double rate;
  int rateCount;
  int follow;
  int likeCount;
  String status;
  int lastNumChap;
  int totalView;
  String lastUpdate;
  List<String> categories;
  bool isFollow;

  FollowBookModel? followBook;

  List<TruyenChapter> listChapters = [];

  List<CommentModel> listCommentsParent = [];
  List<CommentModel> listCommentsChild = [];

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
    required this.isFollow,
  });

  String getCatagory() {
    String result = "";
    for (var item in categories) {
      result += item + ", ";
    }
    return result.substring(0, result.length - 2);
  }

  String getAuthor() => "Đang cập nhật";

  TruyenModel copyWith({
    int? id,
    int? authorID,
    String? name,
    String? tag,
    String? description,
    String? avtBook,
    double? rate,
    int? rateCount,
    int? follow,
    int? likeCount,
    String? status,
    int? lastNumChap,
    int? totalView,
    String? lastUpdate,
    List<String>? categories,
    bool? isFollow,
    List<FollowBookModel>? listFollowBook,
    List<TruyenChapter>? listChapters,
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
      isFollow: isFollow ?? this.isFollow,
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
      'isFollow': isFollow,
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
      rate: double.tryParse(map['rate'].toString()) ?? 0.0,
      rateCount: map['rateCount'],
      follow: map['follow'],
      likeCount: map['likeCount'],
      status: map['status'],
      lastNumChap: map['lastNumChap'],
      totalView: map['totalView'],
      lastUpdate: map['lastUpdate'],
      categories: List<String>.from(map['categories']),
      isFollow: map['isFollow'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TruyenModel.fromJson(String source) =>
      TruyenModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TruyenModel(id: $id, authorID: $authorID, name: $name, tag: $tag, description: $description, avtBook: $avtBook, rate: $rate, rateCount: $rateCount, follow: $follow, likeCount: $likeCount, status: $status, lastNumChap: $lastNumChap, totalView: $totalView, lastUpdate: $lastUpdate, categories: $categories, isFollow: $isFollow, listChapters: $listChapters)';
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
        listEquals(other.categories, categories) &&
        other.isFollow == isFollow &&
        other.followBook == followBook &&
        listEquals(other.listChapters, listChapters);
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
        categories.hashCode ^
        isFollow.hashCode ^
        followBook.hashCode ^
        listChapters.hashCode;
  }
}
