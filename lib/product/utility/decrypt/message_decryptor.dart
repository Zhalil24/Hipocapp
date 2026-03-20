import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:hipocapp/product/init/language/locale_keys.g.dart';

class MessageDecryptor {
  static const String _secretKey = 'Gizli_Anahtar';

  static String decrypt(String encryptedMessage) {
    final encryptedBytes = base64Decode(encryptedMessage);

    if (encryptedBytes.length < 16) {
      return LocaleKeys.chat_invalid_message.tr();
    }

    try {
      final salt = encryptedBytes.sublist(8, 16);
      final keyAndIV = _deriveKeyAndIV(_secretKey, salt, 32, 16);

      final key = encrypt.Key(Uint8List.fromList(keyAndIV.sublist(0, 32)));
      final iv = encrypt.IV(Uint8List.fromList(keyAndIV.sublist(32, 48)));
      final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc),
      );

      final ciphertext = encryptedBytes.sublist(16);
      return encrypter.decrypt(encrypt.Encrypted(ciphertext), iv: iv);
    } catch (e) {
      return LocaleKeys.chat_decrypt_error.tr();
    }
  }

  static List<int> _deriveKeyAndIV(
    String passphrase,
    List<int> salt,
    int keyLength,
    int ivLength,
  ) {
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
