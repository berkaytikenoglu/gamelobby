class APILogin {
  String accessToken;
  int userId;
  int expiresIn;
  String? refreshToken;

  APILogin({
    required this.accessToken,
    required this.userId,
    required this.expiresIn,
    required this.refreshToken,
  });

  // Story nesnesinden JSON'a dönüşüm
  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'userId': userId,
      'expiresIn': expiresIn,
      'refreshToken': refreshToken,
    };
  }

  // JSON'dan Story nesnesine dönüşüm
  factory APILogin.fromJson(Map<String, dynamic> json) {
    return APILogin(
      accessToken: json['accessToken'],
      userId: json['userId'],
      expiresIn: json['expiresIn'],
      refreshToken: json['refreshToken'],
    );
  }
}
