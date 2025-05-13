import 'package:hipocapp/product/utility/decrypt/message_decryptor.dart';
import 'package:hipocapp/product/utility/decrypt/message_enctyptor.dart';

/// Try to decrypt the given encrypted text using [MessageDecryptor]
/// and return the decrypted text. If the decryption fails, return '[Geçersiz Mesaj]'
String decryptMessageSafe(String encryptedText) {
  try {
    return MessageDecryptor.decrypt(encryptedText);
  } catch (e) {
    return '[Geçersiz Mesaj]';
  }
}

/// Try to encrypt the given plain text using [MessageEncryptor]
/// and return the encrypted text. If the encryption fails, return '[Şifreleme Hatası]'
String encryptMessageSafe(String plainText) {
  try {
    return MessageEncryptor.encryptText(plainText);
  } catch (e) {
    return '[Şifreleme Hatası]';
  }
}
