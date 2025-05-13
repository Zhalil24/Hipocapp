import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';

class MessageDecryptor {
  static const String _secretKey = "Gizli_Anahtar";

  /// CryptoJS AES (CBC + PKCS7) ile şifrelenmiş mesajı çözer
  static String decrypt(String encryptedMessage) {
    final encryptedBytes = base64Decode(encryptedMessage);

    // ⚠️ Şifreli veri kontrolü: minimum 16 byte olmalı
    if (encryptedBytes.length < 16) {
      return '[Geçersiz mesaj]';
    }

    try {
      final salt = encryptedBytes.sublist(8, 16);
      final keyAndIV = _deriveKeyAndIV(_secretKey, salt, 32, 16);

      final key = encrypt.Key(Uint8List.fromList(keyAndIV.sublist(0, 32)));
      final iv = encrypt.IV(Uint8List.fromList(keyAndIV.sublist(32, 48)));
      final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));

      final ciphertext = encryptedBytes.sublist(16);
      final decrypted = encrypter.decrypt(encrypt.Encrypted(ciphertext), iv: iv);
      return decrypted;
    } catch (e) {
      return '[Çözüm hatası]';
    }
  }

  /// OpenSSL uyumlu key ve IV türetme (MD5 hashing)
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
}
