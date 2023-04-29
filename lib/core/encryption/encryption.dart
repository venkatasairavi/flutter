// Dart Program to show
// Static methods in Dart
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt;

class AES {
  static final key = encrypt.Key(Uint8List.fromList(<int>[
    -32,
    62,
    -74,
    -25,
    78,
    -71,
    -25,
    126,
    -68,
    -25,
    -82,
    -125,
    -25,
    -34,
    -11,
    -33,
    126,
    -8,
    -33,
    -82,
    -5,
    -33,
    -34,
    -64
  ]));
  final iv = encrypt.IV.fromLength(16);
  final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.ecb, padding: 'PKCS7'));

  String encryptJSON(data) {
    final encrypted = encrypter.encrypt(data, iv: iv);
    return (encrypted.base64);
  }

  String decryptString(data) {
    final decrypted = encrypter.decrypt64(data, iv: iv);
    return decrypted;
  }
}
