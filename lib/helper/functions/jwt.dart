import 'dart:convert';

class Jwt {
  static int decodeJWTfetchID(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Geçersiz JWT!');
    }

    final payload = _decodeBase64(parts[1]);

    Map<String, dynamic> payloadMap = jsonDecode(payload);

    return int.parse(
      payloadMap[
          'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'],
    );
  }

  static String decodeJWTfetchname(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Geçersiz JWT!');
    }

    final payload = _decodeBase64(parts[1]);

    Map<String, dynamic> payloadMap = jsonDecode(payload);

    return payloadMap[
        'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name'];
  }

  static String _decodeBase64(String str) {
    // Padding ekle (Base64 için = karakteri gerekebilir)
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Geçersiz base64url dizesi!');
    }

    final decodedBytes = base64Url.decode(output);
    return utf8.decode(decodedBytes);
  }
}
