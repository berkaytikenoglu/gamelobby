class APIContents {
  int id;
  String title;
  String createdDate;
  String? youtubeUrl;
  int bannerId;

  APIContents({
    required this.id,
    required this.title,
    required this.createdDate,
    this.youtubeUrl,
    required this.bannerId,
  });

  // Story nesnesinden JSON'a dönüşüm
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdDate': createdDate,
      'youtubeUrl': youtubeUrl,
      'bannerId': bannerId,
    };
  }

  // JSON'dan Story nesnesine dönüşüm
  factory APIContents.fromJson(Map<String, dynamic> json) {
    return APIContents(
      id: json['id'],
      title: json['title'],
      createdDate: json['createdDate'],
      youtubeUrl: json['youtubeUrl'],
      bannerId: json['bannerId'],
    );
  }
}
