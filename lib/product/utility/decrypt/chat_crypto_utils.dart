import 'package:easy_localization/easy_localization.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/product/utility/decrypt/message_decryptor.dart';
import 'package:hipocapp/product/utility/decrypt/message_enctyptor.dart';

String decryptMessageSafe(String encryptedText) {
  try {
    return MessageDecryptor.decrypt(encryptedText);
  } catch (e) {
    return LocaleKeys.chat_invalid_message.tr();
  }
}

String encryptMessageSafe(String plainText) {
  try {
    return MessageEncryptor.encryptText(plainText);
  } catch (e) {
    return LocaleKeys.chat_encrypt_error.tr();
  }
}
