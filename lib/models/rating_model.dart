class Rating {
  Rating({
    required this.rate,
    required this.count,
  });

  late final double rate;
  late final int count;

  Rating.fromMap(Map<String, dynamic> map) {
    rate = map['rate'];
    count = map['count'];
  }

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'] as double,
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rate': rate,
      'count': count,
    };
  }

  @override
  String toString() {
    return '''{
     rate: $rate, 
      count: $count, 
      
      }''';
  }
}
