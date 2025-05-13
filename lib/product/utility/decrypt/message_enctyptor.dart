import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';

class MessageEncryptor {
  static const String _secretKey = "Gizli_Anahtar";

  /// CryptoJS AES (CBC + PKCS7) ile mesajı şifreler
  static String encryptText(String plainText) {
    final salt = _generateSalt(8);
    final keyAndIV = _deriveKeyAndIV(_secretKey, salt, 32, 16);

    final key = encrypt.Key(Uint8List.fromList(keyAndIV.sublist(0, 32)));
    final iv = encrypt.IV(Uint8List.fromList(keyAndIV.sublist(32, 48)));
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));

    final encrypted = encrypter.encrypt(plainText, iv: iv);

    final result = Uint8List.fromList([
      ...utf8.encode("Salted__"), // OpenSSL format başlığı
      ...salt,
      ...encrypted.bytes,
    ]);

    return base64Encode(result);
  }

  static List<int> _deriveKeyAndIV(String passphrase, List<int> salt, int keyLength, int ivLength) {
    final passphraseBytes = utf8.encode(passphrase);
    final totalLength = keyLength + ivLength;
    List<int> result = [];
    List<int> previous = [];

    while (result.length < totalLength) {
      final hasher = md5.convert([...previous, ...passphraseBytes, ...salt]);
      previous = hasher.bytes;
      result.addAll(previous);
    }

    return result.sublist(0, totalLength);
  }

  static List<int> _generateSalt(int length) {
    final rand = Random.secure();
    return List<int>.generate(length, (_) => rand.nextInt(256));
  }
}
