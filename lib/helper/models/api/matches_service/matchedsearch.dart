class Matchedsearch {
  final String matchedSearchId;
  final int maximumTimeOfRespond;

  Matchedsearch({
    required this.matchedSearchId,
    required this.maximumTimeOfRespond,
  });

  // Story nesnesinden JSON'a dönüşüm
  Map<String, dynamic> toJson() {
    return {
      'matchedSearchId': matchedSearchId,
      'maximumTimeOfRespond': maximumTimeOfRespond,
    };
  }

  // JSON'dan Story nesnesine dönüşüm
  factory Matchedsearch.fromJson(Map<String, dynamic> json) {
    return Matchedsearch(
      matchedSearchId: json['matchedSearchId'],
      maximumTimeOfRespond: json['maximumTimeOfRespond'],
    );
  }
}
