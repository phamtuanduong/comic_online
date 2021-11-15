import 'dart:convert';

class ReviewBookModel {
  int rate;
  ReviewBookModel({
    required this.rate,
  });

  ReviewBookModel copyWith({
    int? rate,
  }) {
    return ReviewBookModel(
      rate: rate ?? this.rate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rate': rate,
    };
  }

  factory ReviewBookModel.fromMap(Map<String, dynamic> map) {
    return ReviewBookModel(
      rate: map['rate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewBookModel.fromJson(String source) =>
      ReviewBookModel.fromMap(json.decode(source));

  @override
  String toString() => 'ReviewBookModel(rate: $rate)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReviewBookModel && other.rate == rate;
  }

  @override
  int get hashCode => rate.hashCode;
}
